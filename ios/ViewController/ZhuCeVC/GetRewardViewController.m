//
//  GetRewardViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/14.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "GetRewardViewController.h"

@interface GetRewardViewController () {
    IHTextField *_inputCodeTf;
}

@end

@implementation GetRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBarHidden = true;
    leftbutton.hidden = YES;
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    UIImage *image = kImage(@"login_getReward_img");
    self.view.layer.contents = (id) image.CGImage;    // 如果需要背景透明加上下面这句
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    [self addSubiews];
   
}
- (void) addSubiews {
    UIButton *NoinvitaBut = [UIButton buttonWithType:UIButtonTypeSystem];
    NoinvitaBut.frame = CGRectMake(kWidth(30), iPhoneHeight - kWidth(40) - kWidth(44) - KTabSpace, iPhoneWidth - kWidth(60) , kWidth(44));
    [self.view addSubview:NoinvitaBut];
    NoinvitaBut.backgroundColor = kColor(@"#FFD767");
    NoinvitaBut.layer.cornerRadius = NoinvitaBut.height/2.;
    [NoinvitaBut setTitle:@"无邀请码跳过" forState:UIControlStateNormal];
    [NoinvitaBut setTitleColor:kColor(@"#8B0005") forState:UIControlStateNormal];
    NoinvitaBut.titleLabel.font = darkFont(font(17));
    [NoinvitaBut addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *getinvitaBut = [UIButton buttonWithType:UIButtonTypeSystem];
    getinvitaBut.frame = CGRectMake(kWidth(30), NoinvitaBut.top - kWidth(15) - kWidth(44), iPhoneWidth - kWidth(60), kWidth(44));
    [self.view addSubview:getinvitaBut];
    getinvitaBut.backgroundColor = kColor(@"#FFD442");
    getinvitaBut.layer.cornerRadius = NoinvitaBut.height/2.;
    [getinvitaBut setTitle:@"立即领取" forState:UIControlStateNormal];
    [getinvitaBut setTitleColor:kColor(@"#8B0005") forState:UIControlStateNormal];
    getinvitaBut.titleLabel.font = darkFont(font(17));
    [getinvitaBut addTarget:self action:@selector(getInvitationAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *CodeTiele = [[UILabel alloc] initWithFrame:CGRectMake(0, getinvitaBut.top - kWidth(42) - kWidth(32), iPhoneWidth/2. - kWidth(30), kWidth(32))];
    CodeTiele.text = @"好友邀请码:";
    CodeTiele.textColor = kColor(@"#FFFFFF");
    CodeTiele.textAlignment = NSTextAlignmentRight;
    CodeTiele.font = darkFont(font(18));
    [self.view addSubview:CodeTiele];
    
    _inputCodeTf = [[IHTextField alloc] initWithFrame:CGRectMake(CodeTiele.right + kWidth(3), CodeTiele.top, kWidth(134), CodeTiele.height)];
    _inputCodeTf.layer.borderColor = kColor(@"#FFFFFF").CGColor;
    _inputCodeTf.layer.borderWidth = 1.5;
    _inputCodeTf.font = darkFont(font(18));
    _inputCodeTf.textAlignment = NSTextAlignmentCenter;
    _inputCodeTf.textColor = kColor(@"#FFFFFF");
    _inputCodeTf.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:_inputCodeTf];
    
}

//无邀请码跳过
- (void) skipAction {
     [self dismissViewControllerAnimated:YES completion:nil];
}

//领取积分
- (void) getInvitationAction {
    if (_inputCodeTf.text.length <= 0) {
        return;
    }
    [_inputCodeTf resignFirstResponder];
    NSLog(@"兑换码 == %@",_inputCodeTf.text);
    NSString *userID = @"";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    userID = USERMODEL.userID;
    NSDictionary *dic = @{
                          @"userId"            : userID,
                          @"shareInviteCode"   : _inputCodeTf.text,
                          };
    [network httpRequestWithParameter:dic method:partnerCodeUrl success:^(NSDictionary *obj) {
        [IHUtility addSucessView:@"领取成功" type:1];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSDictionary * obj) {
        
    }];
}
@end
