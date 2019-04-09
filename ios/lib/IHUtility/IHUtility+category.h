//
//  IHUtility+category.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IHUtility.h"
 #import "SDImageCache.h"
//#import "Reachability.h"

typedef void (^shareBackBlock) (id data, NSError *error);

@class SDImageCache;
@interface IHUtility (category)

//验证手机号码
+ (BOOL)checkPhoneValidate:(NSString*)str;
+(void)addWaitingView;
+(void)addWaitingViewText:(NSString *)textStr;
+(void)removeWaitingView;
#pragma mark  调用appDelegate单例
+(void)addSucessView:(NSString*)str type:(int)type;
#pragma mark 仅文字提示1.5s消失
+ (void)OnlyShowTexHudPrompt:(NSString *)str;
#pragma mark 仅文字提示
+ (void)ShowTexHudPrompt:(NSString *)str;
+ (void) HudHidden;

//是否为纯数字
//+(BOOL)isPureNumandCharacters:(NSString *)str;

+ (BOOL) IsEnableWIFI ;

+ (BOOL) validateEmail:(NSString *)email;
+(BOOL)validateWeb:(NSString *)web;
+(CGFloat)getNewImagesViewHeigh:(NSArray*)imgsArray imageWidth:(CGFloat)imageWidth;

//分享图片二维码
+ (void)shareImageToPlatformType:(NSInteger )Type Image:(UIImage *) image controller:(UIViewController *)vc completion:(shareBackBlock) ShareCompletion;

//分享图片微信-朋友圈-QQ-QQ空间-微博
+(void)ShareImage:(UIImage *) image PlatformType:(NSInteger )type controller:(UIViewController*)vc;
+(void)SharePingTai:(NSString *)title url:(NSString *)url imgUrl:(NSString *)imgUrl content :(NSString *)content PlatformType:(NSInteger )type controller:(UIViewController*)vc completion:(DidSelectBlock)shareCompletion;
//已过去多少时间；
+(NSString *) compareCurrentTime:(NSString *) compareDateStr;
+ (NSString *) compareCurrentTimeString:(NSString *) compareDateString;

//+(NSString *)genBillNo;



//改变部分字体的颜色
+(NSMutableAttributedString *)changePartTextColor:(NSString *)string range:(NSRange)range value:(id)value;
+(void)ViewAnimateWith:(UIView *)v; 
@end
