//
//  MTActivesListViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTActivesListViewCell.h"

@interface MTActivesListViewCell () {
    UIAsyncImageView *IconImageView;
    UILabel *TitleLabel;
    UILabel *contLabel;
    UILabel *picLabel;
    UILabel *lineLabel;
}
@end

@implementation MTActivesListViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        IconImageView = [[UIAsyncImageView alloc] init];
        contLabel = [[UILabel alloc] init];
        TitleLabel =  [[UILabel alloc] init];
        picLabel = [[UILabel alloc]init];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:IconImageView];
        [self addSubview:contLabel];
        [self addSubview:TitleLabel];
        [self addSubview:picLabel];
    }
    return self;
}
- (void)layoutSubviews {
    IconImageView.layer.cornerRadius = 26.5;
    [IconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.top.mas_equalTo(self).mas_offset(8);
        make.width.mas_offset(53);
        make.height.mas_offset(53);
    }];
    
    TitleLabel.textAlignment = NSTextAlignmentLeft;
    TitleLabel.textColor = kColor(@"333333");
    TitleLabel.font = sysFont(18);
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->IconImageView.mas_top);
        make.left.mas_equalTo(self->IconImageView.mas_right).mas_offset(12);
        make.width.mas_offset(140);
        make.height.mas_offset(18);
    }];
    
    contLabel.textAlignment = NSTextAlignmentLeft;
    contLabel.textColor = kColor(@"333333");
    contLabel.font = sysFont(13);
    [contLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-14);
        make.left.mas_equalTo(self->TitleLabel.mas_left);
        make.width.mas_offset(180);
        make.height.mas_offset(11);
    }];
    
    picLabel.textAlignment = NSTextAlignmentRight;
    picLabel.font = sysFont(18);
    [picLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset( -34);
        make.right.mas_equalTo(self.mas_right).mas_offset( -12);
        make.width.mas_offset(140);
        make.height.mas_offset(18);
    }];
    lineLabel = [[UILabel alloc] init];
    [self addSubview:lineLabel];
    lineLabel.backgroundColor = kColor(@"eeeeee");
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_offset(2);
    }];
}

- (void)setIctonImgUrl:(NSString *)imageUrl andName:(NSString *)nameStr andTime:(NSString *)timeStr andPic:(NSString *)PicStr {
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,imageUrl];
    [IconImageView setImageAsyncWithURL:imageUrlStr placeholderImage:Image(@"tx.png")];
    TitleLabel.text = nameStr;
    contLabel.text = timeStr;
    picLabel.textColor = kColor(@"333333");
    NSString *showPicStr = [NSString stringWithFormat:@"付款 %@元",PicStr];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:showPicStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(3, showPicStr.length - 3)];
    picLabel.attributedText = attributedStr;
}
@end
