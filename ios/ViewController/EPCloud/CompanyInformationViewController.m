//
//  CompanyInformationViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/8/29.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CompanyInformationViewController.h"
#import "CompanyAdditionalViewController.h"
#import "InformationEditViewController.h"
#import "JLSimplePickViewComponent.h"
#import "MapGeographicalPositionViewController.h"
//#import "keychainItemManager.h"
#import "KICropImageView.h"
#import "CompanyImageViewController.h"
@interface CompanyInformationViewController ()<EditInformationDelegate,JLActionSheetDelegate,UIImagePickerControllerDelegate,HJCActionSheetDelegate>
{
    NSMutableArray *industryInfoArray;
    UIAsyncImageView *_headImageView;
    KICropImageView* _cropImageView;
    NSMutableArray *headImageArray;
    UIView *_bgView1;
//    NSString *_companyImage;
//    int typeId;
//
//    CGFloat _latitude;
//    CGFloat _longitude;

    MTCompanyModel *_companyModel;

}
@end

@implementation CompanyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setTitle:@"公司信息"];
	headImageArray=[[NSMutableArray alloc]init];
	self.view.backgroundColor=RGB(247, 248, 250);
	[self creatView];
}

-(void)creatView{
    
     NSDictionary *Dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
   
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutInit];
    
    UIView *bgView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 500)];
    
    bgView1.backgroundColor=[UIColor whiteColor];
    [_BaseScrollView addSubview:bgView1];
    _bgView1=bgView1;
    
    //公司全称
    EditInformationView *nameEditView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, 0, WindowWith-30, 54) name:@"公司全称"];
    
    __weak CompanyInformationViewController *weakSelf = self;
    __weak EditInformationView *weakNameView=nameEditView;
    nameEditView.lbl.text=@"必填";
    nameEditView.lbl.textColor=cGrayLightColor;
    NSString *name;
    
    if (![Dic[@"companyinfo"][@"company_name"] isEqualToString:@""]) {
        nameEditView.lbl.text=Dic[@"companyinfo"][@"company_name"];
        name=nameEditView.lbl.text;
        nameEditView.lbl.textColor=cGrayLightColor;
    }
    
    if (self.model.status == 2) {
        nameEditView.userInteractionEnabled = NO;
    }
    nameEditView.selectBlock=^(NSInteger index){
        
        NSLog(@"name");
        NSString *s=@"公司全称";
        [weakSelf editWithTitle:s type:SelectCompanyNameBlock :NO text:weakNameView.lbl.text];
        
        
    };
    nameEditView.tag=1001;
    [bgView1 addSubview:nameEditView];
    
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, nameEditView.bottom, WindowWith, 1)];
    lineView1.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView1];

    
    
    //公司简称
    EditInformationView *phoneView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView1.bottom, nameEditView.width, nameEditView.height) name:@"公司简称"];
    phoneView.lbl.text=@"必填";
    phoneView.lbl.textColor=cGrayLightColor;
    NSString *phone;
    if (![Dic[@"companyinfo"][@"short_name"] isEqualToString:@""]) {
        phoneView.lbl.text=Dic[@"companyinfo"][@"short_name"];
        phone=phoneView.lbl.text;
        phoneView.lbl.textColor=cGrayLightColor;
        
    }
    if (self.model.status == 2) {
        phoneView.userInteractionEnabled = NO;
    }
    __weak EditInformationView *weakAdressView=phoneView;
    phoneView.selectBlock=^(NSInteger index){
        
        NSString *s=@"公司简称";
        [weakSelf editWithTitle:s type:SelectCompanyAbbreviationNameBlock :NO text:weakAdressView.lbl.text];
    };
    phoneView.tag=1002;
    [bgView1 addSubview:phoneView];
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, phoneView.bottom, WindowWith, 7.5)];
    lineView2.backgroundColor=RGB(247, 248, 250);
    [bgView1 addSubview:lineView2];

    
    
    //所属行业
    EditInformationView *emailView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView2.bottom, phoneView.width, phoneView.height) name:@"所属行业"];
    emailView.lbl.text=@"必填";
    emailView.lbl.textColor=cGrayLightColor;
    NSString *email;
    industryInfoArray=[[NSMutableArray alloc]init];
    for (NSDictionary *obj in dic[@"industryInfoList"]) {
        
        [industryInfoArray addObject:obj[@"i_name"]];
        
    }
    if (![Dic[@"companyinfo"][@"i_name"] isEqualToString:@""]) {
        emailView.lbl.text=Dic[@"companyinfo"][@"i_name"];
        email=emailView.lbl.text;
        emailView.lbl.textColor=cGrayLightColor;
    }
    
    
    
