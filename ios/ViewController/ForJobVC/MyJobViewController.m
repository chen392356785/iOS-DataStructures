//
//  MyJobViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/19.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MyJobViewController.h"
#import "SlideNavTabBarController.h"
#import "MyJobChildrenViewController.h"
#import "JobIdentViewController.h"
#import "CreatPositionViewController.h"
#import "ResumeViewController.h"
#import "PositionListViewController.h"
#import "ChatViewController.h"
#import "JionEPCloudViewController.h"
@interface MyJobViewController ()<ChatViewControllerDelegate>
{
    SlideNavTabBarController *navTabBarController;
    jianliModel *_model;
}

@end

@implementation MyJobViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.text];
    
    rightbutton.hidden=YES;
    [rightbutton setTitle:@"切换身份" forState:UIControlStateNormal];
    rightbutton.size=CGSizeMake(52, 13);
    rightbutton.titleLabel.font=sysFont(13);
    [rightbutton setTitleColor:cGreenColor forState:UIControlStateNormal];
    
    NSArray *arr=self.arr;
    NSMutableArray* controllerArray =[[NSMutableArray alloc]init];
    
    if (self.type==ENT_Seek) {
        ResumeViewController *qiuzhi=[[ResumeViewController alloc]init];
        PositionListViewController *zhaoping=[[PositionListViewController alloc]init];
        //        [controllerArray addObject:qiuzhi];
        [controllerArray addObject:zhaoping];
        for (int i=0; i<arr.count; i++) {
            switch (i) {
                    case 0:
                    qiuzhi.type=self.type;
                    qiuzhi.Mytype=ENT_CurriculumVitae;
                    qiuzhi.inviteParentController=self;
                    break;
                default:
                    zhaoping.type=self.type;
                    zhaoping.Mytype=ENT_Position;
                    zhaoping.inviteParentController=self;
                    break;
            }
        }
    }else if (self.type==ENT_Invite){
        MyJobChildrenViewController *qiuzhi=[[MyJobChildrenViewController alloc]init];
        MyJobChildrenViewController *zhaoping=[[MyJobChildrenViewController alloc]init];
        [controllerArray addObject:qiuzhi];
        [controllerArray addObject:zhaoping];
        for (int i=0; i<arr.count; i++) {
            switch (i) {
                    case 0:
                    qiuzhi.type=self.type;
                    qiuzhi.Mytype=ENT_CurriculumVitae;
                    qiuzhi.inviteParentController=self;
                    break;
                default:
                    zhaoping.type=self.type;
                    zhaoping.Mytype=ENT_Position;
                    zhaoping.inviteParentController=self;
                    break;
            }
        }
    }
    navTabBarController = [[SlideNavTabBarController alloc] init];
    navTabBarController.navH=0;
    navTabBarController.subViewControllers = controllerArray;
    navTabBarController.isShowline=YES;
    navTabBarController.isShowNavSlide=YES;
    navTabBarController.titleArray=arr;
    //  navTabBarController.navBarDelegate=self;
    // Do any additional setup after loading the view.
    [self.view addSubview:navTabBarController.view];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(creatPosition) name:NotificationAddPosition object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushToEcloud) name:NotificationEcloud object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setChat:) name:NotificationJobCommunite object:nil];
}

//进入聊天
-(void)setchat:(jianliModel *)model{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    ChatViewController *vc=[[ChatViewController alloc]initWithChatter:model.hx_user_name conversationType:eConversationTypeChat];
    vc.nickName=model.nickname;
    vc.delelgate=self;
    vc.toUserID=[NSString stringWithFormat:@"%ld",(long)model.user_id];
    vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage];
    
    [self pushViewController:vc];
}

-(void)pushToEcloud{
    JionEPCloudViewController *VC=[[JionEPCloudViewController alloc]init];
    
    [self pushViewController:VC];
}

-(void)setChat:(NSNotification *)dic{
    jianliModel *model=dic.userInfo[@"key"];
    _model=model;
    [self setchat:model];
}

-(void)creatPosition{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    CreatPositionViewController *vc=[[CreatPositionViewController alloc]init];
    [self presentViewController:vc];
}

-(void)back:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)home:(id)sender{
    
    JobIdentViewController *vc=[[JobIdentViewController alloc]init];//招聘求职
    vc.type=ENT_Invite;
    [self pushViewController:vc];
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    NSString *str=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,_model.heed_image_url,smallHeaderImage];
    NSString *userID=[_model.hx_user_name lowercaseString];
    
    if ([chatter isEqualToString:userID]) {
        return str;
    }else{
        return USERMODEL.userHeadImge80;
    }
    return nil;
}

// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    return chatter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
