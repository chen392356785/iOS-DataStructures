//
//  PerfectInformationViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import "InformationEditViewController.h"

//#import "AliyunOSSUpload.h"
//#import "keychainItemManager.h"
#import "JLSimplePickViewComponent.h"
@interface PerfectInformationViewController ()<JLActionSheetDelegate>

{
    UIButton *_manBtn;
    UIButton *_famaleBtn;
    SMLabel *_manLbl;
    SMLabel *_famaleLbl;
    BOOL _sex;
    NSMutableArray *hyArray; //行业list
    UIAsyncImageView *_headImageView;
    NSMutableArray *headImageArray;
}
@end

@implementation PerfectInformationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //  self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"完善个人资料"];
    
    headImageArray=[[NSMutableArray alloc]init];
    
    __weak PerfectInformationViewController *weakSelf=self;
    UIImage *headImg=Image(@"defaulthead125.png");
    UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 10, headImg.size.width, headImg.size.height)];
    headImageView.image=headImg;
    [headImageView setLayerMasksCornerRadius:headImg.size.width/2 BorderWidth:0 borderColor:[UIColor clearColor]];
    headImageView.userInteractionEnabled=YES;
    _headImageView=headImageView;
    headImageView.centerX=self.view.centerX;
    [_BaseScrollView addSubview:headImageView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
    [headImageView addGestureRecognizer:tap];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, headImageView.bottom+10, 84, 20) textColor:cGrayLightColor textFont:sysFont(14)];
    lbl.text=@"点击更换头像";
    lbl.centerX=headImageView.centerX;
    [_BaseScrollView addSubview:lbl];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, lbl.bottom+20, WindowWith, 5)];
    lineView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView];
    
    //姓名
    MapAnnotationView *nameEditView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(0, lineView.bottom+10, WindowWith, 48) name:@"昵称" ifMust:YES];
    nameEditView.lbl.text=@"尚未填写";
    nameEditView.tag=1000;
    _nickNamelbl=nameEditView;
    nameEditView.lbl.textColor=RGBA(232, 121, 117, 1);
    nameEditView.selectBlock=^(NSInteger index){
        NSLog(@"姓名");
        [weakSelf editWithTitle:@"昵称" type:SelectNameBlock :NO];
    };
    [_BaseScrollView addSubview:nameEditView];
    
    //性别
    UIView *sexView=[[UIView alloc]initWithFrame:CGRectMake(nameEditView.left, nameEditView.bottom, nameEditView.width, nameEditView.height)];
    SMLabel *sexLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(40, 15, 30, 20) textColor:cBlackColor textFont:sysFont(15)];
    [sexView addSubview:sexLbl];
    sexLbl.text=@"性别";
    UIImage *photoimg=Image(@"redstar.png");
    UIImageView *photoImgView=[[UIImageView alloc]initWithImage:photoimg];
    photoImgView.frame=CGRectMake(20, sexLbl.top, photoimg.size.width, photoimg.size.height);
    [sexView addSubview:photoImgView];
    [_BaseScrollView addSubview:sexView];
    
    _manBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _famaleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *manImg=Image(@"iconfont_nan_select.png");
    UIImage *unmanImg=Image(@"iconfont_nan.png");
    UIImage *famaleImg=Image(@"iconfont_nv_select.png");
    UIImage *unfamale=Image(@"iconfont_nv.png");
    [_manBtn setImage:[unmanImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    _manBtn.selected=YES;
    [_manBtn setTitle:@"男" forState:UIControlStateNormal];
    [_manBtn setImage:[manImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
    [_manBtn setTitleColor:cLineColor forState:UIControlStateNormal];
    [_manBtn setTitleColor:cBlackColor forState:UIControlStateSelected];
    _manBtn.titleLabel.font=sysFont(14);
    _manBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    
    [_famaleBtn setImage:[unfamale imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [_famaleBtn setTitle:@"女" forState:UIControlStateNormal];
    [_famaleBtn setImage:[famaleImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
    [_famaleBtn setTitleColor:cLineColor forState:UIControlStateNormal];
    [_famaleBtn setTitleColor:cBlackColor forState:UIControlStateSelected];
    _famaleBtn.titleLabel.font=sysFont(14);
    _famaleBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(20, sexView.bottom, WindowWith-40, 1)];
    lineView2.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView2];
    
    _famaleBtn.frame=CGRectMake(lineView2.right-50, sexLbl.top-10, famaleImg.size.width+50, famaleImg.size.height+20);
    
    _manBtn.frame=CGRectMake(_famaleBtn.left-90, sexLbl.top-10, manImg.size.width+50, manImg.size.height+20);
    
    [_manBtn addTarget:self action:@selector(selectedChange:) forControlEvents:UIControlEventTouchUpInside];
    [_famaleBtn addTarget:self action:@selector(selectedChange:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:_manBtn];
    [sexView addSubview:_famaleBtn];
    
    //公司
    MapAnnotationView *companyView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(0, lineView2.bottom, WindowWith, 48) name:@"公司" ifMust:YES];
    companyView.lbl.text=@"尚未填写";
    companyView.tag=1001;
    _companylbl=companyView;
    companyView.lbl.textColor=RGBA(232, 121, 117, 1);
    companyView.selectBlock=^(NSInteger index){
        NSLog(@"公司");
        [weakSelf editWithTitle:@"公司名称" type:SelectCompanyBlock :NO];
    };
    [_BaseScrollView addSubview:companyView];
    
    //行业
    NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
    hyArray=[[NSMutableArray alloc]initWithArray:dic2[@"industryInfoList"]];
    
    MapAnnotationView *industryView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(companyView.left, companyView.bottom, companyView.width, companyView.height) name:@"行业" ifMust:YES];
    industryView.tag=1002;
    _industrylbl=industryView;
    industryView.lbl.text=@"尚未填写";
    industryView.lbl.textColor=RGBA(232, 121, 117, 1);
    industryView.selectBlock=^(NSInteger index){
        NSLog(@"苗木基地");
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in self->hyArray) {
            [arr addObject:dic[@"i_name"]];
        }
        [weakSelf showPicViewWithArr:arr :@"行业" :21];
    };
    [_BaseScrollView addSubview:industryView];
    
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(0, industryView.bottom-1, WindowWith, 210)];
    lineView3.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView3];
    
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame = CGRectMake(0, lineView3.top+60, WindowWith-80, 40);
	btn.backgroundColor = cGreenColor;
	[btn setTintColor:[UIColor whiteColor]];
	[btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
	[btn setTitle:@"完  成" forState:UIControlStateNormal];
	btn.titleLabel.font = sysFont(18.8);
	[lineView3 addSubview:btn];
	btn.centerX = self.view.centerX;
	btn.layer.cornerRadius = 21;
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, lineView3.bottom);
}

-(void)submitClick:(UIButton *)sender{
    if (!isSelectedPhoto) {
        [self addSucessView:@"请上传头像哦" type:2];
        return;
    }
    if ([_nickNamelbl.lbl.text isEqualToString:@"尚未填写"]) {
        [self addSucessView:@"请输入您的昵称" type:2];
        return;
    }
    
    if ([_companylbl.lbl.text isEqualToString:@"尚未填写"]) {
        [self addSucessView:@"请填写公司名称" type:2];
        return;
    }
    
    if ([_industrylbl.lbl.text isEqualToString:@"尚未填写"]) {
        [self addSucessView:@"请选择行业" type:2];
        return;
    }
    
    [self addWaitingView];
    [AliyunUpload uploadImage:headImageArray FileDirectory:ENT_fileImageHeader success:^(NSString *obj) {
        NSString *sexStr;
        if (self->_manBtn.selected) {
            sexStr=@"1";
        }else{
            sexStr=@"2";
        }
        
//        NSDictionary *dic2=[self->hyArray objectAtIndex:self->_selIndex];
//        NSString *i_typeID=[NSString stringWithFormat:@"%@",[dic2 objectForKey:@"i_type_id"]];
        [ConfigManager getAddressInfoWithUser_id:0 country:nil province:nil city:nil area:nil street:nil longitude:0 latitude:0 company_lon:0 company_lat:0 distance:0 company_province:nil company_city:nil company_area:nil company_street:nil];
    }];
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
    isSelectedPhoto=YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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

-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedIndex:(NSInteger)index{
    if (pickViewComponent.tag==21) {
        
        NSDictionary *dic=[hyArray objectAtIndex:index];
        EditInformationView *urgentView=[_BaseScrollView viewWithTag:1002];
        urgentView.lbl.textColor=cBlackColor;
        urgentView.lbl.text=[dic objectForKey:@"i_name"];
        _selIndex=index;
    }
}

-(void)displayTiyle:(NSString *)title type:(EditBlock)type
{
    if (type==SelectNameBlock) {
        EditInformationView *view=[self.view viewWithTag:1000];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
    }
    
    if (type==SelectCompanyBlock) {
        EditInformationView *view=[self.view viewWithTag:1001];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
    }
    if (type==SelectIndustryBlock) {
        EditInformationView *view=[self.view viewWithTag:1002];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
    }
}

- (void)selectedChange:(UIButton *)sender
{
    _manBtn.selected = NO;
    _famaleBtn.selected = NO;
    sender.selected = YES;
    if (_manBtn.selected) {
        _sex=YES;
    }else
    {
        _sex=NO;
    }
}

//跳转填写
-(void)editWithTitle:(NSString *)title type:(EditBlock)type :(BOOL)isLongString
{
    InformationEditViewController *editView=[[InformationEditViewController alloc]init];
    editView.titl=title;
    editView.isLongString=isLongString;
    editView.delegate=self;
    editView.type=type;
    [self pushViewController:editView];
}

-(void)certain
{
	NSString *s;
	if (_sex) {
		s=@"男";
	}else
	{
		s=@"女";
	}
//
//    EditInformationView *name=[self.view viewWithTag:1000];
//    EditInformationView *company=[self.view viewWithTag:1001];
//    EditInformationView *urgentView=[_BaseScrollView viewWithTag:1002];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
