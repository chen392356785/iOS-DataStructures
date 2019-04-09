//
//  OrderHeadView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/27.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "OrderHeadView.h"

@interface OrderHeadView () {
    UIAsyncImageView *OrderImage;
    SMLabel *TitleLabel;
    UILabel *picLabel;
    UILabel *numLabel;
    
}
@end

@implementation OrderHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
         [self createSubView];
    }
    return self;
}
- (void) createSubView {
    OrderImage = [[UIAsyncImageView alloc] init];
    
    [self addSubview:OrderImage];
    
    TitleLabel = [[SMLabel alloc] init];
    TitleLabel.verticalAlignment = VerticalAlignmentTop;
    TitleLabel.font = sysFont(font(17));
    TitleLabel.text = @"中苗会第四届报名";
    TitleLabel.numberOfLines = 2;
    TitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:TitleLabel];
    
    picLabel = [[UILabel alloc] init];
    picLabel.font = sysFont(font(13));
    picLabel.text = @"价格：  1280.00";
    picLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:picLabel];
    
    numLabel = [[UILabel alloc] init];
    numLabel.font = sysFont(font(13));
    numLabel.text = @"数量： 5";
    numLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:numLabel];
    
}
- (void)layoutSubviews {
    [OrderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kWidth(10));
        make.left.mas_equalTo(self).mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(93));
        make.height.mas_offset(kWidth(93));
    }];
    
    
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kWidth(10));
        make.left.mas_equalTo(self->OrderImage.mas_right).mas_offset(kWidth(17));
        make.right.mas_equalTo(self).mas_offset(kWidth(-10));
        make.height.mas_offset(kWidth(49));
    }];
    
    [picLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->TitleLabel.mas_bottom).mas_offset(kWidth(6));
        make.left.mas_equalTo(self->OrderImage.mas_right).mas_offset(kWidth(17));
        make.right.mas_equalTo(self).mas_offset(kLevelSpace(-10));
        make.height.mas_offset(kWidth(14));
    }];
    
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->picLabel.mas_bottom).mas_offset(kWidth(8));
        make.left.mas_equalTo(self->OrderImage.mas_right).mas_offset(kWidth(17));
        make.right.mas_equalTo(self).mas_offset(kLevelSpace(-10));
        make.height.mas_offset(kWidth(14));
    }];
    
}
- (void)setActivitiesListModel:(ActivitiesListModel *)model {
    
    [OrderImage setImageAsyncWithURL:model.activities_pic placeholderImage:Image(@"xiaotu")];
    TitleLabel.text = model.activities_titile;
    numLabel.hidden = YES;
    
    NSString *picLabStr = [NSString stringWithFormat:@"价格：%@",model.payment_amount];
    picLabel.textColor = kColor(@"#333333");
    picLabel.textAlignment = NSTextAlignmentLeft;
    picLabel.font = sysFont(font(17));
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picLabStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(3, model.payment_amount.length)];
    picLabel.attributedText = attributedStr;
    
}
@end
