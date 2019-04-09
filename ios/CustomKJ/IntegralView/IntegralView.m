//
//  IntegralView.m
//  MiaoTuProject
//
//  Created by Zmh on 4/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IntegralView.h"

@implementation IntegralView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame days:(NSString *)day
{
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.45);
        
        UIImage *image = [UIImage imageNamed:@"login_integral.png"];
        
        UIImageView *integralImageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 0, WindowWith - 48, (WindowWith - 48)*0.85)];
        integralImageView.bottom = kScreenHeight - 160;
        integralImageView.image = image;
        [self addSubview:integralImageView];
        
        CGSize size = [IHUtility GetSizeByText:[NSString stringWithFormat:@"欢迎使用%@",KAppName] sizeOfFont:15 width:200];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 21)];
//        titleLabel.center = CGPointMake(integralImageView.center.x, 0);
        titleLabel.centerX = integralImageView.width/2.0;
        titleLabel.top = 37*(kScreenHeight / 667.0);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = [NSString stringWithFormat:@"欢迎使用%@",KAppName];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = sysFont(15);
        [integralImageView addSubview:titleLabel];
        
        UILabel *daysLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        daysLabel1.text = day;
        daysLabel1.textAlignment = NSTextAlignmentCenter;
        daysLabel1.font = sysFont(28);
        [daysLabel1 sizeToFit];
        daysLabel1.centerX = integralImageView.width/2.0;
        daysLabel1.top = titleLabel.bottom + 6;
        daysLabel1.backgroundColor = [UIColor clearColor];
        daysLabel1.textColor = [UIColor whiteColor];
        [integralImageView addSubview:daysLabel1];
        
        size = [IHUtility GetSizeByText:@"连续第" sizeOfFont:22 width:200];
        UILabel *daysLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 30)];
        daysLabel2.center = CGPointMake(0, daysLabel1.center.y);
        daysLabel2.right = daysLabel1.left - 11;
        daysLabel2.backgroundColor = [UIColor clearColor];
        daysLabel2.textColor = RGB(248, 231, 28);
        daysLabel2.text = @"连续第";
        daysLabel2.textAlignment = NSTextAlignmentCenter;
        daysLabel2.font = sysFont(22);
        [integralImageView addSubview:daysLabel2];
        
        size = [IHUtility GetSizeByText:@"日登陆" sizeOfFont:22 width:200];
        UILabel *daysLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 30)];
        daysLabel3.center = CGPointMake(0, daysLabel1.center.y);
        daysLabel3.left = daysLabel1.right + 11;
        daysLabel3.backgroundColor = [UIColor clearColor];
        daysLabel3.textColor = RGB(248, 231, 28);
        daysLabel3.text = @"日登陆";
        daysLabel3.textAlignment = NSTextAlignmentCenter;
        daysLabel3.font = sysFont(22);
        [integralImageView addSubview:daysLabel3];

        size = [IHUtility GetSizeByText:@"人脉热度上升" sizeOfFont:15 width:200];
        UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 21)];
        Label1.top = daysLabel3.bottom + 6;
        Label1.left = daysLabel1.center.x + 5;
        Label1.backgroundColor = [UIColor clearColor];
        Label1.textColor = [UIColor whiteColor];
        Label1.text = @"人脉热度上升";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:Label1.text];
        [str addAttribute:NSForegroundColorAttributeName value:RGB(248, 231, 28)range:NSMakeRange(4, 2)];
        Label1.attributedText = str;
        Label1.textAlignment = NSTextAlignmentCenter;
        Label1.font = sysFont(15);
        [integralImageView addSubview:Label1];
        
        size = [IHUtility GetSizeByText:@"+10" sizeOfFont:15 width:200];
        UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 21)];
        Label2.top = Label1.top;
        Label2.right = daysLabel1.center.x - 5;
        Label2.backgroundColor = [UIColor clearColor];
        Label2.textColor = [UIColor whiteColor];
        Label2.text = @"+10";
        Label2.textAlignment = NSTextAlignmentCenter;
        Label2.font = sysFont(15);
        [integralImageView addSubview:Label2];

        UIImageView *Label3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        Label3.center = CGPointMake(0, Label2.center.y);
        Label3.right = Label2.left - 5;
        Label3.image = [UIImage imageNamed:@"glod.png"];
        [integralImageView addSubview:Label3];
        
        size = [IHUtility GetSizeByText:@"积分" sizeOfFont:15 width:100];
        UILabel *Label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 21)];
        Label4.top = Label1.top;
        Label4.right = Label3.left - 3;
        Label4.backgroundColor = [UIColor clearColor];
        Label4.textColor = [UIColor whiteColor];
        Label4.text = @"积分";
        Label4.textAlignment = NSTextAlignmentCenter;
        Label4.font = sysFont(15);
        [integralImageView addSubview:Label4];
        
        size = [IHUtility GetSizeByText:@"完成积分任务  提升人脉热度" sizeOfFont:15 width:200];
        UILabel *Label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 24)];
        Label5.center = CGPointMake(integralImageView.center.x, 0)  ;
        Label5.bottom = integralImageView.height - 11;
        Label5.backgroundColor = RGBA(232, 121, 117, 1);
        Label5.textColor = [UIColor whiteColor];
        Label5.text = @"完成积分任务  提升人脉热度";
        Label5.layer.cornerRadius = 9.0;
        Label5.layer.masksToBounds = YES;
        Label5.textAlignment = NSTextAlignmentCenter;
        Label5.font = sysFont(15);
//        [integralImageView addSubview:Label5];

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, integralImageView.bottom +30, 150, 38)];
        btn.centerX = self.width/2.0;
        [btn setTitle:@"更多积分任务" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = sysFont(13);
        btn.layer.cornerRadius = 19.0;
        btn.backgroundColor = RGB(6, 193, 174);
        self.integBtn = btn;
        
        [btn addTarget:self action:@selector(integerVC:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)integerVC:(UIButton *)button
{
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    self.selectBtnBlock(SelectBtnBlock);
}
@end
