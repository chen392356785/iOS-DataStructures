//
//  EditPersonInformationViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/24.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "EditPersonInformationViewController.h"
#import "InformationEditViewController.h"
#import "JLSimplePickViewComponent.h"
//#import "AliyunOSSUpload.h"
//#import "keychainItemManager.h"
#import "KICropImageView.h"
#import "MTChooseViewController.h"
//#import "BindenterpriseViewController.h"
@interface EditPersonInformationViewController()<JLActionSheetDelegate,HJCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIButton *_manBtn;
    UIButton *_famaleBtn;
    SMLabel *_manLbl;
    SMLabel *_famaleLbl;
    NSString *_zhuying;
    NSString *_introduction;
    NSArray *hyArray;
     NSMutableArray *headImageArray;
    NSInteger _selIndex;
    KICropImageView* _cropImageView;
     UIAsyncImageView *_headImageView;
    int job_type;
    UIView * bgView1;
    UIView * bgView2;
    
    NSArray *positionArr;
    NSInteger company_id;
    
}
@end

@implementation EditPersonInformationViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    _BaseScrollView.backgroundColor=RGB(232, 240, 240);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    positionArr=[IHUtility getUserdefalutsList:kUserDefalutPositionInfo];
    [self addWaitingView];
    [network selectPublicDicInfo:1 success:^(NSDictionary *obj) {
        [NSUserDefaults standardUserDefaults];
        [self removeWaitingView];
        [IHUtility saveUserDefaluts:obj[@"content"]  key:kUserDefalutPositionInfo];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
    
   NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
   
    hyArray=[[NSMutableArray alloc]init];
    headImageArray=[[NSMutableArray alloc]init];
    
    [self setTitle:@"编辑个人资料"];
    
    if (self.type==ENT_Visitingcard) {
    [self setTitle:@"申请个人名片"];
    }
    
    bgView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 319)];
    bgView1.backgroundColor=[UIColor whiteColor];
    [_BaseScrollView addSubview:bgView1];
    
    bgView2=[[UIView alloc]initWithFrame:CGRectMake(0, bgView1.bottom+2, WindowWith, 222)];
   
    if (self.type==ENT_Visitingcard) {
        bgView2.frame=CGRectMake(0, bgView1.bottom+2, WindowWith, 282);
    }
    
    bgView2.backgroundColor=[UIColor whiteColor];
    [_BaseScrollView addSubview:bgView2];
    
    //头像
    
    UIImage *headImg=Image(@"defaulthead70x70.png");
    _headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(WindowWith-21-headImg.size.width, 14,65, 65)];
     [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
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
    
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, _headImageView.bottom+10, WindowWith, 6)];
    lineView1.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView1];
    
    //姓名
    EditInformationView *nameEditView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, lineView1.bottom, WindowWith-30, 54) name:@"真实姓名"];
     __weak EditPersonInformationViewController *weakSelf = self;
    __weak EditInformationView *weakNameView=nameEditView;
    nameEditView.lbl.text=@"尚未填写";
    nameEditView.lbl.textColor=cGrayLightColor;
    NSString *name;
    if (![dic[@"nickname"] isEqualToString:@""]) {
        nameEditView.lbl.text=dic[@"nickname"];
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
    
   //性别
    
    EditInformationView *sexView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView2.bottom, nameEditView.width, nameEditView.height) name:@"性别"];
        if ([dic[@"sexy"] integerValue]==1) {
            sexView.lbl.text=@"男";
        }else{
            sexView.lbl.text=@"女";
        }
    sexView.lbl.textColor=cGrayLightColor;
    sexView.selectBlock=^(NSInteger index){
        NSLog(@"sex");
        [weakSelf showPicViewWithArr:@[@"男",@"女"] :@"性别" :22];
    };
    sexView.tag=100;
    [bgView1 addSubview:sexView];
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(0, sexView.bottom, WindowWith, 1)];
    lineView3.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView3];
    
    //电话
    EditInformationView *phoneView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView3.bottom, sexView.width, sexView.height) name:@"联系电话"];
    phoneView.lbl.text=@"尚未填写";
    phoneView.lbl.textColor=cGrayLightColor;
    NSString *phone;
    if (![dic[@"mobile"] isEqualToString:@""]) {
        phoneView.lbl.text=dic[@"mobile"];
        phone=phoneView.lbl.text;
        phoneView.lbl.textColor=cGrayLightColor;
    }
    __weak EditInformationView *weakAdressView=phoneView;
    phoneView.selectBlock=^(NSInteger index){
        
        NSString *s=@"联系电话";
        [weakSelf editWithTitle:s type:SelectPhoneBlock:NO text:weakAdressView.lbl.text];
    };
    phoneView.tag=1006;
    [bgView1 addSubview:phoneView];
    UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(0, phoneView.bottom, WindowWith, 1)];
    lineView4.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView4];
    
    //邮箱
    EditInformationView *emailView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView4.bottom, phoneView.width, phoneView.height) name:@"电子邮件"];
    emailView.lbl.text=@"选填";
    emailView.lbl.textColor=cGrayLightColor;
    NSString *email;
    if (![dic[@"email"] isEqualToString:@""]) {
        emailView.lbl.text=dic[@"email"];
        email=emailView.lbl.text;
        emailView.lbl.textColor=cGrayLightColor;
    }
    __weak EditInformationView *weakEmailView=emailView;
    emailView.selectBlock=^(NSInteger index){
        NSLog(@"email");
        NSString *s=@"电子邮件";
        [weakSelf editWithTitle:s type:SelectEmailBlock:NO text:weakEmailView.lbl.text];
    };
    emailView.tag=1007;
    [bgView1 addSubview:emailView];
    
