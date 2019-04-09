//
//  MapAnnotationViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/28.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MapAnnotationViewController.h"
#import "InformationEditViewController.h"
#import "MapGeographicalPositionViewController.h"
#import "JLSimplePickViewComponent.h"
@interface MapAnnotationViewController()<JLActionSheetDelegate>
{
    NSString *_zhuying;
    NSString *_introduction;
    NSString *_adress;
    NSString *_province;
    NSString *_city;
    NSString *_town;
    CGFloat _latitude;
    CGFloat _longitude;
    NSInteger _i;
    NSDictionary *_dic;
}
@end

@implementation MapAnnotationViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _i=0;
    [self setTitle:@"地图标注"];
    
    __weak MapAnnotationViewController *weakSelf = self;
    
    _dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    //公司
    MapAnnotationView *companyView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(0, 5, WindowWith, 48) name:@"公司" ifMust:YES];
    companyView.lbl.text=@"尚未填写";
    companyView.lbl.textColor=RGBA(232, 121, 117, 1);
    NSString *company;
    if (![_dic[@"company_name"] isEqualToString:@""]) {
        companyView.lbl.text=_dic[@"company_name"];
        company=companyView.lbl.text;
        companyView.lbl.textColor=cGrayLightColor;
    }
    companyView.tag=1001;
    __weak MapAnnotationView *weakcompany=companyView;
    companyView.selectBlock=^(NSInteger index){
        NSLog(@"公司");
        [weakSelf editWithTitle:@"公司名称" type:SelectCompanyBlock :NO text:weakcompany.lbl.text];
    };
    [_BaseScrollView addSubview:companyView];
    
    //行业
    MapAnnotationView *industryView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(companyView.left, companyView.bottom, companyView.width, companyView.height) name:@"行业" ifMust:YES];
    industryView.tag=1002;
    industryView.lbl.text=@"尚未填写";
    
    //行业
    NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
    NSArray* mArray =[[NSMutableArray alloc]initWithArray:dic2[@"industryInfoList"]];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    for (NSDictionary *obj in mArray) {
        if ([_dic[@"i_type_id"] intValue]!=0) {
            if ([obj[@"i_type_id"] intValue]==[_dic[@"i_type_id"] intValue]) {
                industryView.lbl.text=obj[@"i_name"];
                industryView.lbl.textColor=cGrayLightColor;
            }
        }
    }
    industryView.selectBlock=^(NSInteger index){
        NSLog(@"苗木基地");
        [arr removeAllObjects];
        for (NSDictionary *obj in mArray) {
            [arr addObject:obj[@"i_name"]];
        }
        [weakSelf showPicViewWithArr:arr :@"行业" :21];
    };
    [_BaseScrollView addSubview:industryView];
    
    //电话
    MapAnnotationView *phoneView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(industryView.left, industryView.bottom, industryView.width, industryView.height) name:@"电话" ifMust:YES];
    phoneView.tag=1003;
    phoneView.lbl.text=@"尚未填写";
    NSString *phone;
    phoneView.lbl.textColor=RGBA(232, 121, 117, 1);
    if (![_dic[@"mobile"] isEqualToString:@""]) {
        phoneView.lbl.text=_dic[@"mobile"];
        phoneView.lbl.textColor=cGrayLightColor;
        phone=phoneView.lbl.text;
    }
    __weak MapAnnotationView *weakPhone=phoneView;
    phoneView.selectBlock=^(NSInteger index){
        NSLog(@"电话");
        [weakSelf editWithTitle:@"电话" type:SelectPhoneBlock :NO text:weakPhone.lbl.text];
    };
    [_BaseScrollView addSubview:phoneView];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, phoneView.bottom-1, WindowWith, 5)];
    lineView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView];
    
    //地图位置
    MapAnnotationView *adressView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(industryView.left, lineView.bottom, industryView.width, industryView.height) name:@"地图位置" ifMust:YES];
    adressView.tag=1007;
    adressView.lbl.text=@"尚未填写";
    
    adressView.lbl.textColor=RGBA(232, 121, 117, 1);
    if (![_dic[@"addressInfo"][@"company_city"] isEqualToString:@""]||![_dic[@"addressInfo"][@"company_province"] isEqualToString:@""]) {
        adressView.lbl.text=[NSString stringWithFormat:@"%@%@%@",_dic[@"addressInfo"][@"company_province"],_dic[@"addressInfo"][@"company_city"],_dic[@"addressInfo"][@"company_area"]];
        adressView.lbl.textColor=cGrayLightColor;
        
        _province=_dic[@"addressInfo"][@"company_province"];
        _city=_dic[@"addressInfo"][@"company_city"];
        _town=_dic[@"addressInfo"][@"company_area"];
    }
    
    adressView.selectBlock=^(NSInteger index){
        NSLog(@"地图位置");
        [weakSelf pushToMapViewController];
    };
    [_BaseScrollView addSubview:adressView];
    
    //详细地址
    MapAnnotationView *detailedView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(adressView.left, adressView.bottom, adressView.width, adressView.height) name:@"详细地址" ifMust:YES];
    detailedView.tag=1008;
    detailedView.lbl.text=@"尚未填写";
    NSString *detailed;
    detailedView.lbl.textColor=RGBA(232, 121, 117, 1);
    if (![_dic[@"addressInfo"][@"company_street"] isEqualToString:@""]) {
        detailedView.lbl.text=_dic[@"addressInfo"][@"company_street"];
        detailedView.lbl.textColor=cGrayLightColor;
        detailed=detailedView.lbl.text;
    }
    __weak MapAnnotationView *weakDetail=detailedView;
    detailedView.selectBlock=^(NSInteger index){
        NSLog(@"详细地址");
        [weakSelf editWithTitle:@"详细地址" type:SelectDetailedBlock :YES text:weakDetail.lbl.text];
        
    };
    [_BaseScrollView addSubview:detailedView];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, detailedView.bottom, WindowWith, WindowHeight-detailedView.bottom)];
    lineView2.backgroundColor=RGBA(220,232,238,1);
    [_BaseScrollView addSubview:lineView2];
    // NSLog(@"%f",lineView2.height);
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0, lineView2.height-70, WindowWith-80, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"提  交" forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(18.8);
    [lineView2 addSubview:btn];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=21;
    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, lineView2.bottom+64);
}

