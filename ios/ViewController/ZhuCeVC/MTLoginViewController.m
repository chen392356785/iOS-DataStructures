//
//  MTLoginViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/18.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTLoginViewController.h"
#import "ZhuCeViewController.h"
#import "CacheUserInfo.h"
#import "MTBindPhoneController.h"
//#import "THModalNavigationController.h"
//
//#import "GetRewardViewController.h"     //新人注册登录 领取奖励

@interface MTLoginViewController ()
{
    IHTextField *_passWordText;
    IHTextField *_phoneText;
    NSString *logType;      //1 短信验证码登录  2. 密码登录
    UIButton *logTypeBut;
    int channel;    // 60秒后重新发送时间
    UILabel *titleLab;  //登录方式
    UIButton *_forgetPWbut;
}
@property (nonatomic, strong) UIButton *GetCodeNumBut;

@end

@implementation MTLoginViewController


- (UIButton *)GetCodeNumBut {
    if (_GetCodeNumBut == nil) {
        _GetCodeNumBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _GetCodeNumBut.size = CGSizeMake(kWidth(95), kWidth(29));
        _GetCodeNumBut.layer.cornerRadius = _GetCodeNumBut.height/2;
        _GetCodeNumBut.titleLabel.font = boldFont(14);
        _GetCodeNumBut.layer.borderWidth = 1;
        _GetCodeNumBut.layer.borderColor = kColor(@"#A1A1A1").CGColor;
        [_GetCodeNumBut setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_GetCodeNumBut setTitleColor:kColor(@"#A2A2A2") forState:UIControlStateNormal];
        [_GetCodeNumBut addTarget:self action:@selector(getCodeNameAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _GetCodeNumBut;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //先让环信退出
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error && info) {
        }
    } onQueue:nil];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
}
//获取登录短信验证码
- (void) getCodeNameAction:(UIButton *)CodeBut {
    NSString *phoneStr = _phoneText.text;
    if (![IHUtility isValidateMobile:phoneStr] || phoneStr.length <= 0) {
        [self addSucessView:[NSString stringWithFormat:@"手机号格式错误"] type:2];
        return;
    }
    [_phoneText resignFirstResponder];
    [self addWaitingView];
    [network getPhoneNumCode:phoneStr success:^(NSDictionary *obj) {
        self->channel++;
        [self removeWaitingView];
        [self addSucessView:@"验证码发送成功，请耐心等待哦^_^" type:1];
        [ConfigManager countdownSecond:60  returnTitle:^(NSString *title)
         {
             if (ConfigManager.seconds>0) {
                 [CodeBut setTitle:title forState:UIControlStateNormal];
                 CodeBut.userInteractionEnabled = NO;
             }
             else
             {
                 [CodeBut setTitle:@"重新获取" forState:UIControlStateNormal];
                 CodeBut.userInteractionEnabled = YES;
             }
         }];
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"用户登录"];
    logType = @"1";
    _BaseScrollView.backgroundColor = kColor(@"#EDEDED");
    [self setLeftButtonImage:Image(@"cancleActivOrder.png") forState:UIControlStateNormal];
    
   UILabel *infoLab =[UILabel new];
//    btn.enabled=NO;
    UIImage *img=nil;
//    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    infoLab.textColor = kColor(@"#313131");
    infoLab.font= darkFont(font(27));
    infoLab.text = @"验证码登录";
    titleLab = infoLab;
//    CGSize size=[IHUtility GetSizeByText:KAppName2 sizeOfFont:21 width:200];
    
    infoLab.frame=CGRectMake(kWidth(21), kWidth(45), iPhoneWidth - kWidth(42),kWidth(30));
    [_BaseScrollView addSubview:infoLab];
    
    
    _phoneText = [[IHTextField alloc]initWithFrame:CGRectMake(kWidth(21), infoLab.bottom +kWidth(61), iPhoneWidth - kWidth(42) - self.GetCodeNumBut.width ,kWidth(30))];
    
    _phoneText.borderStyle=UITextBorderStyleNone;
    _phoneText.delegate=self;
    [_BaseScrollView addSubview:_phoneText];
    
    _phoneText.placeholder=@"手机号";
    _phoneText.text=[keychainItemManager readPhoneNum];
    _phoneText.leftViewMode=UITextFieldViewModeAlways;
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(_phoneText.left, _phoneText.bottom+5, iPhoneWidth - kWidth(42), 1)];
    lineView.backgroundColor = kColor(@"#05C1B0");
    [_BaseScrollView addSubview:lineView];
    
    self.GetCodeNumBut.origin = CGPointMake(lineView.right - self.GetCodeNumBut.width, _phoneText.top);
    [_BaseScrollView addSubview:self.GetCodeNumBut];
    
    
    //密码文本框
    _passWordText=[[IHTextField alloc]initWithFrame:CGRectMake(_phoneText.left, _phoneText.bottom+20, lineView.width, _phoneText.height)];
    
    _passWordText.borderStyle=UITextBorderStyleNone;
    _passWordText.delegate=self;
    [_BaseScrollView addSubview:_passWordText];
    
   
    _passWordText.secureTextEntry=YES;
    
    _passWordText.leftViewMode=UITextFieldViewModeAlways;
    _passWordText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    lineView=[[UIView alloc]initWithFrame:CGRectMake(_passWordText.left, _passWordText.bottom+5, _passWordText.width, 1)];
    lineView.backgroundColor = kColor(@"#D6D6D6");
    [_BaseScrollView addSubview:lineView];
    
    
    
    UIButton *passW=[UIButton buttonWithType:UIButtonTypeCustom];
    [passW setTitle:@"忘记密码" forState:UIControlStateNormal];
    [passW setTitleColor:kColor(@"#424242") forState:UIControlStateNormal];
    [passW addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    passW.titleLabel.font = sysFont(16);
    UIColor *textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [passW setTitleColor:textColor forState:UIControlStateNormal];
    CGSize size3=[IHUtility GetSizeByText:@"忘记密码" sizeOfFont:16 width:WindowWith];
    passW.titleLabel.textAlignment = NSTextAlignmentRight;
    passW.frame=CGRectMake(lineView.right - size3.width, lineView.bottom + kWidth(30), size3.width, 20);
    _forgetPWbut = passW;
    [_BaseScrollView addSubview:passW];
    
    logTypeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [logTypeBut setTitle:@"用户名密码登录" forState:UIControlStateNormal];
    [logTypeBut setTitleColor:kColor(@"#424242") forState:UIControlStateNormal];
    [logTypeBut addTarget:self action:@selector(phoneLogin) forControlEvents:UIControlEventTouchUpInside];
    logTypeBut.titleLabel.font = sysFont(16);
    CGSize size4 = [IHUtility GetSizeByText:@"用户名密码登录" sizeOfFont:16 width:WindowWith];
    logTypeBut.titleLabel.textAlignment = NSTextAlignmentLeft;
    logTypeBut.frame=CGRectMake(lineView.left, lineView.bottom + kWidth(30), size4.width, 20);
    
    [_BaseScrollView addSubview:logTypeBut];
    if ([logType isEqualToString:@"1"]) {             //短信验证码
        _passWordText.placeholder = @"验证码";
        self.GetCodeNumBut.hidden = NO;
        _forgetPWbut.hidden = YES;
        _passWordText.secureTextEntry=NO;
    }else {
        _passWordText.placeholder=@"密码";
        self.GetCodeNumBut.hidden = YES;
        _forgetPWbut.hidden = NO;
        _passWordText.secureTextEntry=YES;
    }
    
    
    UIButton  *Btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    Btn.frame=CGRectMake(0, logTypeBut.bottom + kWidth(46), kWidth(344), kWidth(45));
    Btn.backgroundColor=cGreenColor;
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn setTitle:@"登  录" forState:UIControlStateNormal];
    Btn.titleLabel.font = darkFont(font(18));
    [Btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    Btn.titleLabel.font=sysFont(18.8);
    
    Btn.centerX=self.view.centerX;
    Btn.layer.cornerRadius=21;
    [_BaseScrollView addSubview:Btn];
    
    img=Image(@"weixin.png");
    UIButton   *WXbtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [WXbtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [WXbtn setTitle:@"微信一键登录" forState:UIControlStateNormal];
    WXbtn.titleLabel.font=sysFont(15);
    [WXbtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    WXbtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    WXbtn.backgroundColor = [UIColor whiteColor];
    [WXbtn addTarget:self action:@selector(WXLogin) forControlEvents:UIControlEventTouchUpInside];
    [WXbtn setLayerMasksCornerRadius:20 BorderWidth:0.5 borderColor:cGrayLightColor];
    WXbtn.frame=CGRectMake(0, Btn.bottom+0.1*WindowHeight, _phoneText.width, 42);
    if (kScreenHeight==480) {
        WXbtn.origin=CGPointMake(0, Btn.bottom+25);
    }
    WXbtn.centerX=self.view.centerX;
//    [_BaseScrollView addSubview:WXbtn];
    
    img=Image(@"user.png");
    UIButton *ZCbtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [ZCbtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [ZCbtn setTitle:[NSString stringWithFormat:@"注册%@用户",KAppName] forState:UIControlStateNormal];
    ZCbtn.titleLabel.font = sysFont(15);
    [ZCbtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    ZCbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    ZCbtn.backgroundColor = [UIColor whiteColor];
    [ZCbtn addTarget:self action:@selector(ZhuCe) forControlEvents:UIControlEventTouchUpInside];
    [ZCbtn setLayerMasksCornerRadius:20 BorderWidth:0.5 borderColor:cGrayLightColor];
    ZCbtn.frame=CGRectMake(0, WXbtn.bottom+20, _phoneText.width, 42);
    //ZCbtn.frame=WXbtn.frame;
    ZCbtn.centerX=self.view.centerX;
//    [_BaseScrollView addSubview:ZCbtn];
    
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

-(void)WXLogin{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        
        
        if (error) {
            [self removeWaitingView];

        }
        else {
            
            [self addWaitingView];

            UMSocialUserInfoResponse *resp = result;
            // 第三方平台SDK源数据
//                      NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager loadImageWithURL:[NSURL URLWithString:resp.iconurl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (image) {
                    [AliyunUpload uploadImage:@[image] FileDirectory:ENT_fileImageHeader success:^(NSString *obj) {
                        [network getWXlogin:resp.uid nickname:resp.name heed_image_url:obj success:^(NSDictionary *obj)
                         {
                              [self removeWaitingView];
                             NSInteger errorLogNO=[[obj objectForKey:@"errorNo"]integerValue];
                             if (errorLogNO == 1401) {
                                 [self pushpushMTBindPhoneControllerWXloginNickName:resp.name andHeadImageurl:resp.iconurl dic:nil AndUserId:resp.uid AndErrorlogNO:errorLogNO];
                                 return ;
                             }
                             NSDictionary *dic=[obj objectForKey:@"content"];
                             NSString *user_name = dic[@"user_name"];
                             NSString *hxName = dic[@"hx_user_name"];
                             NSString *hxpassword  =dic[@"hx_password"];
                             if (![IHUtility isValidateMobile:user_name]) {     //判断是否绑定手机号用户名是否为手机号
                                 [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:hxName
                                                                                     password:hxpassword
                                                                                   completion:
                                  ^(NSDictionary *loginInfo, EMError *error) {
                                if (loginInfo && !error) {
                                      [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
                                      NSDictionary *Dic=@{@"fansNum":dic[@"fansNum"],
                                                          @"followNum":dic[@"followNum"]
                                                          };
                                      [IHUtility saveDicUserDefaluts:Dic key:KFansDefalutInfo];
                                    [self addSucessView:@"登录成功!" type:1];
                                      [keychainItemManager writePhoneNum:self->_phoneText.text];
                                      [USERMODEL setUserInfo:dic];
                                      CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
                                      cacheModel.user = USERMODEL;
                                      //设置是否自动登录
                                      [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                                      [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                                      
                                      [self showUserLocation:^(NSString *province, NSString *city, CGFloat latitude, CGFloat longtitude) {
                                          [network getUpdateUserAdress:[USERMODEL.userID intValue]country:nil province:province city:city area:nil street:nil longitude:longtitude latitude:latitude success:^(NSDictionary *obj) {
                                          }];
                                      }];
                                      [self pushpushMTBindPhoneControllerWXloginNickName:resp.name andHeadImageurl:resp.iconurl dic:dic AndUserId:dic[@"user_id"] AndErrorlogNO:0];
                                      return ;
                                    }
                                  }onQueue:nil];
                             }else {
                                 [self loginHuanXin:hxName passWord:hxpassword dic:dic];
                             }
                             
                         } failure:^(NSDictionary *obj2) {
                         }];
                    }];
                }
                else {
                
                    [network getWXlogin:resp.uid nickname:resp.name heed_image_url:@"" success:^(NSDictionary *obj) {
                        [self removeWaitingView];
                        NSInteger errorLogNO=[[obj objectForKey:@"errorNo"]integerValue];
                        if (errorLogNO == 1401) {
                            [self pushpushMTBindPhoneControllerWXloginNickName:resp.name andHeadImageurl:resp.iconurl dic:nil AndUserId:resp.uid AndErrorlogNO:errorLogNO];
                            return ;
                        }
                        NSDictionary *dic=[obj objectForKey:@"content"];
                        NSString *user_name = dic[@"user_name"];
                        NSString *hxName = dic[@"hx_user_name"];
                        NSString *hxpassword  =dic[@"hx_password"];
                        if (![IHUtility isValidateMobile:user_name]) {     //判断是否绑定手机号用户名是否为手机号
                            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:hxName
                                                                                password:hxpassword
                                                                              completion:
                             ^(NSDictionary *loginInfo, EMError *error) {
                                 if (loginInfo && !error) {
                                     [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
                                     NSDictionary *Dic=@{@"fansNum":dic[@"fansNum"],
                                                         @"followNum":dic[@"followNum"]
                                                         };
                                     [self addSucessView:@"登录成功!" type:1];
                                     
                                     [IHUtility saveDicUserDefaluts:Dic key:KFansDefalutInfo];
                                     [keychainItemManager writePhoneNum:self->_phoneText.text];
                                     [USERMODEL setUserInfo:dic];
                                     CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
                                     cacheModel.user = USERMODEL;
                                     //设置是否自动登录
                                     [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                                     [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                                     
                                     [self showUserLocation:^(NSString *province, NSString *city, CGFloat latitude, CGFloat longtitude) {
                                         [network getUpdateUserAdress:[USERMODEL.userID intValue]country:nil province:province city:city area:nil street:nil longitude:longtitude latitude:latitude success:^(NSDictionary *obj) {
                                         }];
                                     }];
                                     [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCompany object:nil]; //更新 我的信息
                                     [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                                    
                                     [self pushpushMTBindPhoneControllerWXloginNickName:resp.name andHeadImageurl:resp.iconurl dic:dic AndUserId:dic[@"user_id"] AndErrorlogNO:0];
                                     return ;
                                 }
                             }onQueue:nil];
                        }else {
                            [self loginHuanXin:hxName passWord:hxpassword dic:dic];
                        }
                        
                    } failure:^(NSDictionary *obj2) {
                    }];
                }
            }];
        }
    }];

}
#pragma mark - 绑定手机号
- (void)pushpushMTBindPhoneControllerWXloginNickName:(NSString *)WXName andHeadImageurl:(NSString *)iconUrl dic:(NSDictionary *)dic AndUserId:(NSString *)UserID AndErrorlogNO:(NSInteger )errorNO{
    MTBindPhoneController *BindPVc = [[MTBindPhoneController alloc] init];
    BindPVc.UserID = UserID;
    BindPVc.errorLogNO = errorNO;
    BindPVc.WXName = WXName;
    BindPVc.headIconUrl = iconUrl;
    BindPVc.SelectSurnBlock = ^(BOOL result, NSDictionary *dict){
        if (result) {   //手机号绑定成功
//            [self loginHuanXin:dic[@"hx_user_name"] passWord:dic[@"hx_password"] dic:dict];
            [IHUtility saveDicUserDefaluts:dict key:kUserDefalutLoginInfo];
            NSDictionary *Dic=@{@"fansNum":dict[@"fansNum"],
                                @"followNum":dict[@"followNum"]
                                };
            [IHUtility saveDicUserDefaluts:Dic key:KFansDefalutInfo];
            [keychainItemManager writePhoneNum:self->_phoneText.text];
            [USERMODEL setUserInfo:dict];
            CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
            cacheModel.user = USERMODEL;
             [self dismissViewControllerAnimated:YES completion:nil];
        }
    };
    BindPVc.NewSelectSurnBlock = ^(BOOL result, NSString *NewHxName, NSString *newHxPassW, NSDictionary *newDic){
        if (result) {   //手机号绑定成功
            [self loginHuanXin:NewHxName passWord:newHxPassW dic:newDic];
        }
    };
    [self.navigationController pushViewController:BindPVc animated:YES];
}


-(void)ZhuCe{
    
    ZhuCeViewController *vc=[[ZhuCeViewController alloc]init];
    vc.type = ENT_register;
    [self pushViewController:vc];
}
- (void) phoneLogin {
    _passWordText.text = @"";
    if ([logType isEqualToString:@"1"]) { //短信验证码
        [logTypeBut setTitle:@"验证码登录" forState:UIControlStateNormal];
        _passWordText.placeholder=@"密码";
        _phoneText.width = _passWordText.width;
        logType = @"2";
        self.GetCodeNumBut.hidden = YES;
        titleLab.text = @"用户名密码登录";
        _forgetPWbut.hidden = NO;
        _passWordText.secureTextEntry = YES;
    }else{
        self.GetCodeNumBut.hidden = NO;
        [logTypeBut setTitle:@"用户名密码登录" forState:UIControlStateNormal];
        _passWordText.placeholder=@"验证码";
        _phoneText.width = _passWordText.width - self.GetCodeNumBut.width;
        logType = @"1";
        titleLab.text = @"验证码登录";
        _forgetPWbut.hidden = YES;
        _passWordText.secureTextEntry = NO;
    }
}
-(void)forgetPassword
{
    ZhuCeViewController *vc = [[ZhuCeViewController alloc]init];
    vc.type = ENT_forget;
    [self pushViewController:vc];
    
}

-(void)submitClick:(UIButton *)sender
{
    
    [self removeWaitingView];
    if (![IHUtility checkPhoneValidate:_phoneText.text]) {
        return;
    }
    
    if ([logType isEqualToString:@"1"]) {   //短信验证码登录
        if (_passWordText.text.length==0) {
            [self addSucessView:@"验证码不能为空" type:2];
            return;
        }
        [self addWaitingView];
        [network getCodeNumUserLogin:_phoneText.text codeNum:_passWordText.text success:^(NSDictionary *obj) {
            NSDictionary *dic=[obj objectForKey:@"content"];
            NSString *hxName=dic[@"hx_user_name"];
            NSString *hxpassword=dic[@"hx_password"];
            [self loginHuanXin:hxName passWord:hxpassword dic:dic];
        }];
        return;
    }
    
    
    if (_passWordText.text.length==0) {
        [self addSucessView:@"密码不能为空" type:2];
        return;
    }
    [self addWaitingView];
    [network getUserLogin:_phoneText.text passWord:_passWordText.text success:^(NSDictionary *obj) {
        NSDictionary *dic=[obj objectForKey:@"content"];
        NSString *hxName=dic[@"hx_user_name"];
        NSString *hxpassword=dic[@"hx_password"];
        [self loginHuanXin:hxName passWord:hxpassword dic:dic];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phoneText && range.location >= 11) {
        return NO;
    }
    return YES;
}

-(void)loginHuanXin:(NSString *)userName passWord:(NSString *)password dic:(NSDictionary *)dic{
    
//    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"exfsMjfQQZbWxNGuey6"
//                                                        password:@"861db460284b0468ad1ffc9f83da7b6d"
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userName
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         
         if (loginInfo && !error) {
             
             [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
             
             NSDictionary *Dic=@{@"fansNum":dic[@"fansNum"],
                                 @"followNum":dic[@"followNum"]
                                 };
             [IHUtility saveDicUserDefaluts:Dic key:KFansDefalutInfo];
             
             [self addSucessView:@"登录成功!" type:1];
             
             [keychainItemManager writePhoneNum:self->_phoneText.text];
             
             [USERMODEL setUserInfo:dic];
             CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
             cacheModel.user = USERMODEL;
             
             //             [network GetBindBaiduPush:USERMODEL.userID channel_id:@"" success:^(NSDictionary *obj) {
             //
             //             } failure:^(NSDictionary *obj2) {
             //
             //             }];
             
             
             
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             
             [self showUserLocation:^(NSString *province, NSString *city, CGFloat latitude, CGFloat longtitude) {
                 [network getUpdateUserAdress:[USERMODEL.userID intValue]country:nil province:province city:city area:nil street:nil longitude:longtitude latitude:latitude success:^(NSDictionary *obj) {
                 }];
             }];
             NSLog(@"%@====第一次登录",dic[@"firstLogin"]);
            
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCompany object:nil]; //更新 我的信息
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             if ([dic[@"firstLogin"] integerValue] == 1 ) {   //第一次登录
//                 GetRewardViewController *getRewVc = [[GetRewardViewController alloc] init];
//                 [self pushViewController:getRewVc];
                 return ;
             }
             [self dismissViewControllerAnimated:YES completion:nil];
             
         }
         else
         {
             [USERMODEL removeUserModel];
             [self removeWaitingView];
             
             switch (error.errorCode)
             {
                 case EMErrorNotFound:
                     TTAlertNoTitle(error.description);
                     break;
                 case EMErrorNetworkNotConnected:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                     break;
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                     break;
                 case EMErrorServerAuthenticationFailure:
                     TTAlertNoTitle(error.description);
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                     break;
                 case  EMErrorServerTooManyOperations:
                     [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                         if (!error && info) {
                             NSLog(@"退出成功");
                         }
                     } onQueue:nil];
                     [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
                     TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                     break;
                 default:
                     TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                     break;
             }
         }
     } onQueue:nil];
}

-(void)back:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self submitClick:nil];
    return YES;
}

- (void)keyBoardWillShow:(NSNotification *)notification
{
//    //获取键盘的相关属性(包括键盘位置,高度...)
//    NSDictionary *userInfo = notification.userInfo;
//    //获取键盘的位置和大小
//    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue /*将对象转换为CGRect结构体*/];
//    //键盘升起的时候
//    [UIView animateWithDuration:0.25 animations:^{
//
//    }];
}

- (void)keyBoardWillHide
{
    //键盘隐藏的时候
    [UIView animateWithDuration:0.25 animations:^{
        
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
