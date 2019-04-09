//
//  PlayPopView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "PlayPopView.h"

@interface PlayPopView () {
    UILabel *titleLabel;
    UILabel *contentLabel;
    UILabel *picTypeLabel;
    UIButton *goPlayBut;
}
@end

@implementation PlayPopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, iPhoneWidth - kWidth(100), kWidth(200));
        [self createView];
    }
    return self;
}
- (void) createView {
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(15), kWidth(100), kWidth(25))];
    titleLabel.text = @"提示";
    titleLabel.font = sysFont(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    titleLabel.centerX = self.centerX;
    
    UIButton *cancelBut = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBut.frame = CGRectMake(width(self) - kWidth(40), 0, kWidth(27), kWidth(27));
    cancelBut.centerY = titleLabel.centerY;
    UIImage *cenImage = [Image(@"icon_gbtc") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [cancelBut setImage:cenImage forState:UIControlStateNormal];
    cancelBut.backgroundColor = [UIColor grayColor];
    cancelBut.layer.cornerRadius = width(cancelBut)/2.;
    [cancelBut addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBut];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), maxY(titleLabel) + kWidth(10), width(self) - kWidth(24), kWidth(50))];
    contentLabel.text = @"自己先支付，让朋友看到你的决心，更易筹满。";
    contentLabel.font = sysFont(16);
    contentLabel.numberOfLines = 2;
    [self addSubview:contentLabel];
    
    picTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(contentLabel), maxY(contentLabel) + 10, width(contentLabel), 20)];
    picTypeLabel.text = @"365元不支持退款";
    picTypeLabel.textColor = kColor(@"#999999");
    picTypeLabel.font = sysFont(15);
    picTypeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:picTypeLabel];
    
    goPlayBut = [UIButton buttonWithType:UIButtonTypeSystem];
    goPlayBut.frame = CGRectMake(minX(picTypeLabel), maxY(picTypeLabel) + kWidth(18), width(picTypeLabel), 35);
    goPlayBut.backgroundColor = [UIColor redColor];
    [goPlayBut addTarget:self action:@selector(GopleayAction) forControlEvents:UIControlEventTouchUpInside];
    [goPlayBut setTitle:@"支付365元" forState:UIControlStateNormal];
    [goPlayBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goPlayBut.layer.cornerRadius = kWidth(4);
    goPlayBut.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT"size:font(16)];;
    [self addSubview:goPlayBut];
}
- (void)setPopViewZouclistModel:(ActivitiesListModel *)model {
    NSString *titlStr = [NSString stringWithFormat:@"支付%@元",model.pop_money];
    [goPlayBut setTitle:titlStr forState:UIControlStateNormal];
    picTypeLabel.text = [NSString stringWithFormat:@"%@元不支持退款",model.pop_money];
}
- (void)cancelAction {
    self.cancelPopView();
}
- (void) GopleayAction {
    if (self.goPlayOrder != nil) {
        self.goPlayOrder();
    }
}
@end
