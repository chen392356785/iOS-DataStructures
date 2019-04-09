//
//  AppDelegate.m
//  SkillExchange
//
//  Created by lfl on 15-3-3.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <MAMapKit/MAMapKit.h>
//#import <AMapSearchKit/AMapSearchAPI.h>
//#import <AMapSearchKit/AMapSearchKit.h>
//
//#import <YZBase/YZBase.h>
#import "StartViewController.h"

#import "XMPaySchemeService.h"

//#import "LaunchPageView.h"
#import "BeeCloud.h"
#import "THRootNavigationViewController.h"
#import "xmSchemeManager.h"

//#import <UserNotifications/UserNotifications.h>

//友盟统计
//#import "MobClick.h"
#import "UMCommon.h"
//#import "UMCommonLogManager.h"
//友盟消息推送
//#import <UMPush/UMessage.h>
//友盟更新
#import "UMCheckUpdate.h"
//友盟社会化分享
#import "WXApi.h"
#import <UMShare/UMShare.h>


#ifdef APP_MiaoTu

#define  kStoreAppId                @"1080191917"
//例如只在中国地区发布, 根据实际情况去配置
#define ITUNES_CHECKVERSION_URL    @"http://itunes.apple.com/lookup?id=1080191917"
#define ITUNES_HOME_URL                  @"https://itunes.apple.com/us/app/id1080191917?ls=1&mt=8"

#elif defined APP_YiLiang

#define  kStoreAppId                @"1178834496"
//例如只在中国地区发布, 根据实际情况去配置
#define ITUNES_CHECKVERSION_URL    @"http://itunes.apple.com/lookup?id=1178834496"
#define ITUNES_HOME_URL                  @"https://itunes.apple.com/us/app/id1178834496?ls=1&mt=8"

#endif

#define WXAppId @"wxeab3fe32632897e3"           //-----------------微信APPID

#define  kStoreAppId_yiliang                @"1178834496"
//#import <JSPatch/JSPatch.h>
#define DEFAULT_ITUNES_CHECKVERSION_URL    @"http://itunes.apple.com/lookup?id=%@"
#define DEFAULT_ITUNES_HOME_URL @"https://itunes.apple.com/us/app/id%@?ls=1&mt=8"



//有赞商城
static NSString *appID = @"0bd1f32440c9ea8dc1";
static NSString *appSecret = @"abecb41a237d63cfcdcdf27bb5f6bd14";
static NSString *userAgent = @"097fce92c454b02dab1471917755554";


@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate


- (void)initAutoScaleSize{
	
	
	
	if (kScreenHeight == 480) {
		//4s
		_autoSizeScaleW = kScreenWidth / 375;
		_autoSizeScaleH = kScreenHeight / 667;
		
	}else if (kScreenHeight == 568) {
		//5
		_autoSizeScaleW = kScreenWidth / 375;
		_autoSizeScaleH = kScreenHeight / 667;
	}else if (kScreenHeight ==667){
		//6
		_autoSizeScaleW = kScreenWidth / 375;
		_autoSizeScaleH = kScreenHeight / 667;
	}else if(kScreenHeight == 736){
		//6p
		_autoSizeScaleW = kScreenWidth / 375;
		_autoSizeScaleH = kScreenHeight / 667;
	}else{
		_autoSizeScaleW = 1;
		_autoSizeScaleH = 1;
	}
	
}

- (CGFloat)autoScaleW:(CGFloat)w{
	
	return w * self.autoSizeScaleW;
	
}

- (CGFloat)autoScaleH:(CGFloat)h{
	
	return h * self.autoSizeScaleH;
	
}

+ (AppDelegate *)sharedAppDelegate
{
	AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
	return app;
}

/**
 配置友盟统计分析代码
 */
