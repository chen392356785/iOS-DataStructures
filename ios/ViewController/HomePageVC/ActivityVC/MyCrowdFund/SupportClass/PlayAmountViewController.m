//
//  PlayAmountViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/4.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "PlayAmountViewController.h"
#import "PayTypeConstants.h"
//#import "ActivityPaySuccessfulViewController.h"
#import "MyCrowdFundController.h"

@interface PlayAmountViewController () <UITextFieldDelegate> {
    IHTextField *_textFied;
    NSString *PicStr;   //最多可支付金额
    BOOL APayShow;      //是否要显示支付
    NSString *type;
    IHTextField *textView;  //评论
    UIButton *playBut;
    UILabel *ifoLabel;
    NSString *message;  //评论内容
}

@end
#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

@implementation PlayAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    message = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.model.infoModel.activities_titile;
    UILabel *LineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 1.)];
    LineLabel.backgroundColor = cLineColor;
    [self.view addSubview:LineLabel];
    
    UILabel *contLabel= [[UILabel alloc] init];
    contLabel.text = @"请输入金额（元）";
    contLabel.font = sysFont(font(14));
    contLabel.textColor = kColor(@"#333333");
    contLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:contLabel];
    [contLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(1);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(kWidth(12));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(47));
    }];
    
    UILabel *symbolLael = [[UILabel alloc] init];
    symbolLael.text = @"￥";
    symbolLael.textColor = kColor(@"#333333");
    symbolLael.font = sysFont(font(32));
    [self.view addSubview:symbolLael];
    [symbolLael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(kWidth(19));
        make.top.mas_equalTo(contLabel.mas_bottom).mas_offset(kWidth(19));
        make.height.mas_offset(kWidth(48));
        make.width.mas_offset(kWidth(33));
    }];
    
    _textFied = [[IHTextField alloc] init];
    [_textFied becomeFirstResponder];
    _textFied.font = sysFont(font(32));
    _textFied.textColor = kColor(@"333333");
    _textFied.keyboardType = UIKeyboardTypeDecimalPad;
    _textFied.delegate = self;
    [self.view addSubview:_textFied];
    [_textFied mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(symbolLael.mas_right).mas_offset(kWidth(3));
        make.top.mas_equalTo(symbolLael.mas_top);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(kWidth(-12));
        make.height.mas_equalTo(symbolLael);
    }];
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = cLineColor;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(kWidth(12));
        make.top.mas_equalTo(self->_textFied.mas_bottom).mas_offset(3);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-12);
        make.height.mas_offset(1);
    }];
    
    ifoLabel= [[UILabel alloc] init];
    PicStr = [NSString stringWithFormat:@"%.2f",self.model.infoModel.total_money - self.model.infoModel.obtain_money];
    ifoLabel.text = [NSString stringWithFormat:@"最多可支持剩余金额%@元",PicStr];
    ifoLabel.font = sysFont(font(14));
    ifoLabel.textColor = kColor(@"#333333");
    ifoLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:ifoLabel];
    [ifoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).mas_offset(3);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(kWidth(12));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(48));
    }];
    
    [self.view layoutIfNeeded];
    
    textView = [[IHTextField alloc]init];
    textView.layer.cornerRadius = 4;
    _textFied.delegate = self;
    textView.layer.borderColor = cLineColor.CGColor;
    textView.layer.borderWidth = 1;
    textView.font = sysFont(font(13));
    textView.placeholder = @" 评价";
    [self.view addSubview:textView];
    if ([self.isSupport isEqualToString:@"1"]) {
        textView.frame = CGRectMake(minX(ifoLabel), maxY(ifoLabel), iPhoneWidth - 2*minX(ifoLabel), kWidth(45));
    }else {
        textView.frame = CGRectMake(minX(ifoLabel), maxY(ifoLabel), iPhoneWidth - 2*minX(ifoLabel), kWidth(0));
    }
    
    playBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [playBut setTitle:@"立即支付" forState:UIControlStateNormal];
    playBut.backgroundColor = kColor(@"#05c1b0");
    [playBut setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
    playBut.layer.cornerRadius = 5;
    playBut.titleLabel.font = sysFont(font(17));
    [self.view addSubview:playBut];
    [playBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->textView.mas_bottom).mas_offset(28);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(kWidth(12));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(48));
    }];
    [playBut addTarget:self action:@selector(goPlaySupport) forControlEvents:UIControlEventTouchUpInside];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)      string {
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        // 判断字符串中是否有小数点，并且小数点不在第一位
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        if (dotLocation == NSNotFound && range.location != 0) {
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
            if (range.location >= 9) {
                NSLog(@"单笔金额不能超过亿位");
                if ([string isEqualToString:@"."] && range.location == 9) {
                    return YES;
                }
                return NO;
            }
        }else {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        }
        // 按cs分离出数组,数组按@""分离出字符串
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            NSLog(@"只能输入数字和小数点");
            return NO;
        }
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
            NSLog(@"小数点后最多两位");
            return NO;
        }
        if (textField.text.length > 11) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - 支付
