//
//  ZhuCeViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/18.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ZhuCeViewController.h"
//#import "PerfectInformationViewController.h"
#import "UserAgreementViewController.h"
#import "PerfectUserInformationViewController.h"
//#import "NSString+AES.h"
//#import "NSObject+GetIP.h"

@interface ZhuCeViewController()
{
    IHTextField *_phoneTextField;
    IHTextField *_messageTextField;
    IHTextField *_passWordTextField;
    UIButton *_vCodeBtn;
    int channel;
}
@end
@implementation ZhuCeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    channel=0;
    //  [self setTitle:@"注册"];
//    _BaseScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIImage *bkImg=[Image(@"bg.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bkImg];
    self.view.layer.contents = (id) bkImg.CGImage;    // 如果需要背景透明加上下面这句
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    _BaseScrollView.backgroundColor = [UIColor clearColor];
//    UIImageView *bkImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    bkImageView.image=bkImg;
//    bkImageView.backgroundColor = [UIColor clearColor];
//    bkImageView.userInteractionEnabled=YES;
//    [_BaseScrollView addSubview:bkImageView];
    
    UIImage *mtImg=Image(@"catchword.png");
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight*0.09, mtImg.size.width, mtImg.size.height)];
    imageView.tag=1008;
    imageView.centerX=self.view.centerX;
    imageView.image=mtImg;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+0.09*kScreenHeight, 108, 16) textColor:[UIColor whiteColor] textFont:sysFont(17)];
    //lbl.text=@"找回密码";
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.centerX=self.view.centerX;
    [self.view addSubview:lbl];
    
    if (self.type==ENT_register) {
        lbl.text=@"新用户注册";
    }else if(self.type==ENT_forget)
    {
        lbl.text=@"找回密码";
    }
    
    //手机号码
    _phoneTextField=[[IHTextField alloc]initWithFrame:CGRectMake(0.12*WindowWith, lbl.bottom+18, WindowWith-0.24*WindowWith, 42)];
    _phoneTextField.delegate=self;
    
    _phoneTextField.borderStyle=UITextBorderStyleNone;
    _phoneTextField.keyboardType=UIKeyboardTypePhonePad;
    _phoneTextField.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_phoneTextField];
    _phoneTextField.layer.cornerRadius=3;
    UIImage *phoneLeftimage=Image(@"phone.png");
    UIImageView *phoneLeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, phoneLeftimage.size.width, phoneLeftimage.size.height)];
    phoneLeftImageView.image=phoneLeftimage;
    
    UIView *phoneLeftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _phoneTextField.height, _phoneTextField.height)];
    
    phoneLeftView.backgroundColor=cGreenColor;
    phoneLeftImageView.center=phoneLeftView.center;
    [phoneLeftView addSubview:phoneLeftImageView];
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, phoneLeftView.width+10, phoneLeftView.height)];
    [bgView addSubview:phoneLeftView];
    
    _phoneTextField.leftView=bgView;
    _phoneTextField.leftViewMode=UITextFieldViewModeAlways;
    _phoneTextField.placeholder=@"手机号码";
    _phoneTextField.text=[keychainItemManager readPhoneNum];
    //短信验证码
    
    _messageTextField=[[IHTextField alloc]initWithFrame:CGRectMake(_phoneTextField.left, _phoneTextField.bottom+10, _phoneTextField.width*0.63, _phoneTextField.height)];
    _messageTextField.borderStyle=UITextBorderStyleNone;
    _messageTextField.backgroundColor=[UIColor whiteColor];
    _messageTextField.keyboardType=UIKeyboardTypePhonePad;
    [self.view addSubview:_messageTextField];
    _messageTextField.layer.cornerRadius=3;
    _messageTextField.delegate=self;
    UIImage *messageLeftimage=Image(@"message.png");
    UIImageView *messageLeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, messageLeftimage.size.width, messageLeftimage.size.height)];
    messageLeftImageView.image=messageLeftimage;
    
    UIView *messageLeftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _messageTextField.height, _messageTextField.height)];
    [messageLeftView addSubview:messageLeftImageView];
    messageLeftView.backgroundColor=cGreenColor;
    messageLeftImageView.center=messageLeftView.center;
    
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, messageLeftView.width+10, phoneLeftView.height)];
    [bgView addSubview:messageLeftView];
    
    _messageTextField.leftView=bgView;
    _messageTextField.leftViewMode=UITextFieldViewModeAlways;
    _messageTextField.placeholder=@"短信验证码";
    
    //获取验证码
    
    UIButton *huoquBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    huoquBtn.frame=CGRectMake(_messageTextField.right+5, _messageTextField.top, _phoneTextField.width-_messageTextField.width-5, _messageTextField.height);
    [huoquBtn setTintColor:[UIColor whiteColor]];
    huoquBtn.backgroundColor=[UIColor clearColor];
    _vCodeBtn=huoquBtn;
    huoquBtn.titleLabel.font=sysFont(15);
    [huoquBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    // 按钮边框宽度
    [huoquBtn setLayerMasksCornerRadius:4.5 BorderWidth:1 borderColor:[UIColor whiteColor]];
    [huoquBtn addTarget:self action:@selector(huoquyanzhengma) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huoquBtn];
    
    //密码
    _passWordTextField=[[IHTextField alloc]initWithFrame:CGRectMake(_phoneTextField.left, _messageTextField.bottom+10, _phoneTextField.width, _phoneTextField.height)];
    _passWordTextField.borderStyle=UITextBorderStyleNone;
    _passWordTextField.backgroundColor=[UIColor whiteColor];
    _passWordTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:_passWordTextField];
    _passWordTextField.layer.cornerRadius=3;
    _passWordTextField.delegate=self;
    UIImage *passwordLeftimage=Image(@"password.png");
    UIImageView *passwordLeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, passwordLeftimage.size.width, passwordLeftimage.size.height)];
    passwordLeftImageView.image=passwordLeftimage;
    
    UIView *passwordLeftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _messageTextField.height, _messageTextField.height)];
    passwordLeftView.backgroundColor=cGreenColor;
    passwordLeftImageView.center=passwordLeftView.center;
    [passwordLeftView addSubview:passwordLeftImageView];
    
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, passwordLeftView.width+10, passwordLeftView.height)];
    [bgView addSubview:passwordLeftView];
    
    _passWordTextField.leftView=bgView;
    _passWordTextField.leftViewMode=UITextFieldViewModeAlways;
    _passWordTextField.placeholder=@"6-12位密码";
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame=CGRectMake(_passWordTextField.left,_passWordTextField.bottom+15, _phoneTextField.width*0.38, _messageTextField.height);
    [backBtn setTintColor:[UIColor whiteColor]];
    backBtn.backgroundColor=[UIColor clearColor];
    [backBtn setTitle:@"返 回" forState:UIControlStateNormal];
    // 按钮边框宽度
    [backBtn setLayerMasksCornerRadius:4.5 BorderWidth:1 borderColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //确定
    UIButton *certainBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTintColor:[UIColor whiteColor]];
    [certainBtn setTitle:@"确 定" forState:UIControlStateNormal];
    certainBtn.backgroundColor=cGreenColor;
    certainBtn.frame=CGRectMake(backBtn.right+10, backBtn.top, _passWordTextField.width-backBtn.width-10, backBtn.height);
    certainBtn.layer.cornerRadius=3;
    [certainBtn addTarget:self action:@selector(certain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:certainBtn];
    
    if (self.type==ENT_register)
    {
        UIImage *img=Image(@"right.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"阅读并同意《%@用户协议》",KAppName] forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(14);
        [btn setTitleColor:RGB(181, 230, 228) forState:UIControlStateNormal];
        btn.frame=CGRectMake(0, certainBtn.bottom+20, 260, img.size.height);
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        btn.centerX=self.view.centerX;
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(xieyi) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImage *logoImg=Image(@"Icon-Small-40.png");
    UIImageView *logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.335*WindowWith, 0.87*kScreenHeight, logoImg.size.width, logoImg.size.height)];
    logoImageView.image=logoImg;
    [self.view addSubview:logoImageView];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, logoImageView.top+10, SCREEN_WIDTH, 20) textColor:cGreenColor textFont:sysFont(20)];
    
    lbl.text=KAppName2;
    lbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl];
}

