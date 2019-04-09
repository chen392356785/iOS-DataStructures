//
//  MyRankingListController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/18.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyRankingListController.h"
#import "XLSlideSwitch.h"
#import "MyRankListViewController.h"

@interface MyRankingListController () <XLSlideSwitchDelegate> {
    XLSlideSwitch *_slideSwitch;
    NSArray *_titleArray;
    NSMutableArray *viewControllers;
}

@end

@implementation MyRankingListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    leftbutton.frame=CGRectMake(0, 0, 20, 44);
    leftbutton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    UIImage *bgImage1 = [UIImage imageWithColor:kColor(@"#05c1b0") size:CGSizeMake(iPhoneWidth, KtopHeitht)];
    UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"排行榜" andTitleColor:kColor(@"#FEFEFE")];
    [self createUI];
    
}
- (void) createUI {
    viewControllers = [[NSMutableArray alloc] init];
    _titleArray = @[@"邀请好友奖励排行榜",@"苗途币排行榜"];
    for (NSInteger i = 0 ; i < _titleArray.count; i++) {
        UIViewController *vc = [self viewControllerOfIndex:i];
        [viewControllers addObject:vc];
    }
    //创建滚动视图
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) Titles:_titleArray viewControllers:viewControllers];
    //设置代理
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.itemSelectedColor = kColor(@"#05c1b0");
    _slideSwitch.itemNormalColor = kColor(@"#2c2c2c");
    //标题横向间距
    _slideSwitch.customTitleSpacing = kWidth(40);
    //显示方法
    [_slideSwitch showInViewController:self];
    _slideSwitch.backgroundColor = kColor(@"#f8f8f8");
}

#pragma mark -
#pragma mark SlideSwitchDelegate

- (void)slideSwitchDidselectAtIndex:(NSInteger)index {
    NSLog(@"切换到了第 -- %zd -- 个视图",index);
}

- (UIViewController *)viewControllerOfIndex:(NSInteger)index {
    MyRankListViewController *vc = [[MyRankListViewController alloc] init];
    if (index == 0) {
        vc.typeStr = @"0";
    }else if (index == 1) {
        vc.typeStr = @"1";
    }else {
        vc.typeStr = @"";
    }
    return vc;
}
- (void)showNextView {
    _slideSwitch.selectedIndex += 1;
}


@end