//    UIView *lineView5=[[UIView alloc]initWithFrame:CGRectMake(emailView.left, emailView.bottom-2, WindowWith-2*nameEditView.left, 3)];
//    lineView5.backgroundColor=cLineColor;
//    [bgView1 addSubview:lineView5];
    
    //头衔标签
    EditInformationView *companyView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, 0, WindowWith-30, emailView.height) name:@"头衔标签"];
    companyView.lbl.text=@"尚未填写";
    companyView.lbl.textColor=cGrayLightColor;
    NSString *company;
    if (![dic[@"title"] isEqualToString:@""]) {
        companyView.lbl.text=dic[@"title"];
        company=dic[@"title"];
        companyView.lbl.textColor=cGrayLightColor;
    }
//    __weak EditInformationView *weakCompanyView=companyView;
    companyView.selectBlock=^(NSInteger index){
        NSLog(@"company");
        NSString *s=@"头衔标签";
        [weakSelf pushToChooseVC:s type:SelectLabelBlock];
    };
    companyView.tag=1003;
    [bgView2 addSubview:companyView];
    UIView *lineView6=[[UIView alloc]initWithFrame:CGRectMake(0, companyView.bottom, WindowWith, 1)];
    lineView6.backgroundColor=cLineColor;
    [bgView2 addSubview:lineView6];
    
    //所属部门
    
    EditInformationView *IndustryView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView6.bottom, nameEditView.width, nameEditView.height) name:@"所属部门"];
    NSString *industry;
    IndustryView.lbl.text=@"尚未填写";
    IndustryView.lbl.textColor=cGrayLightColor;
    if (![dic[@"department"] isEqualToString:@""]) {
        IndustryView.lbl.text=dic[@"department"];
        industry=dic[@"department"];
        IndustryView.lbl.textColor=cGrayLightColor;
    }
      __weak EditInformationView *weakIndustryView=IndustryView;
    IndustryView.selectBlock=^(NSInteger index){
     
         [weakSelf editWithTitle:@"所属部门" type:SelectDepartmentBlock:NO text:weakIndustryView.lbl.text];
    };
    IndustryView.tag=1004;
    [bgView2 addSubview:IndustryView];
    UIView *lineView7=[[UIView alloc]initWithFrame:CGRectMake(0, IndustryView.bottom, WindowWith, 1)];
    lineView7.backgroundColor=cLineColor;
    [bgView2 addSubview:lineView7];
   
    //职位
    EditInformationView *positionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView7.bottom, nameEditView.width, nameEditView.height) name:@"职位类型"];
    positionView.tag=1002;
     positionView.lbl.text=@"必填";
    positionView.lbl.textColor=RGBA(232, 121, 117, 1);
//    NSString *position;
    for (NSDictionary *obj in positionArr) {
        for (NSDictionary *Dic in obj[@"data"]) {
            if (dic[@"job_type"]==Dic[@"job_id"]) {
                positionView.lbl.text=Dic[@"job_name"];
                positionView.lbl.textColor=cGrayLightColor;
            }
        }
    }
    
