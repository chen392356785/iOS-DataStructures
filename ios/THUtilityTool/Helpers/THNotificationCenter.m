//
//  THNotificationCenter.m
//  Owner
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import "THNotificationCenter.h"

@interface THNotificationCenter ()
{
    NSHashTable *delegates;
}
@end

@implementation THNotificationCenter


static THNotificationCenter *instance = nil;

+ (THNotificationCenter *)singleton
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [[THNotificationCenter alloc] init];
            return instance;
        }
    }
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        delegates = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    }
    return self;
}

- (void)addDeletegate:(id<CCAppDelegate>)d
{
    [delegates addObject:d];
}

- (void)removeDeletegate:(id<CCAppDelegate>)d
{
    [delegates removeObject:d];
}

- (NSHashTable *)getDelegateCopy
{
    return [delegates copy];
}

- (void)notifySelector:(SEL)selector
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSHashTable *delegatesCopy = [self getDelegateCopy];
        for (id<CCAppDelegate> d in delegatesCopy) {
            if ([d respondsToSelector:selector])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [d performSelector:selector];
#pragma clang diagnostic pop
            }
        }
    });
}

- (void)notifySelector:(SEL)selector withObject:(id)obj
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSHashTable *delegatesCopy = [self getDelegateCopy];
        for (id<CCAppDelegate> d in delegatesCopy) {
            if ([d respondsToSelector:selector])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [d performSelector:selector withObject:obj];
#pragma clang diagnostic pop
            }
        }
    });
}


- (void)notifySignout
{
    [self notifySelector:@selector(onSignout)];
}

- (void)notifyKickout
{
    [self notifySelector:@selector(onKickout)];
}

- (void)notifyUserBlocked
{
    [self notifySelector:@selector(onUserBlocked)];
}

- (void)notifyDeviceBlocked
{
    [self notifySelector:@selector(onDeviceBlocked)];
}

- (void)notifyLoginSuccess
{
    [self notifySelector:@selector(onLoginSuccess)];
}

- (void)notifyNetWorkFailed
{
    [self notifySelector:@selector(onNetworkFailed)];
}

- (void)notifyNetWorkSuccess
{
    [self notifySelector:@selector(onNetworkSuccess)];
}

@end
