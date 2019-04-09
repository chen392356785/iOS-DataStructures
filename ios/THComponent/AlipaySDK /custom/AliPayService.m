//
//  AliPayService.m
//  PayTest
//
//  Created by Chiang on 14-8-13.
//  Copyright (c) 2014年 Chiang. All rights reserved.
//

#import "AliPayService.h"
#import <AlipaySDK/AlipaySDK.h>

#import "AliPayConfig.h"

#import "AlixPayResult.h"

#pragma mark - Class AliPayService

@interface AliPayService ()

@property (nonatomic, copy) XMPaySchemeServiceResultBlock resultBlock;

@end

@implementation AliPayService

- (void)cancel
{
    self.resultBlock = nil;
}

- (instancetype)init
{
    if ((self = [super init])) {
    }
    return self;
}

#pragma mark - pay order with alipay sdk

- (void)alipayWithOrderString:(NSString *)orderString
                  resultBlock:(XMPaySchemeServiceResultBlock)resultBlock
{
    self.resultBlock = resultBlock;

    [[AlipaySDK defaultService] payOrder:orderString
                              fromScheme:kURLAlipayScheme
                                callback:^(NSDictionary *resultDic) {
                                  NSLog(@"reslut = %@", resultDic);
                                  AlixPayResult *result =
                                      [[AlixPayResult alloc] initWithDict:resultDic];
                                  [self alipayCallbackHandleWithResult:result];
                                }];
}

#pragma mark - alipay callback handle Methods

- (void)alipayCallbackHandleWithResult:(AlixPayResult *)result
{
    BOOL isPaySuccess = NO;

    if (result) {

        if (result.statusCode == 9000) {
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */

            //            //交易成功
            //            NSString *key = AlipayPubKey;
            //            id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //            if ([verifier verifyString:result.resultString
            //            withSign:result.signString]) {
            //                //验证签名成功，交易结果无篡改
            //                NSLog(@"交易成功,验证签名成功!");
            //
            //                isPaySuccess = YES;
            //
            //            } else {
            //                NSLog(@"交易成功,验证签名失败，交易结果可能被篡改!");
            //            }
            isPaySuccess = YES;

        } else {
            NSLog(@"交易失败! statusCode: %@ resultString: %@", @(result.statusCode),
                  result.statusMessage);
        }
    } else {
        NSLog(@"交易异常!");
    }

    if (self.resultBlock) {
        self.resultBlock(isPaySuccess, result.statusMessage);
        self.resultBlock = nil;
    }
}

#pragma mark - callback from alipay app

- (BOOL)alipayHandleOpenURL:(NSURL *)url
{
    //如果极简SDK不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.scheme isEqualToString:kURLAlipayScheme]) {
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService]
                processOrderWithPaymentResult:url
                              standbyCallback:^(NSDictionary *resultDic) {
                                AlixPayResult *result =
                                    [[AlixPayResult alloc] initWithDict:resultDic];

                                [self alipayCallbackHandleWithResult:result];
                              }];
        }
        return YES;
    }
    else{
        return NO;
    }
}


@end
