//
//  CompanyAdditionalViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/8/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CompanyAdditionalViewController.h"
#import "InformationEditViewController.h"
#import "JLSimplePickViewComponent.h"
//#import "keychainItemManager.h"
#import "KICropImageView.h"
@interface CompanyAdditionalViewController ()<EditInformationDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HJCActionSheetDelegate>
{
	NSMutableArray *natureArray;
	NSArray *_arr;
	UIAsyncImageView *_headImageView;
	KICropImageView* _cropImageView;
	NSMutableArray *headImageArray;
	UIView *_bgView1;
	NSString *_zhuying;
	NSString *_jianjie;
	
}

@end

@implementation CompanyAdditionalViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setTitle:@"扩展信息"];
	headImageArray=[[NSMutableArray alloc]init];
	self.view.backgroundColor=RGB(247, 248, 250);
	[self creatView];
}


-(void)creatView{
	
	NSDictionary *Dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
	UIView *bgView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 500)];
	
	bgView1.backgroundColor=[UIColor whiteColor];
	[_BaseScrollView addSubview:bgView1];
	_bgView1=bgView1;
	
	if (self.model != nil) {
		bgView1.userInteractionEnabled = NO;
	}
	natureArray=[[NSMutableArray alloc]init];
	[network selectPublicDicInfo:3 success:^(NSDictionary *obj) {
		self->_arr=obj[@"content"];
		for (NSDictionary *dic in obj[@"content"]) {
			[self->natureArray addObject:dic[@"nature_name"]];
		}
		
	} failure:^(NSDictionary *obj2) {
		
	}];
	
	
	
	
	
	
	
	//公司性质
	EditInformationView *nameEditView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, 0, WindowWith-30, 54) name:@"公司性质"];
	
	__weak CompanyAdditionalViewController *weakSelf = self;
	//    __weak EditInformationView *weakNameView=nameEditView;
	nameEditView.lbl.text=@"必填";
	nameEditView.lbl.textColor=cGrayLightColor;
	// NSString *name;
	if (![Dic[@"companyinfo"][@"nature_id"] isEqualToString:@""]) {
		[network selectPublicDicInfo:3 success:^(NSDictionary *obj) {
			self->_arr=obj[@"content"];
			for (NSDictionary *dic in self->_arr) {
				if ([[dic[@"nature_id"] stringValue] isEqualToString:Dic[@"companyinfo"][@"nature_id"]]) {
					
					nameEditView.lbl.text=dic[@"nature_name"];
					// name=nameEditView.lbl.text;
					nameEditView.lbl.textColor=cGrayLightColor;
				}
				
				
			}
			
		} failure:^(NSDictionary *obj2) {
			
		}];
		
		
	}
	nameEditView.selectBlock=^(NSInteger index){
		
		NSLog(@"name");
		//  NSString *s=@"公司性质";
		[weakSelf showPicViewWithArr:self->natureArray :@"公司性质" :21];
		
	};
	nameEditView.tag=1001;
	[bgView1 addSubview:nameEditView];
	
	UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, nameEditView.bottom, WindowWith, 1)];
	lineView1.backgroundColor=cLineColor;
	[bgView1 addSubview:lineView1];
	
	
	
	//人员规模
	EditInformationView *phoneView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView1.bottom, nameEditView.width, nameEditView.height) name:@"人员规模"];
	phoneView.lbl.text=@"必填";
	phoneView.lbl.textColor=cGrayLightColor;
	NSString *phone;
	if (![Dic[@"companyinfo"][@"staff_size"] isEqualToString:@""]) {
		phoneView.lbl.text=Dic[@"companyinfo"][@"staff_size"];
		phone=phoneView.lbl.text;
		phoneView.lbl.textColor=cGrayLightColor;
		
	}
	//   __weak EditInformationView *weakAdressView=phoneView;
	phoneView.selectBlock=^(NSInteger index){
		
		// NSString *s=@"人员规模";
		[weakSelf showPicViewWithArr:@[@"1-19人",@"20-49人",@"50-99人",@"100-499人"] :@"人员规模" :22];
	};
	phoneView.tag=1002;
	[bgView1 addSubview:phoneView];
	UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, phoneView.bottom, WindowWith, 7.5)];
	lineView2.backgroundColor=RGB(247, 248, 250);
	[bgView1 addSubview:lineView2];
	
	
	
	//主营业务
	EditInformationView *emailView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView2.bottom, phoneView.width, phoneView.height) name:@"主营业务"];
	emailView.lbl.text=@"必填";
	emailView.lbl.textColor=cGrayLightColor;
	//  NSString *email;
	_zhuying=@"";
	if (![Dic[@"companyinfo"][@"main_business"] isEqualToString:@""]) {
		emailView.lbl.text=@"已填写";
		_zhuying=Dic[@"companyinfo"][@"main_business"];
		emailView.lbl.textColor=cGrayLightColor;
	}
	//  __weak EditInformationView *weakEmailView=emailView;
	emailView.selectBlock=^(NSInteger index){
		NSLog(@"email");
		
		[weakSelf editWithTitle:@"主营业务" type:SelectZhuyingBlock :YES text:self->_zhuying];
		
	};
	emailView.tag=1003;
	[bgView1 addSubview:emailView];
	
	UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(0, emailView.bottom, WindowWith, 1)];
	lineView3.backgroundColor=cLineColor;
	[bgView1 addSubview:lineView3];
	
	
	
	
	//公司简介
	EditInformationView *companyView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, lineView3.bottom, WindowWith-30, emailView.height) name:@"公司简介"];
	companyView.lbl.text=@"必填";
	companyView.lbl.textColor=cGrayLightColor;
	//  NSString *company;
	_jianjie=@"";
	if (![Dic[@"companyinfo"][@"company_desc"] isEqualToString:@""]) {
		companyView.lbl.text=@"已填写";
		_jianjie=Dic[@"companyinfo"][@"company_desc"];
		companyView.lbl.textColor=cGrayLightColor;
	}
	//  __weak EditInformationView *weakCompanyView=companyView;
	companyView.selectBlock=^(NSInteger index){
		NSLog(@"company");
		NSString *s=@"公司简介";
		[weakSelf editWithTitle:s type:SelectCompanyIntroduceBlock :YES text:self->_jianjie];
	};
	companyView.tag=1004;
	[bgView1 addSubview:companyView];
	UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(0, companyView.bottom, WindowWith, 1)];
	lineView4.backgroundColor=cLineColor;
	[bgView1 addSubview:lineView4];
	
	
	
	//联系电话
	EditInformationView *positionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView4.bottom, nameEditView.width, nameEditView.height) name:@"联系电话"];
	positionView.tag=1005;
	positionView.lbl.text=@"必填";
	positionView.lbl.textColor=cGrayLightColor;
	//   NSString *position;
	if (![Dic[@"companyinfo"][@"mobile"] isEqualToString:@""]) {
		positionView.lbl.text=Dic[@"companyinfo"][@"mobile"];
		// position=self.model.companyinfoModel.mobile;
		positionView.lbl.textColor=cGrayLightColor;
	}
	__weak EditInformationView *weakPositionView=positionView;
	positionView.selectBlock=^(NSInteger index){
		NSLog(@"position");
		NSString *s=@"联系电话";
		[weakSelf editWithTitle:s type:SelectLandBlock :NO text:weakPositionView.lbl.text];
		
		
	};
	[bgView1 addSubview:positionView];
	UIView *lineView5=[[UIView alloc]initWithFrame:CGRectMake(0, positionView.bottom, WindowWith, 1)];
	lineView5.backgroundColor=cLineColor;
	[bgView1 addSubview:lineView5];
	
	
	
	
	
	//公司网址
	EditInformationView *WebView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView5.bottom, nameEditView.width, nameEditView.height) name:@"公司网址"];
	WebView.tag=1006;
	WebView.lbl.text=@"选填";
	WebView.lbl.textColor=cGrayLightColor;
	// NSString *position;
	if (![Dic[@"companyinfo"][@"website"] isEqualToString:@""]) {
		WebView.lbl.text=Dic[@"companyinfo"][@"website"];
		//        position=self.model.companyinfoModel.mobile;
		positionView.lbl.textColor=cGrayLightColor;
	}
	__weak EditInformationView *weakWebView=WebView;
	WebView.selectBlock=^(NSInteger index){
		NSLog(@"position");
		// NSString *s=@"联系电话";
		[weakSelf editWithTitle:@"公司网址" type:SelectCompanyWebBlock :NO text:weakWebView.lbl.text];
		
		
	};
	[bgView1 addSubview:WebView];
	UIView *lineView6=[[UIView alloc]initWithFrame:CGRectMake(0, WebView.bottom, WindowWith, 7.5)];
	lineView6.backgroundColor=RGB(247, 248, 250);
	[bgView1 addSubview:lineView6];
	
	
	
	
	
	
	
	
	
	
	//营业执照
	EditInformationView *zhuyingView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView6.bottom, positionView.width, positionView.height) name:@"营业执照"];
	zhuyingView.lbl.text=@"必填";
	zhuyingView.lbl.textColor=cGrayLightColor;
	
	UIImage *img=Image(@"GQ_Left.png");
	_headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(WindowWith-img.size.width-30-10-46, 4, 46, 46)];
	_headImageView.image=DefaultImage_logo;
	_headImageView.hidden=YES;
	if (![Dic[@"companyinfo"][@"company_license_url"] isEqualToString:@""]) {
		
		//        NSString *str=[NSString stringWithFormat:@"%@%@@!body",ConfigManager.ImageUrl,Dic[@"companyinfo"][@"company_license_url"]];
		NSString *str=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,Dic[@"companyinfo"][@"company_license_url"]];
		
		[_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",str] placeholderImage:DefaultImage_logo];
		_headImageView.hidden=NO;
		zhuyingView.lbl.text=@"已上传";
		zhuyingView.lbl.hidden=YES;
	}
	
	//[_headImageView setLayerMasksCornerRadius:25 BorderWidth:0 borderColor:cGreenColor];
	[zhuyingView addSubview:_headImageView];
	
	// __weak NSString *zhuying = _zhuying;
	zhuyingView.selectBlock=^(NSInteger index){
		
		[weakSelf headTap:nil];
	};
	zhuyingView.tag=1007;
	[bgView1 addSubview:zhuyingView];
	UIView *lineView7=[[UIView alloc]initWithFrame:CGRectMake(0, zhuyingView.bottom, WindowWith, 1)];
	lineView7.backgroundColor=cLineColor;
	[bgView1 addSubview:lineView7];
	
	
	
	//设计资质
	
	EditInformationView *introductionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView7.bottom, positionView.width, positionView.height) name:@"设计资质"];
	
	introductionView.lbl.text=@"选填";
	introductionView.lbl.textColor=cGrayLightColor;
	
	// __weak NSString *introduction = _introduction;
	if (![Dic[@"companyinfo"][@"design_lv"] isEqualToString:@""]) {
		
		introductionView.lbl.text=Dic[@"companyinfo"][@"design_lv"];
		introductionView.lbl.textColor=cGrayLightColor;
		
	}
	
	
	introductionView.selectBlock=^(NSInteger index){
		
		
		[weakSelf showPicViewWithArr:@[@"甲级",@"乙级"] :@"设计资质" :23];
	};
	introductionView.tag=1008;
	
	
	[bgView1 addSubview:introductionView];
	
	
	
	UIView *lineView8=[[UIView alloc]initWithFrame:CGRectMake(0, introductionView.bottom, WindowWith, 1)];
	lineView8.backgroundColor=cLineColor;
	[bgView1 addSubview:lineView8];
	
	
	
	
	
	//工程资质
	
	EditInformationView *IndustryView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView8.bottom, nameEditView.width, nameEditView.height) name:@"工程资质"];
	//    NSString *industry;
	
	IndustryView.lbl.text=@"选填";
	IndustryView.lbl.textColor=cGrayLightColor;
	
	if (![Dic[@"companyinfo"][@"project_lv"] isEqualToString:@""]) {
		IndustryView.lbl.text=Dic[@"companyinfo"][@"project_lv"];
		//        industry=self.model.companyinfoModel.project_lv;
		IndustryView.lbl.textColor=cGrayLightColor;
	}
	
	
	//    __weak EditInformationView *weakIndustryView=IndustryView;
	IndustryView.selectBlock=^(NSInteger index){
		
		[weakSelf showPicViewWithArr:@[@"一级",@"二级",@"三级"] :@"工程资质" :24];
	};
	IndustryView.tag=1009;
	[bgView1 addSubview:IndustryView];
	UIView *lineView9=[[UIView alloc]initWithFrame:CGRectMake(0, IndustryView.bottom, WindowWith, 1)];
	lineView9.backgroundColor=cLineColor;
	[bgView1 addSubview:lineView9];
	
	bgView1.size=CGSizeMake(WindowWith, lineView9.bottom);
	
	
	
	UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame=CGRectMake(0, bgView1.bottom+20, WindowWith-50, 40);
	btn.backgroundColor=cGreenColor;
	[btn setTintColor:[UIColor whiteColor]];
	[btn setTitle:@"保  存" forState:UIControlStateNormal];
	
	[btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
	btn.titleLabel.font=sysFont(18.8);
	[_BaseScrollView addSubview:btn];
	btn.centerX=self.view.centerX;
	btn.layer.cornerRadius=20;
	
	_BaseScrollView.contentSize=CGSizeMake(WindowWith, btn.bottom+30+64);
	
	
	if ([Dic[@"auth_status"] intValue]!=2&&[Dic[@"companyinfo"][@"status"] intValue] == 2) {
		for (int i=1; i<10; i++) {
			EditInformationView *view=[_bgView1 viewWithTag:1000+i];
			view.userInteractionEnabled = NO;
			btn.enabled=NO;
		}
	}
	
	
	
	
	
	
	
}

