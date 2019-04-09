//
//  DFCommentTopCell.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFCommentTopCell.h"

@interface DFCommentTopCell ()

@property (nonatomic, strong) UIImageView *flowerImageView;
@property (nonatomic, strong) UIImageView *userHeader;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DFCommentTopCell

- (void)addSubviews {
    [self creatViews];
    
    [self.contentView addSubview:self.flowerImageView];
    [self.contentView addSubview:self.userHeader];
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.lineView];
    
}

- (void)defineLayout {
    [self.flowerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
//        make.height.equalTo(@(self.flowerImageView.cas_sizeHeight));
         make.height.equalTo(@(250));
    }];
    
    [self.userHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flowerImageView.mas_bottom).with.offset(self.userHeader.cas_marginTop);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.userHeader.cas_sizeWidth));
        make.height.equalTo(@(self.userHeader.cas_sizeHeight));

    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userHeader.mas_bottom).with.offset(self.userName.cas_marginTop);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.userName.cas_sizeHeight));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.lineView.cas_sizeHeight));
    }];
}

- (void)creatViews {
    self.flowerImageView = [[UIImageView alloc]init];
    self.flowerImageView.cas_styleClass = @"commentTop_flowerImageView";
    self.flowerImageView.clipsToBounds = YES;
    
    self.userHeader = [[UIImageView alloc]init];
    self.userHeader.cas_styleClass = @"commentTop_userHeader";
    self.userHeader.layer.masksToBounds = YES;
    
    
    self.userName = [[UILabel alloc]init];
    self.userName.cas_styleClass = @"commentTop_userName";
    
    self.lineView = [[UIView alloc]init];
    self.lineView.cas_styleClass = @"commentTop_lineView";
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
