//
//  MTMyCollectionViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTMyCollectionViewController.h"
#import "SlideNavTabBarController.h"
//#import "MTCollectionSupplyTableViewController.h"
//#import "MTCollectionBuyTableViewController.h"
//#import "MTTopicListViewController.h"
#import "MTMyChlidSupplyAndBuyListViewController.h"
@interface MTMyCollectionViewController()
{
    SlideNavTabBarController *navTabBarController;
}
@end
@implementation MTMyCollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的收藏"];
    
  
    NSArray *arr=@[@"供应",@"求购",@"话题"];
    NSMutableArray* controllerArray =[[NSMutableArray alloc]init];
    MTMyChlidSupplyAndBuyListViewController *gongying=[[MTMyChlidSupplyAndBuyListViewController alloc]init];
    MTMyChlidSupplyAndBuyListViewController *qiugou=[[MTMyChlidSupplyAndBuyListViewController alloc]init];
    MTMyChlidSupplyAndBuyListViewController *topic=[[MTMyChlidSupplyAndBuyListViewController alloc]init];
    [controllerArray addObject:gongying];
    [controllerArray addObject:qiugou];
    [controllerArray addObject:topic];
    for (int i=0; i<arr.count; i++) {
        switch (i) {
            case 0:
                gongying.type=ENT_Supply;
                  gongying.inviteParentController=self;
                break;
            case 1:
                qiugou.type=ENT_Buy;
                  qiugou.inviteParentController=self;
                break;
            default:
                topic.type=ENT_Topic;
                topic.inviteParentController=self;
                break;
        }
      
       //[controllerArray addObject:gongying];
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
    
    
    // Do any additional setup after loading the view.
}

@end