- (void) goPlaySupport {
    [_textFied resignFirstResponder];
    if ([_textFied.text floatValue] > [PicStr floatValue]) {
        [self showTextHUD:@"输入金额不能大于剩余支付金额"];
//         [self addSucessView:[NSString stringWithFormat:@"输入金额不能大于剩余支付金额"] type:2];
        return;
    }
    if ([_textFied.text floatValue] <= 0.00) {
        [self showTextHUD:@"输入金额错误"];
//        [self addSucessView:[NSString stringWithFormat:@"输入金额错误"] type:2];
        return;
    }
    [self addWaitingView];
    NSDictionary *dict;
    if ([self.isSupport isEqualToString:@"1"]) {
        message = textView.text;
        dict = @{
                 @"c"         : [NSString stringWithFormat:@"%ld",self.model.infoModel.crowd_id],
                 @"headimgurl": USERMODEL.userHeadImge,
                 @"nickname"  : USERMODEL.nickName,
                 @"openid"    : USERMODEL.userID,
                 @"pay_money" :_textFied.text,
                 @"message"   : message,
                 };
    }else {
        dict = @{
                 @"c"         : [NSString stringWithFormat:@"%ld",self.model.infoModel.crowd_id],
                 @"headimgurl": USERMODEL.userHeadImge,
                 @"nickname"  : USERMODEL.nickName,
                 @"openid"    : USERMODEL.userID,
                 @"pay_money" :_textFied.text,
                 };
    }
    [network httpRequestTagWithParameter:dict method:@"CrowdActivity/getPrepay" tag:IH_init success:^(NSDictionary * dic) {
        [self removeWaitingView];
        NSDictionary *OrdDic = dic[@"content"];
        self.ActiModel.order_no = OrdDic[@"order_no"];
        self.ActiModel.uploadtime = OrdDic[@"create_time"];
        CGFloat Npic = [self->_textFied.text floatValue] *100;
        self.ActiModel.payment_amount = stringFormatDouble(Npic);
        [self GoSelectPlayPaymentOrderNO:OrdDic[@"order_no"] OrderPrice:OrdDic[@"pay_amount"]];
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
            //锁定众筹
            self->type = @"1";
//            [self lockCrowd];
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

- (void)lockCrowd {
    [network getlockCrowd:type crowd_id:[NSString stringWithFormat:@"%ld",self.model.infoModel.crowd_id] success:^(NSDictionary *obj) {
        if ([self->type isEqualToString:@"1"]) {
//            [self referAlipay];
        }
    }failure:^(NSDictionary *obj2) {
        [self addSucessView:@"系统繁忙，请稍后再试!" type:2];
    }];
}

- (void)referAlipayOrderNo:(NSString *)OrderNo andPic:(NSString *)pic
{
    CGFloat Npic = [_textFied.text floatValue] *100;
    NSString *price = [NSString stringWithFormat:@"%.f",Npic];
    [[PayMentMangers manager] payment:OrderNo orderPrice:price type:self.payType subject:self.model.selectActivitiesListInfo.activities_titile activitieID:self.model.selectActivitiesListInfo.activities_id parentVC:self resultBlock:^(BOOL isPaySuccess, NSString *msg) {
        if (isPaySuccess) {
            [self addSucessView:@"支付成功！" type:1];
            [self pushToPaySuccessfulVC];
            if ([self.isSupport isEqualToString:@"1"]) {    //给他支持发送微信模板
                [self SendWechatTemplate:OrderNo addActivite:self.model.selectActivitiesListInfo.activities_id];
            }
        }
    }];
}
//支付完成

- (void)pushToPaySuccessfulVC{
    MyCrowdFundController *vc=[[MyCrowdFundController alloc]init];
    vc.Type = @"2";
    NSString *crowID = self.ActiModel.crowd_id;
    if (crowID == nil) {
        crowID = stringFormatInt(self.model.infoModel.crowd_id);
    }
    vc.crowdID = crowID;
    if (self.model.orderInfoModel.user_id != [USERMODEL.userID integerValue]) {
        vc.CFType = OtherPeoPleCrowdFundType;
    }else {
         vc.CFType = MyCrowdFundType;
    }
    vc.isPopVc = @"2";
    [self pushViewController:vc];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:self.indexPath];
}
//- (void)pushToPaySuccessfulVC{
//    ActivityPaySuccessfulViewController *vc=[[ActivityPaySuccessfulViewController alloc]init];
//    vc.indexPath = self.indexPath;
//    vc.model = self.ActiModel;
//    [self pushViewController:vc];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:self.indexPath];
//}
- (void) SendWechatTemplate:(NSString *)orderNo addActivite:(NSString *)activitID{
    NSString *activitPath = [NSString stringWithFormat:@"pages/activity/detail/detail?activitiesId=%@",activitID];
    NSDictionary *dict = @{
                           @"template_id" :  @"0VxuLjqm0-kwsD20OTZqhH3vUC64c9P7fOIkjYXV8zU",
                           @"page"        :  activitPath,
                           @"appid"       :  WXXCXappId,
                           @"appsecret"   :  WXXCXappSecret,
                           @"orderNo"     :  orderNo,
                           };
    [network httpGETRequestTagWithParameter:dict method:SendTemplateUrl tag:IH_init success:^(NSDictionary *obj) {
       
    } failure:^(NSDictionary *obj) {
        
    }];
}
@end
