//
//  DFShareView.m
//  DF
//
//  Created by Tata on 2017/11/29.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFShareView.h"

@interface DFShareView ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UILabel *shareTitleLabel;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) UIView *WXView;
@property (nonatomic, strong) UIImageView *WXImageView;
@property (nonatomic, strong) UILabel *WXTitleLabel;

@property (nonatomic, strong) UIView *friendView;
@property (nonatomic, strong) UIImageView *friendImageView;
@property (nonatomic, strong) UILabel *friendTitleLabel;

@property (nonatomic, strong) UIView *QQView;
@property (nonatomic, strong) UIImageView *QQImageView;
@property (nonatomic, strong) UILabel *QQTitleLabel;

@property (nonatomic, strong) UIView *QQZoneView;
@property (nonatomic, strong) UIImageView *QQZoneImageView;
@property (nonatomic, strong) UILabel *QQZoneTitleLabel;

@property (nonatomic, strong) UIView *sinaView;
@property (nonatomic, strong) UIImageView *sinaImageView;
@property (nonatomic, strong) UILabel *sinaTitleLabel;

@end

@implementation DFShareView

- (void)addSubviews {
    [self creatViews];
    
    [self addSubview:self.shareTitleLabel];
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    
    [self addSubview:self.WXView];
    [self.WXView addSubview:self.WXImageView];
    [self.WXView addSubview:self.WXTitleLabel];
    
    [self addSubview:self.friendView];
    [self.friendView addSubview:self.friendImageView];
    [self.friendView addSubview:self.friendTitleLabel];
    
    [self addSubview:self.QQView];
    [self.QQView addSubview:self.QQImageView];
    [self.QQView addSubview:self.QQTitleLabel];
    
    [self addSubview:self.QQZoneView];
    [self.QQZoneView addSubview:self.QQZoneImageView];
    [self.QQZoneView addSubview:self.QQZoneTitleLabel];
    
    [self addSubview:self.sinaView];
    [self.sinaView addSubview:self.sinaImageView];
    [self.sinaView addSubview:self.sinaTitleLabel];
}

