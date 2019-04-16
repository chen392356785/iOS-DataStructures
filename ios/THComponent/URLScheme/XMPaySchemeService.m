//
//  XMPaySchemeService.m
//  xmLife
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import "XMPaySchemeService.h"
#import "AliPayService.h"
#import "WeichatPayService.h"
//#import "WXApi.h"

@implementation XPayProduct

@end

@interface XMPaySchemeService () <WXApiDelegate>

@property (nonatomic, strong) AliPayService *alipay;
@property (nonatomic, strong) WeichatPayService *weichatPay;

@end

@implementation XMPaySchemeService
MMSchemeCommonImplementation;

- (instancetype)init
{
    if ((self = [super init])) {
        self.alipay = [[AliPayService alloc] init];
        self.weichatPay = [[WeichatPayService alloc] init];
    }
    return self;
}

- (void)cancel
{
    [self.alipay cancel];
    [self.weichatPay cancel];
}

- (BOOL)canDealScheme:(XMSchemeData *)schemeData
{
    return schemeData.fromType == XMOpenSchemeFromOtherApp || schemeData.fromType == XMOpenSchemeFromInternalWebView;
}

- (BOOL)handleDealScheme:(XMSchemeData *)schemeData
{
    BOOL handleDealScheme = NO;
    handleDealScheme = ([self.alipay alipayHandleOpenURL:schemeData.url]);
    // 微信 从  XMShareSchemeService 入口处理
    //    handleDealScheme = ([WXApi handleOpenURL:schemeData.url delegate:self]);
    return handleDealScheme;
}

#pragma mark---
// 处理微信 支付 回调
//- (void)weichatPayCallBack:(PayResp *)resp
//{
//    [self.weichatPay onResp:resp];
//}

#pragma mark - pay order with alipay sdk
+ (void)alipayWithOrderString:(NSString *)orderString
                  resultBlock:(XMPaySchemeServiceResultBlock)resultBlock
{
    XMPaySchemeService *payService = [self sharedInstance];
    [payService.alipay alipayWithOrderString:orderString resultBlock:resultBlock];
}

#pragma mark - weichat pay

+ (void)weichatPayWithPrepayData:(NSDictionary *)prepayData
                     resultBlock:(XMPaySchemeServiceResultBlock)resultBlock
{
    XMPaySchemeService *payService = [self sharedInstance];
    [payService.weichatPay weichatPayWithPrepayData:prepayData resultBlock:resultBlock];
}
+ (void)payHandlerWithUrl:(NSURL *)url {
    XMPaySchemeService *payService = [self sharedInstance];
    [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)payService.weichatPay];
}


@end
