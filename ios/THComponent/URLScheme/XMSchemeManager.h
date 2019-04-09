//
//  XMSchemeManager.h
//  xmLife
//
//  Created by weihuazhang on 14-10-17.
//  Copyright (c) 2014年 PaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMSchemeBase.h"

@interface XMSchemeManager : NSObject

+ (instancetype)sharedInstance;

- (void)registerScheme:(XMSchemeBase *)scheme forTag:(id)tag;
//- (XMSchemeBase *)schemeForTag:(id)tag;

- (BOOL)handleDealScheme:(XMSchemeData *)schemeData;

@end
