//
//  CrowBottom.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "CrowBottom.h"

@interface CrowBottom () {
    UIButton *helpMeCBut;   //帮我筹
    UIButton *selfZCBut;    //自己支持
    UIButton *CheckDetailBut;
    CrowdFundType  selfcrowType;
}
@end

@implementation CrowBottom

- (instancetype)initWithFrame:(CGRect)frame CrowType:(CrowdFundType)crowType{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        helpMeCBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [helpMeCBut addTarget:self action:@selector(helpAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:helpMeCBut];
        
        selfZCBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [selfZCBut addTarget:self action:@selector(selfCrowAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selfZCBut];
        
        CheckDetailBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [CheckDetailBut addTarget:self action:@selector(checkCrowAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:CheckDetailBut];
        [self setCrowType:crowType];

    }
    return self;
}
- (void) setCrowType:(CrowdFundType)crowType {
    selfcrowType = crowType;
    if (crowType == CrowdFundOn) {
        [helpMeCBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(kWidth(12));
            make.width.mas_offset((iPhoneWidth - kWidth(24) - kWidth(38))/3.);
            make.height.mas_offset(kWidth(45));
            make.centerY.mas_equalTo(self);
        }];
        
        [selfZCBut mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(self->helpMeCBut.mas_right).mas_offset(kWidth(19));
			make.width.mas_equalTo(self->helpMeCBut);
            make.height.mas_offset(kWidth(45));
            make.centerY.mas_equalTo(self);
        }];
        
        [CheckDetailBut mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(self->selfZCBut.mas_right).mas_offset(kWidth(19));
			make.width.mas_equalTo(self->helpMeCBut);
            make.height.mas_offset(kWidth(45));
            make.centerY.mas_equalTo(self);
        }];
        [CheckDetailBut setTitle:@"查看众筹详情页" forState:UIControlStateNormal];
        CheckDetailBut.titleLabel.font = sysFont(font(14));
        [CheckDetailBut setTitleColor:kColor(@"#333333") forState:UIControlStateNormal];
        CheckDetailBut.layer.cornerRadius = kWidth(5);
        CheckDetailBut.layer.borderWidth = 1.f;
        CheckDetailBut.layer.borderColor = kColor(@"bfbfbf").CGColor;
        
    }else {
        [CheckDetailBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(kWidth(13));
            make.right.mas_equalTo(self).mas_offset(kWidth(-13));
            make.height.mas_offset(kWidth(45));
            make.centerY.mas_equalTo(self);
        }];
        [CheckDetailBut setTitle:@"查看众筹详情页" forState:UIControlStateNormal];
         CheckDetailBut.titleLabel.font = sysFont(font(14));
        [CheckDetailBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CheckDetailBut.backgroundColor = kColor(@"#05c1b0");
        CheckDetailBut.layer.cornerRadius = kWidth(5);
    }
    [helpMeCBut setTitle:@"找人帮我众筹" forState:UIControlStateNormal];
    helpMeCBut.titleLabel.font = sysFont(font(14));
    [helpMeCBut setTitleColor:kColor(@"#333333") forState:UIControlStateNormal];
    helpMeCBut.layer.cornerRadius = kWidth(5);
    helpMeCBut.layer.borderWidth = 1.f;
    helpMeCBut.layer.borderColor = kColor(@"bfbfbf").CGColor;
    
    [selfZCBut setTitle:@"自己支持" forState:UIControlStateNormal];
    selfZCBut.titleLabel.font = sysFont(font(14));
    [selfZCBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selfZCBut.backgroundColor = kColor(@"#05c1b0");
    selfZCBut.layer.cornerRadius = kWidth(5);
    selfZCBut.layer.borderWidth = 1.f;
    selfZCBut.layer.borderColor = cBgColor.CGColor;
}

- (void)setActivies:(ActivitiesListModel *)ActiModel {
    
    if ([ActiModel.huodong_status integerValue] == 1) {
        selfZCBut.hidden = YES;
        helpMeCBut.hidden = YES;
        CheckDetailBut.backgroundColor = cBgColor;
        [CheckDetailBut setTitleColor:kColor(@"#666666") forState:UIControlStateNormal];
        [CheckDetailBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(self);
        }];
        
        [CheckDetailBut setTitle:@"该活动已下架" forState:UIControlStateNormal];
        if ([ActiModel.isRefund integerValue] == 1) {
            if (selfcrowType == CrowdFundFail) {
//                [CheckDetailBut setTitle:@"退款成功" forState:UIControlStateNormal];
            }else {
                if (![ActiModel.status isEqualToString:@"1"]) {
//                     [CheckDetailBut setTitle:@"退款中..." forState:UIControlStateNormal];
                }
               
            }
            
        }
        [CheckDetailBut setEnabled:NO];
        CheckDetailBut.layer.borderWidth = 1.f;
        CheckDetailBut.layer.borderColor = kColor(@"bfbfbf").CGColor;
        CheckDetailBut.layer.cornerRadius = kWidth(0);
    }
    
    
/*
    if ([ActiModel.crowd_method integerValue] == 0) {
        selfZCBut.hidden = YES;
        
        [helpMeCBut mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(12);
            make.width.mas_offset((iPhoneWidth - kWidth(37))/2.);
            make.height.mas_offset(kWidth(42));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        helpMeCBut.backgroundColor = kColor(@"#05c1b0");
        [helpMeCBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [CheckDetailBut mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(helpMeCBut.mas_right).mas_offset(kWidth(13));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(helpMeCBut);
            make.height.mas_offset(kWidth(42));
        }];
    }
 //*/
}

- (void) helpAction {
    self.helpMeCrowBlock();
}
- (void) selfCrowAction {
    self.selfCrowBlock();
}
- (void) checkCrowAction {
    self.myCrowDetailBlock();
}
@end
