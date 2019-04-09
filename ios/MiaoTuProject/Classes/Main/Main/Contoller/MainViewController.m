//
//  ViewController.m
//  SkillExchange
//
//  Created by lfl on 15-3-3.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "MainViewController.h"
#import "MTTabBarViewController.h"
#import "CreateBuyOrSupplyViewController.h"                     //发布供应
#import "FaBuBuyViewController.h"                               //发布求购
#import "CreatTopicViewController.h"
#import "EMCDDeviceManager.h"
//#import "MTNetworkData+ForModel.h"
#import "MTLoginViewController.h"
//#import "IHBaseConfig.h"
//#import "InvitedViewController.h"
#import "IntegralView.h"
#import "MYTaskViewController.h"
#import "THModalNavigationController.h"

#import "ReleaseNewVarietyController.h" //发布新品种

@interface MainViewController ()<IChatManagerDelegate, EMCallManagerDelegate>
{
    MTTabBarViewController *_tabBarVC;
}

@property (nonatomic,assign)NSInteger count;

@end

@implementation MainViewController


-(void)initWithLocation:(NSNotification *)notification
{
//    THWeakSelf;
    [self showUserLocation:^(NSString *province,NSString *city,CGFloat latitude,CGFloat longtitude) {
//        THStrongSelf;
        if (province.length>0) {
            USERMODEL.province=province;
        }
        if (city.length>0) {
            USERMODEL.city = city;
            [[NSNotificationCenter defaultCenter]postNotificationName:kUserDefalutInitcity object:nil];//初始化定位完成
        }
        USERMODEL.latitude = latitude;
        USERMODEL.longitude = longtitude;
        
        NSString *str = @"0";
        if (USERMODEL.isLogin) {
            str=USERMODEL.userID;
        }
        [network getInitsuccess:str longitude:longtitude latitude:latitude success:^(NSDictionary *obj) {
//            THStrongSelf;
            [IHUtility saveDicUserDefaluts:obj[@"content"] key:kUserDefalutInit];
            NSString *url=[[[IHUtility getUserDefalutDic:kUserDefalutInit]objectForKey:@"urlInfo"]objectForKey:@"url_read"];
            ConfigManager.ImageUrl=[NSString stringWithFormat:@"%@",url];
            
            NSString *url2=[[[IHUtility getUserDefalutDic:kUserDefalutInit]objectForKey:@"urlInfo"]objectForKey:@"url_write"];
            ConfigManager.uploadImgUrl=url2;
//            [self pushTabbarVC];
        } failure:^(NSError *error) {
//            [self pushTabbarVC];
        }];
    }];
    if(USERMODEL.isLogin){
        int isQD=[[notification object]intValue];
        if (isQD==1) {
            NSDate *  senddate=[NSDate date];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *  locationString=[dateformatter stringFromDate:senddate];
            [self getUserAign:locationString];
            
        }
    }
}

-(void)getUserAign:(NSString *)locationString{
    
/*  V2.9.9连续登陆提示
    [network getUserAign:[USERMODEL.userID intValue] sign_date:locationString success:^(NSDictionary *obj) {
        NSString *day = [NSString stringWithFormat:@"%@",obj[@"content"][@"sing_day"]];
        if (day == nil ||[day isEqualToString:@"(null)"]) {
            [self loginSuccess:YES days:@""];
        }else {
            [self loginSuccess:YES days:[NSString stringWithFormat:@"%@",day]];
        }
    }];
 //*/
    
}

