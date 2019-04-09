//
//  CrowdFundBottomView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/2.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "CrowdFundBottomView.h"

@interface CrowdFundBottomView () {
    UIButton *mySupportBut;
    UIButton *OtherPeopleFundBut;
    UIButton *myCrowdFundBut;
    UILabel *SucceOrfailureLabel;
    BootomType _footType;
    
}
@end

@implementation CrowdFundBottomView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = cBgColor;
        mySupportBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [mySupportBut addTarget:self action:@selector(mySupportButAction) forControlEvents:UIControlEventTouchUpInside];
        OtherPeopleFundBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [OtherPeopleFundBut addTarget:self action:@selector(OtherPeopleFundButAction) forControlEvents:UIControlEventTouchUpInside];
        myCrowdFundBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [myCrowdFundBut addTarget:self action:@selector(myCrowdFundButAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mySupportBut];
        [self addSubview:myCrowdFundBut];
        [self addSubview:OtherPeopleFundBut];
       
    }
    return self;
}
- (void)setBootomType:(BootomType)BootomType{
     _footType = BootomType;
    if (MyCrowdFundSignUp == BootomType) {
        [self layoutMyCrowdFundSignUp];
    }
    if (OtherPeoPleCrowdFund == BootomType) {
        [self layoutOtherPeopleCrowdFund];
    }
}

- (void)layoutMyCrowdFundSignUp {
    [OtherPeopleFundBut setTitle:@"找人帮我众筹" forState:UIControlStateNormal];
    [OtherPeopleFundBut setTintColor:kColor(@"ffffff")];
    [OtherPeopleFundBut setBackgroundColor:kColor(@"05c1b0")];
    [OtherPeopleFundBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kWidth(122));
        make.height.mas_offset(kWidth(42));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    OtherPeopleFundBut.layer.cornerRadius = 5.0f;
    OtherPeopleFundBut.titleLabel.font = sysFont(font(16));
    
    
    [mySupportBut setTitle:@"自己支持" forState:UIControlStateNormal];
    [mySupportBut setTintColor:kColor(@"333333")];
    [mySupportBut setBackgroundColor:[UIColor whiteColor]];
    mySupportBut.layer.borderWidth = 1.0f;
    mySupportBut.layer.borderColor = kColor(@"#bfbfbf").CGColor;
    [mySupportBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->OtherPeopleFundBut.mas_left).mas_offset(kWidth(-13));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(42));
    }];
    mySupportBut.layer.cornerRadius = 5.0f;
    mySupportBut.titleLabel.font = sysFont(font(14));
    
    
    [myCrowdFundBut setTitle:@"我的众筹列表" forState:UIControlStateNormal];
    [myCrowdFundBut setTintColor:kColor(@"333333")];
    [myCrowdFundBut setBackgroundColor:[UIColor whiteColor]];
    myCrowdFundBut.layer.borderWidth = 1.0f;
    myCrowdFundBut.layer.borderColor = kColor(@"#bfbfbf").CGColor;
    [myCrowdFundBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->OtherPeopleFundBut.mas_right).mas_offset(kWidth(13));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(42));
    }];
    myCrowdFundBut.layer.cornerRadius = 5.0f;
    myCrowdFundBut.titleLabel.font = sysFont(font(14));
}

- (void)layoutOtherPeopleCrowdFund {
    [mySupportBut setTitle:@"给他支持" forState:UIControlStateNormal];
    [mySupportBut setTintColor:kColor(@"ffffff")];
    [mySupportBut setBackgroundColor:kColor(@"05c1b0")];
    [mySupportBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.height.mas_offset(kWidth(42));
        make.width.mas_offset((iPhoneWidth - kWidth(67))/2);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    mySupportBut.layer.cornerRadius = 5.0f;
    mySupportBut.titleLabel.font = sysFont(font(16));
    
    
    [myCrowdFundBut setTitle:@"我也要玩" forState:UIControlStateNormal];
    [myCrowdFundBut setTintColor:kColor(@"ffffff")];
    [myCrowdFundBut setBackgroundColor:kColor(@"05c1b0")];
    [myCrowdFundBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.width.mas_equalTo(self->mySupportBut);
        make.height.mas_equalTo(self->mySupportBut);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    myCrowdFundBut.layer.cornerRadius = 5.0f;
    myCrowdFundBut.titleLabel.font = sysFont(font(16));
}
#pragma mark - 自己支持 and 给他支持
- (void)mySupportButAction {
    
    if (_footType == MyCrowdFundSignUp) {
        self.selfSupport();
    }else if(_footType == OtherPeoPleCrowdFund) {
        self.giveTasupportlock();
    }
}
#pragma mark - 招人众筹
- (void) OtherPeopleFundButAction {
    self.OtherPeoPleZCBlock();
}
#pragma mark - 我的众筹 and 我也要玩
- (void) myCrowdFundButAction {
    if (_footType == MyCrowdFundSignUp) {
        self.myCrowdFundBlock();
    }else if(_footType == OtherPeoPleCrowdFund) {
        self.IPlayToolock();
    }
}
- (void)setSuceeOrFail:(SucceOrfailureType)SuceeOrFail {
    SucceOrfailureLabel = [[UILabel alloc] init];
    [self addSubview:SucceOrfailureLabel];
    SucceOrfailureLabel.textAlignment = NSTextAlignmentCenter;
    SucceOrfailureLabel.clipsToBounds = YES;
    [SucceOrfailureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.height.mas_offset(kWidth(50));
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    if (SuceeOrFail == SuccesType) {
        SucceOrfailureLabel.text = @"众筹成功";
        SucceOrfailureLabel.backgroundColor = kColor(@"05c1b0");
        SucceOrfailureLabel.textColor = kColor(@"#ffffff");
    }else if (SuceeOrFail == EndCrowdFund) {
        SucceOrfailureLabel.text = @"众筹已结束";
        self.backgroundColor = cBgColor;
        SucceOrfailureLabel.textColor = kColor(@"#999999");
        SucceOrfailureLabel.backgroundColor = kColor(@"#cccccc");
    }else  {
        SucceOrfailureLabel.text = @"众筹失败";
        self.backgroundColor = cBgColor;
        SucceOrfailureLabel.textColor = kColor(@"#999999");
        SucceOrfailureLabel.backgroundColor = kColor(@"#cccccc");
    }
}

//- (void)setActivies:(ActivitiesListModel *)ActiModel {
//    if ([ActiModel.crowd_method integerValue] == 0) {
//        mySupportBut.hidden = YES;
//
//        [OtherPeopleFundBut mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self).mas_offset(12);
//            make.width.mas_offset((iPhoneWidth - kWidth(37))/2.);
//            make.height.mas_offset(kWidth(42));
//            make.centerY.mas_equalTo(self.mas_centerY);
//        }];
//        
//        [myCrowdFundBut mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self->OtherPeopleFundBut.mas_right).mas_offset(kWidth(13));
//            make.centerY.mas_equalTo(self.mas_centerY);
//            make.width.mas_equalTo(self->OtherPeopleFundBut);
//            make.height.mas_offset(kWidth(42));
//        }];
//    }
//    
//}
@end
