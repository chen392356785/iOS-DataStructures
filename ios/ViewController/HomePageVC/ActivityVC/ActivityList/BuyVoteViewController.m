//
//  BuyVoteViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/15.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "BuyVoteViewController.h"
#import "PayTypeConstants.h"
#import "NumberCalculate.h"

@interface BuyVoteViewController () {
    UILabel *moneyLab;
    BOOL APayShow;      //是否要显示支付
    NSString *type;
    NSString *picNum;
}

@end

@implementation BuyVoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买选票";
    [self createSubView];
    picNum = @"1";
}

- (void) createSubView {
    
    UILabel *LineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 1)];
    LineLab.backgroundColor = kColor(@"#E5E5E5");
    [self.view addSubview:LineLab];
    
    UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(kWidth(12), kWidth(14), kWidth(98), kWidth(98))];
    imageView.image=defalutHeadImage;
    [self.view addSubview:imageView];
     [imageView setImageAsyncWithURL:self.model.head_image placeholderImage:defalutHeadImage];
    
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + kWidth(17), imageView.top, iPhoneWidth - imageView.right - kWidth(17), imageView.height/2)];
    titleLab.textColor = kColor(@"#333333");
    titleLab.font = darkFont(font(17));
    titleLab.numberOfLines = 2;
    titleLab.text = self.votoTitle;
    [self.view addSubview:titleLab];
    [titleLab sizeToFit];
    
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + kWidth(17), titleLab.bottom, iPhoneWidth - imageView.right - kWidth(17), kWidth(15))];
    infoLab.textColor = kColor(@"#333333");
    infoLab.font = RegularFont(font(14));
    infoLab.text = [NSString stringWithFormat:@"一元 = %@张选票",self.model.times];
    [self.view addSubview:infoLab];
    
    
    
    LineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + kWidth(14), iPhoneWidth, 1)];
    LineLab.backgroundColor = kColor(@"#E5E5E5");
    [self.view addSubview:LineLab];
    
    UILabel *NumLab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, LineLab.bottom + kWidth(21), iPhoneWidth/2, kWidth(20))];
    NumLab.textColor = kColor(@"#333333");
    NumLab.font = RegularFont(font(16));
    NumLab.text = @"购买金额";
    [self.view addSubview:NumLab];
    
    NumberCalculate *number=[[NumberCalculate alloc]initWithFrame:CGRectMake(iPhoneWidth - kWidth(110) -kWidth(12), LineLab.bottom + kWidth(12), kWidth(110), kWidth(34))];
    number.baseNum=@"1";
    number.multipleNum=1;//数值增减基数（倍数增减） 默认1的倍数增减
    number.minNum=1;
    number.maxNum = 99999;//最大值
    [self.view addSubview:number];
    number.numborderColor = kColor(@"#757575");
    number.resultNumber = ^(NSString *number) {
        self->picNum = number;
        self->moneyLab.text = [NSString stringWithFormat:@"合计金额： %.2f",[number floatValue]];
        self->moneyLab.attributedText = [IHUtility changePartTextColor:self->moneyLab.text range:NSMakeRange(6, self->moneyLab.text.length-6) value:kColor(@"#E70000")];
    };
    
    UILabel *LineLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, LineLab.bottom + kWidth(57), iPhoneWidth, 1)];
    LineLab2.backgroundColor = kColor(@"#E5E5E5");
    [self.view addSubview:LineLab2];
    
    UILabel *buyInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left ,LineLab2.bottom + kWidth(23), iPhoneWidth - 2 * LineLab2.left, kWidth(25))];
    buyInfoLab.text = @"购买须知：";
    buyInfoLab.textColor = kColor(@"#E70000");
    buyInfoLab.font = RegularFont(font(16));
    [self.view addSubview:buyInfoLab];
    
    UILabel *disLab = [[UILabel alloc] initWithFrame:CGRectMake(buyInfoLab.left, buyInfoLab.bottom+kWidth(10), buyInfoLab.width, kWidth(25))];
    disLab.text = self.model.buyNote;
    disLab.numberOfLines = 0;
    disLab.textColor = kColor(@"#E70000");
    disLab.font = RegularFont(font(14));
    [self.view addSubview:disLab];
    [disLab sizeToFit];
    
    
    UILabel *line3 =  [[UILabel alloc] initWithFrame:CGRectMake(0, iPhoneHeight - kWidth(50) - KtopHeitht , iPhoneWidth, 1)];
    line3.backgroundColor = kColor(@"#E5E5E5");
    [self.view addSubview:line3];
    
    UILabel *picLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), line3.bottom+kWidth(18), iPhoneWidth - kWidth(120), kWidth(18))];
    picLab.text = self.model.buyNote;
    moneyLab = picLab;
    picLab.textColor = kColor(@"#333333");
    picLab.font = RegularFont(font(17));
    [self.view addSubview:picLab];
    NSString *pic = @"1";
    picLab.text = [NSString stringWithFormat:@"合计金额： %.2f",[pic floatValue]];
     picLab.attributedText = [IHUtility changePartTextColor:picLab.text range:NSMakeRange(6, picLab.text.length-6) value:kColor(@"#E70000")];
    
    UIButton *payBut = [UIButton buttonWithType:UIButtonTypeSystem];
    payBut.frame = CGRectMake(iPhoneWidth - kWidth(104), line3.bottom, kWidth(104), kWidth(50));
    payBut.backgroundColor = kColor(@"#05C1B0");
    [payBut setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    payBut.titleLabel.font = RegularFont(font(17));
    [self.view addSubview:payBut];
    [payBut addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void) payAction {
    NSString *userID;
    if (!USERMODEL.isLogin) {
        //        userID = @"0";
        //登录
        [self prsentToLoginViewController];
        return;
    } else
    {
        userID = USERMODEL.userID;
    }

    NSDictionary *dict = @{
                           @"userId"      :userID,
                           @"activitiesId":self.ActiviModel.activities_id,
                           @"money"       :picNum
                            };
    [network httpRequestTagWithParameter:dict method:@"vote/getVoteOrder" tag:IH_init success:^(NSDictionary * dic) {
        [self removeWaitingView];
        NSDictionary *OrdDic = dic[@"content"];
        CGFloat Npic = [self->picNum floatValue] *100;
        NSString *price = [NSString stringWithFormat:@"%.f",Npic];
        [self GoSelectPlayPaymentOrderNO:OrdDic[@"vodeOrderNo"] OrderPrice:price];
//        [self GoSelectPlayPaymentOrderNO:OrdDic[@"vodeOrderNo"] OrderPrice:OrdDic[@"money"]];
    } failure:^(NSDictionary * dic) {
        [self removeWaitingView];
    }];
}
- (void) GoSelectPlayPaymentOrderNO:(NSString *)orderNo OrderPrice:(NSString *)orderPrice {
    ApliayView *alipayView = [[ApliayView alloc] initWithFrame:self.view.window.bounds];
    alipayView.top = kScreenHeight;
    APayShow=YES;
    alipayView.selectBlock = ^(NSInteger index){
        if (index == ENT_top) {
            self->type = @"1";
            self.payType = [NSString stringWithFormat:@"%d",WEICHAT_TYPE];
            [self referAlipayOrderNo:orderNo andPic:orderPrice];
        }else if (index == ENT_midden){
            //锁定众筹
            self->type = @"1";
            //            [self lockCrowd];
            self.payType = [NSString stringWithFormat:@"%d",AlIPAY_TYPE];
            [self referAlipayOrderNo:orderNo andPic:orderPrice];
        }
    };
    
    [self.view.window addSubview:alipayView];
    
    [UIView animateWithDuration:.5 animations:^{
        alipayView.top = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            alipayView.backgroundColor = RGBA(0, 0, 0, 0.3);
            self->APayShow=NO;
        }];
    }];
}
- (void)referAlipayOrderNo:(NSString *)OrderNo andPic:(NSString *)pic
{
    [[PayMentMangers manager] payment:OrderNo orderPrice:pic type:self.payType subject:self.ActiviModel.activities_titile activitieID:self.ActiviModel.activities_id parentVC:self resultBlock:^(BOOL isPaySuccess, NSString *msg) {
        if (isPaySuccess) {
//            [self addSucessView:@"支付成功！" type:1];
            BuySuccesVoteViewController *sucVc = [[BuySuccesVoteViewController alloc] init];
            [self pushViewController:sucVc];
        }
    }];

}
@end