- (void)loginSuccess:(BOOL)success days:(NSString *)day
{

    IntegralView *integralView = [[IntegralView alloc] initWithFrame:self.view.window.bounds days:day];
    integralView.selectBtnBlock = ^(NSInteger index){

        MYTaskViewController * task=[[MYTaskViewController alloc]init];
        // task.delegate=self;
        task.type = @"2";
        
        [self presentViewController:task];
    };
    
    if (success) {

        [self.view.window insertSubview:integralView atIndex:1];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setUpTabbar];
    ConfigManager.ImageUrl=TestImageURL;
    ConfigManager.uploadImgUrl=upload_url_write;
    
    NSDictionary *dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
    
    if (dic!=nil) {
        
        if (dic.allKeys.count>0) {
            [USERMODEL setUserInfo:dic];
        }
    }
   
    [self initWithLocation:nil];//初始化
    
    NSDictionary *initDic=[IHUtility getUserDefalutDic:kUserDefalutInit];
    if (initDic.allKeys.count>0) {
        NSString *url=[[[IHUtility getUserDefalutDic:kUserDefalutInit]objectForKey:@"urlInfo"]objectForKey:@"url_read"];
        ConfigManager.ImageUrl=[NSString stringWithFormat:@"%@",url];
         NSString *url2=[[[IHUtility getUserDefalutDic:kUserDefalutInit]objectForKey:@"urlInfo"]objectForKey:@"url_write"];
        ConfigManager.uploadImgUrl=url2;
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callOutWithChatter:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callControllerClose:) name:@"callControllerClose" object:nil];
    
 
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
   
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginInNotification:) name:NotificationLoginIn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initWithLocation:) name:NotificationRefeshInit object:nil]; //通知调用初始化
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationTabBarRed:) name:NotificationTabBarHiddenRedPoint object:nil]; //是否隐藏首页的里面的红点
 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationTabBar4Red:) name:NotificationTabBar4HiddenRedPoint object:nil]; //是否隐藏我的里面的红点
    
  
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(badgeChatNum4:) name:NotificationCurriculum object:nil];//收到简历
    
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(badgeChatNum4:) name:NotificationQAnswer object:nil];//收到回复
    
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(badgeChatNum0:) name:NotificationQusetion object:nil];//未回复消息
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarHidden:) name:NotificationtabBarHidden object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MessageNumNotification:) name:NotificationMessageNum object:nil];
    
    
    
    NSDictionary *dic2=[IHUtility getUserDefalutsDicKey:kBadgeSumNum];
    [BadgeMODEL setBadgeForKey:dic2];
 
 
    [self setupUnreadMessageCount];
    
    if (BadgeMODEL.lookMeNum>0 ||BadgeMODEL.commentMeNum>0) {
        [_tabBarVC setMessageNum:[BadgeMODEL getSumNum]];
       // [[NSNotificationCenter defaultCenter]postNotificationName:NotificationCommentMe object:nil];
    }
    
    if (BadgeMODEL.forumAnswer>0) {
          [_tabBarVC setTabBar4Num:1];
        // [[NSNotificationCenter defaultCenter]postNotificationName:NotificationQAnswer object:nil];//回复问题
    }
    
    if (BadgeMODEL.forumQuestion>0) {
     
        [_tabBarVC setTabBar1Num:1];
         //[[NSNotificationCenter defaultCenter]postNotificationName:NotificationQusetion object:nil];//版主有未回复消息
    }
    
	CGFloat size = SDImageCache.sharedImageCache.totalDiskSize/(1024 * 1024);
    if (size > 300) {
       [IHUtility AlertMessage:@"温馨提示" message:@"系统占用的缓存图片已经超过300MB,建议删除" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"取消" tag:1];
    }
 
}

- (void)setUpTabbar{
    
    MTTabBarViewController *controller = [[MTTabBarViewController alloc]init];
    controller.view.frame = CGRectMake(0, 0, WindowWith, _boundHeihgt);
    _tabBarVC=controller;

    controller.selectBlock=^(NSInteger index) {
        NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        if (index==0) {
            if ([dic[@"mobile"] isEqualToString:@""]) {
                [self showLoginViewWithType:ENT_Lagin];
                return;
            }
            FaBuBuyViewController *v=[[FaBuBuyViewController alloc]init];
            v.type = ENT_Buy;
            [self presentViewController:v];
            
        }
        if (index==1) {//供求 ，供应
            if ([dic[@"mobile"] isEqualToString:@""]) {
                [self showLoginViewWithType:ENT_Lagin];
                return;
            }
            CreateBuyOrSupplyViewController *v=[[CreateBuyOrSupplyViewController alloc]init];
            v.type=ENT_Supply;
            [self presentViewController:v];
        }
        if (index==2) {
            CreatTopicViewController *vc=[[CreatTopicViewController alloc]init];
            
            [self presentViewController:vc];
        }
        
        else if (index==3){
            ReleaseNewVarietyController *vc = [[ReleaseNewVarietyController alloc] init];
            [self presentViewController:vc];

//            [self ShareUrl:self withTittle:[NSString stringWithFormat:@"%@，加入%@，携手共赢",KAppTitle,KAppName] content:[NSString stringWithFormat:@"我一直在用%@找苗木、搜人脉、找企业。邀你一起来体验，积分还可抵现金用哦",KAppName] withUrl:dwonShareURL imgUrl:@""];
        }
    };
     [self pushTabbarVC];
}

- (void)pushTabbarVC{
    [self addChildViewController:_tabBarVC];
    [self.view addSubview:_tabBarVC.view];
}