-(void)submitClick:(UIButton *)sender{
    if (_i==0) {
        [self addSucessView:@"未进行修改" type:2];
        return;
    }
    
    MapAnnotationView *companyView=[_BaseScrollView viewWithTag:1001];
    NSString *company;
    if (![companyView.lbl.text isEqualToString:@"尚未填写"]) {
        company=companyView.lbl.text;
    }else{
        [IHUtility addSucessView:@"未填写公司名" type:1];
        return;
    }
    
    MapAnnotationView *industryView=[_BaseScrollView viewWithTag:1002];
    
    NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
    NSMutableArray *hyArray=[[NSMutableArray alloc]initWithArray:dic2[@"industryInfoList"]];
    
    int itypeid = 0;
    if (![industryView.lbl.text isEqualToString:@"尚未填写"]) {
        for (NSDictionary *obj in hyArray)
        {
            if ([industryView.lbl.text isEqualToString:obj[@"i_name"]]) {
                itypeid=[obj[@"i_type_id"] intValue];
            }
        }
    }else
    {
        [IHUtility addSucessView:@"未填行业" type:1];
        return;
    }
    
    MapAnnotationView *phoneView=[_BaseScrollView viewWithTag:1003];
    NSString *phone;
    if (![phoneView.lbl.text isEqualToString:@"尚未填写"]) {
        phone=phoneView.lbl.text;
    }else
    {
        [IHUtility addSucessView:@"未填电话" type:1];
        return;
    }
    
    MapAnnotationView *adressView=[_BaseScrollView viewWithTag:1007];
    NSString *adress;
    if (![adressView.lbl.text isEqualToString:@"尚未填写"]) {
        adress=adressView.lbl.text;
    }else
    {
        [IHUtility addSucessView:@"未填地址" type:1];
        return;
    }
    
    MapAnnotationView *detailedView=[_BaseScrollView viewWithTag:1008];
    NSString *street;
    if (![detailedView.lbl.text isEqualToString:@"尚未填写"]) {
        street=detailedView.lbl.text;
    }else
    {
        [IHUtility addSucessView:@"未填详细地址" type:1];
        return;
    }
    
    NSString *oreillyAddress=[NSString stringWithFormat:@"%@%@%@%@",_dic[@"addressInfo"][@"company_province"],_dic[@"addressInfo"][@"company_city"],_dic[@"addressInfo"][@"company_area"],street];
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil){
            
            NSDictionary *dic=[ConfigManager getAddressInfoWithUser_id:0 country:nil province:nil city:nil area:nil street:nil longitude:0 latitude:0 company_lon:_longitude company_lat:_latitude distance:0 company_province:_province company_city:_city company_area:_town company_street:street];
            
            
            NSDictionary *dic1=[ConfigManager getUserDicWithUser_name:nil user_id:[USERMODEL.userID intValue] company_name:company password:nil nickname:nil address:nil hx_password:nil mobile:phone landline:nil email:nil i_type_id:itypeid sexy:0 business_direction:nil user_authentication:0 identity_key:0 heed_image_url:nil brief_introduction:nil position:nil wx_key:nil business_license_url:nil  map_callout:1  addressInfo:dic];
            
            [self addWaitingView];
            [network getUserInfoUpdate:dic1 success:^(NSDictionary *obj) {
                
                
                NSDictionary *dic=[obj objectForKey:@"content"];
                [self addSucessView:@"提交成功" type:1];
                // [ConfigManager setUserInfiDic:dic];
                [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
                if ([self.delegate respondsToSelector:@selector(MapAnnotationDelegateSubmit:)]) {
                    [self.delegate MapAnnotationDelegateSubmit:1];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCompany object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
        }
        else if ([placemarks count] == 0 && error == nil)
        {
            NSLog(@"Found no placemarks.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
}

-(void)displayAdress:(NSString *)adress city:(NSString *)city province:(NSString *)province town:(NSString *)town latitude:(CGFloat)latitude longitude:(CGFloat)longitude
{
    _i=1;
    _province=province;
    _city=city;
    _town=town;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo]];
    
    NSMutableDictionary *obj=[[NSMutableDictionary alloc]initWithDictionary:dic[@"addressInfo"]];
    [obj setValue:city forKey:@"company_city"];
    [obj setValue:province forKey:@"company_province"];
    [obj setValue:town forKey:@"company_area"];
    
    [dic setValue:obj forKey:@"addressInfo"];
    [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
    
    EditInformationView *view=[self.view viewWithTag:1008];
    view.lbl.text=adress;
    view.lbl.textColor=cBlackColor;
    
    EditInformationView *View=[self.view viewWithTag:1007];
    View.lbl.text=[NSString stringWithFormat:@"%@%@%@",province,city,town];
    View.lbl.textColor=cBlackColor;
    _latitude=latitude;
    _longitude=longitude;
}

-(void)displayTiyle:(NSString *)title type:(EditBlock)type
{
    _i=1;
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
    if (type==SelectPhoneBlock) {
        EditInformationView *view=[self.view viewWithTag:1003];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
    }
    if (type==SelectDetailedBlock) {
        EditInformationView *view=[self.view viewWithTag:1008];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
    }
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
    _i=1;
    if (pickViewComponent.tag==21) {
        NSLog(@"%@",SelectedStr);
        EditInformationView *urgentView=[_BaseScrollView viewWithTag:1002];
        urgentView.lbl.textColor=cBlackColor;
        urgentView.lbl.text=SelectedStr;
    }
}
//跳转填写
-(void)editWithTitle:(NSString *)title type:(EditBlock)type :(BOOL)isLongString text:(NSString *)text
{
    InformationEditViewController *editView=[[InformationEditViewController alloc]init];
    editView.titl=title;
    editView.text=text;
    editView.isLongString=isLongString;
    editView.delegate=self;
    editView.type=type;
    [self pushViewController:editView];
}
//跳转地图
-(void)pushToMapViewController
{
    MapGeographicalPositionViewController *vc=[[MapGeographicalPositionViewController alloc]init];
    vc.delegate=self;
    [self pushViewController:vc];
}

@end
