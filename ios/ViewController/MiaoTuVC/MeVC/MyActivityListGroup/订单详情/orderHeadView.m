//
//  orderHeadView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/10.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "orderHeadView.h"

@interface orderHeadView () {
    UIAsyncImageView *_imageView;
    UILabel *statuLabel;
    UILabel *conLabel;
    
}
@end

@implementation orderHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = cBgColor;
        _imageView = [[UIAsyncImageView alloc] init];
        [self addSubview:_imageView];
        statuLabel = [[UILabel alloc] init];
        [self addSubview:statuLabel];
        conLabel = [[UILabel alloc] init];
        [self addSubview:conLabel];
        [self layoutSubViewUI];
    }
    return self;
}
- (void) layoutSubViewUI {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(kWidth(79));
        make.height.mas_offset(kWidth(79));
        make.centerX.mas_equalTo(self);
    }];
    
    statuLabel.textColor = kColor(@"#333333");
    statuLabel.font = sysFont(font(16));
    statuLabel.textAlignment = NSTextAlignmentCenter;
    [statuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->_imageView.mas_bottom).mas_offset(kWidth(15));
		make.width.mas_offset(kWidth(150));
		make.height.mas_offset(kWidth(16));
		make.centerX.mas_equalTo(self);
    }];
    
    conLabel.textColor = kColor(@"#333333");
    conLabel.font = sysFont(font(16));
    conLabel.textAlignment = NSTextAlignmentCenter;
    [conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->statuLabel.mas_bottom).mas_offset(kWidth(3));
        make.width.mas_offset(kWidth(150));
        make.height.mas_offset(kWidth(16));
        make.centerX.mas_equalTo(self);
    }];
}
- (void) setHeadView:(NSString *) tepe{
    conLabel.hidden = YES;
    if ([tepe integerValue] == 0) {
        _imageView.image = Image(@"icon_ddfk.png");
        statuLabel.text = @"待付款";
    }else if ([tepe integerValue] == 1){
        _imageView.image = Image(@"icon_zfcg.png");
        statuLabel.text = @"支付成功";
    }else if([tepe integerValue] == 3){
        _imageView.image = Image(@"icon_qxdd.png");
        statuLabel.text = @"订单关闭";
        conLabel.text = @"您已取消订单";
        conLabel.hidden = NO;
    }else if([tepe integerValue] == 4){
        _imageView.image = Image(@"icon_qxdd.png");
        statuLabel.text = @"订单关闭";
        conLabel.text = @"您的订单已失效";
        conLabel.hidden = NO;
    }
}
@end
