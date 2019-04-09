//
//  AliPayService.h
//  PayTest
//
//  Created by Chiang on 14-8-13.
//  Copyright (c) 2014年 Chiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMPaySchemeService.h"

@interface AliPayService : NSObject

- (void)alipayWithOrderString:(NSString *)orderString
                  resultBlock:(XMPaySchemeServiceResultBlock)resultBlock;

- (BOOL)alipayHandleOpenURL:(NSURL *)url;

- (void)cancel;

@end
