//
//  THModalNavigationController.m
//  Owner
//
//  Copyright © 2018年 万匿理. All rights reserved.
//

#import "THModalNavigationController.h"

@interface THModalNavigationController ()

@end

@implementation THModalNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setShadowImage:[UIImage new]];
}


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if ((self = [super initWithRootViewController:rootViewController])) {
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
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
