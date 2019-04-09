//
//  ShareMtViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/15.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "ShareMtViewController.h"

@interface ShareMtViewController () {
    UIScrollView *_scrollView;
    UIView *_topBgView;
}

@end

@implementation ShareMtViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    leftbutton.frame=CGRectMake(0, 0, 20, 44);
    leftbutton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    UIImage *bgImage1 = kImage(@"img_yqhy_bt");
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
    [self setTitle:@"邀请好友得奖励" andTitleColor:kColor(@"#FFFFFF")];
    
    
    UIImage *bjImage = kImage(@"img_yqhy_bj");
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_scrollView];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.width, bjImage.size.height/bjImage.size.width*iPhoneWidth)];
    bgImgView.image = bjImage;
    [_scrollView addSubview:bgImgView];
    _scrollView.contentSize = CGSizeMake(iPhoneWidth, bgImgView.height + KtopHeitht - KTabSpace);
    
    [self createAddsubViews];
    [self createBottomView];
}
- (void) createAddsubViews {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(kWidth(14),kWidth(154),kWidth(347),kWidth(352));
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = kWidth(8);
    [_scrollView addSubview:view];
    _topBgView = view;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,kWidth(25),view.width,18);
    [view addSubview:label];
    label.centerX = view.width/2;
    label.text = @"邀请好友一起赚苗途币";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kColor(@"#303030");
    label.font =  [UIFont fontWithName:@"PingFang-SC-Heavy" size: 18];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(kWidth(53),kWidth(59),kWidth(17),1);
    leftView.backgroundColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1.0];
    [view addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake(view.width - kWidth(53) - leftView.width ,leftView.top,leftView.width,1);
    rightView.backgroundColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1.0];
    [view addSubview:rightView];
    
    UILabel *infolab = [[UILabel alloc] init];
    infolab.frame = CGRectMake(leftView.right,label.bottom + kWidth(10),rightView.left - leftView.right,kWidth(14));
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"每邀请1位好友你将获得" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0]}];
    infolab.attributedText = string;
    [view addSubview:infolab];
    infolab.textAlignment = NSTextAlignmentCenter;
    leftView.centerY = infolab.centerY;
    rightView.centerY = infolab.centerY;
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(view.width - kWidth(14) - kWidth(188), infolab.bottom + kWidth(31), kWidth(188),kWidth(39))];
    bgImgView.image = kImage(@"share_mess_img");
    [view addSubview:bgImgView];
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(5), kWidth(7.5), bgImgView.width - kWidth(10), kWidth(18))];
    textLab.text = @"100苗途币，不限次哦！";
    textLab.textColor = kColor(@"#FFFFFF");
    textLab.font = darkFont(16);
    textLab.textAlignment = NSTextAlignmentCenter;
    [bgImgView addSubview:textLab];
    [textLab adjustsFontSizeToFitWidth];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, bgImgView.bottom + kWidth(1), kWidth(261),kWidth(142))];
    imgView.image = kImage(@"share_lb_img");
    [view addSubview:imgView];
    imgView.centerX = view.width/2;
    
    UILabel *codeNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom + kWidth(30), view.width, kWidth(15))];
    codeNumLab.text = [NSString stringWithFormat:@"我的邀请码：%@",self.infoModel.shareCode];
    codeNumLab.textColor = kColor(@"#F72900");
    codeNumLab.font = darkFont(font(14));
    codeNumLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:codeNumLab];
    
}
- (void) createBottomView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(_topBgView.left,_topBgView.bottom + kWidth(28),_topBgView.width,kWidth(143));
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [_scrollView addSubview:view];
    
    UILabel *titLab =  [[UILabel alloc] init];
    titLab.frame = CGRectMake(0,kWidth(12),kWidth(51),kWidth(13));
    [view addSubview:titLab];
    titLab.text = @"邀请方式";
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.textColor = kColor(@"#333333");
    titLab.font =  [UIFont fontWithName:@"PingFang-SC-Heavy" size: font(13)];
    [titLab sizeToFit];
    titLab.centerX = view.width/2;
    
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(titLab.left - kWidth(25) - kWidth(13),kWidth(0),kWidth(25),1);
    leftView.backgroundColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1.0];
    [view addSubview:leftView];
    leftView.centerY = titLab.centerY;
    
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake(titLab.right + kWidth(13) ,leftView.top,kWidth(25),1);
    rightView.backgroundColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1.0];
    [view addSubview:rightView];
    
    NSArray *titleArr = @[@"QQ",@"空间",@"微信",@"朋友圈"];
    NSArray *imgsArr  =  @[@"share_qq_img",@"share_qqkj_img",@"share_wx_img",@"share_pyq_img"];
    for (int i = 0; i < titleArr.count; i ++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(i * (view.width/titleArr.count), titLab.bottom + kWidth(15), view.width/titleArr.count, kWidth(80))];
        [view addSubview:bgView];
        bgView.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareAction:)];
        // 允许用户交互
        bgView.userInteractionEnabled = YES;
        [bgView addGestureRecognizer:tap];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(50),kWidth(50))];
        imgView.image = [UIImage imageNamed:imgsArr[i]];
        [bgView addSubview:imgView];
        imgView.centerX = bgView.width/2;
        
        UILabel *Lab =  [[UILabel alloc] init];
        Lab.frame = CGRectMake(0,imgView.bottom + kWidth(10),bgView.width,kWidth(13));
        [bgView addSubview:Lab];
        Lab.text = titleArr[i];
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.textColor = kColor(@"#464646");
        Lab.font =  [UIFont fontWithName:@"PingFang-SC-Medium" size: font(13)];
    }
    
}
#pragma - mark 呼叫
-(void)shareAction:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *views = (UIView*)tap.view;
    NSInteger index = views.tag - 100;
    NSInteger shareIndex = 0;
    if (index == 0) {   //QQ
        shareIndex = 3;
    }else if (index == 1){  //QQ空间
        shareIndex = 4;
    }else if (index == 2){  //微信
        shareIndex = 1;
    }else if (index == 3){  //朋友圈
        shareIndex = 2;
    }
    NSString *shareNumUrl;
    shareNumUrl = [NSString stringWithFormat:@"%@?yzm=%@",self.model.yaoqinghaoyou_Url,self.infoModel.shareCode];
    
    [IHUtility SharePingTai:[NSString stringWithFormat:@"%@，加入%@，携手共赢",KAppTitle,KAppName] url:shareNumUrl imgUrl:@"" content:[NSString stringWithFormat:@"我一直在用%@找苗木、搜人脉、找企业。邀你一起来体验，积分还可抵现金用哦",KAppName] PlatformType:shareIndex controller:self completion:^{
        
    }];
    
    
}
- (void) share {
    [self ShareUrl:self withTittle:[NSString stringWithFormat:@"%@，加入%@，携手共赢",KAppTitle,KAppName] content:[NSString stringWithFormat:@"我一直在用%@找苗木、搜人脉、找企业。邀你一起来体验，积分还可抵现金用哦",KAppName] withUrl:dwonShareURL imgUrl:@""];
    NSLog(@"邀请好友");
}


@end
