//
//  MTContactsListViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/22.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTContactsListViewController.h"
#import "SlideNavTabBarController.h"
#import "MTContactTableViewController.h"

@interface MTContactsListViewController ()
{
    SlideNavTabBarController *navTabBarController;
}

@end

@implementation MTContactsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr=@[@"最热",@"最近",@"搜索"];
    NSArray *imgArr=@[@"iconfont-remen copy.png",@"iconfont-fujin.png",@"iconfont-sousuo.png"];
    NSArray *selectImgArr=@[@"iconfont-remen.png",@"iconfont-lanfujin.png",@"iconfont-sousuo select.png"];
    NSMutableArray* controllerArray =[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        
        MTContactTableViewController *controller=[[MTContactTableViewController alloc]init];
        
        switch (i) {
            case 0:
                controller.type=ENT_hot;
                controller.order=0;
                
                break;
            case 1:
                controller.type=ENT_neighbourhood;
                controller.order=2;
                
                break;
            default:
                controller.type=ENT_new;
                controller.order=1;
                
                break;
        }
        controller.inviteParentController=self.inviteParentController;
        [controllerArray addObject:controller];
    }
    navTabBarController = [[SlideNavTabBarController alloc] init];
    navTabBarController.navH=0;
    navTabBarController.imgArray=imgArr;
    navTabBarController.selectImgArray=selectImgArr;
    navTabBarController.subViewControllers = controllerArray;
    navTabBarController.isShowline=YES;
    navTabBarController.isShowNavSlide=YES;
    navTabBarController.titleArray=arr;
    //  navTabBarController.navBarDelegate=self;
    // Do any additional setup after loading the view.
    [self.view addSubview:navTabBarController.view];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
