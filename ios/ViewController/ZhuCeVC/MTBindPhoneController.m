//
//  MTBindPhoneController.m
//  MiaoTuProjectTests
//
//  Created by Tomorrow on 2018/6/12.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTBindPhoneController.h"
//#import "keychainItemManager.h"

@interface MTBindPhoneController () <UITextViewDelegate,UITextFieldDelegate>
{
    IHTextField *_passWordText;
    IHTextField *_phoneText;
    IHTextField *_oldPassWordTextFeild;
    IHTextField *_newPassWordTextFeild;
    BOOL isHiddenPW;
     int channel;
    
}
@end

@implementation MTBindPhoneController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号码";
    self.view.backgroundColor = [UIColor whiteColor];
   [self showLoginView];
}

-(void)showLoginView
{
    UIImage *image=Image(@"bg.png");
    self.view.layer.contents = (id) image.CGImage;    // 如果需要背景透明加上下面这句
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    UIView *centerView=[[UIView alloc]init];
    centerView.tag=1006;
    centerView.frame=CGRectMake(15, 50, WindowWith-30, (WindowWith -30)*0.62);
    [self.view addSubview:centerView];
    
    SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(CGRectGetWidth(centerView.frame)/2-70, 10, 150, 30) textColor:RGB(8, 206, 199) textFont:sysFont(17)];
    label.text=@"绑定手机号码";
    label.textAlignment=NSTextAlignmentLeft;
    // label.centerX=loginView.centerX;
    [centerView addSubview:label];
    
    //手机号码文本框
    _phoneText=[[IHTextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame)+10, CGRectGetWidth(centerView.frame)-20, (CGRectGetWidth(centerView.frame)-20)*0.13)];
    
    _phoneText.borderStyle=UITextBorderStyleRoundedRect;
    _phoneText.delegate=self;
    [centerView addSubview:_phoneText];
    UIView *phoneLeftview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_phoneText.frame)*0.115, CGRectGetHeight(_phoneText.frame))];
    UIImage *phoneImg=Image(@"mobilebig.png");
    UIImageView *phoneLeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, phoneImg.size.width, phoneImg.size.height)];
    phoneLeftImageView.image=phoneImg;
    [phoneLeftview addSubview:phoneLeftImageView];
    phoneLeftImageView.center=phoneLeftview.center;
    _phoneText.placeholder=@"请输入手机号码";
    _phoneText.leftView=phoneLeftview;
    _phoneText.leftViewMode=UITextFieldViewModeAlways;
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    
    //密码文本框
    _passWordText=[[IHTextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_phoneText.frame)+10, CGRectGetWidth(_phoneText.frame)*0.63, CGRectGetHeight(_phoneText.frame))];
    _passWordText.secureTextEntry=YES;
    _passWordText.borderStyle=UITextBorderStyleRoundedRect;
    _passWordText.delegate=self;
    [centerView addSubview:_passWordText];
    
    UIView *passWordLeftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_phoneText.frame)*0.115, CGRectGetHeight(_passWordText.frame))];
    UIImage *passImg=Image(@"messageselect.png");
    UIImageView *passWordLeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, passImg.size.width, passImg.size.height)];
    passWordLeftImageView.image=passImg;
    [passWordLeftView addSubview:passWordLeftImageView];
    
    passWordLeftImageView.center=passWordLeftView.center;
    _passWordText.placeholder=@"请输入短信验证码";
    _passWordText.secureTextEntry=NO;
    _passWordText.leftView=passWordLeftView;
    _passWordText.leftViewMode=UITextFieldViewModeAlways;
    _passWordText.keyboardType = UIKeyboardTypeNumberPad;
    
    //登录按钮
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.backgroundColor=cGrayLightColor;
    self.loginBtn.layer.cornerRadius=3;
    
    [self.loginBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font=sysFont(14);
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.frame=CGRectMake(CGRectGetMaxX(_passWordText.frame), CGRectGetMaxY(_phoneText.frame)+10, CGRectGetWidth(_phoneText.frame)-CGRectGetWidth(_passWordText.frame), CGRectGetHeight(_passWordText.frame));
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:self.loginBtn];
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame=CGRectMake(centerView.width*0.1, self.loginBtn.bottom+0.026*WindowWith, centerView.width*0.3, 40);
    [backBtn setTintColor:cGrayLightColor];
    backBtn.backgroundColor=[UIColor whiteColor];
    [backBtn setTitle:@"返 回" forState:UIControlStateNormal];
    // 按钮边框宽度
    [backBtn setLayerMasksCornerRadius:4.5 BorderWidth:1 borderColor:cGrayLightColor];
    backBtn.layer.cornerRadius=5;
    backBtn.clipsToBounds=YES;
    [backBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:backBtn];
    
    //确定
    
    UIButton *certainBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTintColor:[UIColor whiteColor]];
    [certainBtn setTitle:@"确 定" forState:UIControlStateNormal];
    certainBtn.backgroundColor=cGreenColor;
    certainBtn.layer.cornerRadius=5;
    certainBtn.clipsToBounds=YES;
    certainBtn.frame=CGRectMake(backBtn.right+20, backBtn.top, centerView.width*0.4, backBtn.height);
    certainBtn.layer.cornerRadius=3;
    [certainBtn addTarget:self action:@selector(certain) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:certainBtn];
    
    
}
-(void)certain
{
    if (_phoneText.text.length==0) {
        [IHUtility AlertMessage:@"错误" message:@"请输入手机号"];
        return;
    }
    [self addWaitingView];
    if (self.errorLogNO == 1401) {      //新用户
         SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager loadImageWithURL:[NSURL URLWithString:self.headIconUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            
            if (image) {
                [AliyunUpload uploadImage:@[image] FileDirectory:ENT_fileImageHeader success:^(NSString *obj) {
					[network NewGetUserPhoneNumber:self.UserID code:self->_passWordText.text phone:self->_phoneText.text WXName:self.WXName WXIcon:obj success:^(NSDictionary *obj) {
                        [self addSucessView:@"手机号绑定成功^_^" type:1];
                        [self removeWaitingView];
                        NSDictionary *dic=[obj objectForKey:@"content"];
                        NSString *hxName = dic[@"hx_user_name"];
                        NSString *hxpassword  =dic[@"hx_password"];
                        self.NewSelectSurnBlock(YES, hxName, hxpassword,dic);
                    }];
                }];
            }
            else {
				[network NewGetUserPhoneNumber:self.UserID code:self->_passWordText.text phone:self->_phoneText.text WXName:self.WXName WXIcon:self.headIconUrl success:^(NSDictionary *obj) {
                    [self addSucessView:@"手机号绑定成功^_^" type:1];
                    [self removeWaitingView];
                    NSDictionary *dic=[obj objectForKey:@"content"];
                    NSString *hxName = dic[@"hx_user_name"];
                    NSString *hxpassword  =dic[@"hx_password"];
                    self.NewSelectSurnBlock(YES, hxName, hxpassword,dic);
                }];
            }
        }];
        
    }else {
        [network OldGetUserPhoneNumber:[self.UserID intValue]code:_passWordText.text phone:_phoneText.text success:^(NSDictionary *obj) {
            [self addSucessView:@"手机号绑定成功^_^" type:1];
            [self removeWaitingView];
            NSDictionary *dic=[obj objectForKey:@"content"];
            self.SelectSurnBlock(YES,dic);
        }];
    }
}

