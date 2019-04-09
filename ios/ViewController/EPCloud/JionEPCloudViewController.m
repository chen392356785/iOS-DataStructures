//
//  JionEPCloudViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/8/26.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "JionEPCloudViewController.h"
//#import "keychainItemManager.h"
#import "KICropImageView.h"
#import "JLSimplePickViewComponent.h"
#import "InformationEditViewController.h"
#import "MTChooseViewController.h"
#import "CompanyInformationViewController.h"
#import "IdentAuthViewController.h"
#import "XHFriendlyLoadingView.h"
@interface JionEPCloudViewController ()<JLActionSheetDelegate,HJCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,EditInformationDelegate>
{
     UIAsyncImageView *_headImageView;
     KICropImageView* _cropImageView;
     NSMutableArray *headImageArray;
      NSArray *positionArr;
      int job_type;
    JionEPCloudInfoModel *_model;
    EditInformationView *_zhuyingView;
    UIView *_bgView1;
}
@end

@implementation JionEPCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"加入园林云"];
     headImageArray=[[NSMutableArray alloc]init];

    [self reloadUserInfo];
    
    self.view.backgroundColor=RGB(247, 248, 250);
}
- (void)reloadUserInfo
{
    [self addPushViewWaitingView];
   
   
    [network getUserInfoFollow_id:@"0" success:^(NSDictionary *obj) {
        self->_model = obj[@"content"];
        NSLog(@"%@",obj[@"dic"]);
        [IHUtility saveDicUserDefaluts:obj[@"dic"] key:kUserDefalutLoginInfo];
        [self creatView];

        
    } failure:^(NSDictionary *obj2) {
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}


-(void)creatView{
    
    
    NSDictionary *Dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
    positionArr=[IHUtility getUserdefalutsList:kUserDefalutPositionInfo];

    [network selectPublicDicInfo:1 success:^(NSDictionary *obj) {
        [NSUserDefaults standardUserDefaults];

        [IHUtility saveUserDefaluts:obj[@"content"]  key:kUserDefalutPositionInfo];
        
        [self removePushViewWaitingView];
        
    } failure:^(NSDictionary *obj2) {
        
    }];

    
    UIView *promptView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 41.5)];
    promptView.backgroundColor=[UIColor whiteColor];
    [_BaseScrollView addSubview:promptView];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, WindowWith, 14) textColor:cGrayLightColor textFont:sysFont(13.5)];
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.center=promptView.center;
    lbl.text=@"完善资料，让更多的机会来找你。";
    [promptView addSubview:lbl];
    
    if ([Dic[@"auth_status"] intValue]==1) {
        promptView.backgroundColor=RGB(245, 165, 35);
        lbl.text=[NSString stringWithFormat:@"您的申请已提交%@客服审核，请耐心等待。",KAppName];
        lbl.textColor=[UIColor whiteColor];
        
      
            for (int i=1; i<7; i++) {
                EditInformationView *view=[_bgView1 viewWithTag:1000+i];
                view.userInteractionEnabled = NO;
            }
        
        

        
    }else if ([Dic[@"auth_status"] intValue]==2){
        promptView.backgroundColor=cGreenColor;
        lbl.text=@"恭喜，您的园林云申请已通过，谢谢关注。";
        lbl.textColor=[UIColor whiteColor];
        
    }else if ([Dic[@"auth_status"] intValue]==3){
        promptView.backgroundColor=RGB(232, 121, 117);
        lbl.text=@"审核未通过，请修正“X”图标部分的资料，详询客服。";
        lbl.textColor=[UIColor whiteColor];
        
    }
    
    
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, promptView.height-1, WindowWith, 1)];
    lineView.backgroundColor=cLineColor;
    [promptView addSubview:lineView];
    
    
    
    UIView *bgView1=[[UIView alloc]initWithFrame:CGRectMake(0, promptView.bottom, WindowWith, 500)];
    
    bgView1.backgroundColor=[UIColor whiteColor];
    _bgView1=bgView1;
    [_BaseScrollView addSubview:bgView1];
    
  
    UIImage *headImg=Image(@"defaulthead70x70.png");
    _headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(WindowWith-21-headImg.size.width, 14,65, 65)];
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,Dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
    _headImageView.layer.cornerRadius=_headImageView.width/2;
    _headImageView.clipsToBounds=YES;
    _headImageView.centerX=self.view.centerX;
    _headImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
    [_headImageView addGestureRecognizer:tap];
    
    [bgView1 addSubview:_headImageView];
    
    SMLabel * headLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(23, (headImg.size.height-15)/2.0+_headImageView.top, 35, 15) textColor:cBlackColor textFont:sysFont(15)];
    headLabel.text=@"头像";
    [bgView1 addSubview:headLabel];
    
    
    UIImage *img=Image(@"GQ_Left.png");
    UIImageView *toImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-img.size.width-15, 0, img.size.width, img.size.height)];
    toImageView.centerY=_headImageView.centerY;
    [bgView1 addSubview:toImageView];
    toImageView.image=img;
    
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, _headImageView.bottom+10, WindowWith, 6)];
    lineView1.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView1];

    
    
    
    
    
    
    //姓名
    EditInformationView *nameEditView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, lineView1.bottom, WindowWith-30, 54) name:@"真实姓名"];
    
        __weak JionEPCloudViewController *weakSelf = self;
    __weak EditInformationView *weakNameView=nameEditView;
    nameEditView.lbl.text=@"必填";
    nameEditView.lbl.textColor=cBlackColor;
    NSString *name;
    if (![Dic[@"nickname"] isEqualToString:@""]) {
        nameEditView.lbl.text=Dic[@"nickname"];
        name=nameEditView.lbl.text;
        nameEditView.lbl.textColor=cGrayLightColor;
    }
    nameEditView.selectBlock=^(NSInteger index){
        
        NSLog(@"name");
        NSString *s=@"真实姓名";
        [weakSelf editWithTitle:s type:SelectNameBlock:NO text:weakNameView.lbl.text];
        
    };
    nameEditView.tag=1001;
    [bgView1 addSubview:nameEditView];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, nameEditView.bottom, WindowWith, 1)];
    lineView2.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView2];

    
    
    
    
    //电话
    EditInformationView *phoneView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView2.bottom, nameEditView.width, nameEditView.height) name:@"手机号码"];
    phoneView.lbl.text=@"必填";
    phoneView.lbl.textColor=cBlackColor;
    NSString *phone;
    if (![Dic[@"mobile"] isEqualToString:@""]) {
        phoneView.lbl.text=Dic[@"mobile"];
        phone=phoneView.lbl.text;
        phoneView.lbl.textColor=cGrayLightColor;
        
    }
    __weak EditInformationView *weakAdressView=phoneView;
    phoneView.selectBlock=^(NSInteger index){
        
        NSString *s=@" 手机号码";
        [weakSelf editWithTitle:s type:SelectPhoneBlock:NO text:weakAdressView.lbl.text];
    };
    phoneView.tag=1002;
    [bgView1 addSubview:phoneView];
    UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(0, phoneView.bottom, WindowWith, 1)];
    lineView4.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView4];

    
    
    
    //邮箱
    EditInformationView *emailView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView4.bottom, phoneView.width, phoneView.height) name:@"电子邮件"];
    emailView.lbl.text=@"选填";
    emailView.lbl.textColor=cGrayLightColor;
    NSString *email;
    if (![Dic[@"email"] isEqualToString:@""]) {
        emailView.lbl.text=Dic[@"email"];
        email=emailView.lbl.text;
        emailView.lbl.textColor=cGrayLightColor;
    }
    __weak EditInformationView *weakEmailView=emailView;
    emailView.selectBlock=^(NSInteger index){
        NSLog(@"email");
        NSString *s=@"电子邮件";
        [weakSelf editWithTitle:s type:SelectEmailBlock:NO text:weakEmailView.lbl.text];
    };
    emailView.tag=1003;
    [bgView1 addSubview:emailView];

        UIView *lineView5=[[UIView alloc]initWithFrame:CGRectMake(0, emailView.bottom, WindowWith, 1)];
        lineView5.backgroundColor=cLineColor;
        [bgView1 addSubview:lineView5];

    
    
    
    
    
    //头衔标签
    EditInformationView *companyView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, lineView5.bottom, WindowWith-30, emailView.height) name:@"头衔标签"];
    companyView.lbl.text=@"选填";
    companyView.lbl.textColor=cGrayLightColor;
    NSString *company;
    if (![Dic[@"title"] isEqualToString:@""]) {
        companyView.lbl.text=Dic[@"title"];
        company=Dic[@"title"];
        companyView.lbl.textColor=cGrayLightColor;
    }
   // __weak EditInformationView *weakCompanyView=companyView;
    companyView.selectBlock=^(NSInteger index){
        NSLog(@"company");
        NSString *s=@"头衔标签";
        [weakSelf pushToChooseVC:s type:SelectLabelBlock];
    };
    companyView.tag=1004;
    [bgView1 addSubview:companyView];
    UIView *lineView6=[[UIView alloc]initWithFrame:CGRectMake(0, companyView.bottom, WindowWith, 1)];
    lineView6.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView6];

    
    
    
    
    
    //职位
    EditInformationView *positionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView6.bottom, nameEditView.width, nameEditView.height) name:@"职位名称"];
    positionView.tag=1005;
    positionView.lbl.text=@"选填";
    positionView.lbl.textColor=cGrayLightColor;
    NSString *position;
    if (![Dic[@"position"] isEqualToString:@""]) {
        positionView.lbl.text=Dic[@"position"];
        position= positionView.lbl.text;
        positionView.lbl.textColor=cGrayLightColor;
    }
    __weak EditInformationView *weakPositionView=positionView;
    positionView.selectBlock=^(NSInteger index){
        NSLog(@"position");
        NSString *s=@"职位名称";
        [weakSelf editWithTitle:s type:SelectPositionNameBlock:NO text:weakPositionView.lbl.text];
        
        
    };
    [bgView1 addSubview:positionView];
    UIView *lineView8=[[UIView alloc]initWithFrame:CGRectMake(0, positionView.bottom, WindowWith, 7.5)];
    lineView8.backgroundColor=RGB(247, 248, 250);
    [bgView1 addSubview:lineView8];

    
    
    //身份认证
    EditInformationView *zhuyingView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView8.bottom, positionView.width, positionView.height) name:@"身份认证"];
    zhuyingView.lbl.text=@"未认证";
    zhuyingView.lbl.textColor=cBlackColor;
    _zhuyingView = zhuyingView;

    if ( [Dic[@"authenticationInfo"][@"status"] intValue]== 1) {
        zhuyingView.lbl.text=@"审核中";
        zhuyingView.userInteractionEnabled =  NO;
    }else if ( [Dic[@"authenticationInfo"][@"status"] intValue]== 2){
        zhuyingView.lbl.text=@"认证成功";
        zhuyingView.userInteractionEnabled =  NO;
    }else if ( [Dic[@"authenticationInfo"][@"status"] intValue]== 3){
        zhuyingView.lbl.text=@"认证失败";

    }
   // __weak NSString *zhuying = _zhuying;
    zhuyingView.selectBlock=^(NSInteger index){
        
        [weakSelf IdentAuth];
    };
    zhuyingView.tag=1006;
    [bgView1 addSubview:zhuyingView];
    UIView *lineView9=[[UIView alloc]initWithFrame:CGRectMake(0, zhuyingView.bottom, WindowWith, 7.5)];
    lineView9.backgroundColor=RGB(247, 248, 250);
    [bgView1 addSubview:lineView9];

    
    
    
    
    EditInformationView *introductionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView9.bottom, positionView.width, positionView.height) name:@"所在公司"];
    
    introductionView.lbl.text=@"必填";
    introductionView.lbl.textColor=cBlackColor;
    
   // __weak NSString *introduction = _introduction;
    if (![Dic[@"companyinfo"][@"company_name"] isEqualToString:@""]) {
        
        introductionView.lbl.text=Dic[@"companyinfo"][@"company_name"];
        introductionView.lbl.textColor=cGrayLightColor;
        
    }
    
    
    introductionView.selectBlock=^(NSInteger index){
        
      [weakSelf pushToCompany];
    };
    introductionView.tag=1007;
    
    
    [bgView1 addSubview:introductionView];

    
    
    UIView *lineView10=[[UIView alloc]initWithFrame:CGRectMake(0, introductionView.bottom, WindowWith, 1)];
    lineView10.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView10];

    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"客服" style:UIBarButtonItemStylePlain target:self action:@selector(kefu)];
    
    [item1 setTintColor:cGreenColor];
    self.navigationItem.rightBarButtonItem=item1;
    
    bgView1.size=CGSizeMake(WindowWith, lineView10.bottom);
    
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0, bgView1.bottom+20, WindowWith-50, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"提  交" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=sysFont(18.8);
    [_BaseScrollView addSubview:btn];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=20;
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, btn.bottom+30+promptView.bottom);

    
    if ([Dic[@"auth_status"] intValue]==1) {
       
        
        
        for (int i=1; i<8; i++) {
            EditInformationView *view=[_bgView1 viewWithTag:1000+i];
            view.userInteractionEnabled = NO;
            _headImageView.userInteractionEnabled=NO;
            btn.enabled=NO;
        }
        
        
        
        
    }else if ([Dic[@"auth_status"] intValue]==2){
     
        
         [btn setTitle:@"修  改" forState:UIControlStateNormal];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NotificationIdentAuth object:nil];
    
    
    
}
- (void)notification:(NSNotification *)notification
{
    if (notification.object !=nil) {
        
        _zhuyingView.lbl.text = @"已上传";
    }
}


