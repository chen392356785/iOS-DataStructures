//
//  IHUtility+category.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IHUtility+category.h"


//#import "UMSocialUIManager.h"
@implementation IHUtility (category)

+(void)ViewAnimateWith:(UIView *)v{
	
	//    v.alpha=0;
	v.alpha=1;
	//    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
	//        v.alpha = 1.;
	//    } completion:^(BOOL finished) {
	//
	//    }];
	
}

+(void)addWaitingView{
	
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	
	[MBProgressHUD showHUDAddedTo:window animated:YES];
}
+(void)addWaitingViewText:(NSString *)textStr{
	
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
	hud.label.text = textStr;
}

+(void)removeWaitingView{	
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	[MBProgressHUD hideHUDForView:window animated:YES];
}

+ (void)OnlyShowTexHudPrompt:(NSString *)str {
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	
	[MBProgressHUD hideHUDForView:window animated:YES];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
	hud.label.text = str;
	// 再设置模式
	hud.mode = MBProgressHUDModeText;
	hud.label.font = sysFont(font(16));
	hud.bezelView.backgroundColor = kColor(@"#000000");
	hud.bezelView.alpha = 0.7;
	hud.label.textColor = [UIColor whiteColor];
	// 隐藏时候从父控件中移除
	hud.removeFromSuperViewOnHide = YES;
	// 1秒之后再消失
	[hud hideAnimated:YES afterDelay:1.5];
	//    [hud hide:YES afterDelay:1.8];
}
+ (void)ShowTexHudPrompt:(NSString *)str {
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	
	[MBProgressHUD hideHUDForView:window animated:YES];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
	hud.label.text = str;
	// 再设置模式
	hud.mode = MBProgressHUDModeText;
	hud.label.font = sysFont(font(16));
	hud.bezelView.backgroundColor = kColor(@"#000000");
	hud.bezelView.alpha = 0.5;
	hud.label.textColor = [UIColor whiteColor];
	// 隐藏时候从父控件中移除
	hud.removeFromSuperViewOnHide = YES;
}
+(void)addSucessView:(NSString *)str type:(int)type{
	
	dispatch_async(dispatch_get_main_queue(), ^{
		UIWindow* window = [UIApplication sharedApplication].keyWindow;
		[MBProgressHUD hideHUDForView:window animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
		hud.label.text = str;
		hud.label.numberOfLines = 2;
		// 设置图片
		if (type==1) {
			UIImage *img = [UIImage imageNamed:@"HUD_YES.png"];
			UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,img.size.width-20 , img.size.height-20)];
			imgView.image=img;
			hud.customView =imgView;
		}else if (type==2){
			UIImage *img=[UIImage imageNamed:@"HUD_NO.png"];
			UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,img.size.width-20 , img.size.height-20)];
			imgView.image=img;
			hud.customView = imgView;
		}
		
		// 再设置模式
		hud.mode = MBProgressHUDModeCustomView;
		
		// 隐藏时候从父控件中移除
		hud.removeFromSuperViewOnHide = YES;
		
		// 1秒之后再消失
		//        [hud hide:YES afterDelay:1.5];
		[hud hideAnimated:YES afterDelay:1.5f];
	});
	
	
	
}
+ (void) HudHidden {
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	[UIView animateWithDuration:0.01 animations:^{
		[MBProgressHUD hideHUDForView:window animated:YES];
	}];
	
}

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:email];
}


+(BOOL)validateWeb:(NSString *)web{
	NSString *webRegex = @"(\\bhttp(s)?://)?[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
	NSPredicate *webTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", webRegex];
	return [webTest evaluateWithObject:web];
}


+ (BOOL)checkPhoneValidate:(NSString*)str
{
	if (str == nil || [str length] == 0 ) {
		
		[IHUtility addSucessView:@"手机号码不能为空" type:2];
		return NO;
	}
	
	if([str length] != 11)
	{
		
		[IHUtility addSucessView:@"手机号码为11位" type:2];
		return NO;
	}
	
	return YES;
}

//是否为纯数字
//+ (BOOL)isPureNumandCharacters:(NSString *)string
//{
//    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
//    if(string.length > 0)
//    {
//        return NO;
//    }
//    return YES;
//}

+ (BOOL) IsEnableWIFI {
	return ([IHUtility networkStatus] == 2);
}

