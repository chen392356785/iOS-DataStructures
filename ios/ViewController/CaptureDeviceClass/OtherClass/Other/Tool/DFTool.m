//
//  DFToolView.m
//  DF
//
//  Created by Tata on 2017/11/25.
//  Copyright © 2017年 Tata. All rights reserved.
//

//#import "DFTool.h"
#import "TFTipsView.h"
#import "TFProgressHUD.h"
//#import <CommonCrypto/CommonCrypto.h>

@implementation DFTool

+ (void)addNothingView:(UIView *)view frame:(CGRect)frame {
    CGSize size = frame.size;
    CGPoint orgin = frame.origin;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, orgin.y, size.width, size.height)];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.tag = 8888;
    
    CGFloat orginX = (size.width - 164) / 2;
    CGFloat orginY = size.height /4;
    
    UIView *nothingView = [[UIView alloc] init];
    nothingView.frame = CGRectMake(orginX, orginY, 164, 150);
    [backgroundView addSubview:nothingView];
    
    //图片
    UIImageView *resultImgView = [[UIImageView alloc] init];
    resultImgView.image = kImage(@"icon_noOrder");
    resultImgView.frame = CGRectMake(0, 0, 164, 112);
    [nothingView addSubview:resultImgView];
    
    
    UILabel *resultLab = [[UILabel alloc] init];
    resultLab.text = @"暂无内容";
    resultLab.textColor = THBaseColor;
    resultLab.font = kLightFont(14);
    resultLab.textAlignment = NSTextAlignmentCenter;
    resultLab.frame = CGRectMake(0, CGRectGetMaxY(resultImgView.frame) + 18, 164, 20);
    [nothingView addSubview:resultLab];
    
    [view addSubview:backgroundView];
}

+ (void)removeNothingView:(UIView *)view {
    UIView * aview = [view viewWithTag:8888];
    if (aview == nil) {
        return;
    }
    [aview removeFromSuperview];
    aview = nil;
}

#pragma mark 提示
+(void)alertMessage:(NSString *)title message:(NSString *)message
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

+ (void)addWaitingView:(UIView *)superView {
    TFProgressHUD *HUD = [[TFProgressHUD alloc]initWithType:kTFProgressHUDTypeCycleAndTips];
    HUD.tag = 9999;
    [HUD show];
    [superView addSubview:HUD];
}

//+ (void)addWaitingView:(NSString *)tips superView:(UIView *)superView {
//    TFProgressHUD *HUD = [[TFProgressHUD alloc]initWithType:kTFProgressHUDTypeCycleAndTips];
//    HUD.tag = 9999;
//    HUD.message = tips;
//    [HUD show];
//    [superView addSubview:HUD];
//}

+ (void)removeWaitingView:(UIView *)superView {
    UIView * aview = [superView viewWithTag:9999];
    if (aview==nil)
    {
        return;
    }
    if ([aview isKindOfClass:[TFProgressHUD class]]) {
        TFProgressHUD *HUD = (TFProgressHUD *)aview;
        [HUD dismiss];
        [HUD removeFromSuperview];
    }
    aview=nil;
}


+ (void)showTips:(NSString *)tips {
    TFTipsView *tipsView = [[TFTipsView alloc]initWithType:kTFTipsTypeCenter];
    tipsView.tips = tips;
    [tipsView show];
    UIWindow * window=[[UIApplication sharedApplication]keyWindow];
    [window addSubview:tipsView];
    
    TTDispatchAsync(^{
        sleep(1.5);
        TTDispatchMainSync(^{
            [tipsView dismiss];
        });
    });
}

