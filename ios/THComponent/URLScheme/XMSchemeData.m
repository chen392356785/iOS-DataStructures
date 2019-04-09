//
//  XMSchemeData.m
//  xmLife
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import "XMSchemeData.h"

@implementation XMSchemeData

- (instancetype)initWithStringUrl:(NSString *)url
{
    self = [self init];
    if (self) {
        self.url = [NSURL URLWithString:url];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL
{
    self = [self init];
    if (self) {
        self.url = URL;
    }
    return self;
}

//- (instancetype)initWithSchemeData:(XMSchemeData *)schemeData
//{
//    self = [self init];
//    if (self) {
//        [self copySchemeData:schemeData toData:self];
//    }
//    return self;
//}

//- (instancetype)initWithStringUrl:(NSString *)url fromType:(XMOpenSchemeFromType)fromType
//{
//    self = [self init];
//    if (self) {
//        self.url = [NSURL URLWithString:url];
//        self.fromType = fromType;
//    }
//    return self;
//}

//- (instancetype)initWithURL:(NSURL *)URL fromType:(XMOpenSchemeFromType)fromType
//{
//    if ((self = [self init])) {
//        self.url = URL;
//        self.fromType = fromType;
//    }
//    return self;
//}
//
//- (instancetype)initWithStringUrl:(NSString *)url dictParam:(NSDictionary *)dictParam
//{
//    if ((self = [self init])) {
//        self.url = [NSURL URLWithString:url];
//        self.dictParam = dictParam;
//    }
//    return self;
//}

//- (instancetype)initWithURL:(NSURL *)URL dictParam:(NSDictionary *)dictParam
//{
//    if ((self = [self init])) {
//        self.url = URL;
//        self.dictParam = dictParam;
//    }
//    return self;
//}

- (instancetype)init
{
    if ((self = [super init])) {
        self.fromType = XMOpenSchemeFromAppModel;
    }
    return self;
}

- (void)copySchemeData:(XMSchemeData *)fromData toData:(XMSchemeData *)toData
{
    toData.application = fromData.application;
    toData.url = fromData.url;
    toData.sourceApplication = fromData.sourceApplication;
    toData.annotation = fromData.annotation;
    toData.dealedSchemeUrl = fromData.dealedSchemeUrl;

    toData.dealBlock = fromData.dealBlock;
    toData.fromType = fromData.fromType;

    toData.dictParam = fromData.dictParam;
    toData.arrData = fromData.arrData;
    toData.otherParam = fromData.otherParam;
}

- (id)copyWithZone:(NSZone *)zone
{
    XMSchemeData *copyData = [[[self class] allocWithZone:zone] init];
    [self copySchemeData:self toData:copyData];
    return copyData;
}

- (void)setFromViewController:(UIViewController *)fromViewController
{
}

- (UIViewController *)fromViewController
{
    return self.fromViewController;
}

- (void)setTargetViewController:(UIViewController *)targetViewController
{
}

- (UIViewController *)targetViewController
{
    return self.targetViewController;
}

#pragma mark - private api
//
//+ (XMSchemeData *)defaultSchemeData:(NSString *)url viewController:(UIViewController *)vc
//{
//    if (url.length == 0)
//        return nil;
//    XMSchemeData *schemeData = [[self alloc] initWithStringUrl:url];
//    schemeData.fromViewController = vc;
//    schemeData.fromType = XMOpenSchemeFromAppModel;
//
//    return schemeData;
//}

//- (BOOL)canDealSchemeUrl:(NSString *)schemePrefix
//{
//    if ([_url.absoluteString hasPrefix:schemePrefix]) {
//        _dealedSchemeUrl = [_url.absoluteString substringFromIndex:schemePrefix.length];
//        return YES;
//    }
//    return NO;
//}

@end
