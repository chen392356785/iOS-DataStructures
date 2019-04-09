//
//  DFUserInfoTopViewCell.m
//  DF
//
//  Created by 苏浩楠 on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFUserInfoTopViewCell.h"

@interface DFUserInfoTopViewCell()

/**标题*/
@property (nonatomic,strong) UILabel *nameLab;
/**图片*/
@property (nonatomic,strong) UIImageView *headerImgView;
/**底部分割线*/
@property (nonatomic,strong) UIView *bottomLineView;
@end


@implementation DFUserInfoTopViewCell

- (void)addSubviews {
    
    [self creatViews];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.headerImgView];
    [self.contentView addSubview:self.bottomLineView];

}

- (void)creatViews {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.cas_styleClass = @"user_info_nameLab";
    self.nameLab.text = @"头像";
    
    self.headerImgView = [[UIImageView alloc] init];
    self.headerImgView.cas_styleClass = @"user_info_headerImageView";
    self.headerImgView.layer.masksToBounds = YES;
    self.headerImgView.layer.cornerRadius = 20.5 * TTUIScale();
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.cas_styleClass = @"user_info_bottomBottomView";
}

- (void)defineLayout {
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(self.nameLab.cas_marginLeft);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(self.mas_right).offset(self.headerImgView.cas_marginRight);
        make.centerY.equalTo(self.nameLab.mas_centerY);
        make.width.equalTo(@(self.headerImgView.cas_sizeWidth));
        make.height.equalTo(@(self.headerImgView.cas_sizeHeight));
        
    }];
  
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(self.bottomLineView.cas_marginLeft);
        make.right.equalTo(self.mas_right).with.offset(self.bottomLineView.cas_marginRight);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.bottomLineView.cas_marginBottom);
        make.height.equalTo(@(self.bottomLineView.cas_sizeHeight));
        
    }];
    
    
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
