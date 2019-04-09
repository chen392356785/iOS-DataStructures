//
//  THRootNavigationViewController.m
//  MiaoTuProjectTests
//
//  Created by Neely on 2018/5/2.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "THRootNavigationViewController.h"

@interface THRootNavigationViewController ()

@end

@implementation THRootNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = NO;
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
