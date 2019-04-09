//
//  XMPaySchemeService.h
//  xmLife
//
//  Created by weihuazhang on 14-10-17.
//  Copyright (c) 2014年 PaiTao. All rights reserved.
//

#import "XMSchemeBase.h"

typedef void (^XMPaySchemeServiceResultBlock)(BOOL isPaySuccess, NSString *errMsg);

@interface XPayProduct : NSObject

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSMutableArray *dealIds;

@end

@interface XMPaySchemeService : XMSchemeBase

- (void)cancel;
//- (void)weichatPayCallBack:(id)resp;

// alipay
+ (void)alipayWithOrderString:(NSString *)orderString
                  resultBlock:(XMPaySchemeServiceResultBlock)resultBlock;


// weichat pay
+ (void)payHandlerWithUrl:(NSURL *)url;
+ (void)weichatPayWithPrepayData:(NSDictionary *)prepayData
                     resultBlock:(XMPaySchemeServiceResultBlock)resultBlock;


@end
