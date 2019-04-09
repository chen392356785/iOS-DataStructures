//
//  GuangChangMainViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "GuangChangMainViewController.h"
#import "MTThemeListViewController.h"
#import "ChatListViewController.h"
#import "SlideNavTabBarController.h"
//#import "MTContactsListViewController.h"
#import "NavSlideView.h"
#import "QuestionsViewController.h"
@interface GuangChangMainViewController ()<SlideNavTabBarDelegate,IChatManagerDelegate, EMCallManagerDelegate>
{
    SlideNavTabBarController *navTabBarController;
    NavSlideView *navView;
    ChatListViewController *_chatList;
    NSMutableArray* controllerArray;
    
}
@end

@implementation GuangChangMainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"话题列表"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"话题列表"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    leftbutton.hidden=YES;
    
    // leftbutton.hidden=YES;
    
    
    NSArray *arr=@[@"问吧",@"话题"];
    
    __weak GuangChangMainViewController *weakSelf=self;
    //   [network getpn:@"" maxResults:@"" featured:@"" tagCategoryId:@"" success:^(NSDictionary *obj) {
    //       NSLog(@"dic=%@",obj);
    //   }];
    navView=[[NavSlideView alloc]initWithFrame:CGRectMake(0, 5, WindowWith-100, 35) setTitleArr:arr isPoint:YES integer:0];
    
    navView.selectBlock=^(NSInteger index){
        [weakSelf setNavTabbar:index];
    };
    self.navigationItem.titleView=navView;
    
    // [self.navigationController.navigationBar addSubview:navView];
    
    controllerArray =[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        if (i==1) {
            MTThemeListViewController *controller=[[MTThemeListViewController alloc]init];
            //      controller.type=ENT_topic;
            controller.inviteParentController=self;
            [controllerArray addObject:controller];
        }
        //  else if (i==1){
        //            ChatListViewController *controller=[[ChatListViewController alloc]init];
        //            controller.inviteParentController=self;
        //            _chatList=controller;
        //            [controllerArray addObject:controller];
        //        }
        else if (i==0){
            QuestionsViewController *controller=[[QuestionsViewController alloc]init];
            controller.inviteParentController=self;
            controller.i=self.i;
            [controllerArray addObject:controller];
        }
    }
    navTabBarController = [[SlideNavTabBarController alloc] init];
    navTabBarController.navH=0;
    navTabBarController.subViewControllers = controllerArray;
    navTabBarController.isShowline=NO;
    navTabBarController.titleArray=arr;
    navTabBarController.navBarDelegate=self;
    // Do any additional setup after loading the view.
    [self.view addSubview:navTabBarController.view];
    
    //  [self didUnreadMessagesCountChanged];
    // [[EaseMob sharedInstance].chatManager removeDelegate:self];
    //[[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    // Do any additional setup after loading the view.
    
    
    [rightbutton setImage:[Image(@"ding.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    rightbutton.hidden=YES;
    
    if (self.i==1) {
        
        [self setRedImageView];
        
    }

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setRedImageView) name:NotificationQusetion object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideRedImageView) name:NotificationNavViewHide object:nil];
}

-(void)hideRedImageView{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationTabBarHiddenRedPoint object:nil];
    [navView setPointNum:0];
}

-(void)setRedImageView{
    
    [navView setPointNum:1];
}

-(void)setNavTabbar:(NSInteger )index{
    [navTabBarController SegmentedDelegateViewclickedWithIndex:index];
}

#pragma mark navBarDelegate
-(void)itemSlideScroll:(CGFloat)f{
    NSLog(@"f=%f",f);
    // [navView slideScroll:f];
}

-(void)itemSelectedIndex:(NSInteger)index{
    [navView slideSelectedIndex:index];
}

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [_chatList refreshDataSource];
    
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    int unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    [navView setPointNum:unreadCount];
    //[self setupUnreadMessageCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
