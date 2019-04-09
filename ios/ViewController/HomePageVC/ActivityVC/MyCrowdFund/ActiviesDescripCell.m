//
//  ActiviesDescripCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/2.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ActiviesDescripCell.h"

@interface ActiviesDescripCell () {
    UIAsyncImageView *_ContImageView;
    UILabel *titleLabel;
    UILabel *conLabel;
}
@end

@implementation ActiviesDescripCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _ContImageView = [[UIAsyncImageView alloc] init];
        [self addSubview:_ContImageView];
        titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        conLabel = [[UILabel alloc] init];
        [self addSubview:conLabel];
    }
    return self;
}
- (void)layoutSubviews {
    _ContImageView.contentMode = UIViewContentModeScaleToFill;
    [_ContImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(12);
        make.left.mas_equalTo(self).mas_offset(12);
        make.width.mas_offset(kWidth(88));
        make.height.mas_offset(kWidth(88));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self->_ContImageView.mas_right).mas_offset(kWidth(15));
		make.top.mas_equalTo(self->_ContImageView.mas_top);
        make.right.mas_equalTo(self.mas_right).mas_offset(kWidth(12));
        make.height.mas_offset(kWidth(17));
    }];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = sysFont(font(17));
    titleLabel.textColor = kColor(@"#333333");
    
    [conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self->titleLabel.mas_left);
		make.top.mas_equalTo(self->titleLabel.mas_bottom).mas_offset(kWidth(17));
        make.right.mas_equalTo(self.mas_right).mas_offset(kWidth(12));
        make.height.mas_offset(kWidth(14));
    }];
    conLabel.textAlignment = NSTextAlignmentLeft;
    conLabel.font = sysFont(font(14));
}
- (void)setImageUrl:(NSString *)urlStr andTitle:(NSString *)title andContTitle:(CGFloat )CtonStr {
    [_ContImageView setImageAsyncWithURL:urlStr placeholderImage:DefaultImage_logo];
    titleLabel.text = title;
    conLabel.textColor = kColor(@"#999999");
    NSString *picLabStr = [NSString stringWithFormat:@"报名费用￥%.2f", CtonStr];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picLabStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(4, picLabStr.length - 4)];
    conLabel.attributedText = attributedStr;
}
@end