//    __weak EditInformationView *weakEmailView=emailView;
    emailView.selectBlock=^(NSInteger index){
        NSLog(@"email");
		[weakSelf showPicViewWithArr:self->industryInfoArray :@"行业类型" :21];
    };
    emailView.tag=1003;
    [bgView1 addSubview:emailView];
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(0, emailView.bottom, WindowWith, 1)];
    lineView3.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView3];

    
    
    
    //地址
    EditInformationView *companyView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, lineView3.bottom, WindowWith-30, emailView.height) name:@"地址"];
    companyView.lbl.text=@"必填";
    companyView.lbl.textColor=cGrayLightColor;
    
    NSString *company;
    if (![Dic[@"companyinfo"][@"address"] isEqualToString:@""]) {
        companyView.lbl.text=Dic[@"companyinfo"][@"address"];
        company=self.model.companyinfoModel.address;
        companyView.lbl.textColor=cGrayLightColor;
       
    }
//    __weak EditInformationView *weakCompanyView=companyView;
    companyView.selectBlock=^(NSInteger index){
        NSLog(@"company");
//        NSString *s=@"地址";
        [weakSelf pushToMapVC];
    };
    companyView.tag=1004;
    [bgView1 addSubview:companyView];
    UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(0, companyView.bottom, WindowWith, 1)];
    lineView4.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView4];

    
    
    //企业标志
    EditInformationView *positionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView4.bottom, nameEditView.width, nameEditView.height) name:@"企业标志"];
    positionView.tag=1005;
    positionView.lbl.text=@"必填";
    positionView.lbl.textColor=cGrayLightColor;
     UIImage *img=Image(@"GQ_Left.png");
    _headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(WindowWith-img.size.width-30-10-50, 2, 50, 50)];
    _headImageView.image=EPDefaultImage_logo;
        _headImageView.hidden=YES;
    if (![Dic[@"companyinfo"][@"logo"] isEqualToString:@""]) {
     
//        NSString *str=[NSString stringWithFormat:@"%@%@@!body",ConfigManager.ImageUrl,Dic[@"companyinfo"][@"logo"]];
        NSString *str=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,Dic[@"companyinfo"][@"logo"]];
        
        [ _headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",str] placeholderImage:EPDefaultImage_logo];
        _headImageView.hidden=NO;
         positionView.lbl.text=@"已上传";
         positionView.lbl.hidden=YES;
    }

    [_headImageView setLayerMasksCornerRadius:25 BorderWidth:0 borderColor:cGreenColor];
    [positionView addSubview:_headImageView];
    
   // NSString *position;
    // __weak EditInformationView *weakPositionView=positionView;
    positionView.selectBlock=^(NSInteger index){
        NSLog(@"position");
      //  NSString *s=@"企业标志";
        [weakSelf headTap:nil];
        
        
    };
    [bgView1 addSubview:positionView];
    UIView *lineView5=[[UIView alloc]initWithFrame:CGRectMake(0, positionView.bottom, WindowWith, 1)];
    lineView5.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView5];

    
    
    
    //形象图片
    EditInformationView *zhuyingView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView5.bottom, positionView.width, positionView.height) name:@"形象图片"];
    zhuyingView.lbl.text=@"必填";
    zhuyingView.lbl.textColor=cGrayLightColor;
    if (![Dic[@"companyinfo"][@"company_image"] isEqualToString:@""]) {
     
         zhuyingView.lbl.text=@"已上传";
        
    }
    
    // __weak NSString *zhuying = _zhuying;
    zhuyingView.selectBlock=^(NSInteger index){
        [weakSelf pushToImageVC];
        
    };
    zhuyingView.tag=1006;
    [bgView1 addSubview:zhuyingView];
    UIView *lineView6=[[UIView alloc]initWithFrame:CGRectMake(0, zhuyingView.bottom, WindowWith, 7.5)];
    lineView6.backgroundColor=RGB(247, 248, 250);
    [bgView1 addSubview:lineView6];
    

    
    //扩展信息
    
    
    EditInformationView *introductionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView6.bottom, positionView.width, positionView.height) name:@"扩展信息"];
    
    introductionView.lbl.text=@"必填";
    introductionView.lbl.textColor=cGrayLightColor;
    
 
        if (![Dic[@"companyinfo"][@"design_lv"] isEqualToString:@""]) {
    
            introductionView.lbl.text=@"已填写";
            introductionView.lbl.textColor=cGrayLightColor;
    
        }
    
    
    introductionView.selectBlock=^(NSInteger index){
        
        
        [weakSelf pushToCompanyAdditional];
    };
    introductionView.tag=1007;
    
    
    [bgView1 addSubview:introductionView];
    
    
    
    UIView *lineView7=[[UIView alloc]initWithFrame:CGRectMake(0, introductionView.bottom, WindowWith, 1)];
    lineView7.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView7];

    
     bgView1.size=CGSizeMake(WindowWith, lineView7.bottom);
    
    
    
    UIImage *photoimg=Image(@"redstar.png");
    UIImageView *photoImgView=[[UIImageView alloc]initWithImage:photoimg];
    photoImgView.frame=CGRectMake(20,bgView1.bottom+15, photoimg.size.width, photoimg.size.height);
    [_BaseScrollView addSubview:photoImgView];
    
    
    
    CGSize size=[IHUtility GetSizeByText:@"公司信息的详实程度，将影响到园林去对企业的评级，请尽量完整填写" sizeOfFont:14 width:WindowWith-photoImgView.right-15-15];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(photoImgView.right+15, photoImgView.top, size.width, size.height) textColor:cGrayLightColor textFont:sysFont(14)];
    lbl.numberOfLines=0;
    
    lbl.text=@"公司信息的详实程度，将影响到园林去对企业的评级，请尽量完整填写";
    [_BaseScrollView addSubview:lbl];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0, lbl.bottom+0.186*WindowWith, WindowWith-50, 40);
    if (WindowWith==320) {
    btn.frame=CGRectMake(0, lbl.bottom+0.14*WindowWith, WindowWith-50, 40);
    }
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
        for (int i=2; i<7; i++) {
            EditInformationView *view=[_bgView1 viewWithTag:1000+i];
            view.userInteractionEnabled = NO;
            btn.enabled=NO;
                  }
    }
    

    
    
    

}