-(void)submitClick:(UIButton *)sender{
	
	EditInformationView *nameEditView=[_bgView1 viewWithTag:1001];
	int name=0;
	if (![nameEditView.lbl.text isEqualToString:@"必填"]) {
		for (NSDictionary *dic in _arr) {
			if ([dic[@"nature_name"] isEqualToString:nameEditView.lbl.text]) {
				name=[dic[@"nature_id"]intValue];
			}
		}
		
	}else{
		if (self.model == nil) {
			[self addSucessView:@"未填写公司性质" type:2];
			return;
		}
		
	}
	
	EditInformationView *sexView=[_bgView1 viewWithTag:1002];
	NSString *sexy=@"";
	if (![sexView.lbl.text isEqualToString:@"必填"]) {
		sexy=sexView.lbl.text;
	}else
	{
		if (self.model == nil) {
			[self addSucessView:@"未填写人员规模" type:2];
			return;
		}
	}
	
	
	EditInformationView *adressView=[_bgView1 viewWithTag:1003];
	NSString *adress=@"";
	if (![adressView.lbl.text isEqualToString:@"必填"]) {
		adress=adressView.lbl.text;
	}else{
		if (self.model == nil) {
			[self addSucessView:@"未填写主营业务" type:2];
			return;
		}
	}
	
	EditInformationView *companyView=[_bgView1 viewWithTag:1004];
	NSString *company=@"";
	if (![companyView.lbl.text isEqualToString:@"必填"]) {
		company=companyView.lbl.text;
	}else
	{
		if (self.model == nil) {
			[self addSucessView:@"未填写公司简介" type:2];
			return;
		}
	}
	EditInformationView *phoneView=[_bgView1 viewWithTag:1005];
	NSString *phone=@"";
	if (![phoneView.lbl.text isEqualToString:@"必填"]) {
		phone=phoneView.lbl.text;
	}else{
		if (self.model == nil) {
			[self addSucessView:@"未填写联系电话" type:2];
			return;
		}
	}
	
	EditInformationView *emailView=[_bgView1 viewWithTag:1006];
	NSString *email=@"";
	if (![emailView.lbl.text isEqualToString:@"选填"]) {
		email=emailView.lbl.text;
	}
	
	EditInformationView *positionView=[_bgView1 viewWithTag:1007];
	
	if ([positionView.lbl.text isEqualToString:@"必填"]) {
		if (self.model == nil) {
			[self addSucessView:@"未填写营业执照" type:2];
			return;
		}
	}
	
	EditInformationView *IndustryView=[_bgView1 viewWithTag:1008];
	NSString *industry=@"";
	if (![IndustryView.lbl.text isEqualToString:@"选填"]) {
		industry=IndustryView.lbl.text;
		
	}
	EditInformationView *positionNameView=[_bgView1 viewWithTag:1009];
	NSString *positionName=@"";
	if (![positionNameView.lbl.text isEqualToString:@"选填"]) {
		positionName=positionNameView.lbl.text;
		
	}
	
	[self addWaitingView];
	[AliyunUpload uploadImage:headImageArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
		
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self removeWaitingView];
			NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo]];
			
			NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithDictionary:Dic[@"companyinfo"]];
			[dic1 setObject:stringFormatInt(name) forKey:@"nature_id"];
			[dic1 setObject:sexy forKey:@"staff_size"];
			[dic1 setObject:self->_zhuying forKey:@"main_business"];
			[dic1 setObject:self->_jianjie forKey:@"company_desc"];
			[dic1 setObject:phone forKey:@"mobile"];
			[dic1 setObject:email forKey:@"website"];
			[dic1 setObject:industry forKey:@"design_lv"];
			[dic1 setObject:positionName forKey:@"project_lv"];
			NSArray *arr=[network getJsonForString:obj];
			MTPhotosModel *model=[[MTPhotosModel alloc]initWithDic:arr[0]];
			NSMutableString *str=[[NSMutableString alloc]initWithString:model.imgUrl];
			NSRange range=[str rangeOfString:ConfigManager.ImageUrl];
			[str deleteCharactersInRange:range];
			
			[dic1 setObject:str forKey:@"company_license_url"];
			[Dic setObject:dic1 forKey:@"companyinfo"];
			[IHUtility saveDicUserDefaluts:Dic key:kUserDefalutLoginInfo];
			[IHUtility addSucessView:@"信息已经保存" type:1];
			self.selectBlock(SelectSaveBlock);
			[self back:nil];
			
		});
		
		
		
		
	}];
	
	
	
	
	
}





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
	if (type==SelectCompanyIntroduceBlock) {
		EditInformationView *view=[self.view viewWithTag:1004];
		view.lbl.text=@"已填写";
		_jianjie=title;
		view.lbl.textColor=cBlackColor;
	}
	if (type==SelectCompanyWebBlock) {
		EditInformationView *view=[self.view viewWithTag:1006];
		view.lbl.text=title;
		view.lbl.textColor=cBlackColor;
		
		
	}
	//    if (type==SelectLabelBlock) {
	//        EditInformationView *view=[self.view viewWithTag:1004];
	//        view.lbl.text=title;
	//        view.lbl.textColor=cBlackColor;
	//    }
	
	if (type==SelectLandBlock) {
		EditInformationView *view=[self.view viewWithTag:1005];
		view.lbl.text=title;
		view.lbl.textColor=cBlackColor;
	}
	if (type==SelectZhuyingBlock) {
		EditInformationView *view=[self.view viewWithTag:1003];
		view.lbl.text=@"已填写";
		_zhuying=title;
		view.lbl.textColor=cBlackColor;
	}
	
	
	
	
	
}