- (void) configurationUMCAnalytics {
	
	/// 配置友盟SDK产品并并统一初始化
	[UMConfigure setEncryptEnabled:YES]; // optional: 设置加密传输, 默认NO.
	[UMConfigure initWithAppkey:@"56a32e3667e58eb3d2000f67" channel:@"App Store"];
	[MobClick setScenarioType:E_UM_NORMAL];
	///关闭日志收集 改为 Bugly 收集错误信息
	[MobClick setCrashReportEnabled:YES];
	//开发者需要显式的调用此函数，日志系统才能工作
//	[UMCommonLogManager setUpUMCommonLogManager];
#if DEBUG
	[UMConfigure setLogEnabled:YES];
#endif
	
}

/**
 友盟更新SDK初始化
 */
- (void) configurationUMUpdate {
	[UMCheckUpdate setLogEnabled:YES];
	[UMCheckUpdate checkUpdateWithAppID:kStoreAppId];
}

/**
 友盟分享
 */
- (void) configurationUMShare {
	
	[[UMSocialManager defaultManager] openLog:YES];
	//配置微信平台分享
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxeab3fe32632897e3" appSecret:@"57bd081ad1ec70a146006ebcfa302b57" redirectURL:@"http://mobile.umeng.com/social"];
	//配置QQ平台分享
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105083809"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
	//配置微博平台分享
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3487655197"  appSecret:@"3849eb7f76d07349355b04fd0e45be2e" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
	
}

- (void) ammapInit {
	
	NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
	if ([identifier isEqualToString:@"com.yuanquan8.MiaoTu"]) {
		[AMapServices sharedServices].apiKey =KAmapKey;
		[AMapServices sharedServices].apiKey=KAmapKey;//绑定地图key
	} else if([identifier isEqualToString:@"com.infoholdTest.test"]) {
		[AMapServices sharedServices].apiKey =KAmapKey2;
		[AMapServices sharedServices].apiKey=KAmapKey2;//绑定地图key
	} else if ([identifier isEqualToString:@"com.yuanquan8.yiliang"]){
		[AMapServices sharedServices].apiKey = KAmapKeyYL;
		[AMapServices sharedServices].apiKey = KAmapKeyYL;//绑定地图key
	}
	
}

-(void)shareInit {
	//配置友盟统计分析a
	[self configurationUMCAnalytics];
	//友盟更新SDK
	[self configurationUMUpdate];
	//友盟分享
	[self configurationUMShare];
}

