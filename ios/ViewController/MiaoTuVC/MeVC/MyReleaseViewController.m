//
//  MyReleaseViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/31.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MyReleaseViewController.h"
#import "MyReleaseChildrenViewController.h"
#import "SlideNavTabBarController.h"
//#import "MTContactsListViewController.h"
#import "NavSlideView.h"
#import "MyNerseryViewController.h"

#import "MyReleasePicViewController.h"

@interface MyReleaseViewController ()<SlideNavTabBarDelegate>
{
    SlideNavTabBarController *navTabBarController;
    NavSlideView *navView;
    
    NSMutableArray* controllerArray;
}
@end

@implementation MyReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的发布"];
    
   
    
#ifdef APP_MiaoTu
//     NSArray *arr=@[@"供应",@"求购",@"话题",@"问吧",@"苗木云"];
    NSArray *arr=@[@"供应",@"求购",@"新品种"];
#elif defined APP_YiLiang
     NSArray *arr=@[@"供应",@"求购",@"新品种"];
    
#endif
    
    
    //   [network getpn:@"" maxResults:@"" featured:@"" tagCategoryId:@"" success:^(NSDictionary *obj) {
    //       NSLog(@"dic=%@",obj);
    //   }];
    navView=[[NavSlideView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 50) setTitleArr:arr isPoint:YES integer:3];
    __weak MyReleaseViewController *weakSelf=self;
    navView.selectBlock=^(NSInteger index){
        [weakSelf setNavTabbar:index];
    };
    //self.navigationItem.titleView=navView;
    
    navView.backgroundColor=[UIColor whiteColor];
    // [self.navigationController.navigationBar addSubview:navView];
    
    controllerArray =[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
       #ifdef APP_MiaoTu
        if (i==0) {
            MyReleaseChildrenViewController *controller=[[MyReleaseChildrenViewController alloc]init];
            //      controller.type=ENT_topic;
            controller.inviteParentController=self;
            controller.type=ENT_Supply;
            [controllerArray addObject:controller];
        }
        else if (i==1){
            MyReleaseChildrenViewController *controller=[[MyReleaseChildrenViewController alloc]init];
            controller.inviteParentController=self;
            controller.type=ENT_Buy;
            [controllerArray addObject:controller];
        }else if (i==2){
//            MyReleaseChildrenViewController *controller=[[MyReleaseChildrenViewController alloc]init];
//            controller.inviteParentController=self;
//            controller.type=ENT_Topic;
//            [controllerArray addObject:controller];
            MyReleasePicViewController *controller= [[MyReleasePicViewController alloc]init];
            controller.inviteParentController=self;
            [controllerArray addObject:controller];
            
        }else if (i==3){
            MyReleaseChildrenViewController *controller=[[MyReleaseChildrenViewController alloc]init];
            controller.inviteParentController=self;
            controller.type=ENT_questions;
            [controllerArray addObject:controller];
        }else if (i==4){
            MyNerseryViewController *vc=[[MyNerseryViewController alloc]init];
            vc.inviteParentController=self;
            [controllerArray addObject:vc];
            
        }

        
#elif defined APP_YiLiang
      
        if (i==0) {
            MyReleaseChildrenViewController *controller=[[MyReleaseChildrenViewController alloc]init];
            //      controller.type=ENT_topic;
            controller.inviteParentController=self;
            controller.type=ENT_Supply;
            [controllerArray addObject:controller];
        }
        else if (i==1){
            MyReleaseChildrenViewController *controller=[[MyReleaseChildrenViewController alloc]init];
            controller.inviteParentController=self;
            controller.type=ENT_Buy;
            [controllerArray addObject:controller];
        }else if (i==2){
            MyReleaseChildrenViewController *controller=[[MyReleaseChildrenViewController alloc]init];
            controller.inviteParentController=self;
            controller.type=ENT_Topic;
            [controllerArray addObject:controller];
            
        }else if (i==3){
            MyNerseryViewController *vc=[[MyNerseryViewController alloc]init];
            vc.inviteParentController=self;
            [controllerArray addObject:vc];
        }
#endif
    }
    navTabBarController = [[SlideNavTabBarController alloc] init];
    navTabBarController.navH=0;
    navTabBarController.subViewControllers = controllerArray;
    navTabBarController.isShowline=NO;
    navTabBarController.titleArray=arr;
    navTabBarController.navBarDelegate=self;
    // Do any additional setup after loading the view.
    [self.view addSubview:navTabBarController.view];
    [self.view addSubview:navView];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, navView.bottom-1, WindowWith, 1)];
    lineView.backgroundColor=cLineColor;
    [self.view addSubview:lineView];
  
    if (self.i==1) {
        [self setRedImageView];
    }
    
    //收到回复显示红点
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setRedImageView) name:NotificationQAnswer object:nil];

    //隐藏红点
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideRedImageView) name:NotificationMyNavViewHide object:nil];
}

-(void)hideRedImageView{
    
    [navView setPointNum:0];
}


-(void)setRedImageView{
    
    [navView setPointNum:1];
}

-(void)setNavTabbar:(NSInteger )index{
    [navTabBarController SegmentedDelegateViewclickedWithIndex:index];
}

-(void)itemSelectedIndex:(NSInteger)index{
    [navView slideSelectedIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
