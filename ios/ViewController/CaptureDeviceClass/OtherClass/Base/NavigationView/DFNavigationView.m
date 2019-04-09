//
//  DFNavigationView.m
//  DF
//
//  Created by Tata on 2017/11/25.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFNavigationView.h"

@interface DFNavigationView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *forwardButton;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DFNavigationView

- (void)addSubviews {
    [self creatView];
    
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.backButton];
    [self.backgroundView addSubview:self.titleLabel];
    [self.backgroundView addSubview:self.forwardButton];
    [self.backgroundView addSubview:self.lineView];
}

- (void)defineLayout {
    if (self.backgroundView.cas_styleClass) {
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(self.backgroundView.cas_marginTop / TTUIScale()));
            make.left.equalTo(@(self.backgroundView.cas_marginLeft));
            make.right.equalTo(@(self.backgroundView.cas_marginRight));
            make.height.equalTo(@(self.backgroundView.cas_sizeHeight / TTUIScale()));
        }];
    }
    
    if (self.backButton.cas_styleClass) {
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backgroundView.mas_left).with.offset(self.backButton.cas_marginLeft);
            make.centerY.equalTo(self.backgroundView.mas_centerY);
            make.width.equalTo(@(self.backButton.cas_sizeWidth));
            make.height.equalTo(@(self.backButton.cas_sizeHeight));
        }];
    }
    
    if (self.titleLabel.cas_styleClass) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backgroundView.mas_centerY);
            make.centerX.equalTo(self.backgroundView.mas_centerX);
            make.width.equalTo(@(self.titleLabel.cas_sizeWidth));
            make.height.equalTo(@(self.titleLabel.cas_sizeHeight));
        }];
    }
    
    if (self.forwardButton.cas_styleClass) {
        [self.forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backgroundView.mas_right).with.offset(self.forwardButton.cas_marginRight);
            make.centerY.equalTo(self.backgroundView.mas_centerY);
            make.width.equalTo(@(self.forwardButton.cas_sizeWidth));
            make.height.equalTo(@(self.forwardButton.cas_sizeHeight));
        }];
    }
    
    if (self.lineView.cas_styleClass) {
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.backgroundView.mas_bottom);
            make.left.equalTo(@(self.lineView.cas_marginLeft));
            make.right.equalTo(@(self.lineView.cas_marginRight));
            make.height.equalTo(@(self.lineView.cas_sizeHeight));
        }];
    }
}

- (void)creatView {
    
    self.backgroundView = [[UIView alloc]init];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.titleLabel = [[UILabel alloc]init];
    
    self.forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.lineView = [[UIView alloc]init];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