NSUncaughtExceptionHandler* _uncaughtExceptionHandler = nil;
void UncaughtExceptionHandler(NSException *exception) {
	NSLog(@"CRASH: %@", exception);
	NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
	
	// 异常的堆栈信息
	NSArray *stackArray = [exception callStackSymbols];
	// 出现异常的原因
	NSString *reason = [exception reason];
	// 异常名称
	NSString *name = [exception name];
	
	NSString *syserror = [NSString stringWithFormat:@"mailto://263794169@qq.com?subject=苗途bug报告&body=感谢您的配合,我们会再接再厉,努力完善!<br><br><br>"
						  "System Detail:%@_%@_%@\n"
						  "Error Detail:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",VERSION_CODE,VERSION,[UIDevice currentDevice].systemVersion,
						  name,reason,[stackArray componentsJoinedByString:@"<br>"]];
	
	NSURL *url = [NSURL URLWithString:[syserror stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:url];
	return;
}
//iOS适配
- (void) adapterIos11 {
#ifndef __IPHONE_11_0
#define __IPHONE_11_0    110000
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
	if (@available(iOS 11.0, *)) {
		
	} else {
		
	}
#endif
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self adapterIos11];
	[self initAutoScaleSize];  //初始化自动字体
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	[self configOwnViews];
	[self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
	//
	//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	//    center.delegate = self;
	//    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
	//    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
	//        if (granted) {
	//            //点击允许
	//            //这里可以添加一些自己的逻辑
	//        } else {
	//            //点击不允许
	//            //这里可以添加一些自己的逻辑
	//        }
	//    }];
	//打开日志，方便调试
	//    [UMessage setLogEnabled:YES];
	
	
	//    //集成有赞商城
	//    [YZSDK setOpenInterfaceAppID:appID appSecret:appSecret];
	//
	//    //设置UA
	//    [YZSDK userAgentInit:userAgent version:@""];
	
	//V2.9.17 取消后可以跳转商城
	//    [YZSDK setOpenDebugLog:NO];
	//    [YZSDK setUserAgent:userAgent];
	
	[self getLocationData];
	
	_uncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
	NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
	
	
	//   [JSPatch startWithAppKey:@"3b385ab74f862856"];
	//
	//#ifdef DEBUG
	//    [JSPatch setupDevelopment];
	//#endif
	//    [JSPatch sync];
	
	///高德产品初始化
	[self ammapInit];
	///友盟产品初始化
	[self shareInit];
	
#ifdef Production
	
	[BeeCloud initWithAppID:@"5c9ac31c-4f6a-44c1-911c-4e0d7acd58b1" andAppSecret:@"c92a8421-3d9e-44f1-a0c4-8949e8daf56f"];
	
#else
	
	[BeeCloud initWithAppID:@"5c9ac31c-4f6a-44c1-911c-4e0d7acd58b1" andAppSecret:@"8bd09c42-7a75-48af-b06c-11694f40c656"];
	
	//  [BeeCloud initWithAppID:@"5c9ac31c-4f6a-44c1-911c-4e0d7acd58b1" andAppSecret:@"8bd09c42-7a75-48af-b06c-11694f40c656" sandbox:YES];
#endif
	
	
#ifdef APP_MiaoTu
	//
	//向微信注册,发起支付必须注册
	[WXApi registerApp:WXAppId];         //单接微信支付
	
	//      [BeeCloud initWeChatPay:@"wx7efd0146f0a682ea"];
	[BeeCloud initWeChatPay:@"wxeab3fe32632897e3"];
#elif defined APP_YiLiang
	[BeeCloud initWeChatPay:@"wxeebc078bd7a21d57"];
#endif
	
	
	if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"first"] isEqualToString:@"1"]){
		//第一次启动app
		[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"first"];
		StartViewController *StartViewVC = [[StartViewController alloc] init];
		self.window.rootViewController = StartViewVC;
		
	}else{
		MainViewController  *controller=[[MainViewController alloc]init];
		THRootNavigationViewController *navi = [[THRootNavigationViewController alloc]initWithRootViewController:controller];
		self.window.rootViewController=navi;
	}
	[self.window makeKeyAndVisible];
	//启动动画
	[self startShowWindow];
	
	
	
	// Override point for customization after application launch.
	return YES;
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	// 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
	NSLog(@"token ----      %@",[[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding]);
	//[UMessage registerDeviceToken:deviceToken];
}
#pragma mark --获取位置--
- (void)getLocationData {
	
	//默认经纬度
	//    USERMODEL.latitude = 39.914999999999999;
	//    USERMODEL.longitude = 116.404;
	
	[network getInitsuccess:@"0" longitude:116.404 latitude:39.914999999999999 success:^(NSDictionary *obj) {
		[IHUtility saveDicUserDefaluts:obj[@"content"] key:kUserDefalutInit];
		NSString *url=[[[IHUtility getUserDefalutDic:kUserDefalutInit]objectForKey:@"urlInfo"]objectForKey:@"url_read"];
		ConfigManager.ImageUrl=[NSString stringWithFormat:@"%@",url];
		
		NSString *url2=[[[IHUtility getUserDefalutDic:kUserDefalutInit]objectForKey:@"urlInfo"]objectForKey:@"url_write"];
		ConfigManager.uploadImgUrl=url2;
	}failure:^(NSError *error) {
		
	}];
	
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
	
	[application registerForRemoteNotifications];
	
}

