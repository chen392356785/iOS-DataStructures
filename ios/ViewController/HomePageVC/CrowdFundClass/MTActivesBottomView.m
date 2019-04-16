//
//  MTActivesBottomView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/25.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTActivesBottomView.h"

@interface MTActivesBottomView () {
    UIButton *myCrowdFundBut;
    UIButton *myZCPlayBut;
    UIButton *myActionPlay;         //立即支付
    UILabel  *BottomLbael;
//    BOOL _isDidCrowdFunding;       //是否发起过众筹
}
@end

@implementation MTActivesBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        myCrowdFundBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [myCrowdFundBut addTarget:self action:@selector(myCrowdFundAction) forControlEvents:UIControlEventTouchUpInside];
        myZCPlayBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [myZCPlayBut addTarget:self action:@selector(myZCPlayButAction) forControlEvents:UIControlEventTouchUpInside];
        myActionPlay = [UIButton buttonWithType:UIButtonTypeSystem];
        [myActionPlay addTarget:self action:@selector(myActionPlayAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:myCrowdFundBut];
        [self addSubview:myZCPlayBut];
        [self addSubview:myActionPlay];
        BottomLbael = [[UILabel alloc] init];
        [self addSubview:BottomLbael];
    }
    return self;
}
- (void)layoutupSubviews {
    //0-活动报名未开始  1-众筹未开始  2-活动立即支付 3-我要众筹我要支付 4-众筹已结束 5-活动已结束 6-本次活动人数已满 7-只支持众筹不支持支付
    if ([self.BottomType intValue] == 0 || [self.BottomType intValue] == 1 || [self.BottomType intValue] == 4 || [self.BottomType intValue] == 5 || [self.BottomType intValue] == 6) {
        BottomLbael.textColor = kColor(@"#999999");
        BottomLbael.backgroundColor = kColor(@"#cccccc");
        BottomLbael.font = sysFont(17);
        BottomLbael.textAlignment = NSTextAlignmentCenter;
        [BottomLbael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(self);
        }];
        if ([self.BottomType integerValue] == 0) BottomLbael.text= @"报名未开始";
        if ([self.BottomType integerValue] == 1) BottomLbael.text= @"众筹还未开始";
        if ([self.BottomType integerValue] == 4) BottomLbael.text= @"本次众筹已结束";
        if ([self.BottomType integerValue] == 5) BottomLbael.text= @"报名已结束";
        if ([self.BottomType integerValue] == 6) BottomLbael.text= @"本次活动人数已满,请期待下次活动哦";
        BottomLbael.textColor = kColor(@"#444444");
    }
    if ([self.BottomType integerValue] == 2) {
        [myActionPlay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(kLevelSpace(12.5));
            make.bottom.mas_equalTo(self).mas_offset(kVertiSpace(-5));
            make.width.mas_equalTo(self).mas_offset(kVertiSpace(-25));
            make.height.mas_offset(kHeight(39));
        }];
        [myActionPlay setTitle:@"立即支付" forState:UIControlStateNormal];
        [myActionPlay setTintColor:kColor(@"ffffff")];
        [myActionPlay setBackgroundColor:kColor(@"05c1b0")];
        myActionPlay.layer.cornerRadius = 5.0f;
        myActionPlay.titleLabel.font = sysFont(17);
    }
    if ([self.BottomType integerValue] == 3) {
        [myCrowdFundBut setTitle:@"我要众筹" forState:UIControlStateNormal];
        [myCrowdFundBut setTintColor:kColor(@"ffffff")];
        [myCrowdFundBut setBackgroundColor:kColor(@"05c1b0")];
        [myCrowdFundBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(kLevelSpace(12));
            make.top.mas_equalTo(self).mas_offset(kVertiSpace(5));
            make.width.mas_offset(kWidth(154));
            make.height.mas_offset(kHeight(39));
        }];
        myCrowdFundBut.layer.cornerRadius = 5.0f;
        myCrowdFundBut.titleLabel.font = sysFont(14);
        
        [myZCPlayBut setTitle:@"直接支付" forState:UIControlStateNormal];
        [myZCPlayBut setTintColor:kColor(@"333333")];
        [myZCPlayBut setBackgroundColor:[UIColor whiteColor]];
        myZCPlayBut.layer.borderWidth = 1.0f;
        myZCPlayBut.layer.borderColor = kColor(@"bfbfbf").CGColor;
        [myZCPlayBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(kLevelSpace(-12));
            make.top.mas_equalTo(self).mas_offset(kVertiSpace(5));
            make.width.mas_offset(kWidth(154));
            make.height.mas_offset(kHeight(39));
        }];
        myZCPlayBut.layer.cornerRadius = 5.0f;
        myZCPlayBut.titleLabel.font = sysFont(14);
    }
    if ([self.BottomType integerValue] == 7) {
        [myCrowdFundBut setTitle:@"我要众筹" forState:UIControlStateNormal];
        [myCrowdFundBut setTintColor:kColor(@"ffffff")];
        [myCrowdFundBut setBackgroundColor:kColor(@"05c1b0")];
        [myCrowdFundBut mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
        myCrowdFundBut.titleLabel.font = sysFont(17);
    }
}

//已经众筹过
- (void)setIsDidCrowdFund:(BOOL)isDidCrowdFund {
    [myCrowdFundBut setTitle:@"我的众筹" forState:UIControlStateNormal];
}
#pragma mark - 我要众筹
- (void)myCrowdFundAction {
    self.goCrowdFund();
}
#pragma mark - 立即支付
- (void) myZCPlayButAction {
    self.CrowdFundPlay();
}
#pragma mark - 立即支付
- (void) myActionPlayAction {
    self.ActivityPlay();
}
@end
