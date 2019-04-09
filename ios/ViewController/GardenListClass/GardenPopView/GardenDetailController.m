//
//  GardenDetailController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/3.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenDetailController.h"

static const CGFloat contentFont = 14;

@interface GardenDetailController () {
     UIView *bgView;
     UIScrollView *bgScrollView;
     UIImageView *HeadImageV;
     UIImageView *PaiMingImgV;
     UILabel *PaiMingLabel;
    
    UILabel *conLabel;
    
    UIButton *skrButton;
    UILabel *skrLabel;
    UIButton *PhoneBut;
    UILabel *PhoneLabel;
}

@end

@implementation GardenDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.gardenCompany;
    self.view.backgroundColor = kColor(@"#f3f2f7");
    [self setNavigationBar];
    [self setUI];
    
}
#pragma - mark 设置导航栏
- (void) setNavigationBar {
    UIImage *shareImg=Image(@"icon_fx");
    moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(0, 0, 20, 40);
    [moreBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:shareImg forState:UIControlStateNormal];
    UIBarButtonItem *barMoreBtn=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItems= @[barMoreBtn];
}
#pragma mark - 分享
- (void) shareAction {
    NSString *ClassHomePath = [NSString stringWithFormat:@"pages/gardenRank/gardenDetail/gardenDetail?gardenId=%@",self.model.gardenId];
    NSDictionary *dict = @{
                           @"appid"         : WXXCXappId,
                           @"appsecret"     : WXXCXappSecret,
                           @"gardenId"      : self.model.gardenId,
                           @"path"          : ClassHomePath,
//                           @"path"          : @"pages/activity/detail/detail?1&2",
                           };
    WS(weakSelf);
    [self shareSmallProgramCodeOject:dict httpMethod:0 methoe:GardenDetailSharelUrl Vc:self completion:^(id data, NSError *error) {
        NSLog(@"分享成功");
        [weakSelf shareLike];
    }];
}
//分享成功后 + 1
- (void) shareLike {
    NSDictionary *dic = @{
                          @"gardenId"      : self.model.gardenId,
                          };
    [network httpRequestWithParameter:dic method:shareLikeUrl success:^(NSDictionary *dic) {
        
    } failure:^(NSDictionary * obj) {
    }];
}
- (void) setUI {
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kWidth(17), iPhoneWidth - kWidth(24), iPhoneHeight - KtopHeitht - kWidth(17) - kWidth(50))];
//    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kWidth(17), iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(17))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.centerX = self.view.centerX;
    [self.view addSubview:bgView];
    
    
    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height -  kWidth(45))];
    [bgView addSubview:bgScrollView];
    
    HeadImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgScrollView.width, kWidth(155))];
    [bgScrollView addSubview:HeadImageV];
    [HeadImageV sd_setImageWithURL:[NSURL URLWithString:self.HeadPic] placeholderImage:kImage(@"Garden-bj")];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:HeadImageV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kWidth(8), kWidth(8))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = HeadImageV.bounds;
    maskLayer.path = maskPath.CGPath;
    HeadImageV.layer.mask = maskLayer;

    
    PaiMingImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeadImageV.bottom + kWidth(11), kWidth(148), kWidth(148))];
    PaiMingImgV.image = kImage(@"yuan_pm_bg");
    PaiMingImgV.centerX = HeadImageV.centerX;
    [bgScrollView addSubview:PaiMingImgV];
    
    PaiMingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, PaiMingImgV.width - kWidth(15), kWidth(36))];
    PaiMingLabel.text = self.model.paiming;
   
    PaiMingLabel.centerX = PaiMingImgV.width/2.;
    PaiMingLabel.font = darkFont(font(36));
    PaiMingLabel.textColor = kColor(@"#5d5d5d");
    PaiMingLabel.textAlignment = NSTextAlignmentCenter;
    PaiMingLabel.centerY = PaiMingImgV.height/2. + kWidth(7);
    [PaiMingImgV addSubview:PaiMingLabel];
    PaiMingLabel.adjustsFontSizeToFitWidth = YES;
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, PaiMingLabel.width - kWidth(20), kWidth(12))];
    showLabel.centerX = PaiMingLabel.centerX;
    showLabel.text = @"当前排名";
    showLabel.textColor = kColor(@"#797979");
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.font = boldFont(12);
    showLabel.centerY = PaiMingLabel.top - kWidth(7) - showLabel.height/2.;
    [PaiMingImgV addSubview:showLabel];
    
    UILabel *infoLabel =  [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), PaiMingImgV.bottom + kWidth(33), bgScrollView.width - kWidth(24), kWidth(16))];
    infoLabel.text = @"公司简介";
    infoLabel.textColor = kColor(@"#333333");
    infoLabel.font = boldFont(font(16));
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [bgScrollView addSubview:infoLabel];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, infoLabel.bottom + kWidth(11), infoLabel.width, 1)];
    line1.backgroundColor = kColor(@"#ececec");
    [bgScrollView addSubview:line1];
    
    NSString *textStr = self.model.gardenContent;
    CGFloat textH = [IHUtility calculateRowHeight:textStr Width:infoLabel.width fontSize:font(contentFont)];
    conLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), line1.bottom + kWidth(13), infoLabel.width, textH)];
    conLabel.textColor = kColor(@"#515151");
    conLabel.numberOfLines = 0;
    conLabel.font = [UIFont systemFontOfSize:font(contentFont)];
    [bgScrollView addSubview:conLabel];
    conLabel.text = textStr;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:font(contentFont)],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    conLabel.attributedText = [[NSAttributedString alloc] initWithString:conLabel.text attributes:attributes];
    [conLabel sizeToFit];
    
    bgScrollView.contentSize = CGSizeMake(bgScrollView.width, conLabel.bottom + kWidth(17));
    bgScrollView.showsVerticalScrollIndicator = NO;

    [self addBottomView];
    [self setViewData];
}

