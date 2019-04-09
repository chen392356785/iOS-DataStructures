//
//  MTActionHeadImageCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTActionHeadImageCell.h"
#import "CountDown.h"


@interface MTActionHeadImageCell ()  {
    UIAsyncImageView *headImageView;
    UILabel *titleLabel;
    NSString *ActivityState;
}
@property (strong, nonatomic)  CountDown *countDownForLabel;
@end

@implementation MTActionHeadImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
    }
    return self;
}
- (CountDown *)countDownForLabel {
    if (_countDownForLabel == nil) {
        _countDownForLabel = [[CountDown alloc] init];
    }
    return _countDownForLabel;
}
- (void) createSubView {
    headImageView = [[UIAsyncImageView alloc] initWithFrame:self.frame];
    [self addSubview:headImageView];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 30)];
    titleLabel.font = sysFont(18.0);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGB(255, 255, 255);
    titleLabel.backgroundColor = kColor(@"#000000");
    titleLabel.numberOfLines = 0;
    titleLabel.alpha = 0.4f;
    [headImageView addSubview:titleLabel];
}


- (void)setActivitiesListModel:(ActivitiesListModel *)model {
    [headImageView setImageAsyncWithURL:model.activities_pic placeholderImage:DefaultImage_logo];
    if ([model.user_upper_limit_num integerValue] <= [model.sign_up_num integerValue]) {
        titleLabel.text =@"本次活动人数已满,请期待下次活动哦";
        return;
    }
    
    if ([model.user_upper_limit_num integerValue] <= [model.sign_up_num integerValue]) {
        titleLabel.text = @"活动已结束";
        return;
    }
    
    [self setImageURl:model.activities_pic andCurrentTime:model.curtime andTime:model.activities_expiretime andStartTime:model.activities_ExpireStarttime];
    
    
}
- (void)setImageURl:(NSString *)imageUrl andCurrentTime:(NSString *)curTime andTime:(NSString *)timeStr andStartTime:(NSString *)StartTime {
    [headImageView setImageAsyncWithURL:imageUrl placeholderImage:DefaultImage_logo];
        
    if ([IHUtility overtime:curTime inputDate:timeStr]) {
        //        [self addSucessView:@"该活动已过期" type:2];
        titleLabel.text = @"活动已结束";
        return;
    }else if ([IHUtility overtime:StartTime inputDate:curTime]) {
        //活动未开始
        ActivityState = @"距离活动报名开始还有";
    }
    if ([IHUtility overtime:curTime inputDate:StartTime] && [IHUtility overtime:timeStr inputDate:curTime]) {
        //活动进行
        ActivityState = @"距离活动结束还剩";
    }
    
    
    
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* startDate = [formater dateFromString:curTime];
    NSDate* finishDate = [formater dateFromString:timeStr];
    [self startWithStartDate:startDate finishDate:finishDate];
}
-(void)startLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL{
    __weak __typeof(self) weakSelf= self;
    [self.countDownForLabel countDownWithStratTimeStamp:strtLL finishTimeStamp:finishLL completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        [weakSelf refreshUIDay:day hour:hour minute:minute second:second];
    }];
}

-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate{
    __weak __typeof(self) weakSelf= self;
    [self.countDownForLabel countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        [weakSelf refreshUIDay:day hour:hour minute:minute second:second];

    }];
}


-(void)refreshUIDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    NSString *dd,*hh,*mm,*ss;
    if (day==0) {
        dd = @"0天";
    }else{
        dd = [NSString stringWithFormat:@"%ld天",(long)day];
    }
    if (hour<10&&hour) {
        hh = [NSString stringWithFormat:@"0%ld小时",(long)hour];
    }else{
        hh = [NSString stringWithFormat:@"%ld小时",(long)hour];
    }
    if (minute<10) {
        mm = [NSString stringWithFormat:@"0%ld分",(long)minute];
    }else{
        mm = [NSString stringWithFormat:@"%ld分",(long)minute];
    }
    if (second<10) {
        ss = [NSString stringWithFormat:@"0%ld秒",(long)second];
    }else{
        ss = [NSString stringWithFormat:@"%ld秒",(long)second];
    }
    titleLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",ActivityState,dd,hh,mm,ss];
}
-(void)dealloc{
    [_countDownForLabel destoryTimer];
}

@end