+(CGFloat)getNewImagesViewHeigh:(NSArray*)imgsArray imageWidth:(CGFloat)imageWidth{
	float heigh;
	
	if (imgsArray.count==1) {
		MTPhotosModel *obj=(MTPhotosModel *)[imgsArray objectAtIndex:0];
		float i;
		
		if (obj.imgHeigh>obj.imgWidth*1.8) {
			i=imageWidth/1.8/obj.imgWidth;
		}else{
			if (obj.imgWidth>imageWidth) {
				i=imageWidth/obj.imgWidth*0.5;
			}else{
				i=0.5;
			}
		}
		heigh=i* obj.imgHeigh;
		
	}
	else if (imgsArray.count==2){
		
		heigh=imageWidth/2-0.5;
		
	}else if (imgsArray.count==3){
		heigh=imageWidth +1 +imageWidth/2;
		//        heigh=imageWidth/3*2;
	}else if (imgsArray.count==4){
		heigh=imageWidth+1;
	}else if(imgsArray.count==5){
		float f=imageWidth/2;
		float f1=imageWidth/3;
		heigh=f+f1+1;
	}else if (imgsArray.count==6){
		float f1=imageWidth/3;
		heigh=f1*2+1;
	}else if (imgsArray.count==7){
		float f1=imageWidth/3;
		heigh=imageWidth+f1*2+2;
		
	}else if (imgsArray.count==8){
		float f=imageWidth/2;
		float f1=imageWidth/3;
		heigh=f+f1*2+2;
	}else if (imgsArray.count==9){
		float f1=imageWidth/3;
		heigh= f1*3+2;
	}else{
		heigh = 0.f;
	}
	return heigh+5;
}

//分享图片
+ (void)shareImageToPlatformType:(NSInteger )Type Image:(UIImage *) image controller:(UIViewController *)vc completion:(shareBackBlock)completion
{
	UMSocialPlatformType platformType;
	if (Type==0) {
		platformType=UMSocialPlatformType_WechatSession;
	}else if (Type == 1){
		platformType=UMSocialPlatformType_WechatTimeLine;
	}else {
		platformType = UMSocialPlatformType_Sina;
	}
	//创建分享消息对象
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//创建图片内容对象
	UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
	//如果有缩略图，则设置缩略图
	shareObject.thumbImage = [UIImage imageNamed:@"icon"];
	[shareObject setShareImage:image];
	
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
		NSLog(@"************Share fail with error %@*********",error);
		completion(data,error);
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			NSLog(@"response data is %@",data);
		}
	}];
}

//分享图片微信-朋友圈-QQ-QQ空间-微博
+(void)ShareImage:(UIImage *) image PlatformType:(NSInteger )type controller:(UIViewController*)vc{
	
	UMSocialPlatformType platformType;
	if (type==1) {
		platformType=UMSocialPlatformType_WechatSession;
	}else if (type==2){
		platformType=UMSocialPlatformType_WechatTimeLine;
	}else if ( type==3){
		platformType=UMSocialPlatformType_QQ;
	}else if (type==4){
		platformType=UMSocialPlatformType_Qzone;
	}else if (type==5){
		platformType=UMSocialPlatformType_Sina;
	}else{
		platformType=UMSocialPlatformType_UnKnown;
	}
	//设置文本
	//  messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//创建图片内容对象
	UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
	//如果有缩略图，则设置缩略图
	shareObject.thumbImage = [UIImage imageNamed:@"icon"];
	[shareObject setShareImage:image];
	
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			NSLog(@"response data is %@",data);
		}
	}];
	
}
+(void)SharePingTai:(NSString *)title url:(NSString *)url imgUrl:(NSString *)imgUrl content :(NSString *)content PlatformType:(NSInteger )type controller:(UIViewController*)vc completion:(DidSelectBlock)shareCompletion {
	
	NSError *error = nil;
	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]
										 options:0
										   error:&error];;
	
	
	UMShareWebpageObject *webObject;
	//创建分享消息对象
	if (imgUrl.length) {
		webObject= [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:data];
	}else{
		webObject= [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:Image(@"Icon-76.png")];
	}
	
	UMSocialPlatformType platformType;
	
	if (type==1) {
		platformType=UMSocialPlatformType_WechatSession;
	}else if (type==2){
		platformType=UMSocialPlatformType_WechatTimeLine;
	}else if ( type==3){
		platformType=UMSocialPlatformType_QQ;
	}else if (type==4){
		platformType=UMSocialPlatformType_Qzone;
	}else if (type==5){
		platformType=UMSocialPlatformType_Sina;
	}else{
		platformType=UMSocialPlatformType_UnKnown;
	}
	webObject.webpageUrl=url;
	//设置文本
	//  messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	messageObject.shareObject = webObject;
	
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			if (shareCompletion) {
				shareCompletion();
			}
			NSLog(@"response data is %@",data);
		}
	}];
	
}

