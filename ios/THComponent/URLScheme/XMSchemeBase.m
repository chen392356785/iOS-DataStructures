//
//  XMSchemeBase.m
//  xmLife
//  Created by Neely on 2018/4/27.
//

#import "XMSchemeBase.h"
#import "XMSchemeManager.h"

const XMSchemePriority XMSchemePriorityNormal = 0;
const XMSchemePriority XMSchemePriorityMiddle = 1000;
const XMSchemePriority XMSchemePriorityHigh = 2000;

@implementation XMSchemeBase

+ (void)commonLoad
{
    @autoreleasepool
    {
        if ([[self sharedInstance] needRegisterToManager]) {
            [[XMSchemeManager sharedInstance] registerScheme:[self sharedInstance]
                                                      forTag:[self class]];
        }
    }
}

+ (instancetype)sharedInstance
{
    NSAssert(NO, @"%@需要实现sharedInstance, 在.m添加‘MMSchemeCommonImplementation’",
             NSStringFromClass([self class]));
    return nil;
}

- (instancetype)init
{
    if ((self = [super init])) {
        [self registerAppService];
    }
    return self;
}

- (BOOL)needRegisterToManager
{
    return YES;
}

- (void)registerAppService
{
}

- (BOOL)canDealScheme:(XMSchemeData *)schemeData
{
    return YES;
}

- (BOOL)handleDealScheme:(XMSchemeData *)schemeData
{
    NSAssert(NO, @"%@需要实现处理handleDealScheme", NSStringFromClass([self class]));
    return NO;
}

- (XMSchemePriority)priority
{
    return XMSchemePriorityNormal;
}

@end
