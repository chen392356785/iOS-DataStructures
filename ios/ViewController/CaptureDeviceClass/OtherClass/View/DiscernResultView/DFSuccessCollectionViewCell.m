//
//  DFSuccessCollectionViewCell.m
//  DF
//
//  Created by Tata on 2017/11/28.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFSuccessCollectionViewCell.h"

@interface DFSuccessCollectionViewCell ()

@property (nonatomic, strong) UIImageView *flowerIcon;
@property (nonatomic, strong) UIImageView *roundIcon;
@property (nonatomic, strong) UIButton *checkButton;

@end

@implementation DFSuccessCollectionViewCell

- (void)addSubviews {
    [self creatViews];
    self.contentView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.flowerIcon];
    [self.contentView addSubview:self.roundIcon];
    [self.contentView addSubview:self.checkButton];
}

- (void)defineLayout {
    
    [self.flowerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(self.flowerIcon.cas_marginTop);
        make.left.equalTo(self.mas_left).with.offset(self.flowerIcon.cas_marginLeft);
        make.right.equalTo(self.mas_right).with.offset(self.flowerIcon.cas_marginRight);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.flowerIcon.cas_marginBottom);
    }];
    
    [self.roundIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(self.checkButton.cas_marginBottom));
        make.centerX.equalTo(self.roundIcon.mas_centerX);
        make.width.equalTo(@(self.checkButton.cas_sizeWidth));
        make.height.equalTo(@(self.checkButton.cas_sizeHeight));
        
    }];
}

- (void)creatViews {
    
    self.flowerIcon = [[UIImageView alloc]init];
    self.flowerIcon.cas_styleClass = @"success_flowerIcon";
    self.flowerIcon.layer.masksToBounds = YES;
    self.flowerIcon.layer.cornerRadius = 120 * TTUIScale();
    self.flowerIcon.userInteractionEnabled = YES;
    
    self.roundIcon = [[UIImageView alloc]init];
    self.roundIcon.cas_styleClass = @"success_roundIcon";
    self.roundIcon.userInteractionEnabled = YES;
    
    self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkButton setTitle:@"查看详情" forState:UIControlStateNormal];
    self.checkButton.userInteractionEnabled = YES;
    self.checkButton.cas_styleClass = @"success_checkButton";
    [self.checkButton addTarget:self action:@selector(checkDetailAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)checkDetailAction {
    if ([self.delegate respondsToSelector:@selector(checkDetail)]) {
        [self.delegate checkDetail];
    }
}

@end