/**
 
 * 计算指定时间与当前的时间差
 
 * @param compareDate   某一指定时间
 
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 
 */

+(NSString *) compareCurrentTime:(NSString *) compareDateStr
{
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	
	// 设置日期格式 为了转换成功
	if ([compareDateStr containsString:@"."]) {
		format.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
	}else {
		format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	}
	
	// NSString * -> NSDate *
	NSDate *date = [format dateFromString:compareDateStr];
	
	NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
	timeInterval = -timeInterval;
	long temp = 0;
	NSString *result;
	if (timeInterval < 60) {
		result = [NSString stringWithFormat:@"刚刚"];
	}
	else if((temp = timeInterval/60) <60){
		result = [NSString stringWithFormat:@"%ld分前",temp];
	}
	else if((temp = temp/60) <24){
		result = [NSString stringWithFormat:@"%ld小前",temp];
	}
	else if((temp = temp/24) <30){
		result = [NSString stringWithFormat:@"%ld天前",temp];
	}
	else if((temp = temp/30) <12){
		result = [NSString stringWithFormat:@"%ld月前",temp];
	}
	else{
		temp = temp/12;
		result = [NSString stringWithFormat:@"%ld年前",temp];
	}
	return  result;
}


+ (NSString *) compareCurrentTimeString:(NSString *) compareDateString
{
	if (compareDateString.length>0) {
		NSDateFormatter *date = [[NSDateFormatter alloc] init];
		// 设置日期格式 为了转换成功
		if ([compareDateString containsString:@"."]) {
			[date setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
		}else {
			[date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		}
		NSDate *compareDate = [date dateFromString:compareDateString];
		NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
		timeInterval = -timeInterval;
		
		NSDate *timeData = [NSDate date];
		//        NSTimeInterval time = 365 * 24 * 60 * 60;
		//        NSDate * lastYear = [timeData dateByAddingTimeInterval:-time];
		//        NSString * startDate = [date stringFromDate:lastYear];
		
		NSInteger temp = 0;
		NSString *result;
		
		if (timeInterval < 300) {
			
			result = [NSString stringWithFormat:@"刚刚"];
			
		}
		else if((temp = (timeInterval/60)/60) <24){
			NSString *hourStr = [[date stringFromDate:compareDate] substringWithRange:NSMakeRange(11, 5)];
			if ([IHUtility isSameDay:timeData date2:compareDate]) {
				result = [NSString stringWithFormat:@"%@",hourStr];
			}else {
				result = [NSString stringWithFormat:@"昨天 %@",hourStr];
			}
		}
		else if(temp < 48){
			NSString *nowDay = [IHUtility GetDayFromData:timeData];
			NSString *beforDay = [IHUtility GetDayFromData:compareDate];
			
			NSString *hourStr = [[date stringFromDate:compareDate] substringWithRange:NSMakeRange(11, 5)];
			NSString *monthStr = [[date stringFromDate:compareDate] substringWithRange:NSMakeRange(5, 5)];
			if ([nowDay intValue] - [beforDay intValue] >1) {
				result = [NSString stringWithFormat:@"%@",monthStr];
			}else {
				result = [NSString stringWithFormat:@"昨天 %@",hourStr];
			}
			
		}
		else if((temp = (temp/24)/30) <12){
			NSString *monthStr = [[date stringFromDate:compareDate] substringWithRange:NSMakeRange(5, 5)];
			result = [NSString stringWithFormat:@"%@",monthStr];
		}
		else{
			
			
			NSString *yearStr = [[date stringFromDate:compareDate] substringWithRange:NSMakeRange(0, 10)];
			result = [NSString stringWithFormat:@"%@",yearStr];
		}
		return  result;
	}else{
		return nil;
	}
}

#pragma mark - 生成订单号
//+(NSString *)genBillNo {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
//    return [formatter stringFromDate:[NSDate date]];
//}

+(NSMutableAttributedString *)changePartTextColor:(NSString *)string range:(NSRange)range value:(id)value
{
	NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
	[str addAttribute:NSForegroundColorAttributeName value:value range:range];
	
	return str;
}
@end

