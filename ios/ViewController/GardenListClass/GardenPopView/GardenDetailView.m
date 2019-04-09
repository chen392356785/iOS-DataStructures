//
//  GardenDetailView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/23.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenDetailView.h"

static const CGFloat contentFont = 13;

@interface GardenDetailView (){
    UILabel *paiminLabel;
    UIImageView *HeadImageV;
    UILabel *nameLabel;
    UIButton *cancelBut;
    UITextView *conTextView;
    UIButton *skrButton;
    UILabel *skrLabel;
    UILabel *lineLabel;
    UIButton *PhoneBut;
    UIImageView *paiImageView;
    
    UIButton *shareBut;
    
}
@end

@implementation GardenDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.layer.cornerRadius = kWidth(7);
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
    }
    return self;
}
- (void) createView {
    HeadImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, kWidth(154))];
    [self addSubview:HeadImageV];
    
    cancelBut = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBut.frame = CGRectMake(self.right - kWidth(28), 0, kWidth(32), kWidth(32));
    [cancelBut addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBut setBackgroundImage:[kImage(@"guanbi") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self addSubview:cancelBut];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, HeadImageV.width, kWidth(34))];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = darkFont(font(17));
    nameLabel.textColor = kColor(@"#fefefe");
    [HeadImageV addSubview:nameLabel];
    nameLabel.centerY = HeadImageV.centerY;
    
    lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - kWidth(47) , self.width, 1)];
    lineLabel.backgroundColor = kColor(@"#eeeeee");
    [self addSubview:lineLabel];\
    
    conTextView = [[UITextView alloc] initWithFrame:CGRectMake(kWidth(12), HeadImageV.bottom + kWidth(10), self.width - kWidth(24), lineLabel.bottom - HeadImageV.bottom - kWidth(20))];
    conTextView.textColor = kColor(@"#515151");
    conTextView.font = [UIFont systemFontOfSize:font(contentFont)];
    [conTextView setEditable: NO];
    
    [self addSubview:conTextView];
    
    
    skrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skrButton.frame = CGRectMake(kWidth(17), 0, kWidth(19), kWidth(19));
    skrButton.centerY = lineLabel.bottom + kWidth(47)/2.;
    [skrButton setImage:[kImage(@"garden-wdz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self addSubview:skrButton];
    [skrButton addTarget:self action:@selector(skrAction) forControlEvents:UIControlEventTouchUpInside];
    
    skrLabel = [[UILabel alloc] initWithFrame:CGRectMake(skrButton.right + kWidth(6), lineLabel.bottom + kWidth(5), kWidth(47), kWidth(18))];
    skrLabel.font = sysFont(font(14));
    skrLabel.textColor = kColor(@"#535252");
    skrLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:skrLabel];
    skrLabel.centerY = skrButton.centerY;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skrAction)];
    // 允许用户交互
    skrLabel.userInteractionEnabled = YES;
    [skrLabel addGestureRecognizer:tap];

    
    
    paiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(skrLabel.right + kWidth(17), 0, kWidth(19), kWidth(16))];
    paiImageView.image = kImage(@"garden_mingci");
    paiImageView.centerY = skrButton.centerY;
    [self addSubview:paiImageView];
    
    paiminLabel = [[UILabel alloc] initWithFrame:CGRectMake(paiImageView.right + kWidth(6), skrLabel.top, skrLabel.width, kWidth(20))];
    paiminLabel.font = sysFont(font(14));
    paiminLabel.textColor = kColor(@"#535252");
    paiminLabel.centerY = skrButton.centerY;
    paiminLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:paiminLabel];
    
    
    PhoneBut = [UIButton buttonWithType:UIButtonTypeSystem];
    PhoneBut.frame = CGRectMake(self.width - kWidth(17) - kWidth(35), 0, kWidth(20), kWidth(20));
    PhoneBut.centerY = skrButton.centerY;
    [PhoneBut setBackgroundImage:kImage(@"phone_img") forState:UIControlStateNormal];
    [self addSubview:PhoneBut];
    [PhoneBut addTarget:self action:@selector(CallPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    
    shareBut = [UIButton buttonWithType:UIButtonTypeSystem];
    shareBut.frame = CGRectMake(PhoneBut.left - kWidth(38)  - kWidth(20), 0, kWidth(20), kWidth(20));
    shareBut.centerY = skrButton.centerY;
    [shareBut setBackgroundImage:kImage(@"Garden_Share") forState:UIControlStateNormal];
    [self addSubview:shareBut];
    [shareBut addTarget:self action:@selector(ShareAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
   
    
}
- (void)setYuanbangModel:(yuanbangModel *)yuanbangModel andPicUrl:(NSString *)picUrl{
    NSURL *headUrl = [NSURL URLWithString:picUrl];
    [HeadImageV sd_setImageWithURL:headUrl placeholderImage:kImage(@"Garden-bj")];
    nameLabel.text = yuanbangModel.gardenCompany;
    conTextView.text = yuanbangModel.gardenContent;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    skrLabel.text = yuanbangModel.gardenSign;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:font(contentFont)],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    conTextView.attributedText = [[NSAttributedString alloc] initWithString:conTextView.text attributes:attributes];
    if ([yuanbangModel.isClick isEqualToString:@"1"]) {
        skrButton.selected = YES;
        [skrButton setImage:[kImage(@"garden-dz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        skrButton.selected = NO;
        [skrButton setImage:[kImage(@"garden-wdz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    
    paiminLabel.text = [NSString stringWithFormat:@"%@",yuanbangModel.paiming];
}
- (void) skrAction{
    if (skrButton.selected == YES) {
        [IHUtility addSucessView:@"今日已投过票了!请明日再投" type:2];
        return;
    }
    if (self.SkrBlock) {
        self.SkrBlock();
    }
}
- (void) CancelAction:(UIButton *)but {
    if (self.CancelBlock) {
        self.CancelBlock();
    }
}
- (void) CallPhoneAction {
    if (self.PhoneActionBlock) {
        self.PhoneActionBlock();
    }
}
- (void) ShareAction {
    if (self.ShareActionBlock) {
        self.ShareActionBlock();
    }
}
- (void) upSubViewDataModel:(yuanbangModel *)yuanbangModel{
    
    skrLabel.text = yuanbangModel.gardenSign;
    if ([yuanbangModel.isClick isEqualToString:@"1"]) {
        skrButton.selected = YES;
        [skrButton setImage:[kImage(@"garden-dz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        skrButton.selected = NO;
        [skrButton setImage:[kImage(@"garden-wdz") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}
@end
