//
//  InviteCodeViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/15.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "InviteCodeViewController.h"

@interface InviteCodeViewController (){
    IHTextField *_inputCodeTf;
}

@end

@implementation InviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleName;
    
    
    self.view.backgroundColor = kColor(@"#FFFFFF");
    [self createOrAddSbuview];
}
- (void) createOrAddSbuview {
    UIImageView *topImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(28), kWidth(122), kWidth(122))];
    topImgV.centerX = iPhoneWidth/2;
    [self.view addSubview:topImgV];
    topImgV.image = kImage(@"img_yqm");
    IHTextField *inputTf = [[IHTextField alloc] initWithFrame:CGRectMake(0, topImgV.bottom + kWidth(25), kWidth(342), kWidth(45))];
    inputTf.layer.cornerRadius = inputTf.height/2;
    inputTf.layer.borderColor = kColor(@"#DCDCDC").CGColor;
    inputTf.layer.borderWidth = 1;
    [self.view addSubview:inputTf];
    _inputCodeTf = inputTf;
    if ([self.typeStr isEqualToString:@"1"]) {
        inputTf.placeholder = @"输入好友邀请码";
    }else if ([self.typeStr isEqualToString:@"2"]) {
        inputTf.placeholder = @"请输入兑换码";
    }
    inputTf.textAlignment = NSTextAlignmentCenter;
    inputTf.font = darkFont(16);
    inputTf.centerX = topImgV.centerX;
    _inputCodeTf.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UIButton *getinvitaBut = [UIButton buttonWithType:UIButtonTypeSystem];
    getinvitaBut.frame = inputTf.frame;
    getinvitaBut.origin = CGPointMake(getinvitaBut.left, inputTf.bottom + kWidth(40));
    [self.view addSubview:getinvitaBut];
    getinvitaBut.backgroundColor = kColor(@"#05C1B0");
    getinvitaBut.layer.cornerRadius = getinvitaBut.height/2.;
    if ([self.typeStr isEqualToString:@"1"]) {
         [getinvitaBut setTitle:@"马上提交" forState:UIControlStateNormal];
    }else if ([self.typeStr isEqualToString:@"2"]) {
        [getinvitaBut setTitle:@"立即兑换" forState:UIControlStateNormal];
    }
    [getinvitaBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    getinvitaBut.titleLabel.font = darkFont(font(16));
    [getinvitaBut addTarget:self action:@selector(getInvitationAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.typeStr isEqualToString:@"2"]) {
        return;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(getinvitaBut.left, getinvitaBut.bottom + kWidth(73), getinvitaBut.width, kWidth(13))];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"温馨提示" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName:kColor(@"#444343")}];
    label.attributedText = string;
    [self.view addSubview:label];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(label.left,label.bottom + kWidth(21),label.width,117);
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"1.下载软件后的10天内可输入邀请码，超过时间不能输入。\n2.一个手机只能输入一次邀请码。已输入过邀请码的手机，切换账号也无法输入其他邀请码。\n3.如有疑问可联系客服咨询。" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName: kColor(@"#898888")}];
        label1.attributedText = string1;
    [label1 sizeToFit];
}

- (void) getInvitationAction {
    if (_inputCodeTf.text.length <= 0) {
        return;
    }
    [_inputCodeTf resignFirstResponder];
    NSLog(@"兑换码 == %@",_inputCodeTf.text);
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    if ([self.typeStr isEqualToString:@"1"]) {
        [self submitYaoqignCode];
    }else if ([self.typeStr isEqualToString:@"2"]) {
        [self submitDuiHuanCode];
    }
   
}
//提交邀请码
- (void) submitYaoqignCode {
    NSString *userID = @"";
    userID = USERMODEL.userID;
    NSDictionary *dic = @{
                          @"userId"            : userID,
                          @"shareInviteCode"   : _inputCodeTf.text,
                          };
    [network httpRequestWithParameter:dic method:partnerCodeUrl success:^(NSDictionary *obj) {
        [IHUtility addSucessView:@"领取成功" type:1];
        
    } failure:^(NSDictionary * obj) {
        
    }];
}
//提交兑换码
- (void) submitDuiHuanCode {
    NSString *userID = @"";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    userID = USERMODEL.userID;
    NSDictionary *dic = @{
                          @"userId"     : userID,
                          @"cardCode"   : _inputCodeTf.text,
                          };
    [network httpRequestWithParameter:dic method:bindCardeUrl success:^(NSDictionary *obj) {
        [IHUtility addSucessView:@"兑换成功" type:1];

    } failure:^(NSDictionary * obj) {
        
    }];
    
}
@end
