//
//  DFDiscernWaitingView.m
//  DF
//
//  Created by Tata on 2017/11/27.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFDiscernWaitingView.h"

@interface DFDiscernWaitingView ()

@property (nonatomic, strong) UILabel *precentLabel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *waitTipsLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation DFDiscernWaitingView

- (void)addSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.precentLabel];
    [self addSubview:self.leftLabel];
    [self addSubview:self.waitTipsLabel];
    [self addSubview:self.rightLabel];
}

- (void)setPrecent:(NSString *)precent {
    if (!precent) {
        return;
    }
    self.precentLabel.text = precent;
    self.precentLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)defineLayout {
    [self.precentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(self.precentLabel.cas_marginTop));
        make.left.equalTo(@(self.precentLabel.cas_marginLeft));
//        make.width.equalTo(@(self.precentLabel.cas_sizeWidth));
        make.width.mas_offset(iPhoneWidth);
        make.height.equalTo(@(self.precentLabel.cas_sizeHeight));
    }];
    
    [self.waitTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(self.waitTipsLabel.cas_sizeWidth));
        make.height.equalTo(@(self.waitTipsLabel.cas_sizeHeight));
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.waitTipsLabel.mas_top).with.offset(self.leftLabel.cas_marginBottom);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.leftLabel.cas_sizeWidth));
        make.height.equalTo(@(self.leftLabel.cas_sizeHeight));
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.waitTipsLabel.mas_bottom).with.offset(self.rightLabel.cas_marginTop);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.rightLabel.cas_sizeWidth));
        make.height.equalTo(@(self.rightLabel.cas_sizeHeight));
    }];
}

- (UILabel *)precentLabel {
    if (_precentLabel == nil) {
        _precentLabel = [[UILabel alloc]init];
        _precentLabel.cas_styleClass = @"discernWaiting_precentLabel";
    }
    return _precentLabel;
}

- (UILabel *)leftLabel {
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.text = @"“";
        _leftLabel.cas_styleClass = @"discernWaiting_leftLabel";
    }
    return _leftLabel;
}

- (UILabel *)waitTipsLabel {
    if (_waitTipsLabel == nil) {
        _waitTipsLabel = [[UILabel alloc]init];
        _waitTipsLabel.text = @"不要着急，马上就有结果";
        _waitTipsLabel.cas_styleClass = @"discernWaiting_waitTipsLabel";
    }
    return _waitTipsLabel;
}

- (UILabel *)rightLabel {
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.text = @"”";
        _rightLabel.cas_styleClass = @"discernWaiting_rightLabel";
    }
    return _rightLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
