//
//  DFFailureView.m
//  DF
//
//  Created by Tata on 2017/11/24.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFDiscernFailureView.h"

@interface DFDiscernFailureView ()

@property (nonatomic, strong) UIImageView *badIcon;
@property (nonatomic, strong) UILabel *failureMessage;
@property (nonatomic, strong) UILabel *failureTips;
@property (nonatomic, strong) UIButton *takePhotosButton;

@end

@implementation DFDiscernFailureView

- (void)addSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.badIcon];
    [self addSubview:self.failureMessage];
    [self addSubview:self.failureTips];
    [self addSubview:self.takePhotosButton];
}

- (void)defineLayout {
    [self.failureMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(-15);
        make.width.equalTo(@(self.failureMessage.cas_sizeWidth));
        make.height.equalTo(@(self.failureMessage.cas_sizeHeight));
    }];
    
    [self.badIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.failureMessage.mas_top).with.offset(self.badIcon.cas_marginBottom);
        make.width.equalTo(@(self.badIcon.cas_sizeWidth));
        make.height.equalTo(@(self.badIcon.cas_sizeHeight));
    }];
    
    [self.failureTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.failureMessage.mas_bottom).with.offset(self.failureTips.cas_marginTop);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.failureTips.cas_sizeWidth));
        make.height.equalTo(@(self.failureTips.cas_sizeHeight));
    }];
    
    [self.takePhotosButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.failureTips.mas_bottom).with.offset(self.takePhotosButton.cas_marginTop);
        make.width.equalTo(@(self.takePhotosButton.cas_sizeWidth));
        make.height.equalTo(@(self.takePhotosButton.cas_sizeHeight));
    }];
}

- (UIImageView *)badIcon {
    if (_badIcon == nil) {
        _badIcon = [[UIImageView alloc]init];
        _badIcon.image = kImage(BadIcon);
        _badIcon.cas_styleClass = @"discernFailure_badIcon";
    }
    return _badIcon;
}

- (UILabel *)failureMessage {
    if (_failureMessage == nil) {
        _failureMessage = [[UILabel alloc]init];
        _failureMessage.text = @"抱歉，没认出来！";
        _failureMessage.cas_styleClass = @"discernFailure_failureMessageLabel";
    }
    return _failureMessage;
}

- (UILabel *)failureTips {
    if (_failureTips == nil) {
        _failureTips = [[UILabel alloc]init];
        _failureTips.text = @"我猜这不是植物";
        _failureTips.cas_styleClass = @"discernFailure_failureTipsLabel";
    }
    return _failureTips;
}

- (UIButton *)takePhotosButton {
    if (_takePhotosButton == nil) {
        _takePhotosButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_takePhotosButton setTitleColor:THBaseColor forState:UIControlStateNormal];
        [_takePhotosButton setTitle:@"拍个植物试试" forState:UIControlStateNormal];
        [_takePhotosButton addTarget:self action:@selector(retakePhotosAction:) forControlEvents:UIControlEventTouchUpInside];
        _takePhotosButton.cas_styleClass = @"discernFailure_takePhotosButton";
    }
    return _takePhotosButton;
}

#pragma mark - 拍个植物试试
- (void)retakePhotosAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(retakePhotos)]) {
        [self.delegate retakePhotos];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
