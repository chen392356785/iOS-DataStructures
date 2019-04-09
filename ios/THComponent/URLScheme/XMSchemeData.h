//
//  XMSchemeData.h
//  xmLife
//
//  Created by weihuazhang on 14-10-17.
//  Copyright (c) 2014年 PaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XMSchemeData;
@class XMSchemeBase;
typedef void (^xmSchemeDealBlock)(XMSchemeData *resp);

typedef NS_OPTIONS(NSUInteger, XMOpenSchemeFromType){
    XMOpenSchemeFromAppModel = 1 << 0,        // 从内部某些模块跳转
    XMOpenSchemeFromInternalWebView = 1 << 1, // 从内嵌浏览器跳转
    XMOpenSchemeFromOtherApp = 1 << 2,        // 从其它App跳转
    XMOpenSchemeFromMessage = 1 << 3,         // IM & APNS
    XMOpenSchemeFromQRCode = 1 << 4,          // 来自二维码
    XMOpenSchemeFromSHOWVC = 1 << 5,          // 调用显示视图
};

@interface XMSchemeData : NSObject <NSCopying>

- (instancetype)initWithStringUrl:(NSString *)url;
- (instancetype)initWithURL:(NSURL *)URL;
//- (instancetype)initWithStringUrl:(NSString *)url fromType:(XMOpenSchemeFromType)fromType;
//- (instancetype)initWithURL:(NSURL *)URL fromType:(XMOpenSchemeFromType)fromType;
//- (instancetype)initWithStringUrl:(NSString *)url dictParam:(NSDictionary *)dictParam;
//- (instancetype)initWithURL:(NSURL *)URL dictParam:(NSDictionary *)dictParam;
//- (instancetype)initWithSchemeData:(XMSchemeData *)schemeData;

@property (nonatomic, strong) UIApplication *application;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSString *dealedSchemeUrl;
@property (nonatomic, copy) NSString *sourceApplication;
@property (nonatomic, strong) id annotation;

@property (nonatomic, copy) xmSchemeDealBlock dealBlock; //处理完成回调
@property (nonatomic, assign) XMOpenSchemeFromType fromType;
@property (nonatomic, weak) UIViewController *fromViewController;
@property (nonatomic, strong) UIViewController *targetViewController;

@property (nonatomic, strong) NSDictionary *dictParam;
@property (nonatomic, copy) NSArray *arrData;
@property (nonatomic, strong) id otherParam;

//+ (XMSchemeData *)defaultSchemeData:(NSString *)url viewController:(UIViewController *)vc;

//- (BOOL)canDealSchemeUrl:(NSString *)schemePrefix;

@end
