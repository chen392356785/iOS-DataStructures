//
//  MTActionCollectionViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTActionCollectionViewCell.h"

@implementation MTActionCollectionViewCell

@end

//活动价格说明
@interface MTActionContionTitleCell () {
    UILabel *TitleLabel;
    UILabel *conLabel;
}
@end

@implementation MTActionContionTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        TitleLabel = [[UILabel alloc] init];
        conLabel = [[UILabel alloc] init];
        [self.contentView addSubview:TitleLabel];
        [self.contentView addSubview:conLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(14);
        make.right.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];
    [conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->TitleLabel);
        make.top.mas_equalTo(self->TitleLabel.mas_bottom).mas_offset(16);
        make.width.mas_equalTo(self->TitleLabel);
        make.height.mas_offset(13);
    }];
}
- (void)setTitle:(NSString *)title andPic:(NSString *)picStr {
    TitleLabel.text = title;
    TitleLabel.font = sysFont(16);
    TitleLabel.textAlignment = NSTextAlignmentLeft;
    TitleLabel.textColor = kColor(@"333333");

    NSString *picLabStr = [NSString stringWithFormat:@"报名费用 :  ￥%@", picStr];
    conLabel.textColor = kColor(@"#999999");
    conLabel.textAlignment = NSTextAlignmentLeft;
    conLabel.font = sysFont(13);
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picLabStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(8, picStr.length + 1)];
    conLabel.attributedText = attributedStr;
}

@end


//活动人数说明
@interface MTActionSignUpPersonCell () {
    UIView *bgView;
    UILabel *TitleLabel;
    UILabel *conLabel;
}
@end
@implementation MTActionSignUpPersonCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        bgView = [[UIView alloc] init];
        TitleLabel = [[UILabel alloc] init];
        conLabel = [[UILabel alloc] init];
        [self.contentView addSubview:bgView];
        [bgView addSubview:TitleLabel];
        [bgView addSubview:conLabel];
    }
    return self;
}
- (void)layoutSubviews {
    bgView.layer.borderWidth = 0.5f;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView);
    }];
    bgView.layer.borderColor = kColor(@"ff0000").CGColor;
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->bgView);
        make.top.mas_equalTo(self->bgView.mas_top).mas_offset(kVertiSpace(5));
        make.right.mas_equalTo(self->bgView);
        make.height.mas_equalTo(kHeight(16));
    }];
    [conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->TitleLabel);
        make.top.mas_equalTo(self->TitleLabel.mas_bottom).mas_offset(kVertiSpace(5));
        make.width.mas_equalTo(self->TitleLabel);
        make.height.mas_equalTo(self->TitleLabel);
    }];
}
- (void) setLimitTitle:(NSString *)limtTitle andNumber:(NSString *) numStr{
    TitleLabel.textColor = kColor(@"333333");
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.font = sysFont(font(16));
    TitleLabel.text = limtTitle;
    
    conLabel.textColor = kColor(@"ff0000");
    conLabel.textAlignment = NSTextAlignmentCenter;
    conLabel.font = sysFont(font(16));
    conLabel.text = [NSString stringWithFormat:@"%@",numStr];
}
@end

//活动详情
@interface MTActionDetailDescribeCell() {
    UIAsyncImageView *_ContImageView;
}
@end
//活动详情描述
@implementation MTActionDetailDescribeCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _ContImageView = [[UIAsyncImageView alloc] init];
        _ContImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_ContImageView];
        [_ContImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self).mas_offset(.5f);
        }];
        
    }
    return self;
}
- (void)layoutSubviews {
    
}
- (void)setConternImag:(NSString *)imageStr {
     [_ContImageView setImageAsyncWithURL:imageStr placeholderImage:DefaultImage_logo];
}
@end

