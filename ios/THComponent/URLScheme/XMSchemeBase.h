//
//  XMSchemeBase.h
//  xmLife
//
//  Created by weihuazhang on 14-10-17.
//  Copyright (c) 2014年 PaiTao. All rights reserved.
//

/**
 *			使用说明
 *1.XMSchemeBase子类需要在.m实现类中加上 MMSchemeCommonImplementation
        用于调用将需要处理的scheme加入到manager
 *2.如果需要类似微信这种需要注册service的，子类在registerAppService中注册服务
 **/

#import <Foundation/Foundation.h>
#import "XMSchemeData.h"

typedef NSInteger XMSchemePriority;

UIKIT_EXTERN const XMSchemePriority XMSchemePriorityNormal;
UIKIT_EXTERN const XMSchemePriority XMSchemePriorityMiddle;
UIKIT_EXTERN const XMSchemePriority XMSchemePriorityHigh;

#undef MMSchemeCommonImplementation
#define MMSchemeCommonImplementation                                                               \
    +(void)load                                                                                    \
    {                                                                                              \
        [self commonLoad];                                                                         \
    }                                                                                              \
    +(instancetype)sharedInstance                                                                  \
    {                                                                                              \
        static dispatch_once_t once;                                                               \
        static id __singleton__ = nil;                                                             \
        dispatch_once(&once, ^{ __singleton__ = [[self alloc] init]; });                           \
        return __singleton__;                                                                      \
    }

@interface XMSchemeBase : NSObject
@property (nonatomic, readonly, assign) XMSchemePriority priority; //优先级Default=0

+ (void)commonLoad;
+ (instancetype)sharedInstance;

- (BOOL)needRegisterToManager;
- (void)registerAppService;

- (BOOL)canDealScheme:(XMSchemeData *)schemeData;
- (BOOL)handleDealScheme:(XMSchemeData *)schemeData;

@end