- (void)defineLayout {
    [self.shareTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(self.shareTitleLabel.cas_marginTop));
        make.width.equalTo(@(self.shareTitleLabel.cas_sizeWidth));
        make.height.equalTo(@(self.shareTitleLabel.cas_sizeHeight));
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareTitleLabel.mas_left);
        make.centerY.equalTo(self.shareTitleLabel.mas_centerY);
        make.width.equalTo(@(self.leftView.cas_sizeWidth));
        make.height.equalTo(@(self.leftView.cas_sizeHeight));
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareTitleLabel.mas_right);
        make.centerY.equalTo(self.shareTitleLabel.mas_centerY);
        make.width.equalTo(@(self.rightView.cas_sizeWidth));
        make.height.equalTo(@(self.rightView.cas_sizeHeight));
    }];
    
    
    [self.WXView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTitleLabel.mas_bottom).offset(self.WXView.cas_marginTop);
        make.left.equalTo(self.mas_left).with.offset(self.WXView.cas_marginLeft);
        make.width.equalTo(@(self.WXView.cas_sizeWidth));
        make.height.equalTo(@(self.WXView.cas_sizeHeight));
    }];
    [self.WXImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.WXView.mas_top);
        make.left.equalTo(self.WXView.mas_left);
        make.width.equalTo(@(self.WXImageView.cas_sizeWidth));
        make.height.equalTo(@(self.WXImageView.cas_sizeHeight));
    }];
    
    [self.WXTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.WXImageView.mas_bottom).with.offset(self.WXTitleLabel.cas_marginTop);
        make.centerX.equalTo(self.WXView.mas_centerX);
        make.width.equalTo(@(self.WXTitleLabel.cas_sizeWidth));
        make.height.equalTo(@(self.WXTitleLabel.cas_sizeHeight));
    }];
    
    
    [self.friendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTitleLabel.mas_bottom).with.offset(self.friendView.cas_marginTop);
        make.left.equalTo(self.WXView.mas_right).with.offset(self.friendView.cas_marginLeft);
        make.width.equalTo(@(self.friendView.cas_sizeWidth));
        make.height.equalTo(@(self.friendView.cas_sizeHeight));
    }];
    
    [self.friendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.friendView.mas_top);
        make.left.equalTo(self.friendView.mas_left);
        make.width.equalTo(@(self.friendImageView.cas_sizeWidth));
        make.height.equalTo(@(self.friendImageView.cas_sizeHeight));
    }];
    
    [self.friendTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.friendImageView.mas_bottom).with.offset(self.friendTitleLabel.cas_marginTop);
        make.centerX.equalTo(self.friendView.mas_centerX);
        make.width.equalTo(@(self.friendTitleLabel.cas_sizeWidth));
        make.height.equalTo(@(self.friendTitleLabel.cas_sizeHeight));
    }];
    
    
    [self.QQView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTitleLabel.mas_bottom).with.offset(self.QQView.cas_marginTop);
        make.left.equalTo(self.friendView.mas_right).with.offset(self.QQView.cas_marginLeft);
        make.width.equalTo(@(self.QQView.cas_sizeWidth));
        make.height.equalTo(@(self.QQView.cas_sizeHeight));
    }];
    
    [self.QQImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QQView.mas_top);
        make.left.equalTo(self.QQView.mas_left);
        make.width.equalTo(@(self.QQImageView.cas_sizeWidth));
        make.height.equalTo(@(self.QQImageView.cas_sizeHeight));
    }];
    
    [self.QQTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QQImageView.mas_bottom).with.offset(self.QQTitleLabel.cas_marginTop);
        make.centerX.equalTo(self.QQView.mas_centerX);
        make.width.equalTo(@(self.QQTitleLabel.cas_sizeWidth));
        make.height.equalTo(@(self.QQTitleLabel.cas_sizeHeight));
    }];
    
    
    [self.QQZoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTitleLabel.mas_bottom).with.offset(self.QQZoneView.cas_marginTop);
        make.left.equalTo(self.QQView.mas_right).with.offset(self.QQZoneView.cas_marginLeft);
        make.width.equalTo(@(self.QQZoneView.cas_sizeWidth));
        make.height.equalTo(@(self.QQZoneView.cas_sizeHeight));
    }];
    
    [self.QQZoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QQZoneView.mas_top);
        make.left.equalTo(self.QQZoneView.mas_left);
        make.width.equalTo(@(self.QQZoneImageView.cas_sizeWidth));
        make.height.equalTo(@(self.QQZoneImageView.cas_sizeHeight));
    }];
    
    [self.QQZoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QQZoneImageView.mas_bottom).with.offset(self.QQZoneTitleLabel.cas_marginTop);
        make.centerX.equalTo(self.QQZoneView.mas_centerX);
        make.width.equalTo(@(self.QQZoneTitleLabel.cas_sizeWidth));
        make.height.equalTo(@(self.QQZoneTitleLabel.cas_sizeHeight));
    }];
    
    
    [self.sinaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTitleLabel.mas_bottom).with.offset(self.sinaView.cas_marginTop);
        make.left.equalTo(self.QQZoneView.mas_right).with.offset(self.WXView.cas_marginLeft);
        make.width.equalTo(@(self.sinaView.cas_sizeWidth));
        make.height.equalTo(@(self.sinaView.cas_sizeHeight));
    }];
    
    [self.sinaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sinaView.mas_top);
        make.left.equalTo(self.sinaView.mas_left);
        make.width.equalTo(@(self.sinaImageView.cas_sizeWidth));
        make.height.equalTo(@(self.sinaImageView.cas_sizeHeight));
    }];
    
    [self.sinaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sinaImageView.mas_bottom).with.offset(self.sinaTitleLabel.cas_marginTop);
        make.centerX.equalTo(self.sinaView.mas_centerX);
        make.width.equalTo(@(self.sinaTitleLabel.cas_sizeWidth));
        make.height.equalTo(@(self.sinaTitleLabel.cas_sizeHeight));
    }];
}

