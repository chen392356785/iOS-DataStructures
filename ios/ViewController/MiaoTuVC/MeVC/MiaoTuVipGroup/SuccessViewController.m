//
//  SuccessViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/19.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SuccessViewController.h"

@interface SuccessViewController () {
    NSString *_succStr;
    NSString *_infoStr;
}

@end

@implementation SuccessViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)back:(id)sender {
    if ([self.navigationController.viewControllers indexOfObject:self] == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleName;
    [self addsubViews];
}

- (void) addsubViews {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(55), kWidth(152), kWidth(91))];
    [self.view addSubview:imageV];
    imageV.image = kImage(@"img_bmcg");
    imageV.centerX = self.view.centerX;
    
    UILabel *_succLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.bottom + kWidth(30), iPhoneWidth, kWidth(18))];
    _succLab.font = darkFont(font(18));
    _succLab.textAlignment = NSTextAlignmentCenter;
    _succLab.textColor = kColor(@"#333333");
    _succLab.text = _succStr;
    [self.view addSubview:_succLab];
    
    UILabel *_infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _succLab.bottom + kWidth(34), iPhoneWidth, kWidth(14))];
    _infoLab.font = darkFont(font(14));
    _infoLab.textAlignment = NSTextAlignmentCenter;
    _infoLab.textColor = kColor(@"#595959");
    _infoLab.text = _infoStr;
    [self.view addSubview:_infoLab];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeSystem];
    backBut.frame = CGRectMake(0, iPhoneHeight - KtopHeitht - kWidth(75) - kWidth(49), kWidth(350), kWidth(49));
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    backBut.titleLabel.font = sysFont(17);
    backBut.backgroundColor = kColor(@"#05C1B0");
    backBut.layer.cornerRadius = kWidth(7);
    [backBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    backBut.centerX = self.view.centerX;
    [backBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBut];
    
}
- (void)setSucceStr:(NSString *)succStr andInfoStr:(NSString *)infoStr {
    _succStr = succStr;
    _infoStr = infoStr;
}
- (void) backAction {
    if ([self.navigationController.viewControllers indexOfObject:self] == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
