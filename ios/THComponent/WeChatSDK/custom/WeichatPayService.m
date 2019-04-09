//
//  WeichatPayService.m
//  PayTest
//
//  Created by Chiang on 14-8-14.
//  Copyright (c) 2014年 Chiang. All rights reserved.
//

#import "WeichatPayService.h"
//#import "WeichatPayConfig.h"
//
//#import "WXApi.h"
//#import "NSString+Extents.h"
//
//#import "AFNetworking.h"

@interface WeichatPayService () 

@property (nonatomic, copy) XMPaySchemeServiceResultBlock resultBlock;

@end

@implementation WeichatPayService

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

//- (void)payHandlerWithUrl:(NSURL *)url{
//    [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
//}

#pragma mark - WXApiDelegate Methods

// weichat callback handle Methods
- (void)onResp:(PayResp *)resp
{
    BOOL isPaySuccess = NO;

    PayResp *response = (PayResp *)resp;
    switch (response.errCode) {
    case WXSuccess: {
        isPaySuccess = YES;
    } break;
    default: {
       NSLog(@"支付错误： errcode : %@", @(resp.errCode));
    } break;
    }

    if (resp.errStr == nil) {
        resp.errStr = @"支付异常，请重试！";
    }

    if (self.resultBlock) {
        self.resultBlock(isPaySuccess, resp.errStr);
        self.resultBlock = nil;
    }
}

#pragma mark - pay order with weichat sdk

- (void)weichatPayWithPrepayData:(NSDictionary *)prepayData
                     resultBlock:(XMPaySchemeServiceResultBlock)resultBlock
{
    self.resultBlock = resultBlock;

    [self sendDataWithDict:prepayData];
}

- (void)sendDataWithDict:(NSDictionary *)dict
{
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = dict[@"partnerid"];
    request.prepayId = dict[@"prepayid"];
    request.package = dict[@"package"];
    request.nonceStr = dict[@"noncestr"];
    request.timeStamp = (UInt32)[dict[@"timestamp"] integerValue];
    request.sign = dict[@"sign"];
    [WXApi sendReq:request];
    //废弃
//    [WXApi safeSendReq:request];
}

@end
