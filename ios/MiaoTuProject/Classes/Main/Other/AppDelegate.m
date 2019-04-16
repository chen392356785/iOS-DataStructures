//
//  AppDelegate.m
//  SkillExchange
//
//  Created by lfl on 15-3-3.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "StartViewController.h"
#import "XMPaySchemeService.h"
#import "BeeCloud.h"
#import "XMSchemeManager.h"
#import <UMCommon/UMCommon.h>
#import "THRootNavigationViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

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
//static NSString *appID = @"0bd1f32440c9ea8dc1";
//static NSString *appSecret = @"abecb41a237d63cfcdcdf27bb5f6bd14";
//static NSString *userAgent = @"097fce92c454b02dab1471917755554";


@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (void)initAutoScaleSize {
    
    
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
    //    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES];
    
}

/**
 友盟分享
 */
- (void) configurationUMShare {
    
    [[UMSocialManager defaultManager] openLog:YES];
    //配置微信平台分享
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppId appSecret:@"d02c7f80e6f4996cceebec52a6c4077f" redirectURL:@"http://mobile.umeng.com/social"];
    //配置QQ平台分享
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105083809"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //配置微博平台分享
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3487655197"  appSecret:@"3849eb7f76d07349355b04fd0e45be2e" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
}

/**
 高德地图初始化
 */
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
    //友盟分享
    [self configurationUMShare];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initAutoScaleSize];  //初始化自动字体
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self configOwnViews];
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self getLocationData];
    ///高德产品初始化
    [self ammapInit];
    ///友盟产品初始化
    [self shareInit];
    
#ifdef Production
    [BeeCloud initWithAppID:@"5c9ac31c-4f6a-44c1-911c-4e0d7acd58b1" andAppSecret:@"c92a8421-3d9e-44f1-a0c4-8949e8daf56f"];
#else
    [BeeCloud initWithAppID:@"5c9ac31c-4f6a-44c1-911c-4e0d7acd58b1" andAppSecret:@"8bd09c42-7a75-48af-b06c-11694f40c656"];
#endif
    
    //向微信注册,发起支付必须注册
    [WXApi registerApp:WXAppId];         //单接微信支付
    [BeeCloud initWeChatPay:WXAppId];
    
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"first"] isEqualToString:@"1"]){
        //第一次启动app
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"first"];
        StartViewController *StartViewVC = [[StartViewController alloc] init];
        self.window.rootViewController = StartViewVC;
    } else {
        MainViewController  *controller=[[MainViewController alloc]init];
        THRootNavigationViewController *navi = [[THRootNavigationViewController alloc]initWithRootViewController:controller];
        self.window.rootViewController=navi;
    }
    
    [self.window makeKeyAndVisible];
    [self startShowWindow];
    
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
        launchView.selectBtnBlock = ^(NSInteger index){
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTapLanuch object:imgDic userInfo:nil];
        };
        [self.window addSubview:launchView];
    }
    
}

-(void)removeFormWindow
{
    [_launchView removeFromSuperview];
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
    
}


@end



