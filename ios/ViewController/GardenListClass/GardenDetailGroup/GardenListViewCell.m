//
//  GardenListViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenListViewCell.h"


@interface  GardenListViewCell () {
    
    UIImageView *bgImageView;
    UIView *bgView;
    
    UILabel *mingciLabel;
    UILabel *nameLabel;
    
    UILabel *SkrLabel;
    
    UIView *skrBgView;
    UIButton *skrButton;
    
    UILabel *userLab;   //榜单
    UILabel *phoLab;    //电话
    UILabel *liuyanNumLab;    //评论留言数
    yuanbangModel *_yuanbangModel;
    
}

@end

@implementation GardenListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(8.5), iPhoneWidth - kWidth(20), kWidth(59))];
    bgView.backgroundColor = kColor(@"#ffffff");
    [self.contentView addSubview:bgView];
    
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
    bgImageView.layer.cornerRadius = kWidth(6);
    bgImageView.clipsToBounds = YES;
    [bgView addSubview:bgImageView];
    
    mingciLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), 0, kWidth(32), bgView.height)];
    mingciLabel.textAlignment = NSTextAlignmentCenter;
    mingciLabel.font = HBoldFont(font(16));
    mingciLabel.textColor = kColor(@"#575757");
    mingciLabel.numberOfLines = 2;
    self.rankingLabel = mingciLabel;
    [bgView addSubview:mingciLabel];
    
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(mingciLabel.right + kWidth(2), kWidth(7), bgView.width  - mingciLabel.right - kWidth(68), kWidth(17))];
    nameLabel.textColor = kColor(@"#4A4A4A");
    nameLabel.font = RegularFont(font(14));
    [bgView addSubview:nameLabel];
    
    
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + kWidth(8), kWidth(16), kWidth(16))];
    userImage.image = kImage(@"grend_user");
    [bgView addSubview:userImage];
    
    userLab = [[UILabel alloc] initWithFrame:CGRectMake(userImage.right + kWidth(9), userImage.top, nameLabel.width/2 - userImage.width - kWidth(35), userImage.height)];
    userLab.textColor = kColor(@"#575757");
    userLab.font = RegularFont(font(12));
    [bgView addSubview:userLab];
    
    
    UIView *phonView = [[UIView alloc] initWithFrame:CGRectMake(userLab.right, userLab.top, nameLabel.width/2 + kWidth(35), userImage.height)];
    [bgView addSubview:phonView];
    UITapGestureRecognizer *Phonetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CallPhoneAction)];
    // 允许用户交互
    phonView.userInteractionEnabled = YES;
    [phonView addGestureRecognizer:Phonetap];
    
    
    UIImageView *phoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(16), kWidth(16))];
    phoImg.image = kImage(@"phone_img");
    [phonView addSubview:phoImg];
    
    phoLab = [[UILabel alloc] initWithFrame:CGRectMake(phoImg.right + kWidth(9), phoImg.top, phonView.width - phoImg.width - kWidth(9), userImage.height)];
    phoLab.textColor = kColor(@"#575757");
    phoLab.font = LightFont(font(14));
    [phonView addSubview:phoLab];
    
    
    skrBgView = [[UIView alloc] initWithFrame:CGRectMake(bgView.width - kWidth(60), kWidth(8), kWidth(56), (bgView.height - kWidth(20))/2.)];
    [bgView addSubview:skrBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skrAction)];
    // 允许用户交互
    skrBgView.userInteractionEnabled = YES;
    [skrBgView addGestureRecognizer:tap];
    
    
    skrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skrButton.frame = CGRectMake(0 , 0,kWidth(16), kWidth(16));
    [skrButton setImage:[kImage(@"garden-wdz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [skrBgView addSubview:skrButton];
    skrButton.centerY = skrBgView.height/2;
    [skrButton addTarget:self action:@selector(skrAction) forControlEvents:UIControlEventTouchUpInside];
    
    SkrLabel = [[UILabel alloc] initWithFrame:CGRectMake(skrButton.right + kWidth(3), 0, skrBgView.width - skrButton.width - kWidth(3), skrBgView.height)];
    SkrLabel.centerY = skrButton.centerY;
    SkrLabel.textColor = kColor(@"#575757");
    SkrLabel.textAlignment = NSTextAlignmentCenter;
    SkrLabel.font = LightFont(font(14));
    SkrLabel.text = @"100";
    [skrBgView addSubview:SkrLabel];
    
    
    
    UIView *liuyanBgView = [[UIView alloc] initWithFrame:CGRectMake(skrBgView.left, skrBgView.bottom + kWidth(3),skrBgView.width, skrBgView.height)];
    [bgView addSubview:liuyanBgView];
    
    UITapGestureRecognizer *Luiyantap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liuyanAction)];
    // 允许用户交互
    liuyanBgView.userInteractionEnabled = YES;
    [liuyanBgView addGestureRecognizer:Luiyantap];
    
    
    UIButton *liuyanBut = [UIButton buttonWithType:UIButtonTypeCustom];
    liuyanBut.frame = CGRectMake(0 , 0,kWidth(16), kWidth(16));
    [liuyanBut setImage:[kImage(@"garden_liuyan") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [liuyanBgView addSubview:liuyanBut];
    liuyanBut.centerY = liuyanBgView.height/2;
    [liuyanBut addTarget:self action:@selector(liuyanAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *liuyanLab = [[UILabel alloc] initWithFrame:CGRectMake(liuyanBut.right + kWidth(3), 0, liuyanBgView.width - liuyanBut.width - kWidth(3), liuyanBgView.height)];
    liuyanLab.centerY = liuyanBut.centerY;
    liuyanLab.textColor = kColor(@"#575757");
    liuyanLab.textAlignment = NSTextAlignmentCenter;
    liuyanLab.font = LightFont(font(14));
    liuyanLab.text = @"100";
    [liuyanBgView addSubview:liuyanLab];
    liuyanNumLab = liuyanLab;
    
    
    
    bgView.layer.cornerRadius = kWidth(6);
    bgView.layer.shadowColor = kColor(@"#05C1B0").CGColor;
    bgView.layer.shadowOffset = CGSizeMake(2, 4);
    bgView.layer.shadowOpacity = 0.1;
    bgView.layer.shadowRadius = 1.5;
    
}


- (void)setYuanbangModel:(yuanbangModel *)yuanbangModel andBgImage:(NSString *)image{
    mingciLabel.centerY = kWidth(59)/2;
    _yuanbangModel = yuanbangModel;
    NSString *paimingStr;
    if (yuanbangModel.paiming.length == 1) {
        paimingStr = [NSString stringWithFormat:@"00%@",yuanbangModel.paiming];
    }else if (yuanbangModel.paiming.length == 2) {
        paimingStr = [NSString stringWithFormat:@"0%@",yuanbangModel.paiming];
    }else {
        paimingStr = [NSString stringWithFormat:@"%@",yuanbangModel.paiming];
    }
    mingciLabel.text = [NSString stringWithFormat:@"NO.\n%@",paimingStr];
    
    nameLabel.text = yuanbangModel.gardenCompany;
    SkrLabel.text = yuanbangModel.gardenSignString;
   
    SkrLabel.adjustsFontSizeToFitWidth = YES;
    userLab.text = yuanbangModel.gardenName;
    phoLab.text = yuanbangModel.mobile;
    liuyanNumLab.text = yuanbangModel.commentCountString;
    
    if ([yuanbangModel.isClick isEqualToString:@"1"]) {
        skrButton.selected = YES;
        [skrButton setImage:[kImage(@"garden-dz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        skrButton.selected = NO;
        [skrButton setImage:[kImage(@"garden-wdz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:image]];
}
- (void) skrAction {
    if (skrButton.isSelected == NO) {
        if (self.SkrBlock) {
            self.SkrBlock(0);
        }
    } else {
        if (self.SkrBlock) {
            self.SkrBlock(1);
        }
//        [IHUtility addSucessView:@"今日已投过票了!请明日再投" type:2];
    }
}
#pragma - mark 留言
- (void) liuyanAction {
    if (self.pinlunBlock) {
        self.pinlunBlock();
    }
}

#pragma - mark 打电话
- (void) CallPhoneAction {
    if (![_yuanbangModel.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",_yuanbangModel.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.contentView addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
}

@end