//    __weak EditInformationView *weakPositionView=positionView;
    positionView.selectBlock=^(NSInteger index){
        NSLog(@"position");
        NSString *s=@"职位类型";
        [weakSelf pushToChooseVC:s type:SelectPositiontypeBlock];
    };
    [bgView2 addSubview:positionView];
    UIView *lineView8=[[UIView alloc]initWithFrame:CGRectMake(0, positionView.bottom, WindowWith, 1)];
    lineView8.backgroundColor=cLineColor;
    [bgView2 addSubview:lineView8];
   
    //职位名称
    EditInformationView *zhuyingView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView8.bottom, positionView.width, positionView.height) name:@"职位名称"];
    zhuyingView.lbl.text=@"尚未填写";
    zhuyingView.lbl.textColor=cGrayLightColor;
    if (![dic[@"position"] isEqualToString:@""]) {
        zhuyingView.lbl.text=dic[@"position"];
        _zhuying=dic[@"position"];
        zhuyingView.lbl.textColor=cGrayLightColor;
    }
    
      __weak NSString *zhuying = _zhuying;
    zhuyingView.selectBlock=^(NSInteger index){
       
        NSString *s=@"职位名称";
        [weakSelf editWithTitle:s type:SelectPositionNameBlock:NO text:zhuying];
    };
    zhuyingView.tag=1008;
    [bgView2 addSubview:zhuyingView];
    UIView *lineView9=[[UIView alloc]initWithFrame:CGRectMake(0, zhuyingView.bottom, WindowWith, 5)];
    lineView9.backgroundColor=cLineColor;
    [bgView2 addSubview:lineView9];

    //简介
      if (self.type==ENT_Visitingcard) {
     
          EditInformationView *introductionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView9.bottom, positionView.width, positionView.height) name:@"企业绑定"];
          
          introductionView.lbl.text=@"选填";
          introductionView.lbl.textColor=cGrayLightColor;
          
//          __weak NSString *introduction = _introduction;
          if (![dic[@"company_name"] isEqualToString:@""]) {
              
              introductionView.lbl.text=dic[@"company_name"];
              introductionView.lbl.textColor=cGrayLightColor;
          }
          
          introductionView.selectBlock=^(NSInteger index){
            
//              NSString *s=@"企业绑定";
              //[weakSelf editWithTitle:s type:SelectIntroductionBlock:YES text:introduction];
              [self pushToCompany];
          };
          introductionView.tag=1009;
        
        [bgView2 addSubview:introductionView];
      }
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitClick:)];
   
    [item1 setTintColor:cGreenColor];
    self.navigationItem.rightBarButtonItem=item1;
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0, bgView2.bottom+20, WindowWith-50, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"提  交" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=sysFont(18.8);
    [_BaseScrollView addSubview:btn];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=21;
   
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, 666);
    
    if (btn.bottom>600) {
        _BaseScrollView.contentSize=CGSizeMake(WindowWith, btn.bottom+80);
        NSLog(@"%f",btn.bottom);
    }
}

-(void)pushToCompany{
	BindenterpriseViewController *vc=[[BindenterpriseViewController alloc]init];
	vc.delegate = self;
	[self pushViewController:vc];
}

-(void)disPalyBindCompany:(BindCompanyModel *)model{
    
    EditInformationView *view=[self.view viewWithTag:1009];
    view.lbl.text=model.company_name;
    view.lbl.textColor=cBlackColor;
    
    company_id=model.company_id ;
}

-(void)pushToChooseVC:(NSString *)text type:(EditBlock)type{

    MTChooseViewController *vc=[[MTChooseViewController alloc]init];
    vc.text=text;
    vc.delegate=self;
    vc.type=type;
    [self pushViewController:vc];
}