-(void)MessageNumNotification:(NSNotification *)notificaiton{
    
    [_tabBarVC setMessageNum:[BadgeMODEL getSumNum]];
    
     [[NSNotificationCenter defaultCenter]postNotificationName:KSheQuBadgeSumNum object:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        if (buttonIndex==0){
            SDImageCache * imageCache = [SDImageCache sharedImageCache];
            [imageCache clearMemory];
            [imageCache clearDiskOnCompletion:^{
                
            }];
            [self addSucessView:@"删除成功" type:1];
            
        }
    }
   
}

-(void)tabBarHidden:(NSNotification *)notification{
    BOOL isHidden=[[notification object]boolValue];
    [_tabBarVC setTabBarHidden:isHidden];
}


-(void)loginInNotification:(NSNotification *)notification{
    [USERMODEL removeUserModel];
    MTLoginViewController *vc=[[MTLoginViewController alloc]init];
    THModalNavigationController *nav=[[THModalNavigationController alloc]initWithRootViewController:vc];
    [_tabBarVC presentViewController:nav animated:YES completion:nil];
}

-(void)notificationTabBarRed:(NSNotification *)notification{
    [_tabBarVC setTabBar1Num:0];
}

-(void)notificationTabBar4Red:(NSNotification *)notification{
     [_tabBarVC setTabBar4Num:0];
}

-(void)badgeChatNum4:(NSNotification *)noti{
    [_tabBarVC setTabBar4Num:1];
}

-(void)badgeChatNum0:(NSNotification *)noti{
    [_tabBarVC setTabBar1Num:1];
}


// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    int unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
      BadgeMODEL.chatNum=unreadCount;
    
   [_tabBarVC setMessageNum:[BadgeMODEL getSumNum]];
   [[NSNotificationCenter defaultCenter]postNotificationName:KSheQuBadgeSumNum object:nil];
  
   // [[NSNotificationCenter defaultCenter]postNotificationName:NotificationHomePageBadgeNum object:[NSNumber numberWithInt:[BadgeMODEL getSumNum]]];
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:[BadgeMODEL getSumNum]];
}


#pragma mark - call


#pragma mark - IChatManagerDelegate 消息变化

- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [self setupUnreadMessageCount];
}

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineCmdMessages
{
    
}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = (message.messageType != eMessageTypeChat) ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            [self showNotificationWithMessage:message];
        }else {
            [self playSoundAndVibration];
        }
#endif
    }
}




-(void)didReceiveCmdMessage:(EMMessage *)message
{
    
    
    NSDictionary *messAgeDic=message.ext;

    
    int forumAnswer=[[messAgeDic objectForKey:@"forumAnswer"]intValue];//发布的问题被回复
    int forumQuestion=[[messAgeDic objectForKey:@"forumQuestion"] intValue];//版主有未恢复的消息
    
    int comment_num=[[messAgeDic objectForKey:@"comment_num"]intValue];
    int view_num=[[messAgeDic objectForKey:@"view_num"]intValue];
    
    int status =[[messAgeDic objectForKey:@"status"]intValue];
    
    int currculum=[[messAgeDic objectForKey:@"curriculum"]intValue];//收到简历
    
    if (comment_num>0) {//评论我的
       BadgeMODEL.commentMeNum=comment_num;
         [_tabBarVC setMessageNum:[BadgeMODEL getSumNum]];
    }
    if (view_num>0) {//看过我的
       BadgeMODEL.lookMeNum=view_num;
        NSString *str=[messAgeDic objectForKey:@"view_list"];
        if (str.length>0) {
            NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[network getJsonForString:str]];
            BadgeMODEL.headArr=arr;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"lookMeNotification" object:nil];
         [_tabBarVC setMessageNum:[BadgeMODEL getSumNum]];
    }
    
    
    
    if (currculum>0) {
         [[NSNotificationCenter defaultCenter]postNotificationName:NotificationCurriculum object:nil];
    }
    
    if (status>0) {
        [_tabBarVC setTabBar4Num:status];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMeNum object:[NSNumber numberWithInt:1]];
        
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:KSheQuBadgeSumNum object:nil];
    
    
#ifdef APP_MiaoTu
    if (forumQuestion>0) {
        BadgeMODEL.forumQuestion=forumQuestion;
        [_tabBarVC setTabBar1Num:forumQuestion];
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationQusetion object:nil];
    }
    
    if (forumAnswer>0) {
        BadgeMODEL.forumAnswer=forumAnswer;
        [_tabBarVC setTabBar4Num:forumAnswer];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationQAnswer object:nil];
    }
 
    
