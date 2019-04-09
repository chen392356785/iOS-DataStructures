//
//  CardDetailViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "CardDetailViewController.h"

@interface CardDetailViewController () {
    UIView *_bgView;
}

@end

@implementation CardDetailViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UIImage *backImg=Image(@"icon_fh_b");
    leftbutton.frame=CGRectMake(0, 0, 34, 40);
    [leftbutton setImage:backImg forState:UIControlStateNormal];
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
 
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
    
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)back:(id)sender {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *bgImage1 = [UIImage imageWithColor:kColor(@"#05C1B0") size:CGSizeMake(iPhoneWidth, KtopHeitht)];
    UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = kColor(@"#05C1B0");
    [self setTitle:@"入场券" andTitleColor:kColor(@"#FEFEFE")];
    [self createSbuViews];
}
- (void) createSbuViews {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(13), kWidth(13) , kWidth(350), kWidth(510))];
    _bgView.backgroundColor = kColor(@"#FFFFFF");
    [self.view addSubview:_bgView];
    _bgView.centerX = self.view.centerX;
    _bgView.layer.cornerRadius = kWidth(7);
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(25), _bgView.width, kWidth(16))];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"出示二维码";
    titleLab.font = sysFont(font(16));
    [_bgView addSubview:titleLab];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(60), _bgView.width, 1)];
    line.backgroundColor = kColor(@"#DBDBDB");
    [_bgView addSubview:line];
    
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, line.bottom + kWidth(65), _bgView.width, kWidth(18))];
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.text = @"使用时请向工作人员出示此二维码";
    infoLab.font = sysFont(font(18));
    [_bgView addSubview:infoLab];
    
    UIImageView *codeImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, infoLab.bottom + kWidth(11), kWidth(306), kWidth(306))];
    codeImageV.centerX = infoLab.centerX;
    [_bgView addSubview:codeImageV];
    [codeImageV sd_setImageWithURL:[NSURL URLWithString:self.model.cardUrl] placeholderImage:kImage(@"")];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
