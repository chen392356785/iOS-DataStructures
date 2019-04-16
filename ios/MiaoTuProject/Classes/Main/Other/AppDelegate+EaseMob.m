/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "AppDelegate+EaseMob.h"
#import "AppDelegate+EaseMobDebug.h"
#import <UMPush/UMessage.h>

/**
 *  本类中做了EaseMob初始化和推送等操作
 */

@implementation AppDelegate (EaseMob)

- (void)easemobApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    if (launchOptions) {
        NSDictionary*userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        if(userInfo)
        {
            [self didReceiveRemoteNotification:userInfo];
        }
    }
    
//    _connectionState = eEMConnectionConnected;
	
   [self registerRemoteNotification];
	
	
	// Push组件基本功能配置
	UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
	//type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
	entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
	[UNUserNotificationCenter currentNotificationCenter].delegate=self;
	[UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
		if (granted) {
			
		} else {
			
		}
	}];
	
    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
//    [UMessage registerForRemoteNotifications];
    [self registerEaseMobNotification];
    
    
// SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
    NSString *appKey = nil;
#ifdef Production
    appKey =@"yjkj2016#miaotu12";
    apnsCertName = @"miaotuPushProduction";
#else
      appKey =@"yjkj2016#miaotutest";
    [UMessage setLogEnabled:YES];
    apnsCertName = @"miaotuPushDevelopment";
#endif
    
    if (![self isSpecifyServer]) {
        [[EaseMob sharedInstance] registerSDKWithAppKey:appKey
                                           apnsCertName:apnsCertName
                                            otherConfig:@{kSDKConfigEnableConsoleLogger:@YES}];
    }
    // 注册环信监听
    [[EaseMob sharedInstance] application:application
            didFinishLaunchingWithOptions:launchOptions];
    
    NSLog(@"环信版本:%@", [[EaseMob sharedInstance] sdkVersion]);
    
    [self setupNotifiers];
}


// 监听系统生命周期回调，以便将需要的事件传给SDK
- (void)setupNotifiers{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackgroundNotif:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActiveNotif:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActiveNotif:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidReceiveMemoryWarning:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillTerminateNotif:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataWillBecomeUnavailableNotif:)
                                                 name:UIApplicationProtectedDataWillBecomeUnavailable
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataDidBecomeAvailableNotif:)
                                                 name:UIApplicationProtectedDataDidBecomeAvailable
                                               object:nil];
}

#pragma mark - notifiers
- (void)appDidEnterBackgroundNotif:(NSNotification*)notif{
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
 
        [NSString stringWithFormat:@"%d",BadgeMODEL.lookMeNum],@"badgelookMe",
        [NSString stringWithFormat:@"%d",BadgeMODEL.commentMeNum],@"badgeCommentMe",
        [NSString stringWithFormat:@"%d",BadgeMODEL.chatNum],@"badgeChat",
        [NSString stringWithFormat:@"%d",BadgeMODEL.curriculumNum],@"badgecurriculum",
                       BadgeMODEL.headArr,@"headArr",
                      [NSString stringWithFormat:@"%d",BadgeMODEL.forumAnswer],@"forumAnswer",
                       [NSString stringWithFormat:@"%d",BadgeMODEL.forumQuestion],@"forumQuestion",
                       nil];
    
    [IHUtility setUserDefaultDic:dic key:kBadgeSumNum];
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:[BadgeMODEL getSumNum]];
    [[EaseMob sharedInstance] applicationDidEnterBackground:notif.object];
    
    NSDate *date=[NSDate date];
    NSString *dataStr=[IHUtility ConvertToStringFromNSDate:date];
  //  isSameDate=[IHUtility isSameDay:<#(NSDate *)#> date2:<#(NSDate *)#>]
    [IHUtility setUserDefalutsKey:dataStr key:kYesterday];
    
    
}

- (void)appWillEnterForeground:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:notif.object];
}

- (void)appDidFinishLaunching:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidFinishLaunching:notif.object];
}

- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
    //本周任务完成情况统计入口
    
    
    [network getWeekTaskInfofoForId:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
          } failure:^(NSDictionary *obj2) {
         
    }];
    
    NSDate *date=[NSDate date];
    NSString *yesDate=[IHUtility getUserDefalutsKey:kYesterday];
    NSDate * yestoday=[IHUtility ConvertToDateFromString:yesDate];
    BOOL isSameDate=[IHUtility isSameDay:date date2:yestoday];
    if (!isSameDate) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationRefeshInit object:[NSNumber numberWithInt:1]];
    }
  
    [[EaseMob sharedInstance] applicationDidBecomeActive:notif.object];
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillResignActive:notif.object];
}

- (void)appDidReceiveMemoryWarning:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidReceiveMemoryWarning:notif.object];
}

- (void)appWillTerminateNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillTerminate:notif.object];
}

- (void)appProtectedDataWillBecomeUnavailableNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationProtectedDataWillBecomeUnavailable:notif.object];
}

- (void)appProtectedDataDidBecomeAvailableNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationProtectedDataDidBecomeAvailable:notif.object];
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *token=[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                      stringByReplacingOccurrencesOfString: @">" withString: @""]
                     stringByReplacingOccurrencesOfString: @" " withString: @""];
    BOOL isBind=[[PARAMMODEL.param objectForKey:@"isBind"]boolValue];
    if (!isBind) {
        [PARAMMODEL.param setObject:[NSNumber numberWithBool:YES] forKey:@"isBind"];
        [network GetBindBaiduPush:USERMODEL.userID channel_id:token success:^(NSDictionary *obj) {
            [PARAMMODEL.param setObject:[NSNumber numberWithBool:YES] forKey:@"isBind"];
        } failure:^(NSDictionary *obj2) {
            
        }];
    }

    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
//                                                    message:error.description
//                                                   delegate:nil
//                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                                          otherButtonTitles:nil];
  //  [alert show];
}

// 注册推送
- (void)registerRemoteNotification{
  
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
               
            }
        }];
    } else {
        UIApplication *application = [UIApplication sharedApplication];
        application.applicationIconBadgeNumber = 0;
        
        if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
        }
    }
}


/// App在前台时候回调
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    [self performSelector:@selector(UMessagePush:) withObject:userInfo afterDelay:1.0];
    [UMessage didReceiveRemoteNotification:userInfo];
  //  [self handleRemoteNotificationForcegroundWithUserInfo:userInfo];
}

/// App在后台时候点击推送调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    [self performSelector:@selector(UMessagePush:) withObject:userInfo afterDelay:1.0];
    [UMessage didReceiveRemoteNotification:userInfo];
  //  [self handleRemoteNotificationBackgroundWithUserInfo:userInfo];
}

#pragma mark - registerEaseMobNotification
- (void)registerEaseMobNotification{
    [self unRegisterEaseMobNotification];
    // 将self 添加到SDK回调中，以便本类可以收到SDK回调
    [[EaseMob sharedInstance].chatManager addDelegate:(id<EMChatManagerDelegate>)self delegateQueue:nil];
}

- (void)unRegisterEaseMobNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:(id<EMChatManagerDelegate>)self];
}



#pragma mark - IChatManagerDelegate
// 开始自动登录回调
-(void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
   // UIAlertView *alertView = nil;
    if (error) {
//        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.errorAutoLogin", @"Automatic logon failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        //[IHUtility loginPage];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil];
        //发送自动登陆状态通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
    else{
//        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.beginAutoLogin", @"Start automatic login...") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        
        
        // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
     //   [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
        //获取数据库中的数据
        [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
    }
    
  //  [alertView show];
}

// 结束自动登录回调
-(void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
//    UIAlertView *alertView = nil;
    if (error) {
//        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.errorAutoLogin", @"Automatic logon failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        
        //发送自动登陆状态通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
    else{
        //获取群组列表
       // [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
        
//        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.endAutoLogin", @"End automatic login...") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    }
    
    //[alertView show];
}

// 好友申请回调
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    if (!username) {
        return;
    }
    if (!message) {
        message = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), username];
    }
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":username, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
//    [[ApplyViewController shareController] addNewApply:dic];
//    if (self.mainController) {
//        [self.mainController setupUntreatedApplyCount];
//    }
}

// 离开群组回调
- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error
{
    NSString *tmpStr = group.groupSubject;
    NSString *str;
    if (!tmpStr || tmpStr.length == 0) {
        NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup *obj in groupArray) {
            if ([obj.groupId isEqualToString:group.groupId]) {
                tmpStr = obj.groupSubject;
                break;
            }
        }
    }
    
    if (reason == eGroupLeaveReason_BeRemoved) {
        str = [NSString stringWithFormat:NSLocalizedString(@"group.beKicked", @"you have been kicked out from the group of \'%@\'"), tmpStr];
    }
    if (str.length > 0) {
        TTAlertNoTitle(str);
    }
}

