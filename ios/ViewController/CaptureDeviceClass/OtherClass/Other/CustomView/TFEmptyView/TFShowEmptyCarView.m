//
//  TFShowEmptyCarView.m
//  TH
//
//  Created by 苏浩楠 on 16/7/21.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import "TFShowEmptyCarView.h"

@interface TFShowEmptyCarView ()
/**图片*/
@property (weak, nonatomic)  UIImageView *remindImgView;
/**提示文字*/
@property (weak, nonatomic)  UILabel *remindLab;

@end

@implementation TFShowEmptyCarView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //去逛逛按钮
        UIButton *goToShoppingCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.goToShoppingCarBtn = goToShoppingCarBtn;
        self.goToShoppingCarBtn.layer.borderColor = THBaseColor.CGColor;
        self.goToShoppingCarBtn.layer.borderWidth = 1.0;
        self.goToShoppingCarBtn.layer.cornerRadius = 3;
        self.goToShoppingCarBtn.layer.masksToBounds = YES;
        [self.goToShoppingCarBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        [self.goToShoppingCarBtn setTitleColor:THBaseColor forState:UIControlStateNormal];
        [self.goToShoppingCarBtn setTitleColor:THBaseColor forState:UIControlStateHighlighted];
        [self.goToShoppingCarBtn.titleLabel setFont:kLightFont(14)];
        [self addSubview:goToShoppingCarBtn];
        
        //提示文字
        UILabel *remindLab = [[UILabel alloc] init];
        self.remindLab = remindLab;
        remindLab.font = kLightFont(14);
        remindLab.text = @"购物车还空空如也哦~";
        remindLab.textColor = THContentTextColor;
        remindLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:remindLab];
        
        //图片
        UIImageView *remindImgView = [[UIImageView alloc] init];
        self.remindImgView = remindImgView;
        remindImgView.image = kImage(@"icon_noGoods");
        [self addSubview:remindImgView];
        
        [self setSubFrame];
    }
    return self;
}
#pragma mark --设置坐标--
- (void)setSubFrame {

    [self.goToShoppingCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_centerY).offset(20);
        
    }];
    //提示文字
    [self.remindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.goToShoppingCarBtn.mas_top).offset(-10);
        
    }];
    //图片
    [self.remindImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@59);
        make.height.equalTo(@68);
        make.bottom.equalTo(self.remindLab.mas_top).offset(-10);
        
    }];
}
//- (void)awakeFromNib {
//    
//    [super awakeFromNib];
//
//    self.remindLab.font = SystemFont14;
//    self.remindLab.textColor = THContentTextColor;
//    
//    self.goToShoppingCarBtn.hidden = YES;
//    self.goToShoppingCarBtn.layer.borderColor = THBaseColor.CGColor;
//    self.goToShoppingCarBtn.layer.borderWidth = 1.0;
//    self.goToShoppingCarBtn.layer.cornerRadius = 3;
//    self.goToShoppingCarBtn.layer.masksToBounds = YES;
//    [self.goToShoppingCarBtn setTitleColor:THBaseColor forState:UIControlStateNormal];
//    [self.goToShoppingCarBtn setTitleColor:THBaseColor forState:UIControlStateHighlighted];
//    [self.goToShoppingCarBtn.titleLabel setFont:SystemFont14];
//    
//}


@end
