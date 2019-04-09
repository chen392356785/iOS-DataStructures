//
//  MTLoginView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/5.
//  Copyright © 2016年 xubin. All rights reserved.
//
//#import "keychainItemManager.h"
#import "MTLoginView.h"
//#import "ZhuCeViewController.h"
@interface MTLoginView()
{
    IHTextField *_passWordText;
    IHTextField *_phoneText;
    IHTextField *_oldPassWordTextFeild;
    IHTextField *_newPassWordTextFeild;
  
}
@end
@implementation MTLoginView

- (instancetype)initWithFrame:(CGRect)frame :(LaginType)type
{
    self=[super initWithFrame:frame];
    if (self) {
        // self.backgroundColor=[UIColor clearColor];
        [self showLoginView:type];
    }
    return self;
}

-(void)showLoginView:(LaginType)type
{
    UIView *centerView=[[UIView alloc]init];
    UIImage *image=Image(@"catchword.png");
    centerView.tag=1006;
    centerView.frame=CGRectMake(15, kScreenHeight*0.21+image.size.height+(kScreenHeight)*0.049, WindowWith-30, (WindowWith -30)*0.62);
  
    if (type==ENT_Lagin) {
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
        _passWordText.secureTextEntry=YES;
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
   
    CatapultView *catapultView=[[CatapultView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight) withView:centerView];
    catapultView.tag=1001;
    catapultView.selectBtnBlock=^(NSInteger index)
    {
        [self removeFromSuperview];
    };
    [self addSubview:catapultView];

    
    //监听键盘的升起和隐藏事件,需要用到通知中心 ****IQKeyboard
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //监听升起:UIKeyboardWillShowNotification
    //name:  监听指定通知
    //observer: 当接收到指定通知后,由指定对象
    //selector: 执行对应的方法进行处理
//    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//    //监听隐藏:UIKeyboardWillHideNotification
//    [center addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
    
}
-(void)certain
{
    if (_phoneText.text.length==0) {
        [IHUtility AlertMessage:@"错误" message:@"请输入手机号"];
        return;
    }
   
    self.selectSurnBlock(_phoneText.text,_passWordText.text);
}

//验证
-(void)login
{
    
    !self.selectYZMBlock ?: self.selectYZMBlock(_phoneText.text);
    
    
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

//隐藏view
-(void)hideView
{
   
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
#pragma mark -水平左右画面抖动效果
- (void)shakeViewHorizontal:(UIView*)viewToShake
{
    CGFloat t =8.0;
    //左右抖动效果
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}



- (void)keyBoardWillShow:(NSNotification *)notification
{
    
      CatapultView *catapultView=[self viewWithTag:1001];
    //获取键盘的相关属性(包括键盘位置,高度...)
   // NSDictionary *userInfo = notification.userInfo;
    
    //获取键盘的位置和大小
   // CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue /*将对象转换为CGRect结构体*/];
    
    //键盘升起的时候
    [UIView animateWithDuration:0.25 animations:^{
       
        UIImage *image=Image(@"catchword.png");
        catapultView.imageView.frame=CGRectMake(0, kScreenHeight*0.21-kScreenHeight*0.08, image.size.width, image.size.height);
        catapultView.imageView.centerX=self.centerX;
        UIView *centerView=[self viewWithTag:1006];
       centerView.frame=CGRectMake(15, CGRectGetMaxY(catapultView.imageView.frame)+(kScreenHeight)*0.049, WindowWith-30, (WindowWith -30)*0.62);
        
    }];
    
    

   
}

- (void)keyBoardWillHide
{
     CatapultView *catapultView=[self viewWithTag:1001];
    
    //键盘隐藏的时候
    [UIView animateWithDuration:0.25 animations:^{
      
        UIImage *image=Image(@"catchword.png");
        catapultView.imageView.frame=CGRectMake(0, kScreenHeight*0.21, image.size.width, image.size.height);
        catapultView.imageView.centerX=self.centerX;
         UIView *centerView=[self viewWithTag:1006];
        centerView.frame=CGRectMake(15, CGRectGetMaxY(catapultView.imageView.frame)+(kScreenHeight)*0.049, WindowWith-30, (WindowWith -30)*0.62);
//        
    }];
    
}


@end
