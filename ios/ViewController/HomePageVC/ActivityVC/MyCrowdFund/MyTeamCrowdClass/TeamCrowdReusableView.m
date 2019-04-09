//
//  TeamCrowdReusableView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "TeamCrowdReusableView.h"

@interface TeamCrowdReusableView () {
    UILabel *TheTeamLabel;
    UILabel *TheTeamNum;
    UILabel *TheTeamLine;
    
    UILabel *TeamPeopleLabel;
    UILabel *TeamPeopleNum;
    UILabel *TeamPeopleLine;
    
    UILabel *SuperLabel;
    UILabel *SuperNum;
    UILabel *SuperLine;
}
@end

@implementation TeamCrowdReusableView

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
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SpokesmanButAction:)];
//    [SpokesmanBgView addGestureRecognizer:tap];
    
    TheTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, width(SpokesmanBgView), 16)];
    TheTeamLabel.text = @"参赛队伍";
    TheTeamLabel.textColor =kColor(@"333333");
    TheTeamLabel.textAlignment = NSTextAlignmentCenter;
    TheTeamLabel.font = sysFont(font(16));
    [SpokesmanBgView addSubview:TheTeamLabel];
    
    TheTeamNum = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(TheTeamLabel) +3, width(SpokesmanBgView), 16)];
    TheTeamNum.text = @"20支";
    TheTeamNum.textColor =kColor(@"333333");
    TheTeamNum.textAlignment = NSTextAlignmentCenter;
    TheTeamNum.font = sysFont(font(16));
    [SpokesmanBgView addSubview:TheTeamNum];
    
    TheTeamLine = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(SpokesmanBgView) - 2, width(SpokesmanBgView), 2)];
    TheTeamLine.backgroundColor = kColor(@"eb420a");
    TheTeamLine.hidden = YES;
    [SpokesmanBgView  addSubview:TheTeamLine];
    
    
    
    UIView *CowdFundBgView = [[UIView alloc] initWithFrame:CGRectMake(maxX(SpokesmanBgView), 0, iPhoneWidth/3., height(self))];
    [self addSubview:CowdFundBgView];
    UITapGestureRecognizer *CowdFundTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CowdFundButAction:)];
    [CowdFundBgView addGestureRecognizer:CowdFundTap];
    TeamPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, width(CowdFundBgView), 16)];
    TeamPeopleLabel.text = @"本队人数";
    TeamPeopleLabel.textColor =kColor(@"333333");
    TeamPeopleLabel.textAlignment = NSTextAlignmentCenter;
    TeamPeopleLabel.font = sysFont(font(16));
    [CowdFundBgView addSubview:TeamPeopleLabel];
    
    TeamPeopleNum = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(TeamPeopleLabel) +3, width(CowdFundBgView), 16)];
    TeamPeopleNum.text = @"5人";
    TeamPeopleNum.textColor =kColor(@"333333");
    TeamPeopleNum.textAlignment = NSTextAlignmentCenter;
    TeamPeopleNum.font = sysFont(font(16));
    [CowdFundBgView addSubview:TeamPeopleNum];
    
    TeamPeopleLine = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(CowdFundBgView) - 2, width(CowdFundBgView), 2)];
    TeamPeopleLine.backgroundColor = kColor(@"eb420a");
    TeamPeopleLine.hidden = YES;
    [CowdFundBgView  addSubview:TeamPeopleLine];
    
    
    
    
    UIView *SuperBgView = [[UIView alloc] initWithFrame:CGRectMake(maxX(CowdFundBgView), 0, iPhoneWidth/3., height(self))];
    [self addSubview:SuperBgView];
    UITapGestureRecognizer *SuperTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SuperButAction:)];
    [SuperBgView addGestureRecognizer:SuperTap];
    
    SuperLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, width(SuperBgView), 16)];
    SuperLabel.text = @"支持人数";
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
    TheTeamNum.text = [NSString stringWithFormat:@"%ld 支",model.teamList.count];
    TeamPeopleNum.text = [NSString stringWithFormat:@"%ld 人",model.zcouList.count];
    SuperNum.text = [NSString stringWithFormat:@"%ld 人",model.zclist.count];
}

- (void)setSelectIndex:(NSString *)selectIndex {
    if ([selectIndex isEqualToString:@"0"]) {
         TheTeamLine.hidden = NO;
    }
    if ([selectIndex isEqualToString:@"1"]) {
        TeamPeopleLine.hidden = NO;
    }
    if ([selectIndex isEqualToString:@"2"]) {
        SuperLine.hidden = NO;
    }
}
#pragma mark - 代言人
- (void) SpokesmanButAction:(UITapGestureRecognizer *)tapGes {
    NSLog(@"代言人");
    if (TheTeamLine.hidden) {
        SuperLine.hidden = YES;
        TeamPeopleLine.hidden = YES;
        TheTeamLine.hidden = NO;
        self.TheTeamAction();
    }
    
    
}
- (void) CowdFundButAction:(UITapGestureRecognizer *)tapGes {
    NSLog(@"众筹中");
    if (TeamPeopleLine.hidden) {
        SuperLine.hidden = YES;
        TeamPeopleLine.hidden = NO;
        TheTeamLine.hidden = YES;
        self.TeamPeopleAction();
    }
    
}
- (void) SuperButAction:(UITapGestureRecognizer *)tapGes {
    NSLog(@"已筹满");
    if (SuperLine.hidden) {
        SuperLine.hidden = NO;
        TeamPeopleLine.hidden = YES;
        TheTeamLine.hidden = YES;
        self.SuperAction();
    }
    
}
@end