- (void) addBottomView {
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, bgScrollView.bottom, bgScrollView.width, 1)];
    line2.backgroundColor = kColor(@"#f7f7f7");
    [bgView addSubview:line2];
    
    UIView *lineH = [[UIView alloc] initWithFrame:CGRectMake(0, line2.bottom, 1, kWidth(45))];
    lineH.backgroundColor = kColor(@"#f7f7f7");
    lineH.centerX = bgView.width/2.;
    [bgView addSubview:lineH];
    
    skrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skrButton.frame = CGRectMake(kWidth(23), 0, kWidth(19), kWidth(19));
    skrButton.centerY = line2.bottom + kWidth(44)/2.;
    [skrButton setImage:[kImage(@"garden-wdz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [bgView addSubview:skrButton];
    [skrButton addTarget:self action:@selector(skrAction) forControlEvents:UIControlEventTouchUpInside];
    skrButton.centerX = bgView.width/4. - (kWidth(70) + kWidth(19))/2.;
    
    skrLabel = [[UILabel alloc] initWithFrame:CGRectMake(skrButton.right + kWidth(3), 0, kWidth(76), kWidth(18))];
    skrLabel.font = sysFont(font(14));
    skrLabel.centerY = skrButton.centerY;
    skrLabel.textColor = kColor(@"#535252");
    skrLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:skrLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skrAction)];
    // 允许用户交互
    skrLabel.userInteractionEnabled = YES;
    [skrLabel addGestureRecognizer:tap];
    
    PhoneBut = [UIButton buttonWithType:UIButtonTypeSystem];
    PhoneBut.frame = CGRectMake(iPhoneWidth/2 + kWidth(23), 0, kWidth(19), kWidth(19));
    PhoneBut.centerY = skrButton.centerY;
    [PhoneBut setBackgroundImage:kImage(@"phone_img") forState:UIControlStateNormal];
    [bgView addSubview:PhoneBut];
    [PhoneBut addTarget:self action:@selector(CallPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    PhoneBut.centerX = bgView.width/2. + (kWidth(80) + kWidth(22))/2.;
    
    PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(PhoneBut.right + kWidth(3), 0, iPhoneWidth/2 - kWidth(80), kWidth(18))];
    PhoneLabel.centerY = PhoneBut.centerY;
    PhoneLabel.font = sysFont(font(14));
    PhoneLabel.centerY = skrButton.centerY;
    PhoneLabel.textColor = kColor(@"#535252");
    PhoneLabel.textAlignment = NSTextAlignmentLeft;
    PhoneLabel.text = self.model.mobile;
    [bgView addSubview:PhoneLabel];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CallPhoneAction)];
    // 允许用户交互
    PhoneLabel.userInteractionEnabled = YES;
    [PhoneLabel addGestureRecognizer:tap2];
    
    bgView.layer.cornerRadius = kWidth(8);
    bgView.layer.shadowColor = kColor(@"#000000").CGColor;
    bgView.layer.shadowOffset = CGSizeMake(2, 4);
    bgView.layer.shadowOpacity = 0.12;
    bgView.layer.shadowRadius = 1.5;
}

- (void) setViewData {
    if ([self.model.gardenSign intValue] >= 10000) {
        CGFloat zanNum = [self.model.gardenSign intValue]/10000.00;
        skrLabel.text = [NSString stringWithFormat:@"%.1f W",zanNum];
    }else {
        skrLabel.text = self.model.gardenSign;
    }
   
    if ([self.model.isClick isEqualToString:@"1"]) {
        skrButton.selected = YES;
        [skrButton setImage:[kImage(@"garden-dz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        skrButton.selected = NO;
        [skrButton setImage:[kImage(@"garden-wdz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}
#pragma -  mark  点赞
- (void) skrAction{
    if (skrButton.selected == YES) {
         [self showHomeHint:@"已给该公司点赞，其他公司还可以点哦" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
//        [IHUtility addSucessView:@"今日已投过票了!请明日再投" type:2];
        return;
    }
    [self addWaitingView];
    NSString *userId = @"";
    if (USERMODEL.userID != nil) {
        userId = USERMODEL.userID;
    }
    WS(weakSelf);
    NSDictionary *dic = @{
                          @"gardenId"      : self.model.gardenId,
                          @"userId"        : userId,
                          @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                          };
    [network httpRequestWithParameter:dic method:GardenLikeUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        NSLog(@"%@ - %@",dic[@"content"],dic[@"errorContent"]);
        self.model.isClick = @"1";
        self.model.gardenSign = [NSString stringWithFormat:@"%d",[self.model.gardenSign intValue] + 1];
        [weakSelf setViewData];    //刷新弹框
        if (self.SkrBlock) {
            self.SkrBlock();
        }
        [self showHomeHint:@"明天还可以继续哦~" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
}

#pragma -  mark  打电话
- (void) CallPhoneAction {
    if (![self.model.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",self.model.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
