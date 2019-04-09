//
//  TFMyMessageEmptyView.m
//  TH
//
//  Created by 苏浩楠 on 16/7/8.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import "TFMyMessageEmptyView.h"

@interface TFMyMessageEmptyView ()

/**图片*/
@property (nonatomic,weak) UIImageView *iconImageView;
/**标题*/
@property (nonatomic,weak) UILabel *nameTitleLab;

@end

@implementation TFMyMessageEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark --创建UI--
- (void)setupUI {
    
    //标题
    UILabel *nameTitleLab = [[UILabel alloc] init];
    self.nameTitleLab = nameTitleLab;
    nameTitleLab.font = kLightFont(14);
    nameTitleLab.textColor = THTextColor;
    nameTitleLab.textAlignment = NSTextAlignmentCenter;
    nameTitleLab.numberOfLines = 0;
    [self addSubview:nameTitleLab];
    //添加约束
    [nameTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_centerY);
    }];
    //图片
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    [self addSubview:iconImageView];
    //添加约束
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nameTitleLab.mas_top).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
}
#pragma mark --设置数据--
- (void)setImageStr:(NSString *)imageStr {
    _imageStr = [imageStr copy];
    self.iconImageView.image = kImage(imageStr);
}
- (void)setNameTitle:(NSString *)nameTitle {
    _nameTitle = [nameTitle copy];
    self.nameTitleLab.text = nameTitle;
}
@end