-(void)submitClick:(UIButton *)sender{
    
    EditInformationView *nameEditView=[_BaseScrollView viewWithTag:1001];
    NSString *name=@"";
    if (![nameEditView.lbl.text isEqualToString:@"尚未填写"]) {
        name=nameEditView.lbl.text;
    }
    int sexy;
//    if(_manBtn.selected) {
//        sexy=1;
//    }else
//    {
//        sexy=2;
//    }
    
    EditInformationView *sexView=[_BaseScrollView viewWithTag:100];
    if ([sexView.lbl.text isEqualToString:@"男"]) {
        sexy=1;
    }else
    {
        sexy=2;
    }
    
    EditInformationView *adressView=[_BaseScrollView viewWithTag:1005];
    NSString *adress=@"";
    if (![adressView.lbl.text isEqualToString:@"尚未填写"]) {
        adress=adressView.lbl.text;
    }
    
    EditInformationView *companyView=[_BaseScrollView viewWithTag:1003];
    NSString *company=@"";
    if (![companyView.lbl.text isEqualToString:@"尚未填写"]) {
        company=companyView.lbl.text;
    }
    EditInformationView *phoneView=[_BaseScrollView viewWithTag:1006];
    NSString *phone=@"";
    if (![phoneView.lbl.text isEqualToString:@"尚未填写"]&&![phoneView.lbl.text isEqualToString:@"(null)"]) {
        phone=phoneView.lbl.text;
    }
    
    EditInformationView *emailView=[_BaseScrollView viewWithTag:1007];
    NSString *email=@"";
    if (![emailView.lbl.text isEqualToString:@"选填"]) {
        email=emailView.lbl.text;
    }
    
    EditInformationView *positionView=[_BaseScrollView viewWithTag:1002];
    NSString *position=@"";
    if (![positionView.lbl.text isEqualToString:@"必填"]) {
        position=positionView.lbl.text;
    }
    
    
    EditInformationView *IndustryView=[_BaseScrollView viewWithTag:1004];
    NSString *industry=@"";
    if (![IndustryView.lbl.text isEqualToString:@"尚未填写"]&&![IndustryView.lbl.text isEqualToString:@"(null)"]) {
        industry=IndustryView.lbl.text;
    
    }
    EditInformationView *positionNameView=[_BaseScrollView viewWithTag:1008];
    NSString *positionName=@"";
    if (![positionNameView.lbl.text isEqualToString:@"尚未填写"]&&![positionNameView.lbl.text isEqualToString:@"(null)"]) {
        positionName=positionNameView.lbl.text;
    }
    
    if (headImageArray.count>0) {
        
           [self addWaitingView];
        [AliyunUpload uploadImage:headImageArray FileDirectory:ENT_fileImageHeader success:^(NSString *obj) {
            
            [network CompleteUserCloudInfoById:name title:company department:industry job_type:self->job_type position:positionName company_id:(int)self->company_id mobile:phone email:email user_id:[USERMODEL.userID intValue] heed_image_url:obj sexy:sexy job_name:position success:^(NSDictionary *obj) {
                
                [self removeWaitingView];
                NSDictionary *dic=[obj objectForKey:@"content"];
                [self addSucessView:@"保存成功" type:1];
                [ConfigManager setUserInfiDic:dic];
                [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateUserinfo object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
            
        }];

    }else
    {
              [self addWaitingView];
        [network CompleteUserCloudInfoById:name title:company department:industry job_type:job_type position:positionName company_id:(int)self->company_id mobile:phone email:email user_id:[USERMODEL.userID intValue] heed_image_url:@"" sexy:sexy job_name:position success:^(NSDictionary *obj) {
            
            NSLog(@"%@-%@-%@-%@",company,industry,positionName,position);
            
            [self removeWaitingView];
            NSDictionary *dic=[obj objectForKey:@"content"];
            [self addSucessView:@"保存成功" type:1];
            [ConfigManager setUserInfiDic:dic];
            [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateUserinfo object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
}

-(void)displayTiyle:(NSString *)title type:(EditBlock)type
{
    if (type==SelectNameBlock) {
        EditInformationView *view=[self.view viewWithTag:1001];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
    if (type==SelectPositiontypeBlock) {
        EditInformationView *view=[self.view viewWithTag:1002];
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
        EditInformationView *view=[self.view viewWithTag:1003];
        view.lbl.text=title;
         view.lbl.textColor=cBlackColor;
    }
    if (type==SelectDepartmentBlock) {
        EditInformationView *view=[self.view viewWithTag:1004];
        view.lbl.text=title;
         view.lbl.textColor=cBlackColor;
    }
    if (type==SelectAdressBlock) {
        EditInformationView *view=[self.view viewWithTag:1005];
        view.lbl.text=title;
         view.lbl.textColor=cBlackColor;
    }
    if (type==SelectPhoneBlock) {
        EditInformationView *view=[self.view viewWithTag:1006];
        view.lbl.text=title;
         view.lbl.textColor=cBlackColor;
    }
    if (type==SelectEmailBlock) {
        EditInformationView *view=[self.view viewWithTag:1007];
        view.lbl.text=title;
         view.lbl.textColor=cBlackColor;
    }
    if (type==SelectPositionNameBlock) {
        EditInformationView *view=[self.view viewWithTag:1008];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
        
          }
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

- (void)selectedChange:(UIButton *)sender
{
    _manBtn.selected = NO;
    _famaleBtn.selected = NO;
    sender.selected = YES;
}

-(void)showPicViewWithArr:(NSArray *)arr :(NSString *)title :(NSInteger)tag
{
    JLSimplePickViewComponent *pickView =(JLSimplePickViewComponent*)[self.view viewWithTag:tag];
    if(pickView == nil)
    {
        
        pickView = [[JLSimplePickViewComponent alloc] initWithParams:title withData:arr];
        pickView.tag=tag;
        pickView.ActionSheetDelegate = self;
    }
    [pickView show];
}

-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedData:(NSString *)SelectedStr
{
    if (pickViewComponent.tag==21) {
        NSLog(@"%@",SelectedStr);
        EditInformationView *urgentView=[_BaseScrollView viewWithTag:1004];
        urgentView.lbl.textColor=cBlackColor;
        urgentView.lbl.text=SelectedStr;
    }else
    {
        NSLog(@"%@",SelectedStr);
        EditInformationView *sexView=[_BaseScrollView viewWithTag:100];
        sexView.lbl.textColor=cBlackColor;
        sexView.lbl.text=SelectedStr;
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

@end
