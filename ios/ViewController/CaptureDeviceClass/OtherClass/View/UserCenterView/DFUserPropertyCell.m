//
//  DFUserPropertyCell.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFUserPropertyCell.h"

@interface DFUserPropertyCell ()

@property  (nonatomic, strong) UIImageView *propertyIcon;
@property (nonatomic, strong) UILabel *propertyTitleLabel;

@end

@implementation DFUserPropertyCell

- (void)addSubviews {
    [self creatViews];
    
    [self addSubview:self.propertyIcon];
    [self addSubview:self.propertyTitleLabel];
}

- (void)defineLayout {
    [self.propertyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(@(self.propertyIcon.cas_marginLeft));
        make.width.equalTo(@(self.propertyIcon.cas_sizeWidth));
        make.height.equalTo(@(self.propertyIcon.cas_sizeHeight));
    }];
    
    [self.propertyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.propertyIcon.mas_right).with.offset(self.propertyTitleLabel.cas_marginLeft);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.propertyTitleLabel.cas_sizeHeight));
    }];
}

- (void)creatViews{
    self.propertyIcon = [[UIImageView alloc]init];
    self.propertyIcon.cas_styleClass = @"userProperty_propertyIcon";
    
    self.propertyTitleLabel = [[UILabel alloc]init];
    self.propertyTitleLabel.cas_styleClass = @"userProperty_propertyTitleLabel";
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