-(void)pushToCompany{
    CompanyInformationViewController  *vc=[[CompanyInformationViewController alloc]init];
    vc.model = _model;
    vc.selectBlock=^(NSString *name){
        EditInformationView *view=[self.view viewWithTag:1007];
        view.lbl.text=name;
        view.lbl.textColor=cBlackColor;
    };
    [self pushViewController:vc];
    
    
}






-(void)kefu{
    
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
//    NSString *phoneString = @"tel:400-077-9991";
//    UIWebView * callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
//    [self.view addSubview:callWebview];

    
    UIAlertView *alertView = [UIAlertView alertViewWithTitle:nil
                                                     message:KTelNum
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@[ @"呼叫" ]
                                                   onDismiss:^(NSInteger buttonIndex) {
                                                       [[UIApplication sharedApplication]
                                                        openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", KTelNum]]];
                                                       
                                                   }
                                                    onCancel:nil];
    [alertView show];

}


-(void)pushToChooseVC:(NSString *)text type:(EditBlock)type{
    
    MTChooseViewController *vc=[[MTChooseViewController alloc]init];
    vc.text=text;
    vc.delegate=self;
    vc.type=type;
    [self pushViewController:vc];
}

- (void)IdentAuth
{
    IdentAuthViewController *vc = [[IdentAuthViewController alloc] init];
    vc.auth_id = [NSString stringWithFormat:@"%ld",_model.authInfoModel.auth_id];
    [self pushViewController:vc];
}

//跳转填写
-(void)editWithTitle:(NSString *)title type:(EditBlock)type :(BOOL)isLongString text:(NSString *)text
{
    InformationEditViewController *editView=[[InformationEditViewController alloc]init];
    editView.titl=title;
    editView.delegate=self;
    editView.text=text;
    editView.isLongString=isLongString;
    editView.type=type;
    [self pushViewController:editView];
}



-(void)displayTiyle:(NSString *)title type:(EditBlock)type
{
    if (type==SelectNameBlock) {
        EditInformationView *view=[self.view viewWithTag:1001];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
    if (type==SelectPositiontypeBlock) {
        EditInformationView *view=[self.view viewWithTag:1005];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
        for (NSDictionary *obj in positionArr) {
            for (NSDictionary *dic in obj[@"data"]) {
                if ([title isEqualToString:dic[@"job_name"]]) {
                    job_type=[dic[@"job_id"] intValue];
                }
                
            }
        }
        
        
    }
    if (type==SelectLabelBlock) {
        EditInformationView *view=[self.view viewWithTag:1004];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
 
    if (type==SelectPhoneBlock) {
        EditInformationView *view=[self.view viewWithTag:1002];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
    if (type==SelectEmailBlock) {
        EditInformationView *view=[self.view viewWithTag:1003];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
       
    if (type==SelectPositionNameBlock) {
        EditInformationView *view=[self.view viewWithTag:1005];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
    
    
    
}


- (void)submitClick:(UIButton *)button
{
    
    EditInformationView *nameEditView=[_bgView1 viewWithTag:1001];
    NSString *name=@"";
    if (![nameEditView.lbl.text isEqualToString:@"必填"]) {
        name=nameEditView.lbl.text;
    }else{
        [self addSucessView:@"未填写真实姓名" type:2];
        return;
    }
    
    EditInformationView *sexView=[_bgView1 viewWithTag:1002];
    NSString *sexy=@"";
    if (![sexView.lbl.text isEqualToString:@"必填"]) {
        sexy=sexView.lbl.text;
    }else
    {
        [self addSucessView:@"未填写真实姓名" type:2];
        return;
    }
    
    
    EditInformationView *adressView=[_bgView1 viewWithTag:1003];
    NSString *adress=@"";
   
    if (![adressView.lbl.text isEqualToString:@"必填"]) {
        adress=adressView.lbl.text;
        
    }else{
        [self addSucessView:@"未填写电子邮件" type:2];
        return;
    }
    
    EditInformationView *companyView=[_bgView1 viewWithTag:1004];
    NSString *company=@"";
    if (![companyView.lbl.text isEqualToString:@"选填"]) {
        company=companyView.lbl.text;
    }
    
    EditInformationView *phoneView=[_bgView1 viewWithTag:1005];
    NSString *phone=@"";
    if (![phoneView.lbl.text isEqualToString:@"选填"]) {
        phone=phoneView.lbl.text;
    }
    
    EditInformationView *emailView=[_bgView1 viewWithTag:1006];

    if ([emailView.lbl.text isEqualToString:@"未认证"]) {
        [self addSucessView:@"未认证身份" type:2];
        return;
        
    }
    
    EditInformationView *positionView=[_bgView1 viewWithTag:1007];
    
    if ([positionView.lbl.text isEqualToString:@"必填"]) {
        [self addSucessView:@"未填写所在公司" type:2];
        return;
    }

    
    
    
    
    NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo]];
  
   // [self addWaitingView];
    if (headImageArray.count>0) {
        [AliyunUpload uploadImage:headImageArray FileDirectory:ENT_fileImageHeader success:^(NSString *obj) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [Dic setObject:obj forKey:@"heed_image_url"];
                 [Dic setObject:sexy forKey:@"nickname"];
                 [Dic setObject:adress forKey:@"email"];
                 [Dic setObject:company forKey:@"title"];
                 [Dic setObject:phone forKey:@"position"];
//                 int jobType=0;
//                 for (NSDictionary *obj in positionArr) {
//                     for (NSDictionary *dic2 in obj[@"data"]) {
//                         if ([phone isEqualToString:dic2[@"job_name"]]) {
//                             jobType=[dic2[@"job_id"] intValue];
//                         }
//                         
//                         
//                         
//                     }
//                 }
//                 
//                 
//                 [Dic setObject:stringFormatInt(jobType) forKey:@"i_type_id"];
                 
                 
                 [IHUtility saveDicUserDefaluts:Dic key:kUserDefalutLoginInfo];
                // [IHUtility addWaitingView];
                 [network authenticationForUser:Dic success:^(NSDictionary *obj) {
                     [IHUtility removeWaitingView];
                     
                     if ([Dic[@"auth_status"] intValue]==2){
                         
                         [IHUtility addSucessView:@"修改成功" type:1];
                       
                     }else{
                         [IHUtility addSucessView:@"提交成功,请耐心等待审核" type:1];
                     }

                     
                     [self back:nil];
                     
                 } failure:^(NSDictionary *obj2) {
                     
                 }];

             });
          
            
            
        }];
        
        
    }else{
        [Dic setObject:name forKey:@"nickname"];
        [Dic setObject:sexy forKey:@"mobile"];
        [Dic setObject:adress forKey:@"email"];
        [Dic setObject:company forKey:@"title"];
        [Dic setObject:phone forKey:@"position"];
//        int jobType=0;
//        for (NSDictionary *obj in positionArr) {
//            for (NSDictionary *dic2 in obj[@"data"]) {
//                if ([phone isEqualToString:dic2[@"job_name"]]) {
//                    jobType=[dic2[@"job_id"] intValue];
//                }
//                
//                
//                
//            }
//        }
//        
//        
//        [Dic setObject:stringFormatInt(jobType) forKey:@"i_type_id"];
         [IHUtility saveDicUserDefaluts:Dic key:kUserDefalutLoginInfo];
      //  [IHUtility addWaitingView];
        [network authenticationForUser:Dic success:^(NSDictionary *obj) {
            [IHUtility removeWaitingView];
            
            if ([Dic[@"auth_status"] intValue]==2){
                
                [IHUtility addSucessView:@"修改成功" type:1];
                
            }else{
                [IHUtility addSucessView:@"提交成功,请耐心等待审核" type:1];
            }
            

            [self back:nil];
            
        } failure:^(NSDictionary *obj2) {
            
        }];


    }
    
    
    
    
    
    
    
    
    
    
}




-(void)headTap:(UITapGestureRecognizer *)tap{
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", nil];
    // 2.显示出来
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
    [_BaseScrollView addSubview:v];
    
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
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationIdentAuth object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
