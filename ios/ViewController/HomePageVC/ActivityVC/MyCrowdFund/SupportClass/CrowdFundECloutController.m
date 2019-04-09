//
//  CrowdFundECloutControllerViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/5.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "CrowdFundECloutController.h"
//#import "DLFixedTabbarView.h"
#import "MyCrowdFundListController.h"

@interface CrowdFundECloutController ()

@end

@implementation CrowdFundECloutController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.tabedSlideView.selectedIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的众筹";
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor blackColor];
    self.tabedSlideView.tabbarTrackColor = kColor(@"#05c1b0");
    self.tabedSlideView.height = kWidth(64);
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width(self.tabedSlideView), 1)];
    lineLabel.backgroundColor = cLineColor;
    [self.tabedSlideView addSubview:lineLabel];
    
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"进行中" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"成功" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"失败" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
}
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            MyCrowdFundListController *Vc = [[MyCrowdFundListController alloc] init];
            Vc.Type = OnGoingType;
            return Vc;
        }
        case 1:
        {
            MyCrowdFundListController *Vc = [[MyCrowdFundListController alloc] init];
            Vc.Type = SuccessfulType;
            return Vc;
        }
        case 2:
        {
            MyCrowdFundListController *Vc = [[MyCrowdFundListController alloc] init];
            Vc.Type = FailureType;
            return Vc;
        }
        default:
            return nil;
    }
}
- (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index {
    
}


@end
