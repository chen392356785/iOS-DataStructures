//
//  DFToolView.h
//  DF
//
//  Created by Tata on 2017/11/25.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "WXApi.h"
#import <Foundation/Foundation.h>

@interface DFTool : NSObject

+(void)alertMessage:(NSString *)title message:(NSString *)message;

+ (void)addWaitingView:(UIView *)superView;
//+ (void)addWaitingView:(NSString *)tips superView:(UIView *)superView;
+ (void)removeWaitingView:(UIView *)superView;

+ (void)addNothingView:(UIView *)view frame:(CGRect)frame;
+ (void)removeNothingView:(UIView *)view;

+ (void)showTips:(NSString *)tips;

#pragma mark 分享
/**
 *  分享指定平台
 *
 *  @param title               分享标题
 *  @param content             分享内容
 *  @param urlStr              分享的图片地址
 *  @param presentedController 哪个界面去分享
 *  @param arrayType           分享的类型 例如：QQ分享、微信分享
 */
//+(void)shareWXWithTitle:(NSString *)title andContent:(NSString *)content andContentURL:(NSString *)contentUrl andUrlImage:(NSString *)urlStr andPresentedController:(UIViewController *)presentedController withType:(NSArray *)arrayType result:(void(^)(UMSocialResponseEntity * shareResponse))result;

//+ (void)shareImageWith:(UIImage *)image andPresentedController:(UIViewController *)presentedController withType:(NSString *)type result:(void(^)(UMSocialResponseEntity * shareResponse))result;

+ (NSString *)getVerificationCode:(int)from to:(int)to;

+ (void)saveUserInfo:(NSDictionary *)dic;

+ (BOOL)phone_CheckMobilePhoneValidate:(NSString *)phoneNum;

+ (UIImage*)image_NewImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

+(NSString *)time_DateConversionHoweSeconds:(NSDate *)date;

+(int)math_getRandomNumber:(int)from to:(int)to;

+(NSString *)md5:(NSString *)inputStr;

@end