@implementation BuySuccesVoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投票活动";
    [self createSubView];
}
- (void) createSubView {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(129), kWidth(56), kWidth(22), kWidth(22))];
    imageV.image = kImage(@"d_succes_img");
    [self.view addSubview:imageV];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(imageV.right+ kWidth(9), imageV.top,iPhoneWidth - imageV.right - kWidth(12), imageV.height)];
    lab.text = @"支付成功！";
    lab.textColor = kColor(@"#333333");
    [self.view addSubview:lab];
    lab.font = darkFont(font(18));
    
    UIButton *backHomeBut = [UIButton buttonWithType:UIButtonTypeSystem];
    backHomeBut.frame = CGRectMake(kWidth(53), lab.bottom + kWidth(70), kWidth(269), kWidth(42));
    backHomeBut.backgroundColor = kColor(@"#05C1B0");
    backHomeBut.centerX = iPhoneWidth/2.;
    backHomeBut.layer.cornerRadius = kWidth(5);
    [backHomeBut setTitle:@"返回活动首页" forState:UIControlStateNormal];
    [backHomeBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    backHomeBut.titleLabel.font = RegularFont(font(17));
    [self.view addSubview:backHomeBut];
    [backHomeBut addTarget:self action:@selector(backHomeAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) backHomeAction {
    NSArray *ViewControllers= self.navigationController.viewControllers;
    [self popViewController:(int)(ViewControllers.count - 3)];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationVoteAction object:nil];
}
- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationVoteAction object:nil];
}
@end
