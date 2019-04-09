//
//  NewECloudHomePageViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NewECloudHomePageViewController.h"
#import "NavSlideView.h"
#import "SlideNavTabBarController.h"
#import "ECloudHomePageChildrenViewController.h"
//#import "NewECloudSearchViewController.h"
#import "ECloudMiaomuyunMainViewController.h"
@interface NewECloudHomePageViewController ()<SlideNavTabBarDelegate>
{
    SlideNavTabBarController *navTabBarController;
    NavSlideView *navView;
    NSMutableArray* controllerArray;
}
@end

@implementation NewECloudHomePageViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView=navView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *arr=@[@"苗木云",@"企业云",@"人脉云"];
    __weak NewECloudHomePageViewController *weakSelf = self;
    navView=[[NavSlideView alloc]initWithFrame:CGRectMake(0, 5, WindowWith-150, 35) setTitleArr:arr isPoint:NO integer:0];
    [navView slideSelectedIndex:self.currentIndex];
    navView.selectBlock=^(NSInteger index){
        [weakSelf SegmentedIndex:index];
    };
    self.navigationItem.titleView=navView;
    controllerArray =[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        if (i==0) {
            ECloudMiaomuyunMainViewController *controller=[[ECloudMiaomuyunMainViewController alloc]init];
            controller.inviteParentController=self;
            [controllerArray addObject:controller];
        }
        else  if (i==1) {
            ECloudHomePageChildrenViewController *controller=[[ECloudHomePageChildrenViewController alloc]init];
            controller.type=ENT_company;
            controller.inviteParentController=self;
            [controllerArray addObject:controller];
        }
        else if(i==2){
            ECloudHomePageChildrenViewController *controller=[[ECloudHomePageChildrenViewController alloc]init];
            controller.type=ENT_Connections;
            controller.inviteParentController=self;
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

    [self SegmentedIndex:self.currentIndex];

}
-(void)SegmentedIndex:(NSInteger)index
{
    [navTabBarController SegmentedDelegateViewclickedWithIndex:index];
}
-(void)itemSelectedIndex:(NSInteger)index{
    [navView slideSelectedIndex:index];
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
//        return NO;
//    }
//    return  YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