-(void)xieyi
{
    UserAgreementViewController *vc=[[UserAgreementViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)huoquyanzhengma
{
    if (![IHUtility checkPhoneValidate:_phoneTextField.text]) {
        return;
    }
    int type;
    if (self.type==ENT_register) {
        type=0;
    }else
    {
        type=1;
    }
    
//    NSString *IP = [NSString deviceIPAdress];
//    NSString *phoneParam = [IP stringByAppendingString:_phoneTextField.text];
    [network getSendRegisterSms:_phoneTextField.text type:type chanle:channel  success:^(NSDictionary *obj) {
		self->channel++;
        [self removeWaitingView];
        [self addSucessView:@"验证码发送成功，请耐心等待哦^_^" type:1];
        [ConfigManager countdownSecond:60  returnTitle:^(NSString *title)
         {
             if (ConfigManager.seconds>0) {
				 [self->_vCodeBtn setTitle:title forState:UIControlStateNormal];
				 self->_vCodeBtn.userInteractionEnabled = NO;
             }
             else
             {
				 [self->_vCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
				 self->_vCodeBtn.userInteractionEnabled = YES;
             }
         }];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phoneTextField && range.location>=11) {
        return NO;
    }else if(textField == _passWordTextField && range.location>=12){
        return NO;
    }
    
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}

-(void)certain
{
    if (![IHUtility checkPhoneValidate:_phoneTextField.text]) {
        return;
    }

    if (_messageTextField.text.length==0) {
        [self addSucessView:@"验证码不能为空！" type:2];
        return;
    }

    if (_passWordTextField.text.length<6) {
        [self addSucessView:@"密码不能少于6位！" type:2];
        return;
    }
    
    [self addWaitingView];
    if (self.type==ENT_register) {
        [network getValidateCode:_phoneTextField.text vcode:_messageTextField.text success:^(NSDictionary *obj) {
            [self removeWaitingView];
            PerfectUserInformationViewController  *vc=[[PerfectUserInformationViewController alloc]init];
			vc.phoneStr=self->_phoneTextField.text;
			vc.passwordStr=self->_passWordTextField.text;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else if(self.type==ENT_Password)
    {
        [network findPassword:_phoneTextField.text password:_passWordTextField.text code:_messageTextField.text success:^(NSDictionary *obj) {
            [self addSucessView:@"密码找回成功" type:1];
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [self back:nil];
        }];
    }
}

@end