// type 1成功  2失败
-(void)addSucessView:(NSString *)str type:(int)type{
	
	MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:_window];
	NSString *imgName;
	// HUD.tag = 8173;
	if (type==1) {
		imgName = @"success-color.png";
	}else if (type == 2){
		imgName = @"error-color.png";
	}else{
		imgName = @"success-white.png";
	}
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.label.text = str;
	[HUD showAnimated:YES];
	[HUD hideAnimated:YES afterDelay:2];
	[_window addSubview:HUD];
	
}

- (void)startShowWindow
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
	NSMutableArray *imageArr = [NSMutableArray array];
	
	[imageArr addObjectsFromArray:[dic objectForKey:@"launchImage"]];
	
	NSDictionary *UserDefaultDic = [IHUtility getUserDefalutDic:kUserDefalutInit];
	if (UserDefaultDic) {
		NSDictionary *imgDic = UserDefaultDic[@"startupImage"];
		LaunchPageView *launchView = [[LaunchPageView alloc] initWithFrame:self.window.bounds images:imageArr];
		
#ifdef APP_MiaoTu
		launchView.selectBtnBlock = ^(NSInteger index){
			[[NSNotificationCenter defaultCenter] postNotificationName:NotificationTapLanuch object:imgDic userInfo:nil];
		};
		
#elif defined APP_YiLiang
		
#endif
		[self.window addSubview:launchView];
	}
}
-(void)removeFormWindow
{
	[_launchView removeFromSuperview];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
	// The directory the application uses to store the Core Data store file. This code uses a directory named "com.xubin.SkillExchange" in the application's documents directory.
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
	// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MiaoTuProject" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	// The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	// Create the coordinator and store
	
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SkillExchange.sqlite"];
	NSError *error = nil;
	NSString *failureReason = @"There was an error creating or loading the application's saved data.";
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		// Report any error we got.
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
		dict[NSLocalizedFailureReasonErrorKey] = failureReason;
		dict[NSUnderlyingErrorKey] = error;
		error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
		// Replace this with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
	// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (!coordinator) {
		return nil;
	}
	_managedObjectContext = [[NSManagedObjectContext alloc] init];
	[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
	if (managedObjectContext != nil) {
		NSError *error = nil;
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Replace this implementation with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

- (BOOL)application:(UIApplication *)application
			openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
		 annotation:(id)annotation
{
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
	[self doApplication:application
				openURL:url
	  sourceApplication:sourceApplication
			 annotation:annotation];
	
	if (result == FALSE) {
		//调用其他SDK，例如支付宝SDK等
	}
	//    if (![BeeCloud handleOpenUrl:url]) {
	//        //handle其他类型的url
	//    }
	return YES;
}

- (BOOL)doApplication:(UIApplication *)application
			  openURL:(NSURL *)url
	sourceApplication:(NSString *)sourceApplication
		   annotation:(id)annotation
{
	XMSchemeData *schemeData = [[XMSchemeData alloc] initWithURL:url];
	if ([sourceApplication isEqualToString:[[NSBundle mainBundle] bundleIdentifier]]) {
		schemeData.fromType = XMOpenSchemeFromInternalWebView;
	} else {
		schemeData.fromType = XMOpenSchemeFromOtherApp;
#if TARGET_IPHONE_SIMULATOR
		if (sourceApplication == nil) {
			schemeData.fromType = XMOpenSchemeFromInternalWebView;
		}
#endif
	}
	schemeData.application = application;
	schemeData.sourceApplication = sourceApplication;
	schemeData.annotation = annotation;
	
	[XMPaySchemeService payHandlerWithUrl:url];
	return [[XMSchemeManager sharedInstance] handleDealScheme:schemeData];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	// [UMSocialSnsService applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
	
	
}
//iOS9之后官方推荐用此方法
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (![BeeCloud handleOpenUrl:url]) {
//        //handle其他类型的url
//         BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//        return result;
//    }
//    return YES;
//}


@end