-(void)showPicViewWithArr:(NSArray *)arr :(NSString *)title :(NSInteger)tag
{
	JLSimplePickViewComponent *pickView =(JLSimplePickViewComponent*)[self.view viewWithTag:tag];
	if(pickView == nil)
	{
		
		pickView = [[JLSimplePickViewComponent alloc] initWithParams:title withData:arr];
		pickView.tag=tag;
		pickView.ActionSheetDelegate = (id<JLActionSheetDelegate>)self;
	}
	[pickView show];
	
}

#pragma mark - JLActionSheetDelegate

-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedData:(NSString *)SelectedStr
{
	if (pickViewComponent.tag==21) {
		NSLog(@"%@",SelectedStr);
		EditInformationView *urgentView=[_BaseScrollView viewWithTag:1001];
		urgentView.lbl.textColor=cBlackColor;
		urgentView.lbl.text=SelectedStr;
	}else if(pickViewComponent.tag==22)
	{
		NSLog(@"%@",SelectedStr);
		EditInformationView *sexView=[_BaseScrollView viewWithTag:1002];
		sexView.lbl.textColor=cBlackColor;
		sexView.lbl.text=SelectedStr;
	}else if(pickViewComponent.tag==23)
	{
		NSLog(@"%@",SelectedStr);
		EditInformationView *sexView=[_BaseScrollView viewWithTag:1008];
		sexView.lbl.textColor=cBlackColor;
		sexView.lbl.text=SelectedStr;
	}else if(pickViewComponent.tag==24)
	{
		NSLog(@"%@",SelectedStr);
		EditInformationView *sexView=[_BaseScrollView viewWithTag:1009];
		sexView.lbl.textColor=cBlackColor;
		sexView.lbl.text=SelectedStr;
	}
	
	
	
	
}


-(void)headTap:(UITapGestureRecognizer *)tap{
	HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", nil];
	// 2.显示出来
	[sheet show];
}

#pragma mark - HJCActionSheetDelegate

// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	UIImagePickerController * ip=[[UIImagePickerController alloc]init];
	ip.delegate = self;
	
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
	// UIImage *img=Image(@"defaulthead125.png");
	UIImageView *xzImg=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, width)];
	//xzImg.layer.masksToBounds=YES;
	//xzImg.layer.cornerRadius=img.size.height/2;
	xzImg.image=[_cropImageView cropImage];
	_headImageView.hidden=NO;
	EditInformationView *positionView=[_bgView1 viewWithTag:1007];
	[positionView addSubview:xzImg];
	positionView.lbl.text=@"已上传";
	positionView.lbl.hidden=YES;
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

