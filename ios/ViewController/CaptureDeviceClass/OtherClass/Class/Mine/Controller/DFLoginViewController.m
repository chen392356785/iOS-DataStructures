//
//  DFLoginViewController.m
//  DF
//
//  Created by Tata on 2017/12/4.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFLoginViewController.h"
#import "DFLoginView.h"
#import "DFConstant.h"
#import "DFIdentifierConstant.h"

@interface DFLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) DFLoginView *loginView;

@property (nonatomic, strong) NSString *phoneCode;
@property (nonatomic, strong) NSString *phoneNumber;

@end

@implementation DFLoginViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [self configureView];
}

- (DFLoginView *)loginView {
    return (DFLoginView *)self.view;
}

#pragma mark - 配置页面
- (void)configureView {
    DFLoginView *loginView = [[DFLoginView alloc]init];
    self.view = loginView;
    
    DFNavigationView *navigationView = loginView.navigationView;
    [navigationView.forwardButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    [loginView.wechatButton addTarget:self action:@selector(wechatLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginView.sendCodeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    [loginView.voiceButton addTarget:self action:@selector(sendVoiceCode) forControlEvents:UIControlEventTouchUpInside];
    [loginView.loginButton addTarget:self action:@selector(phoneLogin) forControlEvents:UIControlEventTouchUpInside];
    
    loginView.phoneTextField.delegate = self;
    loginView.codeTextField.delegate = self;
}

#pragma mark - 微信登录
- (void)wechatLogin {
    /*/
    UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity * snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
            if (snsAccount != nil) {
                [DFTool addWaitingView:self.view];
                //微信登录成功后回调
                [HttpRequest postUserLoginWithLoginType:@"2" phone:@"" accessToken:snsAccount.openId headerImage:snsAccount.iconURL Id:@"" nick:snsAccount.userName genderType:@"0" userName:snsAccount.userName uagent:@"" signature:@"" success:^(NSDictionary * result) {
                     [DFTool removeWaitingView:self.view];

                    if (!TTValidateDictionary(result)) {
                        return ;
                    }
                    
                    if ([result[DFErrCode]integerValue] == 200) {
                        
                        NSDictionary *dic = result[DFData];
                        [self saveUserInfo:dic];
                    }
                    
                 } failure:^(NSError *error) {
                     [DFTool removeWaitingView:self.view];
                     if ([self.delegate respondsToSelector:@selector(loginFailure)])
                     {
                         [self.delegate loginFailure];
                     }
                     [DFTool showTips:nil];
                 }];
            }
        }
    });
//*/
}

#pragma mark - 发送验证码
- (void)sendCode {
    self.loginView.voiceButton.hidden = YES;
    
    self.phoneCode = @"";
    self.phoneNumber  = @"";
    
    if (self.loginView.phoneTextField.text.length == 0) {
        [DFTool showTips:DFSetPhoneString()];
        return;
    }
    
    [self.loginView.phoneTextField resignFirstResponder];
    
    //发送短信验证码
    NSString * numCode=[DFTool getVerificationCode:1000 to:10000];
    
    //短信验证码
    [HttpRequest postPhoneCodeWithPhoneNum:self.loginView.phoneTextField.text withPhoneCode:numCode withTime:[NSString stringWithFormat:@"%d",10] success:^(NSDictionary * result) {
         //短信验证码
         self.phoneCode= numCode;
         self.phoneNumber = self.loginView.phoneTextField.text;
//         [self.loginView.sendCodeButton startTime:60 title:DFSendCodeString() waitTittle:@"秒" waitTime:5 waitTimer:^(NSInteger time) {
//             
////             self.loginView.voiceButton.hidden = NO;
//             
//         } complete:^(BOOL finished) {
//             
//         }];
     } failure:^(NSString * message) {
         [self alertMessage:DFSorryString() message:message];
     }];
}

#pragma mark - 发送语音验证码
- (void)sendVoiceCode {
    [HttpRequest postPhoneVerifyCodeWithPhoneNum:self.phoneNumber andVerifyCode:self.phoneCode success:^(NSDictionary * result) {
         [DFTool showTips:DFVoiceSuccessString()];
     } failure:^(NSString *message) {
         [self alertMessage:DFSorryString() message:message];
     }];
}

#pragma mark - 手机号登录
- (void)phoneLogin {
    if ([self.loginView.phoneTextField.text isEqualToString:DFTestPhoneNumber])
    {
        [self testAccount];
        return;
    }
    
    if ([DFTool phone_CheckMobilePhoneValidate:self.loginView.phoneTextField.text] == NO)
    {
        return;
    }
    
    if (self.loginView.codeTextField.text.length == 0)
    {
        [DFTool showTips:DFSetCodeString()];
        return;
    }
    
    if (![self.loginView.codeTextField.text isEqualToString:self.phoneCode] || ![self.loginView.phoneTextField.text isEqualToString:self.phoneNumber])
    {
        [DFTool showTips:DFCodeErrorString()];
        return;
    }
    
    [DFTool addWaitingView:self.view];
    [HttpRequest postUserLoginWithLoginType:@"1" phone:self.loginView.phoneTextField.text accessToken:@"" headerImage:@"" Id:@"" nick:@"" genderType:@"" userName:@"" uagent:@"" signature:@"" success:^(NSDictionary *result) {
         [DFTool removeWaitingView:self.view];
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            
            NSDictionary *dic = result[DFData];
            [self saveUserInfo:dic];
        }
     } failure:^(NSError *error) {
         
         [DFTool showTips:DFLoginFailureString()];
     }];
}

#pragma mark - 测试账号登录
- (void)testAccount {
    if (![self.loginView.codeTextField.text isEqualToString:DFTestCodeNumber])
    {
        [DFTool showTips:DFCodeErrorString()];
        return;
    }
    
    [DFTool addWaitingView:self.view];
    [HttpRequest postUserLoginWithLoginType:@"1" phone:self.loginView.phoneTextField.text accessToken:@"" headerImage:@"" Id:@"" nick:@"" genderType:@"" userName:@"" uagent:@"" signature:@"" success:^(NSDictionary *result) {
         [DFTool removeWaitingView:self.view];
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            
            NSDictionary *dic = result[DFData];
            [self saveUserInfo:dic];
        }
     } failure:^(NSError *error) {
         if ([self.delegate respondsToSelector:@selector(loginFailure)])
         {
             [self.delegate loginFailure];
         }
         [DFTool showTips:DFNoNetworkString()];
     }];
}

#pragma mark - 保存用户数据
- (void)saveUserInfo:(NSDictionary *)dic {
    [DFTool saveUserInfo:dic];
    
    //登录成功
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessIdentifier object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
    [self dismissViewControllerAnimated:YES completion:^{
         if ([self.delegate respondsToSelector:@selector(loginSuccess)])
         {
             [self.delegate loginSuccess];
         }
     }];
}

#pragma mark - 关闭页面
- (void)closeView {
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 消息提示
- (void)alertMessage:(NSString *)title message:(NSString *)message {
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:DFSureString() otherButtonTitles:nil];
    [alert show];
}

#pragma mark --键盘的通知--
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30];
    self.view.frame=CGRectMake(0, - self.loginView.phoneTextField.y + DFStatusHeight, iPhoneWidth, iPhoneHeight);
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30];
    self.view.frame=CGRectMake(0, 0, iPhoneWidth, iPhoneHeight);
    [UIView commitAnimations];
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    //手机号改变了
    if ([self.loginView.phoneTextField isEqual:notification.object])
    {
        self.phoneCode = @"";
        self.phoneNumber = @"";
        self.loginView.voiceButton.hidden = YES;
        [self.loginView.sendCodeButton setTitle:DFSendCodeString() forState:UIControlStateNormal];
//        [self.loginView.sendCodeButton stopTime];
    }
    NSString * tele      = self.loginView.phoneTextField.text;
    NSString * checkCode = self.loginView.codeTextField.text;
    if (tele.length > 0 && checkCode.length > 0 )//&& self.argree)
    {
        self.loginView.loginButton.backgroundColor = THBaseColor;
        self.loginView.loginButton.userInteractionEnabled=YES;
    }
    else
    {
        self.loginView.loginButton.backgroundColor = THBtnBackgroundColor;
        self.loginView.loginButton.userInteractionEnabled=NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
