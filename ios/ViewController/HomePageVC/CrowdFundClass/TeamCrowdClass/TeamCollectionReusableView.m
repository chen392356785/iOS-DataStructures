//
//  TeamCollectionReusableView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/17.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "TeamCollectionReusableView.h"

@interface TeamCollectionReusableView () {
    UILabel *SpokesmanLabel;
    UILabel *SpokesmanNum;
    UILabel *SpokesLine;
    
    UILabel *CowdFundLabel;
    UILabel *CowdFundNum;
    UILabel *CowdFundLine;
    
    UILabel *SuperLabel;
    UILabel *SuperNum;
    UILabel *SuperLine;
}

@end


@implementation TeamCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createlayoutSubviews];
    }
    return self;
}
- (void) createlayoutSubviews {
    UIView *SpokesmanBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth/3., height(self))];
    [self addSubview:SpokesmanBgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SpokesmanButAction:)];
    [SpokesmanBgView addGestureRecognizer:tap];
    
    SpokesmanLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, width(SpokesmanBgView), 16)];
    SpokesmanLabel.text = @"代言人";
    SpokesmanLabel.textColor =kColor(@"333333");
    SpokesmanLabel.textAlignment = NSTextAlignmentCenter;
    SpokesmanLabel.font = sysFont(font(16));
    [SpokesmanBgView addSubview:SpokesmanLabel];
    
    SpokesmanNum = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(SpokesmanLabel) +3, width(SpokesmanBgView), 16)];
    SpokesmanNum.text = @"1人";
    SpokesmanNum.textColor =kColor(@"333333");
    SpokesmanNum.textAlignment = NSTextAlignmentCenter;
    SpokesmanNum.font = sysFont(font(16));
    [SpokesmanBgView addSubview:SpokesmanNum];
    
    SpokesLine = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(SpokesmanBgView) - 2, width(SpokesmanBgView), 2)];
    SpokesLine.backgroundColor = kColor(@"eb420a");
    [SpokesmanBgView  addSubview:SpokesLine];
    
    
    
    UIView *CowdFundBgView = [[UIView alloc] initWithFrame:CGRectMake(maxX(SpokesmanBgView), 0, iPhoneWidth/3., height(self))];
    [self addSubview:CowdFundBgView];
    UITapGestureRecognizer *CowdFundTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CowdFundButAction:)];
    [CowdFundBgView addGestureRecognizer:CowdFundTap];
    CowdFundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, width(CowdFundBgView), 16)];
    CowdFundLabel.text = @"众筹中";
    CowdFundLabel.textColor =kColor(@"333333");
    CowdFundLabel.textAlignment = NSTextAlignmentCenter;
    CowdFundLabel.font = sysFont(font(16));
    [CowdFundBgView addSubview:CowdFundLabel];
    
    CowdFundNum = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(CowdFundLabel) +3, width(CowdFundBgView), 16)];
    CowdFundNum.text = @"5人";
    CowdFundNum.textColor =kColor(@"333333");
    CowdFundNum.textAlignment = NSTextAlignmentCenter;
    CowdFundNum.font = sysFont(font(16));
    [CowdFundBgView addSubview:CowdFundNum];
    
    CowdFundLine = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(CowdFundBgView) - 2, width(CowdFundBgView), 2)];
    CowdFundLine.backgroundColor = kColor(@"eb420a");
    CowdFundLine.hidden = YES;
    [CowdFundBgView  addSubview:CowdFundLine];
    
    
    
    
    UIView *SuperBgView = [[UIView alloc] initWithFrame:CGRectMake(maxX(CowdFundBgView), 0, iPhoneWidth/3., height(self))];
    [self addSubview:SuperBgView];
    UITapGestureRecognizer *SuperTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SuperButAction:)];
    [SuperBgView addGestureRecognizer:SuperTap];
    
    SuperLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, width(SuperBgView), 16)];
    SuperLabel.text = @"已筹满";
    SuperLabel.textColor =kColor(@"333333");
    SuperLabel.textAlignment = NSTextAlignmentCenter;
    SuperLabel.font = sysFont(font(16));
    [SuperBgView addSubview:SuperLabel];
    
    SuperNum = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(SuperLabel) +3, width(SuperBgView), 16)];
    SuperNum.text = @"6人";
    SuperNum.textColor =kColor(@"333333");
    SuperNum.textAlignment = NSTextAlignmentCenter;
    SuperNum.font = sysFont(font(16));
    [SuperBgView addSubview:SuperNum];
    
    SuperLine = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(SuperBgView) - 2, width(SuperBgView), 2)];
    SuperLine.backgroundColor = kColor(@"eb420a");
    SuperLine.hidden = YES;
    [SuperBgView  addSubview:SuperLine];
    
}
- (void)setTeamActioviesModel:(ActivitiesListModel *)model {
    SpokesmanNum.text = [NSString stringWithFormat:@"%ld 人",model.daiyanren.count];
    CowdFundNum.text = [NSString stringWithFormat:@"%ld 人",model.zhong.count];
    SuperNum.text = [NSString stringWithFormat:@"%ld 人",model.wancheng.count];
}


#pragma mark - 代言人
- (void) SpokesmanButAction:(UITapGestureRecognizer *)tapGes {
    NSLog(@"代言人");
    if (SpokesLine.hidden) {
        SuperLine.hidden = YES;
        CowdFundLine.hidden = YES;
        SpokesLine.hidden = NO;
        self.SpokesmanAction();
    }
    
    
}
- (void) CowdFundButAction:(UITapGestureRecognizer *)tapGes {
     NSLog(@"众筹中");
    if (CowdFundLine.hidden) {
        SuperLine.hidden = YES;
        CowdFundLine.hidden = NO;
        SpokesLine.hidden = YES;
        self.CowdFundAction();
    }
    
}
- (void) SuperButAction:(UITapGestureRecognizer *)tapGes {
     NSLog(@"已筹满");
    if (SuperLine.hidden) {
        SuperLine.hidden = NO;
        CowdFundLine.hidden = YES;
        SpokesLine.hidden = YES;
        self.SuperAction();
    }
    
}
@end
