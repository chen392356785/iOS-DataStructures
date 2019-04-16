//
//  DFLoginView.m
//  DF
//
//  Created by Tata on 2017/12/4.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFLoginView.h"

@interface DFLoginView ()

@property (nonatomic, strong) UIButton *wechatButton;
@property (nonatomic, strong) UILabel *wechatLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *orLabel;
@property (nonatomic, strong) UILabel *phoneLoginLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIButton *sendCodeButton;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation DFLoginView

- (void)addSubviews {
    [super addSubviews];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.wechatButton];
    [self addSubview:self.wechatLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.orLabel];
    [self addSubview:self.phoneLoginLabel];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.codeTextField];
    [self addSubview:self.voiceButton];
    [self addSubview:self.loginButton];	
}

- (void)defineLayout {
    [super defineLayout];
    
    [self.wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom).with.offset(self.wechatButton.cas_marginTop);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.wechatButton.cas_sizeWidth));
        make.height.equalTo(@(self.wechatButton.cas_sizeHeight));
    }];
    
    [self.wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechatButton.mas_bottom).with.offset(self.wechatLabel.cas_marginTop);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.wechatLabel.cas_sizeWidth));
        make.height.equalTo(@(self.wechatLabel.cas_sizeHeight));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechatLabel.mas_bottom).with.offset(self.lineView.cas_marginTop);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.lineView.cas_sizeWidth));
        make.height.equalTo(@(self.lineView.cas_sizeHeight));
    }];
    
    [self.orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.lineView.mas_centerY);
        make.width.equalTo(@(self.orLabel.cas_sizeWidth));
        make.height.equalTo(@(self.orLabel.cas_sizeHeight));
    }];
    
    [self.phoneLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(self.phoneLoginLabel.cas_marginTop);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.phoneLoginLabel.cas_sizeWidth));
        make.height.equalTo(@(self.phoneLoginLabel.cas_sizeHeight));
    }];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_bottom).with.offset(self.voiceButton.cas_marginTop);
        make.left.equalTo(self.mas_left).with.offset(self.voiceButton.cas_marginLeft);
        make.right.equalTo(self.mas_right).with.offset(self.voiceButton.cas_marginRight);
        make.height.equalTo(@(self.voiceButton.cas_sizeHeight));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_bottom).with.offset(self.loginButton.cas_marginTop);
        make.left.equalTo(self.mas_left).with.offset(self.loginButton.cas_marginLeft);
        make.right.equalTo(self.mas_right).with.offset(self.loginButton.cas_marginRight);
        make.height.equalTo(@(self.loginButton.cas_sizeHeight));
    }];
    
}

- (void)creatViews {
    [super creatViews];
    
    [self.navigationView.forwardButton setImage:kImage(CloseLogin) forState:UIControlStateNormal];
    self.navigationView.forwardButton.cas_styleClass = @"navigation_forward";
    
    self.wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wechatButton setImage:kImage(WXLogin) forState:UIControlStateNormal];
    self.wechatButton.cas_styleClass = @"login_wechatButton";
    self.wechatButton.layer.masksToBounds = YES;
    
    self.wechatLabel = [[UILabel alloc]init];
    self.wechatLabel.cas_styleClass = @"login_wecharLabel";
    self.wechatLabel.text = @"微信登录";
    
    self.lineView = [[UIView alloc]init];
    self.lineView.cas_styleClass = @"login_lineView";
    
    self.orLabel = [[UILabel alloc]init];
    self.orLabel.cas_styleClass = @"login_orLabel";
    self.orLabel.text = @"or";
    
    self.phoneLoginLabel = [[UILabel alloc]init];
    self.phoneLoginLabel.cas_styleClass = @"login_phoneLoginLabel";
    self.phoneLoginLabel.text = @"手机登录";
    //手机号
    self.phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 300 * TTUIScale(), iPhoneWidth, 44 * TTUIScale())];
    self.phoneTextField.placeholder = @"请输入您的手机号";
    UIView * phoneTextLeft=[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 55 * TTUIScale() , 44 * TTUIScale())];
    UIImageView *phontIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10 * TTUIScale(), 10 * TTUIScale(), 20 * TTUIScale(), 20 * TTUIScale())];
    phontIcon.contentMode = UIViewContentModeScaleAspectFit;
    phontIcon.image  = kImage(PhoneLogin);
    [phoneTextLeft addSubview:phontIcon];
    self.phoneTextField.leftView = phoneTextLeft;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.phoneTextField makeLayerRadius:1.0 Color:THBaseLightGray Directions:[NSArray arrayWithObjects:@"top",@"bottom",nil]];
    self.phoneTextField.cas_styleClass = @"login_phoneTextField";
    //发送验证码
    self.sendCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendCodeButton.frame = CGRectMake(0, 0, 100 * TTUIScale(), 44 * TTUIScale());
    [self.sendCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.sendCodeButton setTitleColor:THBaseColor forState:UIControlStateNormal];
    [self.sendCodeButton makeLayerRadius:1.0 Color:THBaseLightGray Directions:[NSArray arrayWithObjects:@"left", nil]];
    self.sendCodeButton.cas_styleClass = @"login_sendCodeButton";
    self.phoneTextField.rightView = self.sendCodeButton;
    self.phoneTextField.rightViewMode = UITextFieldViewModeAlways;
    //验证码
    self.codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneTextField.frame), iPhoneWidth, 44 * TTUIScale())];
    self.codeTextField.placeholder = @"请输入验证码";
    self.codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIView * codeTextLeft=[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 55 * TTUIScale() , 44 * TTUIScale())];
    UIImageView *codeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10 * TTUIScale(), 10 * TTUIScale(), 20 * TTUIScale(), 20 * TTUIScale())];
    codeIcon.contentMode = UIViewContentModeScaleAspectFit;
    codeIcon.image  = kImage(CodeLogin);
    [codeTextLeft addSubview:codeIcon];
    self.codeTextField.leftView = codeTextLeft;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.codeTextField makeLayerRadius:1.0 Color:THBaseLightGray Directions:[NSArray arrayWithObjects:@"bottom", nil]];
    self.codeTextField.cas_styleClass = @"login_codeTextField";
    //语音验证码
    self.voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.voiceButton.cas_styleClass = @"login_voiceButton";
    self.voiceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.voiceButton.hidden = YES;
    [self.voiceButton setTitleColor:THBaseColor forState:UIControlStateNormal];
    NSString * myAttributedString = @"短信验证码收不到? 试试语音验证码!";
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:myAttributedString];
    [attributedText addAttribute:NSForegroundColorAttributeName value:THBaseGray range:NSMakeRange(0,9)];
    [attributedText addAttribute:NSForegroundColorAttributeName value:THBaseColor range:NSMakeRange(9,myAttributedString.length-9)];
    [attributedText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleNone] range:NSMakeRange(0,9)];
    [attributedText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(9,myAttributedString.length-9)];
    [self.voiceButton setAttributedTitle:attributedText forState:UIControlStateNormal];
    //登录
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.cas_styleClass = @"login_loginButton";
    self.loginButton.layer.masksToBounds = YES;
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