//验证
-(void)login {
    if (_phoneText.text.length==0) {
        [IHUtility AlertMessage:@"错误" message:@"请输入手机号"];
        return;
    }
    if ( ![IHUtility isValidateMobile:_phoneText.text]) {
        [IHUtility AlertMessage:@"错误" message:@"请输入正确的手机号"];
        return;
    }
    [self addWaitingView];
    int  type;
    if (self.errorLogNO == 1401) {
        type = 7;
    }else {
        type = 4;
    }
    [network getSendRegisterSms:_phoneText.text type:type chanle:channel  success:^(NSDictionary *obj) {
		self->channel++;
        [self removeWaitingView];
        [self addSucessView:@"验证码发送成功，请耐心等待哦^_^" type:1];
        [ConfigManager countdownSecond:60  returnTitle:^(NSString *title)
         {
             
             if (ConfigManager.seconds>0) {
                 [self.loginBtn setTitle:title forState:UIControlStateNormal];
                 self.loginBtn.userInteractionEnabled = NO;
             }
             else
             {
                 [self.loginBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                 self.loginBtn.userInteractionEnabled = YES;
             }
         }];
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phoneText && range.location>=11) {
        return NO;
    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    return YES;
}
- (void) hideView {
    if (self.errorLogNO != 1401) {
         [self dismissViewControllerAnimated:YES completion:nil];
    }else {
         [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void) back:(UIButton *)backBut {
    [self hideView];
}

@end