-(void)submitClick:(UIButton *)sender{
    
    EditInformationView *nameEditView=[_bgView1 viewWithTag:1001];
  NSString *name=@"";
    if (![nameEditView.lbl.text isEqualToString:@"必填"]) {
        name=nameEditView.lbl.text;
    }else{
        [self addSucessView:@"未填写公司全称" type:2];
        return;
    }
    
    EditInformationView *sexView=[_bgView1 viewWithTag:1002];
    NSString *sexy=@"";
    if (![sexView.lbl.text isEqualToString:@"必填"]) {
        sexy=sexView.lbl.text;
    }else
    {
        [self addSucessView:@"未填写公司简称" type:2];
        return;
    }
    
    
    EditInformationView *adressView=[_bgView1 viewWithTag:1003];
  int adress=0;
     NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutInit];
    if (![adressView.lbl.text isEqualToString:@"必填"]) {
        for (NSDictionary *obj in dic[@"industryInfoList"]) {
            if ([adressView.lbl.text isEqualToString:obj[@"i_name"]]) {
                adress=[obj[@"i_type_id"] intValue];
            }
           
            
        }

    }else{
        [self addSucessView:@"未填写所属行业" type:2];
        return;
    }
    
    EditInformationView *companyView=[_bgView1 viewWithTag:1004];
    NSString *company=@"";
    if (![companyView.lbl.text isEqualToString:@"必填"]) {
        company=companyView.lbl.text;
    }else
    {
        [self addSucessView:@"未填写地址" type:2];
        return;
    }
    EditInformationView *phoneView=[_bgView1 viewWithTag:1005];
    NSString *phone=@"";
    if (![phoneView.lbl.text isEqualToString:@"必填"]) {
        phone=phoneView.lbl.text;
    }else{
        [self addSucessView:@"未填写企业标志" type:2];
        return;
    }
    
    EditInformationView *emailView=[_bgView1 viewWithTag:1006];
   // NSString *email=@"";
    if ([emailView.lbl.text isEqualToString:@"必填"]) {
        [self addSucessView:@"未上传形象图片" type:2];
        return;

    }
    
    EditInformationView *positionView=[_bgView1 viewWithTag:1007];
    
    if ([positionView.lbl.text isEqualToString:@"必填"]) {
        [self addSucessView:@"未填写扩展信息" type:2];
        return;
    }

    
 
    if (!_companyModel ) {

        [self addWaitingView];
        [AliyunUpload uploadImage:headImageArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self removeWaitingView];
                NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo]];
                
                NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithDictionary:Dic[@"companyinfo"]];
                [dic1 setObject:name forKey:@"company_name"];
                [dic1 setObject:sexy forKey:@"short_name"];
                [dic1 setObject:stringFormatInt(adress) forKey:@"i_type_id"];
                [dic1 setObject:company forKey:@"address"];
                //[dic1 setObject:_companyImage forKey:@"company_image"];
                
                NSArray *arr=[network getJsonForString:obj];
                MTPhotosModel *mod=[[MTPhotosModel alloc]initWithUrlDic:arr[0]];
                
                NSMutableString *str=[[NSMutableString alloc]initWithString:mod.imgUrl];
                NSRange range=[str rangeOfString:ConfigManager.ImageUrl];
                [str deleteCharactersInRange:range];
                
                [dic1 setObject:str forKey:@"logo"];
                
                
                [Dic setObject:dic1 forKey:@"companyinfo"];
                
                [IHUtility saveDicUserDefaluts:Dic key:kUserDefalutLoginInfo];
                [IHUtility addSucessView:@"信息已经保存" type:1];
                self.selectBlock(name);
                [self back:nil];
            });
            
           
           
            
		} failure:^(NSError *error) {
			
		}];
    }
    
    
}