#pragma mark 分享
/*/
//直接分享
+(void)shareWXWithTitle:(NSString *)title andContent:(NSString *)content andContentURL:(NSString *)contentUrl andUrlImage:(NSString *)urlStr andPresentedController:(UIViewController *)presentedController withType:(NSArray *)arrayType result:(void(^)(UMSocialResponseEntity * shareResponse))result
{
    NSString *codeUrl = [contentUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [UMSocialData defaultData].extConfig.title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url  = codeUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = codeUrl;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    
    [UMSocialData defaultData].extConfig.qqData.title = title;// QQ分享title
    [UMSocialData defaultData].extConfig.qqData.url = codeUrl;// QQ分享url
    
    [UMSocialData defaultData].extConfig.qzoneData.title = title;// Qzone分享title
    [UMSocialData defaultData].extConfig.qzoneData.url = codeUrl;// Qzone分享url
    
    
    
    [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"%@,%@",title,codeUrl];
    [UMSocialData defaultData].extConfig.sinaData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]];
    
    UMSocialDataService * sevice = [UMSocialDataService defaultDataService];
    
    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionCenter];
    
    [sevice postSNSWithTypes:arrayType content:content image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]] location:nil urlResource:nil presentedController:presentedController completion:^(UMSocialResponseEntity * shareResponse)
     {
         result(shareResponse);
     }];
}

+ (void)shareImageWith:(UIImage *)image andPresentedController:(UIViewController *)presentedController withType:(NSString *)type result:(void(^)(UMSocialResponseEntity * shareResponse))result {
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
    [UMSocialData defaultData].extConfig.qzoneData.title = @" ";
    UMSocialDataService * sevice = [UMSocialDataService defaultDataService];
    
    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionCenter];
    
    [sevice postSNSWithTypes:@[type] content:@"" image:image location:nil urlResource:nil presentedController:presentedController completion:^(UMSocialResponseEntity * shareResponse)
     {
         result(shareResponse);
     }];
}
//*/
+ (NSString *)getVerificationCode:(int)from to:(int)to {
    return [NSString stringWithFormat:@"%d", (from + (arc4random() % (to - from + 1)))];
}

+ (void)saveUserInfo:(NSDictionary *)dic {
    if (dic==nil || ![dic isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
    /*1、保存用户信息到本地*/
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Id"]] forKey:@"Id"];
    [userDefault setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Nick"]]      forKey:@"Nick"];
    [userDefault setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserName"]]         forKey:@"UserName"];
    [userDefault setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"UAgent"]]           forKey:@"UAgent"];
    [userDefault setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"GenderType"]]          forKey:@"GenderType"];
    [userDefault setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"LoginType"]]          forKey:@"LoginType"];
    [userDefault setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Signature"]]  forKey:@"Signature"];
    [userDefault setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"HeadImage"]]  forKey:@"HeadImage"];
    [userDefault setBool:YES forKey:@"login"];
    
    [userDefault synchronize];
    
    /*2、用户信息赋值*/
    UserModel.Id        =[userDefault objectForKey:@"Id"];
    UserModel.Nick  =[userDefault objectForKey:@"Nick"];
    UserModel.UserName    =[userDefault objectForKey:@"UserName"];
    UserModel.UAgent  =[userDefault objectForKey:@"UAgent"];
    UserModel.GenderType  =[userDefault objectForKey:@"GenderType"];
    UserModel.LoginType =[userDefault objectForKey:@"LoginType"];
    UserModel.Signature =[userDefault objectForKey:@"Signature"];
    UserModel.HeadImage =[userDefault objectForKey:@"HeadImage"];
    UserModel.isLogin       =[userDefault boolForKey:@"login"];
    
}

+ (BOOL)phone_CheckMobilePhoneValidate:(NSString *)phoneNum
{
    NSString * regEx = @"^\\s$";
    if (phoneNum == nil || [phoneNum length] == 0 || [self text_Regex:phoneNum andRegex:regEx])
    {
        [self showTips:@"请输入您的手机号"];
        return NO;
    }
    
    if([phoneNum length]!= 11)
    {
        [self showTips:@"抱歉,您的手机号码格式有误"];
        
        return NO;
    }
    
    regEx = @"\\d{11}";
    if (![self text_Regex:phoneNum andRegex:regEx])
    {
        [self showTips:@"抱歉,您的手机号码格式有误"];
        return NO;
    }
    return YES;
}

+ (BOOL)text_Regex:(NSString *)str andRegex:(NSString*)regex
{
    NSPredicate * phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [phoneTest evaluateWithObject:str];
}


+ (UIImage*)image_NewImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSString *)time_DateConversionHoweSeconds:(NSDate *)date
{
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",timeStamp*1000];
}

+(int)math_getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to- from + 1)));
}

+(NSString *)md5:(NSString *)inputStr
{
    const char * cStr = [inputStr UTF8String];
    unsigned char result[16];
    // This is the md5 call
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
