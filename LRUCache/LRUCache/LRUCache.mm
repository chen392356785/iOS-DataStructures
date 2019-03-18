//
//  LRUCache.m
//  LRUCache
//
//  Created by dzb on 2019/3/18.
//  Copyright © 2019年 大兵布莱恩特. All rights reserved.
//

#include <map>
#include <unistd.h>
#include <pthread.h>
#import "LRUCache.h"
#include "LinkList.hpp"
#import <Quartz/Quartz.h>
#import <CoreFoundation/CoreFoundation.h>

using namespace std;
/// 任意类型指针
typedef void * AnyObject;
///链表数据节点
typedef  LinkList<AnyObject>::LinkNode  LinkNodeType;
typedef  multimap<NSString *, LinkNodeType *>::iterator MapIterator;

#define ObjectBridge(obj) ((__bridge_retained AnyObject)obj)
#define PointerBridge(obj) ((__bridge AnyObject)obj)

@interface LRUCache () <NSCopying,NSMutableCopying>

@property (nonatomic,assign) LinkList<AnyObject> *linkList;
@property (nonatomic,assign) multimap<NSString *, LinkNodeType *> *dict;
@property (nonatomic,assign,readonly) pthread_mutex_t lock;

@end

@implementation LRUCache

@dynamic shareCache;

+ (LRUCache *)shareCache {
    return [[super alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static LRUCache *_lru_cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lru_cache = [super allocWithZone:zone];
        _lru_cache->_countLimit = 10;
        _lru_cache->_autoTrimInterval = 5.0f;
        pthread_mutex_init(&_lru_cache->_lock,NULL);
        [_lru_cache _trimRecursively];
    });
    return _lru_cache;
}

/**
 递归检查缓存情况
 */
- (void) _trimRecursively {
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_autoTrimInterval * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) return;
        [strongSelf _trimInBackground];
        [strongSelf _trimRecursively];
    });
    
}

/**
 后台进程进行旧数据淘汰
 */
- (void) _trimInBackground {
    [self _trimToCount:self->_countLimit];
}

- (void)_trimToCount:(NSUInteger)countLimit {
    BOOL finish = NO;
    pthread_mutex_lock(&_lock);
    if (countLimit == 0) {
        self.linkList->clear_by_completion(NULL);
        finish = YES;
    } else if (countLimit <= self.linkList->size()) {
        finish = YES;
    }
    pthread_mutex_unlock(&_lock);
    if (finish) return;

    while (!finish) {
        if (pthread_mutex_trylock(&_lock) == 0) {
            int size = self.linkList->size();
            if (size > countLimit) { ///移除尾结点数据
                AnyObject obj = self->_linkList->remove_tail_node();
                if ([self.delegate respondsToSelector:@selector(lurcache:willEvictObject:)]) {
                    [self.delegate lurcache:self willEvictObject:(__bridge id)obj];
                }
                CFRelease(obj);
            } else {
                finish = YES;
            }
            pthread_mutex_unlock(&_lock);
        } else {
            usleep(10 * 1000); //10 ms
        }
        
    }
    

}

#pragma mark - getter

- (multimap<NSString *, LinkNodeType *> *)dict {
    if (_dict == NULL) {
        _dict = new multimap<NSString *,LinkNodeType*>();
    }
    return _dict;
}

- (LinkList<AnyObject> *)linkList {
    if (_linkList == NULL) {
        _linkList = new LinkList<AnyObject>();
    }
    return _linkList;
}

- (void)setObject:(id)object forKey:(NSString *)key {
    if (!key) return;
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    pthread_mutex_lock(&_lock);
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    LinkNodeType *node = NULL;
    MapIterator ret = self.dict->find(key);
    if (ret != self.dict->end()) { ///查找当前key是否有添加到链表中的节点
        node = ret->second;
        node->_data = ObjectBridge(object);
        self.linkList->bring_node_to_head(node);
    } else {
        node = self.linkList->insert(ObjectBridge(object));
        node->_key = [key UTF8String];
        node->_time = now;
        self.dict->insert(make_pair(key, node));
    }
    int size = self.linkList->size();
    if (size > _countLimit) { ///链表缓存数量已经超过最大缓存数量
        AnyObject data = self.linkList->remove_tail_node();
        if ([self.delegate respondsToSelector:@selector(lurcache:willEvictObject:)]) {
            [self.delegate lurcache:self willEvictObject:(__bridge id)data];
        }
        CFRelease(data);
    }
    pthread_mutex_unlock(&_lock);
}

- (id)objectForKey:(id)key {
    if (!key) return nil;
    pthread_mutex_lock(&_lock);
    id object = nil;
    LinkNodeType *node;
    MapIterator ret = self.dict->find(key);
    if (ret != self.dict->end()) {
        node = ret->second;
        node->_time = [NSDate date].timeIntervalSince1970;
        AnyObject data = node->_data;
        object = (__bridge id)data;
        self.linkList->bring_node_to_head(node);
    }
    pthread_mutex_unlock(&_lock);
    return object;
}

- (void)removeObjectForKey:(id)key {
    if (!key) return;
    pthread_mutex_lock(&_lock);
    LinkNodeType *node;
    MapIterator ret = self.dict->find(key);
    if (ret != self.dict->end()) {
        node = ret->second;
        AnyObject data = self.linkList->remove_by(node);
        if ([self.delegate respondsToSelector:@selector(lurcache:willEvictObject:)]) {
            [self.delegate lurcache:self willEvictObject:(__bridge id)data];
        }
        CFRelease(data);
    }
    pthread_mutex_unlock(&_lock);
}

- (void)removeAllObjects {
    pthread_mutex_lock(&_lock);
    self.dict->clear();
    self.linkList->clear_by_completion([](AnyObject obj){
        typeof(self)weakSelf = LRUCache.shareCache;
        if ([weakSelf.delegate respondsToSelector:@selector(lurcache:willEvictObject:)]) {
            [weakSelf.delegate lurcache:weakSelf willEvictObject:(__bridge id)obj];
        }
        CFRelease(obj);
    });
    ///清空指针操作
    delete self.dict;
    delete self.linkList;
    self.dict = NULL;
    self.linkList = NULL;
    pthread_mutex_unlock(&_lock);
}

- (BOOL)containsObjectForKey:(id)key {
    if (!key) return NO;
    pthread_mutex_lock(&_lock);
    BOOL contains = NO;
    MapIterator ret = self.dict->find(key);
    if (ret != self.dict->end()) {
        contains = YES;
    }
    pthread_mutex_unlock(&_lock);
    return contains;
}

- (NSUInteger)totalCount {
    pthread_mutex_lock(&_lock);
    NSInteger size = (NSInteger)self.linkList->size();
    pthread_mutex_unlock(&_lock);
    return size;
}

#pragma mark - NSMutableCopying

- (id)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (void)dealloc
{
    pthread_mutex_destroy(&_lock);
}


@end
