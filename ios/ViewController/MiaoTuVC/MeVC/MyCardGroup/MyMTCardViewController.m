//
//  MyMTCardViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyMTCardViewController.h"
#import "XLSlideSwitch.h"
#import "MyCardListViewController.h"

@interface MyMTCardViewController () <XLSlideSwitchDelegate> {
    XLSlideSwitch *_slideSwitch;
    NSArray *_titleArray;
    NSMutableArray *viewControllers;
}

@end

@implementation MyMTCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的卡券";
    self.view.backgroundColor = kColor(@"#F2F2F2");
    [self createUI];
}

- (void) createUI {
    viewControllers = [[NSMutableArray alloc] init];
    _titleArray = @[@"未使用",@"已使用",@"已失效"];
    for (NSInteger i = 0 ; i < _titleArray.count; i++) {
        UIViewController *vc = [self viewControllerOfIndex:i];
        [viewControllers addObject:vc];
    }
    //创建滚动视图
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 1, self.view.bounds.size.width, self.view.bounds.size.height) Titles:_titleArray viewControllers:viewControllers];
    //设置代理
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.itemSelectedColor = kColor(@"#05c1b0");
    _slideSwitch.itemNormalColor = kColor(@"#929292");
    //标题横向间距
    _slideSwitch.customTitleSpacing = kWidth(80);
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
    MyCardListViewController *vc = [[MyCardListViewController alloc] init];
    if (index == 0) {
        vc.typeStr = @"0";
    }else if (index == 1) {
        vc.typeStr = @"1";
    }else if (index == 2) {
        vc.typeStr = @"2";
    }else {
        vc.typeStr = @"";
    }
    return vc;
}
- (void)showNextView {
    _slideSwitch.selectedIndex += 1;
}

@end