#elif defined APP_YiLiang
    
   
    
    
#endif

    
    
    // [_tabBarVC setTabBar1Num:[BadgeMODEL getSumNum]];
 
   // [[NSNotificationCenter defaultCenter]postNotificationName:NotificationHomePageBadgeNum object:[NSNumber numberWithInt:[BadgeMODEL getSumNum]]];
   //  [_tabBarVC setTabBar4Num:BadgeMODEL.lookMeNum+BadgeMODEL.commentMeNum];

    UIApplication *application = [UIApplication sharedApplication];
    
    [application setApplicationIconBadgeNumber:[BadgeMODEL getSumNum]];
   
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        NSString *title = message.from;
        if (message.messageType == eMessageTypeGroupChat) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        else if (message.messageType == eMessageTypeChatRoom)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:@"username" ]];
            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
            NSString *chatroomName = [chatrooms objectForKey:message.conversationChatter];
            if (chatroomName)
            {
                title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, chatroomName];
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
// 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}


- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                bCanRecord = granted;
            }];
        }
    }
    
    if (!bCanRecord) {
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"setting.microphoneNoAuthority", @"No microphone permissions") message:NSLocalizedString(@"setting.microphoneAuthority", @"Please open in \"Setting\"-\"Privacy\"-\"Microphone\".") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alt show];
    }
    
    return bCanRecord;
}


- (void)callOutWithChatter:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        if (![self canRecord]) {
            return;
        }
        
        EMError *error = nil;
        NSString *chatter = [object objectForKey:@"chatter"];
        EMCallSessionType type = [[object objectForKey:@"type"] intValue];
        EMCallSession *callSession = nil;
        if (type == eCallSessionTypeAudio) {
            callSession = [[EaseMob sharedInstance].callManager asyncMakeVoiceCall:chatter timeout:50 error:&error];
        }
        else if (type == eCallSessionTypeVideo){
            if (![CallViewController canVideo]) {
                return;
            }
            callSession = [[EaseMob sharedInstance].callManager asyncMakeVideoCall:chatter timeout:50 error:&error];
        }
        
        if (callSession && !error) {
            [[EaseMob sharedInstance].callManager removeDelegate:self];
            
            CallViewController *callController = [[CallViewController alloc] initWithSession:callSession isIncoming:NO];
            callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:callController animated:NO completion:nil];
        }
        
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", @"error") message:error.description delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

- (void)callControllerClose:(NSNotification *)notification
{
//        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
//        [audioSession setActive:YES error:nil];
    
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
}

#pragma mark - ICallManagerDelegate

- (void)callSessionStatusChanged:(EMCallSession *)callSession changeReason:(EMCallStatusChangedReason)reason error:(EMError *)error
{
    if (callSession.status == eCallSessionStatusConnected)
    {
        EMError *error = nil;
        do {
            BOOL isShowPicker = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isShowPicker"] boolValue];
            if (isShowPicker) {
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
            if (![self canRecord]) {
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
// 在后台不能进行视频通话
            if(callSession.type == eCallSessionTypeVideo && ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive || ![CallViewController canVideo])){
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
            if (!isShowPicker){
                [[EaseMob sharedInstance].callManager removeDelegate:self];
                CallViewController *callController = [[CallViewController alloc] initWithSession:callSession isIncoming:YES];
                callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
                [self presentViewController:callController animated:NO completion:nil];
                if ([self.navigationController.topViewController isKindOfClass:[ChatViewController class]])
                {
                    ChatViewController *chatVc = (ChatViewController *)self.navigationController.topViewController;
                    chatVc.isInvisible = YES;
                }
            }
        } while (0);
        
        if (error) {
            [[EaseMob sharedInstance].callManager asyncEndCall:callSession.sessionId reason:eCallReasonHangup];
            return;
        }
    }
}

#pragma mark离线非透传
- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages{
    NSLog(@"arr=%@",offlineMessages);
    if (offlineMessages.count>0) {
        EMMessage *message=[offlineMessages lastObject];
        [self didReceiveCmdMessage:message];
    }
}

#pragma mark 离线透传
- (void)didReceiveOfflineCmdMessages:(NSArray *)offlineCmdMessages{
    NSLog(@"offlineCmdMessages=%@",offlineCmdMessages);
    if (offlineCmdMessages.count>0) {
        EMMessage *message=[offlineCmdMessages lastObject];
        [self didReceiveCmdMessage:message];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
