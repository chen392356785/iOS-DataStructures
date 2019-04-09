//
//  CrowFundDetailCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "CrowFundDetailCell.h"
#import "CountDown.h"

@interface CrowFundDetailCell ()  {
    UILabel *_titlelabel;
    UIImageView *_imageView;
    UILabel *picLabel;
    UILabel *totalLabel;
    UILabel *OrderPicLabel;
    UILabel *timeLabel;
    NSString *ActivityState;        //timelLable状态
}
@property (strong, nonatomic)  CountDown *countDownForLabel;
@end


@implementation CrowFundDetailCell
- (CountDown *)countDownForLabel {
    if (_countDownForLabel == nil) {
        _countDownForLabel = [[CountDown alloc] init];
    }
    return _countDownForLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        _titlelabel = [[UILabel alloc] init];
        [self addSubview:_titlelabel];
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        picLabel = [[UILabel alloc] init];
        [self addSubview:picLabel];
        totalLabel = [[UILabel alloc] init];
        [self addSubview:totalLabel];
        OrderPicLabel = [[UILabel alloc]init];
        [self addSubview:OrderPicLabel];
        timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        [self LaysubViewsUI];
    }
    return self;
}
- (void) LaysubViewsUI {
    UILabel *xqlable = [[UILabel alloc] init];
    xqlable.text = @"详情";
    xqlable.font = sysFont(font(16));
    [self.contentView addSubview:xqlable];
    [xqlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(kWidth(200));
        make.height.mas_offset(kWidth(30));
    }];
    //*/
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = cLineColor;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(xqlable.mas_bottom);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_offset(1);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).mas_offset(kWidth(7));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.height.mas_offset(kWidth(80));
        make.width.mas_offset(kWidth(80));
    }];
    
    _titlelabel.font = sysFont(font(16));
    _titlelabel.textColor = kColor(@"#333333");
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_imageView.mas_top).mas_offset(kWidth(6));
        make.left.mas_equalTo(self->_imageView.mas_right).mas_offset(kWidth(13));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(16));
    }];
    
    picLabel.font = sysFont(font(16));
    picLabel.textColor = kColor(@"#ff0000");
    [picLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_titlelabel.mas_bottom).mas_offset(kWidth(10));
        make.left.mas_equalTo(self->_titlelabel.mas_left);
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(16));
    }];
    
    timeLabel.font = sysFont(font(16));
    timeLabel.textColor = kColor(@"#ff0000");
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->picLabel.mas_bottom).mas_offset(kWidth(10));
        make.left.mas_equalTo(self->picLabel.mas_left);
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(16));
    }];
    
    UILabel *Line2 = [[UILabel alloc] init];
    [self addSubview:Line2];
    Line2.backgroundColor = cLineColor;
    [Line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_imageView.mas_bottom).mas_offset(kWidth(6));
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_offset(kWidth(1));
    }];
    UILabel *showtatoLabel = [[UILabel alloc] init];;
    [self addSubview:showtatoLabel];
    showtatoLabel.text = @"商品总价";
    showtatoLabel.font = sysFont(font(14));
    [showtatoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Line2.mas_bottom).mas_offset(kWidth(11));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(kWidth(120));
        make.height.mas_offset(kWidth(30));
    }];
    
    totalLabel.font = sysFont(font(14));
    totalLabel.textAlignment = NSTextAlignmentRight;
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(showtatoLabel.mas_top);
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.width.mas_offset(kWidth(120));
        make.height.mas_offset(kWidth(30));
    }];
    
//    UILabel *showOrderPLabel = [[UILabel alloc] init];;
//    [self addSubview:showOrderPLabel];
//    showOrderPLabel.text = @"订单总价";
//    showOrderPLabel.font = sysFont(font(14));
//    [showOrderPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(showtatoLabel.mas_bottom);
//        make.left.mas_equalTo(self).mas_offset(kWidth(12));
//        make.width.mas_offset(kWidth(120));
//        make.height.mas_offset(kWidth(30));
//    }];
//    
//    OrderPicLabel.font = sysFont(font(14));
//    OrderPicLabel.textAlignment = NSTextAlignmentRight;
//    [OrderPicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(showOrderPLabel.mas_top);
//        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
//        make.width.mas_offset(kWidth(150));
//        make.height.mas_offset(kWidth(30));
//    }];
    //*/
}
- (void)setActivitiesListModel:(ActivitiesListModel *)model {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.activities_pic] placeholderImage: Image(@"xiaotu.png")];
    _titlelabel.text = model.activities_titile;
    picLabel.text = [NSString stringWithFormat:@"￥ %@",model.unit_price];
    totalLabel.text = [NSString stringWithFormat:@"￥ %.2f",[model.payment_amount floatValue]/100.0];
    OrderPicLabel.text = [NSString stringWithFormat:@"￥ %.2f",[model.payment_amount floatValue]/100.0];

    if ([IHUtility overtime:model.curtime inputDate:model.activities_expiretime]) {
        ActivityState = @"已结束";
        return;
    }
    if ([IHUtility overtime:model.curtime inputDate:model.activities_starttime] && [IHUtility overtime:model.activities_expiretime inputDate:model.curtime]) {
        //活动进行
        ActivityState = @"剩余";
    }
    ActivityState = @"剩余";
    if ([model.huodong_status integerValue] == 1) {
        timeLabel.text = @"活动已下架";
        return;
    }
    NSString *limitNum;
    NSString *signUp;
    limitNum = model.user_upper_limit_num;
    signUp = model.sign_up_num;
    if ([signUp integerValue] >= [limitNum integerValue]) {
        timeLabel.text = @"活动名额已满";
        return;
    }
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* startDate = [formater dateFromString:model.curtime];
    NSDate* finishDate = [formater dateFromString:model.activities_expiretime];
    [self startWithStartDate:startDate finishDate:finishDate];
}
//-(void)startLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL{
//    __weak __typeof(self) weakSelf= self;
//    [self.countDownForLabel countDownWithStratTimeStamp:strtLL finishTimeStamp:finishLL completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
//        [weakSelf refreshUIDay:day hour:hour minute:minute second:second];
//    }];
//}

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

@end