-(void)pushToImageVC{
    CompanyImageViewController *vc=[[CompanyImageViewController alloc]init];
    vc.selectImageBlock=^(NSString *str){
		EditInformationView *emailView=[self->_bgView1 viewWithTag:1006];
        emailView.lbl.text=@"已上传";
        emailView.lbl.textColor=cBlackColor;
//		self->_companyImage=str;
    };
    [self pushViewController:vc];
}



-(void)pushToMapVC{
    MapGeographicalPositionViewController *vc=[[MapGeographicalPositionViewController alloc]init];
    vc.type=ENT_RenZheng;
    vc.selectPilotBlock=^(CGFloat latitude,CGFloat longtitude,NSString *adress){
		EditInformationView *sexView=[self->_BaseScrollView viewWithTag:1004];
        sexView.lbl.textColor=cBlackColor;
        sexView.lbl.text=adress;
//		self->_latitude=latitude;
//		self->_longitude=longtitude;
    };
   
    [self pushViewController:vc];

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
        EditInformationView *urgentView=[_BaseScrollView viewWithTag:1003];
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



-(void)pushToCompanyAdditional{
    
    CompanyAdditionalViewController *vc=[[CompanyAdditionalViewController alloc]init];
    vc.model = _companyModel;
    vc.selectBlock=^(NSInteger index){
        EditInformationView *view=[self.view viewWithTag:1007];
        view.lbl.text=@"已填写";
        view.lbl.textColor=cBlackColor;
    };
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

//MARK:EditInformationDelegate

-(void)displayTiyle:(NSString *)title type:(EditBlock)type {
	
    if (type == SelectCompanyNameBlock) {
		EditInformationView *view = [self.view viewWithTag:1001];
		view.lbl.text = title;
		view.lbl.textColor = cBlackColor;
		[self searchCompanyInfoWith:title];
    }
//    if (type==SelectPositiontypeBlock) {
//        EditInformationView *view=[self.view viewWithTag:1005];
//        view.lbl.text=title;
//        view.lbl.textColor=cBlackColor;
//        
//        
//    }
//    if (type==SelectLabelBlock) {
//        EditInformationView *view=[self.view viewWithTag:1004];
//        view.lbl.text=title;
//        view.lbl.textColor=cBlackColor;
//    }
    
    if (type==SelectCompanyAbbreviationNameBlock) {
        EditInformationView *view=[self.view viewWithTag:1002];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
//    if (type==SelectEmailBlock) {
//        EditInformationView *view=[self.view viewWithTag:1003];
//        view.lbl.text=title;
//        view.lbl.textColor=cBlackColor;
//    }
    

}


- (void)searchCompanyInfoWith:(NSString *)name
{
	[network getSearchCompanyInfo:@"0" company_name:name success:^(NSDictionary *obj) {
		
		if ([obj[@"content"] isMemberOfClass:[MTCompanyModel class]]) {
			
			
			
			MTCompanyModel *model  = obj[@"content"];
			self->_companyModel = model;
			[self reloadDataWith:model];
			NSDictionary *dic = [IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
			NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithDictionary:dic];
			[dic1 setValue:obj[@"data"] forKey:@"companyinfo"];
			[IHUtility saveDicUserDefaluts:dic1 key:kUserDefalutLoginInfo];
			self.selectBlock(name);
		}else{
			NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithDictionary:[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo]];
			
			NSMutableDictionary *companyInfo=[[NSMutableDictionary alloc]initWithCapacity:[dic[@"companyinfo"] allKeys].count];
			
			for(NSString *key in [dic[@"companyinfo"] allKeys]){
				
				if ([dic[@"companyinfo"][key] isKindOfClass:[NSString class]]) {
					[companyInfo setObject:@"" forKey:key];
				}else{
					
					
					
					[companyInfo setValue:0 forKey:key];
					
				}
				
				
			}
			
			
			[dic setObject:companyInfo forKey:@"companyinfo"];
			
			[IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
			[self reloadDataWith:nil];
			
			
		}
		
		
	} failure:^(NSDictionary *obj2) {
		if ([obj2[@"errorNo"] intValue] == 459){
			//添加提示
			[self addBox];
		}
	}];
}





- (void)reloadDataWith:(MTCompanyModel *)model
{
	if (!model) {
		for (int i=2; i<=7; i++) {
			EditInformationView *view=[_bgView1 viewWithTag:1000+i];
			view.userInteractionEnabled = YES;
			view.lbl.textColor=cGrayLightColor;
			view.lbl.text=@"必填";
		}
	}else{
		for (int i=2; i<=7; i++) {
			EditInformationView *view=[_bgView1 viewWithTag:1000+i];
			view.userInteractionEnabled = NO;
			view.lbl.textColor=cBlackColor;
			if (i==2) {
				view.lbl.text=model.short_name;
			}else if (i==3){
				view.lbl.text=model.i_name;
			}else if (i==4){
				view.lbl.text=model.address;
			}else if (i==5){
				if (model.logo.length >0) {
					_headImageView.hidden = NO;
				}
				view.lbl.text=@"";
				
				[_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.logo] placeholderImage:EPDefaultImage_logo];
			}else if (i==6){
				if (model.company_image.length > 0) {
					view.lbl.text=@"已上传";
				}else{
					view.lbl.text=@"未上传";
				}
				
			}else if (i==7){
				view.userInteractionEnabled= YES;
				view.lbl.text=@"已填写";
			}
		}
		
		
	}
	
	
}

//提示该公司正在审核中
- (void)addBox{
	EditInformationView *view=[_bgView1 viewWithTag:1001];
	NSString *context = [NSString stringWithFormat:@"“%@公司”该公司名称已有其他用户提交了申请，且尚在审核中，请等待",view.lbl.text];
	NSArray *Arr = @[@"我知道了"];
	BombBoxView *boxView  = [[BombBoxView alloc] initWithFrame:self.view.window.bounds context:context title:@"温馨提示" buttonArr:Arr];
	boxView.selectBlock = ^(NSInteger index){
	};
	boxView.alpha = 0;
	[self.view.window addSubview:boxView];
	[UIView animateWithDuration:1 animations:^{
		boxView.alpha = 1;
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
	ip.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
	
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

#pragma mark - UIImagePickerControllerDelegate

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
	_headImageView.hidden=NO;
	EditInformationView *positionView=[_bgView1 viewWithTag:1005];
	positionView.lbl.text=@"已上传";
	positionView.lbl.hidden=YES;
	[positionView addSubview:xzImg];
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
