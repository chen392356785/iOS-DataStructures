//
//  OnGoingTableCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/5.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "OnGoingTableCell.h"
#import "CountDown.h"

@interface OnGoingTableCell () {
    UIAsyncImageView *leftImageView;
    UILabel *timeLabel;
    UIView *topView;
    UILabel *titleLabel;    //标题
    UILabel *PicLabel;      //金额
    UILabel *percentlabel;  //百分比
    UIView *_progressView;
    CGFloat progress;
    UILabel *AlPicLabel;    //还差金额
    UIButton *CrowdBut;     //找人帮我众筹
    UIButton *supportBut;   //自己支持
    UIView *bgView;         //进度背景
    NSString *ActivityState;        //timelLable状态
}
@property (strong, nonatomic)  CountDown *countDownForLabel;
@end

@implementation OnGoingTableCell

- (CountDown *)countDownForLabel {
    if (_countDownForLabel == nil) {
        _countDownForLabel = [[CountDown alloc] init];
    }
    return _countDownForLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(32))];
        topView.backgroundColor = kColor(@"#fff6f6");
        [self addSubview:topView];
        
        timeLabel = [[UILabel alloc] init];
        [topView addSubview:timeLabel];
        timeLabel.frame = CGRectMake(kWidth(12), 0, iPhoneWidth - kWidth(24), height(topView));
        timeLabel.centerY = topView.centerY;
        timeLabel.font = sysFont(font(14));
        timeLabel.textColor = kColor(@"#ff0000");
        
        self.backgroundColor = [UIColor whiteColor];
        leftImageView = [[UIAsyncImageView alloc] init];
        [self addSubview:leftImageView];
        
        titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        
        PicLabel = [[UILabel alloc] init];
        [self addSubview:PicLabel];
        
        percentlabel = [[UILabel alloc] init];
        [self addSubview:percentlabel];
        
        AlPicLabel = [[UILabel alloc] init];
        [self addSubview:AlPicLabel];
        
        CrowdBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [CrowdBut addTarget:self action:@selector(lookingCrowdAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:CrowdBut];
        
        supportBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [supportBut addTarget:self action:@selector(supporeCrowdAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:supportBut];
        
        [self createLayoutSubviews];
    }
    return self;
}
- (void)createLayoutSubviews{
    UILabel *lineLabel = [[UILabel alloc] init];
    [self addSubview:lineLabel];
    lineLabel.backgroundColor = cLineColor;
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->topView.mas_bottom);
        make.left.mas_equalTo(self);
        make.height.mas_offset(1);
        make.width.mas_offset(iPhoneWidth);
    }];
    
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineLabel.mas_bottom).mas_offset(kWidth(11));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(kWidth(85));
        make.height.mas_offset(kWidth(85));
    }];
    
    titleLabel.textColor = kColor(@"#333333");
    titleLabel.font = sysFont(font(17));
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->leftImageView.mas_top).mas_offset(kWidth(5));
        make.left.mas_equalTo(self->leftImageView.mas_right).mas_offset(kWidth(22));
        make.right.mas_equalTo(lineLabel.mas_right).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(17));
    }];
    
    PicLabel.textColor = kColor(@"#ff0000");
    PicLabel.font = sysFont(font(16));
    PicLabel.textAlignment = NSTextAlignmentLeft;
    [PicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->titleLabel.mas_bottom).mas_offset(kWidth(27));
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.width.mas_offset(100);
        make.height.mas_offset(kWidth(16));
    }];
    
    [percentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->titleLabel.mas_bottom).mas_offset(kWidth(14));
        make.width.mas_offset(kWidth(70));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
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
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.bottom.mas_equalTo(self->leftImageView.mas_bottom);
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
    
    
    UILabel *botLine = [[UILabel alloc] init];
    botLine.backgroundColor = cLineColor;
    [self addSubview:botLine];
    [botLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->leftImageView.mas_bottom).mas_offset(kWidth(11));
        make.left.mas_equalTo(self);
        make.height.mas_offset(1);
        make.width.mas_offset(iPhoneWidth);
    }];
    
    [AlPicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(botLine.mas_bottom).mas_offset(kWidth(6));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(14));
        make.width.mas_offset(140);
    }];
    AlPicLabel.textAlignment = NSTextAlignmentRight;
    AlPicLabel.font = sysFont(font(14));
    
    [supportBut setTitle:@"自己支持" forState:UIControlStateNormal];
    supportBut.layer.cornerRadius = kWidth(16);
    supportBut.layer.borderWidth = 1.;
    supportBut.layer.borderColor = kColor(@"#999999").CGColor;
    [supportBut setTitleColor:kColor(@"#333333") forState:UIControlStateNormal];
    supportBut.titleLabel.font = sysFont(font(14));
    [supportBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->AlPicLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self->AlPicLabel.mas_right);
        make.width.mas_offset(kWidth(68));
        make.height.mas_offset(kWidth(32));
    }];
    
    [CrowdBut setTitle:@"找人帮我筹" forState:UIControlStateNormal];
    CrowdBut.layer.cornerRadius = kWidth(16);
    CrowdBut.layer.borderWidth = 1.;
    CrowdBut.layer.borderColor = kColor(@"#999999").CGColor;
    [CrowdBut setTitleColor:kColor(@"#333333") forState:UIControlStateNormal];
    CrowdBut.titleLabel.font = sysFont(font(14));
    [CrowdBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->AlPicLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self->supportBut.mas_left).mas_offset(kWidth(-18));
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(32));
    }];
    
}