// 申请加入群组被拒绝回调
- (void)didReceiveRejectApplyToJoinGroupFrom:(NSString *)fromId
                                   groupname:(NSString *)groupname
                                      reason:(NSString *)reason
                                       error:(EMError *)error{
    if (!reason || reason.length == 0) {
        reason = [NSString stringWithFormat:NSLocalizedString(@"group.beRefusedToJoin", @"be refused to join the group\'%@\'"), groupname];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:reason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}

//接收到入群申请
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error
{
    if (!groupId || !username) {
        return;
    }
    
    if (!reason || reason.length == 0) {
        reason = [NSString stringWithFormat:NSLocalizedString(@"group.applyJoin", @"%@ apply to join groups\'%@\'"), username, groupname];
    }
    else{
        reason = [NSString stringWithFormat:NSLocalizedString(@"group.applyJoinWithName", @"%@ apply to join groups\'%@\'：%@"), username, groupname, reason];
    }
    
    if (error) {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"group.sendApplyFail", @"send application failure:%@\nreason：%@"), reason, error.description];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", @"Error") message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupname, @"groupId":groupId, @"username":username, @"groupname":groupname, @"applyMessage":reason, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleJoinGroup]}];
//        [[ApplyViewController shareController] addNewApply:dic];
//        if (self.mainController) {
//            [self.mainController setupUntreatedApplyCount];
//        }
    }
}

// 已经同意并且加入群组后的回调
- (void)didAcceptInvitationFromGroup:(EMGroup *)group
                               error:(EMError *)error
{
    if(error)
    {
        return;
    }
    
    NSString *groupTag = group.groupSubject;
    if ([groupTag length] == 0) {
        groupTag = group.groupId;
    }
    
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"group.agreedAndJoined", @"agreed and joined the group of \'%@\'"), groupTag];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}


// 绑定deviceToken回调
- (void)didBindDeviceWithError:(EMError *)error
{
    if (error) {
        TTAlertNoTitle(NSLocalizedString(@"apns.failToBindDeviceToken", @"Fail to bind device token"));
    }
}

// 网络状态变化回调
- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
//     _connectionState = connectionState;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"networkChanged2" object:[NSNumber numberWithInt:connectionState]];
     //[self.mainController networkChanged:connectionState];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
    //  [UMessage setAutoAlert:NO];
   [self performSelector:@selector(UMessagePush:) withObject:userInfo afterDelay:1.0];
    [UMessage didReceiveRemoteNotification:userInfo];
    
   
}

-(void)UMessagePush:(NSDictionary *)dic{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationPushVC object:dic];
    
}
// 打印收到的apns信息
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self performSelector:@selector(UMessagePush:) withObject:userInfo afterDelay:4.0];
    [UMessage didReceiveRemoteNotification:userInfo];
    /*
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                        options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.content", @"Apns content")
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
     */

}
/**
 配置控件
 */
- (void)configOwnViews {
    // 隐藏键盘上的工具栏
	[IQKeyboardManager sharedManager].enableAutoToolbar = YES;
	[IQKeyboardManager sharedManager].enable = YES;
	// 点击视图隐藏键盘
	[IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
	[[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
}

- (void)addDelegate:(id<EMChatManagerDelegate>)delegate delegateQueue:(dispatch_queue_t)queue {
	
}

- (void)removeDelegate:(id<EMChatManagerDelegate>)delegate {
	
}

@end
