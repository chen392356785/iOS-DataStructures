//
//  PerfectUserInformationViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PerfectUserInformationViewController.h"
//#import "AliyunOSSUpload.h"
//#import "keychainItemManager.h"
#import "KICropImageView.h"
@interface PerfectUserInformationViewController ()<HJCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIAsyncImageView *_headImageView;
    NSMutableArray *headImageArray;
    IHTextField *_nickNameTextField;
    KICropImageView* _cropImageView;
    BOOL isSelectedPhoto;
//    NSInteger _selIndex;
}
@end

@implementation PerfectUserInformationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *bkImg=Image(@"bg.png");
    self.view.backgroundColor = [UIColor colorWithPatternImage:bkImg];
    self.view.contentMode = UIViewContentModeScaleAspectFill;

    headImageArray=[[NSMutableArray alloc]init];
//    UIImage *bkImg=Image(@"bg.png");
//    UIImageView *bkImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
//    bkImageView.image=bkImg;
//    bkImageView.userInteractionEnabled=YES;
//    [_BaseScrollView addSubview:bkImageView];
    
    UIImage *headImg=Image(@"defaulthead125.png");
    UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight*0.172, headImg.size.width, headImg.size.height)];
    headImageView.image=headImg;
    [headImageView setLayerMasksCornerRadius:headImg.size.width/2 BorderWidth:0 borderColor:[UIColor clearColor]];
    headImageView.userInteractionEnabled=YES;
    _headImageView=headImageView;
    headImageView.centerX=self.view.centerX;
    [self.view addSubview:headImageView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
    [headImageView addGestureRecognizer:tap];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, headImageView.bottom+15, 84, 20) textColor:cLineColor textFont:sysFont(14)];
    lbl.text=@"点击上传头像";
    lbl.centerX=headImageView.centerX;
    [self.view addSubview:lbl];
    
    //手机号码
    _nickNameTextField=[[IHTextField alloc]initWithFrame:CGRectMake(0.12*WindowWith, lbl.bottom+35, WindowWith-0.24*WindowWith, 42)];
    _nickNameTextField.delegate=self;
    
    _nickNameTextField.borderStyle=UITextBorderStyleNone;
    // _nickNameTextField.keyboardType=UIKeyboardTypePhonePad;
    _nickNameTextField.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_nickNameTextField];
    _nickNameTextField.layer.cornerRadius=3;
    UIImage *phoneLeftimage=Image(@"phone.png");
    UIImageView *phoneLeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, phoneLeftimage.size.width, phoneLeftimage.size.height)];
    phoneLeftImageView.image=phoneLeftimage;
    
    UIView *phoneLeftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _nickNameTextField.height, _nickNameTextField.height)];
    phoneLeftView.backgroundColor=cGreenColor;
    phoneLeftImageView.center=phoneLeftView.center;
    [phoneLeftView addSubview:phoneLeftImageView];
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, phoneLeftView.width+10, phoneLeftView.height)];
    [bgView addSubview:phoneLeftView];
    
    _nickNameTextField.leftView=bgView;
    _nickNameTextField.leftViewMode=UITextFieldViewModeAlways;
    _nickNameTextField.placeholder=@"输入昵称";
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame=CGRectMake(_nickNameTextField.left,_nickNameTextField.bottom+20, _nickNameTextField.width*0.38, _nickNameTextField.height);
    [backBtn setTintColor:[UIColor whiteColor]];
    backBtn.backgroundColor=[UIColor clearColor];
    [backBtn setTitle:@"返 回" forState:UIControlStateNormal];
    // 按钮边框宽度
    [backBtn setLayerMasksCornerRadius:4.5 BorderWidth:1 borderColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //确定
    
    UIButton *certainBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTintColor:[UIColor whiteColor]];
    [certainBtn setTitle:@"确 定" forState:UIControlStateNormal];
    certainBtn.backgroundColor=cGreenColor;
    certainBtn.frame=CGRectMake(backBtn.right+10, backBtn.top, _nickNameTextField.width-backBtn.width-10, backBtn.height);
    certainBtn.layer.cornerRadius=3;
    [certainBtn addTarget:self action:@selector(registerSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:certainBtn];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --确定按钮点击处理--
-(void)registerSubmitClick:(UIButton *)sender{
    
    if (!isSelectedPhoto) {
        [self addSucessView:@"请上传头像哦" type:2];
        return;
    }
    if ([_nickNameTextField.text isEqualToString:@"尚未填写"] || _nickNameTextField.text.length ==0) {
        [self addSucessView:@"请输入您的昵称" type:2];
        return;
    }
    
    [self addWaitingView];
    THWeakSelf;
    [AliyunUpload uploadImage:headImageArray FileDirectory:ENT_fileImageHeader success:^(NSString *obj) {
		[self removeWaitingView];
        NSDictionary *dic = [ConfigManager getAddressInfoWithUser_id:0 country:nil province:nil city:nil area:nil street:nil longitude:0 latitude:0 company_lon:0 company_lat:0 distance:0 company_province:nil company_city:nil company_area:nil company_street:nil];
        
        NSDictionary *dic1 = [ConfigManager getUserDicWithUser_name:self.phoneStr user_id:0 company_name:nil password:[IHUtility MD5Encode:[IHUtility MD5Encode:self.passwordStr]] nickname:self->_nickNameTextField.text address:nil hx_password:nil mobile:nil landline:nil email:nil i_type_id:0 sexy:0 business_direction:nil user_authentication:0 identity_key:0 heed_image_url:obj brief_introduction:nil position:nil wx_key:nil business_license_url:nil map_callout:0 addressInfo:dic];
        NSLog(@"%@",dic1);
        
        [network getuserRegister:dic1
                         success:^(NSDictionary *obj) {
                             THStrongSelf;
                             NSDictionary *dic=[obj objectForKey:@"content"];
                             [self loginHuanXin:dic];
                         }];
	} failure:^(NSError *error) {
		[self removeWaitingView];
	}];
}

-(void)loginHuanXin:(NSDictionary *)dic{
    
    NSString *hxName=dic[@"hx_user_name"];
    NSString *hxpassword=dic[@"hx_password"];
    
    THWeakSelf;
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:hxName
                                                        password:hxpassword
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         THStrongSelf;
         [self removeWaitingView];
         if (loginInfo && !error) {
             [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
             //  [ConfigManager setUserInfiDic:dic];
             [self addSucessView:@"注册成功!" type:1];
             [keychainItemManager writePhoneNum:self.phoneStr];
             
             [USERMODEL setUserInfo:dic];
             
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             
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

-(void)headTap:(UITapGestureRecognizer *)tap{
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", nil];
    // 2.显示出来
    [_nickNameTextField resignFirstResponder];
    [sheet show];
}

// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController * ip=[[UIImagePickerController alloc]init];
    ip.delegate=self;
    
    // ip.allowsEditing = YES;
    BOOL isOpen=[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (isOpen)
    {
        if (buttonIndex==1) {
            ip.sourceType=UIImagePickerControllerSourceTypeCamera;
        }else if (buttonIndex==2){
            ip.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        //设置控件是打开相机还是相册，默认是相册，设置UIImagePickerControllerSourceTypeCamera 打开相机
        
    }
    
    [self presentViewController:ip animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage * img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    img=[UIImage rotateImage:img];
    leftbutton.hidden=YES;
    
    UIView *v=[self.view viewWithTag:2001];
    if (v) {
        [v removeFromSuperview];
    }
    
    v=[[UIView alloc]initWithFrame:self.view.bounds];
    v.backgroundColor=[UIColor blackColor];
    v.tag=2001;
    
    _cropImageView = [[KICropImageView alloc] initWithFrame:self.view.bounds];
    [_cropImageView setCropSize:CGSizeMake(_deviceSize.width-10,_deviceSize.width-10)];
    [_cropImageView setImage:img];
    [v addSubview:_cropImageView];
    
    UIView *bView=[[UIView alloc ]initWithFrame:CGRectMake(0, v.bottom-70, _deviceSize.width, 60)];
    bView.alpha=0.8;
    //  bView.backgroundColor=[UIColor blackColor];
    [v addSubview:bView];
    
    img=Image(@"btn_cancel.png");
    UIButton *calBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    calBtn.frame=CGRectMake(30, 0, img.size.width, img.size.height);
    [calBtn setBackgroundImage:img forState:UIControlStateNormal];
    [calBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [bView addSubview:calBtn];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    img=Image(@"nav_ok.png");
    btn.frame=CGRectMake(WindowWith-30-img.size.width, 0,  img.size.width, img.size.height);
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [bView addSubview:btn];
    
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    img=Image(@"login_cx.png");
    btn.frame=CGRectMake(WindowWith/2-img.size.width/2, 0, img.size.width, img.size.height);
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(headTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [bView addSubview:btn];
    [self.view addSubview:v];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelClick{
    leftbutton.hidden=NO;
    UIView *v=[self.view viewWithTag:2001];
    [v removeFromSuperview];
}

-(void)saveImage{
    leftbutton.hidden=NO;
    CGFloat width = WindowWith;
    CGFloat x = (CGRectGetWidth(self.view.bounds) - width) / 2;
    CGFloat y = (CGRectGetHeight(self.view.bounds)/2 - width/ 2);
    UIView *v=[self.view viewWithTag:2001];
    [v removeFromSuperview];
    //判断先画一个大图，然后进行缩小动画。然后再删除。
    UIImage *img=Image(@"defaulthead125.png");
    UIImageView *xzImg=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, width)];
    xzImg.layer.masksToBounds=YES;
    xzImg.layer.cornerRadius=img.size.height/2;
    xzImg.image=[_cropImageView cropImage];
    [self.view addSubview:xzImg];
    [UIView animateWithDuration:0.7 animations:^{
        xzImg.frame=self->_headImageView.frame;
    } completion:^(BOOL finished) {
        //[_photoButton setBackgroundImage:[_cropImageView cropImage] forState:UIControlStateNormal];
        [self->headImageArray removeAllObjects];
        self->_headImageView.image=[self->_cropImageView cropImage] ;
        [self->headImageArray addObject:[self->_cropImageView cropImage]];
        
        [xzImg removeFromSuperview];
    }];
    isSelectedPhoto=YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
