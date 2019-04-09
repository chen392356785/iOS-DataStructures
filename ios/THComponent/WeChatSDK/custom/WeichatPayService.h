//
//  WeichatPayService.h
//  PayTest
//
//  Created by Chiang on 14-8-14.
//  Copyright (c) 2014年 Chiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPaySchemeService.h"

@class PayResp;

@interface WeichatPayService : NSObject

//- (void)payHandlerWithUrl:(NSURL *)url;     //微信支付完成

- (void)weichatPayWithPrepayData:(NSDictionary *)prepayData
                     resultBlock:(XMPaySchemeServiceResultBlock)resultBlock;

- (void)onResp:(PayResp *)resp;

- (void)cancel;

@end
