//
//  StartViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 29/4/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "StartViewController.h"
#import "StartPageView.h"
#import "MainViewController.h"
#import "THRootNavigationViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    StartPageView *startView  = [[StartPageView alloc] initWithFrame:self.view.bounds top:70.0 plistFileName:@"startImage" sizeHeight:(kScreenHeight/667.0)];
    [startView.firstView.startAppBtu addTarget:self action:@selector(setRootView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startView];
}

- (void)setRootView:(UIButton *)button
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MainViewController *mainVC = [[MainViewController alloc] init];
    THRootNavigationViewController *navi = [[THRootNavigationViewController alloc]initWithRootViewController:mainVC];
    window.rootViewController = navi;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