- (void)creatViews {
    
    self.shareTitleLabel = [[UILabel alloc]init];
    self.shareTitleLabel.cas_styleClass = @"share_titleLabel";
    self.shareTitleLabel.text = @"分享至";
    
    self.leftView = [[UIView alloc]init];
    self.leftView.cas_styleClass = @"share_leftView";
    
    self.rightView = [[UIView alloc]init];
    self.rightView.cas_styleClass = @"share_leftView";
    
    UITapGestureRecognizer *tapWX = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShareAction:)];
    self.WXView = [[UIView alloc]init];
    self.WXView.cas_styleClass = @"share_WXView";
    [self.WXView addGestureRecognizer:tapWX];
    self.WXView.tag = 1;
    
    self.WXImageView = [[UIImageView alloc]init];
    self.WXImageView.userInteractionEnabled = YES;
    self.WXImageView.cas_styleClass = @"share_WXImageView";
    self.WXImageView.image = kImage(@"share_wx.png");
    
    self.WXTitleLabel = [[UILabel alloc]init];
    self.WXTitleLabel.cas_styleClass = @"share_WXTitleLabel";
    self.WXTitleLabel.text = @"微信";
    
    UITapGestureRecognizer *tapFriendWX = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShareAction:)];
    self.friendView = [[UIView alloc]init];
    self.friendView.cas_styleClass = @"share_WXView";
    [self.friendView addGestureRecognizer:tapFriendWX];
    self.friendView.tag = 2;
    
    self.friendImageView = [[UIImageView alloc]init];
    self.friendImageView.cas_styleClass = @"share_WXImageView";
    self.friendImageView.userInteractionEnabled = YES;
    self.friendImageView.image = kImage(@"share_wxPYQ.png");
    
    self.friendTitleLabel = [[UILabel alloc]init];
    self.friendTitleLabel.cas_styleClass = @"share_WXTitleLabel";
    self.friendTitleLabel.text = @"朋友圈";
    
    UITapGestureRecognizer *tapQQ = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShareAction:)];
    self.QQView = [[UIView alloc]init];
    self.QQView.cas_styleClass = @"share_WXView";
    [self.QQView addGestureRecognizer:tapQQ];
    self.QQView.tag = 3;
    
    self.QQImageView = [[UIImageView alloc]init];
    self.QQImageView.cas_styleClass = @"share_WXImageView";
    self.QQImageView.userInteractionEnabled = YES;
    self.QQImageView.image = kImage(@"share_qq.png");
    
    self.QQTitleLabel = [[UILabel alloc]init];
    self.QQTitleLabel.cas_styleClass = @"share_WXTitleLabel";
    self.QQTitleLabel.text = @"QQ";
    
    UITapGestureRecognizer *tapQQZone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShareAction:)];
    self.QQZoneView = [[UIView alloc]init];
    self.QQZoneView.cas_styleClass = @"share_WXView";
    [self.QQZoneView addGestureRecognizer:tapQQZone];
    self.QQZoneView.tag = 4;
    
    self.QQZoneImageView = [[UIImageView alloc]init];
    self.QQZoneImageView.cas_styleClass = @"share_WXImageView";
    self.QQZoneImageView.image = kImage(@"share_kongjian.png");
    
    self.QQZoneTitleLabel = [[UILabel alloc]init];
    self.QQZoneTitleLabel.cas_styleClass = @"share_WXTitleLabel";
    self.QQZoneTitleLabel.text = @"QQ空间";
    
    UITapGestureRecognizer *tapSina = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShareAction:)];
    self.sinaView = [[UIView alloc]init];
    self.sinaView.cas_styleClass = @"share_WXView";
    [self.sinaView addGestureRecognizer:tapSina];
    self.sinaView.tag = 5;
    
    self.sinaImageView = [[UIImageView alloc]init];
    self.sinaImageView.cas_styleClass = @"share_WXImageView";
    self.sinaImageView.userInteractionEnabled = YES;
    self.sinaImageView.image = kImage(@"share_xinlang.png");
    
    self.sinaTitleLabel = [[UILabel alloc]init];
    self.sinaTitleLabel.cas_styleClass = @"share_WXTitleLabel";
    self.sinaTitleLabel.text = @"微博";
}

#pragma mark --按钮点击处理--
- (void)tapShareAction:(UITapGestureRecognizer *)tap {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewTypeWith:)]) {
        [self.delegate shareViewTypeWith:tap.view.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
