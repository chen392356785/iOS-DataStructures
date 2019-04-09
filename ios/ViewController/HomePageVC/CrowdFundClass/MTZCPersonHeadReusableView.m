//
//  MTZCPersonHeadReusableView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTZCPersonHeadReusableView.h"

@interface MTZCPersonHeadReusableView () {
    UILabel *CowdFundLab;
    UILabel *SupportLab;
    UILabel *CowdFundLabel;
    UILabel *supportLabel;
    UILabel *CFlineLabel;
    UILabel *SuplineLabel;
}

@end

@implementation MTZCPersonHeadReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CowdFundLab = [[UILabel alloc] init];
        SupportLab = [[UILabel alloc] init];
        CowdFundLabel = [[UILabel alloc] init];
        supportLabel = [[UILabel alloc] init];
        [self addSubview:CowdFundLab];
        [self addSubview:SupportLab];
        [self addSubview:CowdFundLabel];
        [self addSubview:supportLabel];
        CFlineLabel = [[UILabel alloc] init];
        CFlineLabel.backgroundColor = kColor(@"eb420a");
        [self addSubview:CFlineLabel];
        [self createlayoutSubviews];
    }
    return self;
}
- (void)createlayoutSubviews {
    CowdFundLab.text = @"众筹人数";
    CowdFundLab.textColor =kColor(@"333333");
    CowdFundLab.textAlignment = NSTextAlignmentCenter;
    CowdFundLab.frame = CGRectMake(0, 6, iPhoneWidth/2, 16);
    CowdFundLab.font = sysFont(font(16));
    [CowdFundLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(6);
        make.left.mas_equalTo(self);
        make.height.mas_offset(16);
        make.width.mas_equalTo(self).multipliedBy(0.5);
    }];
    
    CowdFundLabel.textAlignment = NSTextAlignmentCenter;
    CowdFundLabel.font = sysFont(font(16));
    [CowdFundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->CowdFundLab.bottom).mas_offset(22);
        make.left.mas_equalTo(self);
        make.height.mas_offset(16);
        make.width.mas_equalTo(self).multipliedBy(0.5);
    }];
    
    SupportLab.text = @"支持人数";
    SupportLab.textColor = kColor(@"333333");
    SupportLab.textAlignment = NSTextAlignmentCenter;
     SupportLab.font = sysFont(font(16));
    [SupportLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(6);
        make.left.mas_equalTo(self->CowdFundLab.right);
        make.height.mas_offset(16);
        make.width.mas_equalTo(self).multipliedBy(0.5);
    }];
    
    supportLabel.textAlignment = NSTextAlignmentCenter;
    supportLabel.font = sysFont(font(16));
    [supportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->CowdFundLab.bottom).mas_offset(22);
        make.left.mas_equalTo(self->SupportLab);
        make.height.mas_offset(16);
        make.width.mas_equalTo(self).multipliedBy(0.5);
    }];
    
   
    [CFlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_offset(2);
            make.width.mas_equalTo(self).multipliedBy(0.5);
    }];
    
    
    SuplineLabel = [[UILabel alloc] init];
    SuplineLabel.backgroundColor = kColor(@"eb420a");
    [self addSubview:SuplineLabel];{
        [SuplineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.height.mas_offset(2);
            make.right.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(0.5);
        }];
    }
    SuplineLabel.hidden = YES;
    
    UIView *CFtagView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth/2.0, height(self))];
    [self addSubview:CFtagView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CrowdfundButAction)];
    [CFtagView addGestureRecognizer:tap];
    
    UIView *supportView = [[UIView alloc] initWithFrame:CGRectMake(maxX(CFtagView), 0, iPhoneWidth/2.0, height(self))];
    [self addSubview:supportView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SupportButAction)];
    [supportView addGestureRecognizer:tap1];
    
    
    
}
- (void)setCrowdFundCount:(NSString *)CowdFundCont andSupportCount:(NSString *)supportCount {
    CowdFundLabel.text = [NSString stringWithFormat:@"%@ 人",CowdFundCont];
    supportLabel.text = [NSString stringWithFormat:@"%@ 人",supportCount];
    
}
- (void) CrowdfundButAction {
    if (CFlineLabel.hidden) {
        CFlineLabel.hidden = NO;
        self.CrowdfundAction();
        SuplineLabel.hidden = YES;
    }
    
}
- (void) SupportButAction{
    if (SuplineLabel.hidden) {
        SuplineLabel.hidden = NO;
        self.SupportAction();
        CFlineLabel.hidden = YES;
    }
}
@end



@interface MTZCDetailReusableView() {
    BOOL _isShowDetail;
    UIImageView *imageView;
}
@end

@implementation MTZCDetailReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self createlayoutSubviews];
    }
    return self;
}
- (void)createlayoutSubviews {
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(6);
        make.left.mas_equalTo(self).mas_offset(12);
        make.width.mas_offset(iPhoneWidth - 50);
        make.height.mas_offset(18);
        make.centerY.mas_equalTo(self);
    }];
    titleLabel.font = sysFont(18);
    titleLabel.textColor = kColor(@"333333");
    titleLabel.text = @"详情描述";
    [self addSubview:titleLabel];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth - 30, 9, 12, 16)];
    [self addSubview:imageView];
    
    UIButton * tapBut = [UIButton buttonWithType:UIButtonTypeSystem];
    tapBut.frame = CGRectMake(0, 0, iPhoneWidth, 35);
    [self addSubview:tapBut];
    [tapBut addTarget:self action:@selector(isShowDetailTap) forControlEvents:UIControlEventTouchUpInside];
    [tapBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.width.height.mas_equalTo(self);
    }];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height(self) - 1, iPhoneWidth, 1)];
    lineLabel.backgroundColor = cBgColor;
    [self addSubview:lineLabel];
}
- (void) isShowDetailTap {
    _isShowDetail = !_isShowDetail;
    if (_isShowDetail == NO) {
        imageView.frame = CGRectMake(iPhoneWidth - 30, 9, 12, 16);
        imageView.image = Image(@"icon_shouqi.png");
    }else {
        imageView.frame = CGRectMake(iPhoneWidth - 30, 13, 16, 12);
        imageView.image = Image(@"icon_zhankai.png");
    }
    self.isShowDetailblock(_isShowDetail);
}
- (void) setisShowDetail:(BOOL) isShow{
    _isShowDetail = isShow;
    if (_isShowDetail == NO) {
        imageView.frame = CGRectMake(iPhoneWidth - 30, 9, 12, 16);
        imageView.image = Image(@"icon_shouqi.png");
    }else {
        imageView.frame = CGRectMake(iPhoneWidth - 30, 13, 16, 12);
        imageView.image = Image(@"icon_zhankai.png");
    }
}
@end

