//
//  CrowdFundInfoViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/2.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "CrowdFundInfoViewCell.h"


@interface CrowdFundInfoViewCell () {
    UIAsyncImageView *_ContImageView;
    UILabel *TitleLabel;
    UILabel *timeLabel;
    UILabel *percentlabel;
    UILabel *picLabel;
    UIView *_progressView;
    CGFloat progress;
    UIView *bgView;     //进度背景
}
@end


@implementation CrowdFundInfoViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _ContImageView = [[UIAsyncImageView alloc] init];
        [self addSubview:_ContImageView];
        TitleLabel = [[UILabel alloc] init];
        [self addSubview:TitleLabel];
        picLabel = [[UILabel alloc] init];
        percentlabel = [[UILabel alloc] init];
        [self addSubview:percentlabel];
        [self addSubview:picLabel];
        timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        [self createlayoutSubviews];
    }
    return self;
}
- (void)createlayoutSubviews {
    _ContImageView.layer.cornerRadius = kWidth(40);
    [_ContImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kWidth(14));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(kWidth(80));
        make.height.mas_offset(kWidth(80));
    }];
    
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ContImageView.mas_right).mas_offset(kWidth(10));
        make.top.mas_equalTo(self->_ContImageView.mas_top);
        make.right.mas_equalTo(self.mas_right).mas_offset(kWidth(-14));
        make.height.mas_offset(kWidth(18));
    }];
    TitleLabel.textColor = kColor(@"#333333");
    TitleLabel.textAlignment = NSTextAlignmentLeft;
    TitleLabel.font = sysFont(font(16));
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->TitleLabel.mas_left);
        make.top.mas_equalTo(self->TitleLabel.mas_bottom).mas_offset(kWidth(13));
        make.right.mas_equalTo(self).mas_offset(kWidth(-75));
        make.height.mas_offset(kWidth(14));
    }];
    timeLabel.textColor = kColor(@"#333333");
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = sysFont(font(14));
    
    [percentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kWidth(31));
        make.right.mas_equalTo(self.mas_right).mas_offset(kWidth(-12));
        make.width.mas_offset(kWidth(70));
        make.height.mas_offset(kWidth(29));
    }];
    percentlabel.layer.cornerRadius = 14;
    percentlabel.clipsToBounds = YES;
    percentlabel.backgroundColor = kColor(@"#ffa6a2");
    percentlabel.textAlignment = NSTextAlignmentCenter;
    percentlabel.textColor = kColor(@"#ffffff");
    percentlabel.font = sysFont(font(14));
    
    bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->TitleLabel.mas_left);
        make.top.mas_equalTo(self->timeLabel.mas_bottom).mas_offset(kWidth(21));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(6);
    }];
    bgView.backgroundColor = kColor(@"#ffefee");
    [bgView setLayerMasksCornerRadius:3 BorderWidth:0 borderColor:[UIColor clearColor]];
    
    UIView *progressView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 6)];
    [bgView addSubview:progressView];
    _progressView = progressView;
    [progressView setLayerMasksCornerRadius:3 BorderWidth:0 borderColor:[UIColor clearColor]];
    progressView.backgroundColor = kColor(@"#ff7567");
    
    [bgView layoutIfNeeded];
    
    
    [picLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->bgView.mas_bottom).mas_offset(kWidth(10));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(14));
        make.width.mas_offset(140);
    }];
   
    picLabel.font = sysFont(font(14));
}
- (void)setUIData:(CrowdInfoModel *)model {
     NSString *imagUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url];
     [_ContImageView setImageAsyncWithURL:imagUrlStr placeholderImage:DefaultImage_logo];
     TitleLabel.text = [NSString stringWithFormat:@"%@的众筹",model.nickname];
     timeLabel.text = [NSString stringWithFormat:@"%@ 发起",model.create_time];
     progress = model.obtain_money*100/model.total_money;
     percentlabel.text = [NSString stringWithFormat:@"%.2f%@",(progress),@"%"];
    CGFloat width= progress/100. * WIDTH(bgView);
    _progressView.size = CGSizeMake(width, 6);
    NSString *picLabStr = [NSString stringWithFormat:@"还差￥%.2f", (model.total_money - model.obtain_money)];
    picLabel.textColor = kColor(@"#333333");
    picLabel.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picLabStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(2, picLabStr.length - 2)];
    picLabel.attributedText = attributedStr;
}
@end