- (void)setActivitiesListModel:(ActivitiesListModel* )model {
    [leftImageView setImageAsyncWithURL:model.activities_pic placeholderImage:Image(@"xiaotu.png")];
    titleLabel.text = model.activities_titile;
    PicLabel.text = [NSString stringWithFormat:@"￥ %.2f",[model.total_money floatValue]];
    progress = [model.obtain_money floatValue]/[model.total_money floatValue];
    percentlabel.text = [NSString stringWithFormat:@"%.2f%%",(progress*100)];
    CGFloat width= progress * WIDTH(bgView);
    _progressView.size = CGSizeMake(width, 6);
    NSString *picLabStr = [NSString stringWithFormat:@"还差￥%.2f", ([model.total_money floatValue] - [model.obtain_money floatValue])];
    AlPicLabel.textColor = kColor(@"#333333");
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picLabStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(2, picLabStr.length - 2)];
    AlPicLabel.attributedText = attributedStr;
    
/*//是否可以自己支持
    if ([model.crowd_method integerValue] == 0) {
        [supportBut mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(AlPicLabel.mas_bottom).mas_offset(10);
            make.right.mas_equalTo(self);
            make.width.mas_offset(kWidth(0));
            make.height.mas_offset(kWidth(32));
        }];
    }
//*/
    
    
    if ([IHUtility overtime:model.curtime inputDate:model.activities_expiretime]) {
        //        [self addSucessView:@"该活动已过期" type:2];
        ActivityState = @"活动已结束";
        return;
    }
    if ([IHUtility overtime:model.curtime inputDate:model.activities_ExpireStarttime] && [IHUtility overtime:model.activities_expiretime inputDate:model.curtime]) {
        //活动进行
        ActivityState = @"剩余";
    }
    ActivityState = @"剩余";
    if ([model.huodong_status integerValue] == 1) {
        timeLabel.text = @"该活动已下架";
        CrowdBut.hidden = YES;
        supportBut.hidden = YES;
        if ([model.isRefund integerValue] == 1) {
            timeLabel.text = @"退款中...";
        }
        return;
    }else {
        NSString *limitNum;
        NSString *signUp;
        limitNum = model.user_upper_limit_num;
        signUp = model.sign_up_num;
        if ([signUp integerValue] >= [limitNum integerValue]) {
            timeLabel.text = @"活动名额已满";
            CrowdBut.hidden = YES;
            supportBut.hidden = YES;
            return;
        }else {
            CrowdBut.hidden = NO;
            supportBut.hidden = NO;
        }
    }
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* startDate = [formater dateFromString:model.curtime];
    NSDate* finishDate = [formater dateFromString:model.activities_expiretime];
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
    timeLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",ActivityState,dd,hh,mm,ss];
}
-(void)dealloc{
    [_countDownForLabel destoryTimer];
}

- (void)lookingCrowdAction {
    self.otherPeopleblock();
}
- (void)supporeCrowdAction {
    self.supportBlock();
}

@end
