//
//  MyActivityOrderCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/10.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyActivityOrderCell.h"

@implementation MyActivityOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.font = sysFont(font(16));
    self.timeLabel.textColor = kColor(@"#333333");
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.height.mas_offset(kWidth(50));
        make.width.mas_offset(kWidth(170));
    }];
    
    self.statuLabel.font = sysFont(font(16));
    self.statuLabel.textColor = kColor(@"#333333");
    self.statuLabel.textAlignment = NSTextAlignmentRight;
    [self.statuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(50));
        make.width.mas_offset(kWidth(100));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_offset(kWidth(1));
    }];
    self.line1.backgroundColor = cLineColor;
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line1.mas_bottom).mas_offset(kWidth(10));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.height.mas_offset(kWidth(80));
        make.width.mas_offset(kWidth(80));
    }];
    
    self.titleLabel.font = sysFont(font(16));
    self.titleLabel.textColor = kColor(@"#333333");
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftImageView.mas_top).mas_offset(kWidth(6));
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(kWidth(13));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(16));
    }];
    self.picLabel.font = sysFont(font(16));
    self.picLabel.textColor = kColor(@"#ff0000");
    [self.picLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(kWidth(37));
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(16));
    }];
    
    self.Line2.backgroundColor = cLineColor;
    [self.Line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftImageView.mas_bottom).mas_offset(kWidth(10));
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_offset(kWidth(1));
    }];
    
    
    [self.shouldPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.Line2.mas_bottom);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(32));
    }];
    
    [self.PlayBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shouldPic.mas_bottom).mas_offset(kWidth(7));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(30));
        make.width.mas_offset(kWidth(84));
    }];
    
    [self.PlayBut setTitleColor:kColor(@"#05c1b0") forState:UIControlStateNormal];
     self.PlayBut.layer.cornerRadius = kWidth(15);
     self.PlayBut.layer.borderWidth = 1.;
     self.PlayBut.layer.borderColor = kColor(@"#05c1b0").CGColor;
     self.PlayBut.titleLabel.font = sysFont(font(14));
     
     [self.cancelBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shouldPic.mas_bottom).mas_offset(kWidth(7));
        make.right.mas_equalTo(self.PlayBut.mas_left).mas_offset(kWidth(-15));
        make.height.mas_offset(kWidth(30));
        make.width.mas_offset(kWidth(84));
     }];
     [self.cancelBut setTitleColor:kColor(@"#999999") forState:UIControlStateNormal];
      self.cancelBut.layer.cornerRadius = kWidth(15);
      self.cancelBut.layer.borderWidth = 1.;
      self.cancelBut.layer.borderColor = kColor(@"#999999").CGColor;
      self.cancelBut.titleLabel.font = sysFont(font(14));
}

- (void)setActivitiesListModel:(ActivitiesListModel *)model {
    self.titleLabel.text = model.activities_titile;
    self.timeLabel.text = model.uploadtime;
    self.cancelBut.hidden = YES;
    self.PlayBut.hidden = YES;
    if ([model.order_status integerValue] == 0) {
        self.statuLabel.text = @"等待买家付款";
        self.cancelBut.hidden = NO;
        self.PlayBut.hidden = NO;
    }else if ([model.order_status integerValue] == 1){
        self.statuLabel.text = @"已成功";
    }else if([model.order_status integerValue] == 3){
        self.statuLabel.text = @"订单已取消";
    }else if([model.order_status integerValue] == 4){
        self.statuLabel.text = @"订单已失效";
    }
    self.picLabel.text = [NSString stringWithFormat:@"￥ %.2f",[model.payment_amount floatValue]/100.0];
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.activities_pic] placeholderImage: Image(@"xiaotu.png")];
    
    NSString *shouPicStr = [NSString stringWithFormat:@"应付金额：￥%.2f",[model.payment_amount floatValue]/100.0];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:shouPicStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#999999") range:NSMakeRange(0, 5)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(5, shouPicStr.length - 5)];
    self.shouldPic.attributedText = attributedStr;
    self.shouldPic.font = sysFont(font(16));
}
- (IBAction)CancelOrderAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否取消报名该活动" message:@"" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //取消活动报名
    if (buttonIndex == 0) {
        self.cancelOrder();
    }
}
- (IBAction)PlayOrderAction:(id)sender {
    self.playOrder();
}

@end
