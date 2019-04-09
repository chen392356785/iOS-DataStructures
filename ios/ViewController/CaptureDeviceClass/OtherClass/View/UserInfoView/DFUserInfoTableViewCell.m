//
//  DFUserInfoTableViewCell.m
//  DF
//
//  Created by 苏浩楠 on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFUserInfoTableViewCell.h"

@interface DFUserInfoTableViewCell()

/**标题*/
@property (nonatomic,strong) UILabel *nameLab;
/**副标题*/
@property (nonatomic,strong) UILabel *detailNameLab;
/**右方箭头*/
@property (nonatomic,strong) UIImageView *arrowImgView;
/**底部分割线*/
@property (nonatomic,strong) UIView *bottomLineView;

@end


@implementation DFUserInfoTableViewCell

- (void)addSubviews {
    
    [self creatViews];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.detailNameLab];
    [self.contentView addSubview:self.arrowImgView];
    [self.contentView addSubview:self.bottomLineView];
    
}
- (void)creatViews {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.cas_styleClass = @"user_info_nameLab";
    
    self.detailNameLab = [[UILabel alloc] init];
    self.detailNameLab.textColor = THTitleColor3;
    self.detailNameLab.font = kLightFont(13);
    self.detailNameLab.cas_styleClass = @"user_info_detailLab";
    
    self.arrowImgView = [[UIImageView alloc] init];
    self.arrowImgView.image = kImage(RightArrowGray);
    self.arrowImgView.cas_styleClass = @"user_info_arrowImageView";
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.cas_styleClass = @"user_info_bottomBottomView";
    
}

- (void)defineLayout {
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self.mas_left).offset(self.nameLab.cas_marginLeft);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(self.arrowImgView.cas_marginRight);
        make.width.equalTo(@(self.arrowImgView.cas_sizeWidth));
        make.height.equalTo(@(self.arrowImgView.cas_sizeHeight));
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.detailNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(self.arrowImgView.mas_left).offset(self.detailNameLab.cas_marginRight);
        make.centerY.equalTo(self.nameLab.mas_centerY);
        
        
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
