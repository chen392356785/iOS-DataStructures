//
//  SignUpSuccessViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/19.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SignUpSuccessViewController.h"


@interface SignUpSuccessViewController ()

@end

@implementation SignUpSuccessViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *bgImage = [[UIImage imageNamed:@"success_na_bj"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
    [self setTitle:@"报名成功"];
    titleLabel.font = sysFont(17);
    titleLabel.textColor = kColor(@"#ffffff");
    [self creareSubView];
}
- (void) creareSubView {
    UIImage *image = [Image(@"success_bj") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGFloat imageH = iPhoneWidth / (image.size.width / image.size.height);
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, imageH)];
    bgImageView.image = image;
    [self.view addSubview:bgImageView];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(45), kWidth(45), iPhoneWidth - kWidth(90), kWidth(340))];
    bgView.layer.cornerRadius = kWidth(10);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    bgView.layer.shadowColor = kColor(@"#40dccb").CGColor;
    bgView.layer.shadowOffset = CGSizeMake(2, 5);
    bgView.layer.shadowOpacity = 0.5;
    bgView.layer.shadowRadius = 5;
    
    UIImageView *succImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(54), kWidth(152), kWidth(91))];
    succImageV.image = Image(@"img_bmcg");
    succImageV.centerX = bgView.width/2.;
    [bgView addSubview:succImageV];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, succImageV.bottom + kWidth(58), bgView.width, kWidth(20))];
    titleLabel.font = sysFont(18);
    [bgView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"报名成功";
    titleLabel.textColor = kColor(@"#333333");
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom + kWidth(34), bgView.width, kWidth(20))];
    infoLabel.font = sysFont(14);
    [bgView addSubview:infoLabel];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = @"课程报名成功，可在我的订购中查看";
    infoLabel.textColor = kColor(@"#595959");
    
    UIButton *StudyBut = [UIButton buttonWithType:UIButtonTypeSystem];
    StudyBut.frame = CGRectMake(kWidth(15), bgView.bottom + kWidth(108), kWidth(155), 39);
    [StudyBut setTitle:@"立即学习" forState:UIControlStateNormal];
    StudyBut.backgroundColor = kColor(@"#54D693");
    [StudyBut setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
    [StudyBut addTarget:self action:@selector(StudyAction) forControlEvents:UIControlEventTouchUpInside];
    StudyBut.layer.cornerRadius = StudyBut.height/2.;
    StudyBut.titleLabel.font = boldFont(14);
    [self.view addSubview:StudyBut];
    
    UIButton *classHomeBut = [UIButton buttonWithType:UIButtonTypeSystem];
    classHomeBut.frame = CGRectMake(iPhoneWidth - kWidth(15) - StudyBut.width, StudyBut.top, kWidth(155), 39);
    [classHomeBut setTitle:@"返回首页" forState:UIControlStateNormal];
    classHomeBut.backgroundColor = kColor(@"#47B7A1");
    [classHomeBut addTarget:self action:@selector(backClassHomeAction) forControlEvents:UIControlEventTouchUpInside];
    [classHomeBut setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
    classHomeBut.layer.cornerRadius = StudyBut.height/2.;
    classHomeBut.titleLabel.font = boldFont(14);
    [self.view addSubview:classHomeBut];
    
}
- (void) StudyAction {
    
//    NSLog(@"立即学习");
}
//返回首页
- (void)backClassHomeAction {
    [self popViewController:1];
}


@end
