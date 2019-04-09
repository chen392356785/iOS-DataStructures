//
//  CreatPositionViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/13.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CreatPositionViewController.h"
//#import "MTChooseViewController.h"
#import "InformationEditViewController.h"
#import "JLSimplePickViewComponent.h"
//#import "MapGeographicalPositionViewController.h"
#import "JionEPCloudViewController.h"
#import "ChoosePositionViewController.h"
#import "AdressChooseViewController.h"
//#import "FMDatabase.h"
#import "JLAddressPickView.h"
@interface CreatPositionViewController ()<JLActionSheetDelegate,JLAddressActionSheetDelegate>
{
    UIView *_bgView1;
    NSString *_jianjie;
    NSArray *positionArr;
    int job_type;
    NSString *_province;
    NSString *_city;
    NSString *_town;
    CGFloat _latitude;
    CGFloat _longtitude;
    int cityId;
    int provinceId;
    JLAddressPickView *_adressPickView;
    NSInteger jobId;
}
@end

@implementation CreatPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"发布职位"];
    _city=@"";
    _province=@"";
    _town=@"";
    jobId=0;
    if (self.model) {
        jobId=self.model.job_id;
    }
    self.view.backgroundColor=RGB(247, 248, 250);
    UIView *bgView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 500)];
    _bgView1=bgView1;
    bgView1.backgroundColor=[UIColor whiteColor];
    [_BaseScrollView addSubview:bgView1];
    _BaseScrollView.backgroundColor=[UIColor whiteColor];
    
    NSDictionary *Dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
    
    positionArr=[IHUtility getUserdefalutsList:kUserDefalutPositionInfo];
    
    [network selectPublicDicInfo:1 success:^(NSDictionary *obj) {
        [NSUserDefaults standardUserDefaults];
        
        [IHUtility saveUserDefaluts:obj[@"content"]  key:kUserDefalutPositionInfo];
        
        [self removePushViewWaitingView];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
    
    EditInformationView *nameEditView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, 0, WindowWith-30, 54) name:@"公司信息"];
    
    __weak CreatPositionViewController *weakSelf = self;
    //    __weak EditInformationView *weakNameView=nameEditView;
    nameEditView.lbl.text=@"必填";
    nameEditView.lbl.textColor=cGrayLightColor;
//    NSString *name;
    if (self.model) {
        nameEditView.lbl.text=self.model.company_name;
        nameEditView.lbl.textColor=cBlackColor;
    }else{
        if (![Dic[@"companyinfo"][@"company_name"] isEqualToString:@""]) {
            
            nameEditView.lbl.text=Dic[@"companyinfo"][@"company_name"];
            nameEditView.lbl.textColor=cBlackColor;
        }
    }
    
    nameEditView.selectBlock=^(NSInteger index){
        
        JionEPCloudViewController *VC=[[JionEPCloudViewController alloc]init];
        
        [self pushViewController:VC];
        
    };
    nameEditView.tag=1001;
    [bgView1 addSubview:nameEditView];
    
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, nameEditView.bottom, WindowWith, 1)];
    lineView1.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView1];
    
    //职位名称
    EditInformationView *phoneView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView1.bottom, nameEditView.width, nameEditView.height) name:@"职位名称"];
    phoneView.lbl.text=@"必填";
    phoneView.lbl.textColor=cGrayLightColor;
//    NSString *phone;
    if (self.model) {
        phoneView.lbl.text=self.model.job_name;
        job_type = (int)self.model.job_name_id;
    }
//    __weak EditInformationView *weakAdressView=phoneView;
    phoneView.selectBlock=^(NSInteger index){
        if (!self.model) {
            [weakSelf pushToChooseVC];
        }
    };
    phoneView.tag=1002;
    [bgView1 addSubview:phoneView];
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, phoneView.bottom, WindowWith, 1)];
    lineView2.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView2];
    
    //    //职位名称
    //    EditInformationView *emailView=[[EditInformationView alloc]initWithFrame:CGRectMake(nameEditView.left, lineView2.bottom, phoneView.width, phoneView.height) name:@"职位名称"];
    //    emailView.lbl.text=@"必填";
    //    emailView.lbl.textColor=cGrayLightColor;
    //    NSString *email;
    //       __weak EditInformationView *weakEmailView=emailView;
    //    emailView.selectBlock=^(NSInteger index){
    //        NSLog(@"email");
    //
    //        NSString *s=@"职位名称";
    //        [weakSelf editWithTitle:s type:SelectPositionNameBlock:NO text:weakEmailView.lbl.text];
    //
    //
    //    };
    //    emailView.tag=1003;
    //    [bgView1 addSubview:emailView];
    //
    //    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(0, emailView.bottom, WindowWith, 1)];
    //    lineView3.backgroundColor=cLineColor;
    //    [bgView1 addSubview:lineView3];
    
    //薪资范围
    EditInformationView *companyView=[[EditInformationView alloc]initWithFrame:CGRectMake(15, lineView2.bottom, WindowWith-30, phoneView.height) name:@"薪资范围"];
    companyView.lbl.text=@"必填";
    companyView.lbl.textColor=cGrayLightColor;
//    NSString *company;
    if (self.model) {
        companyView.lbl.text=self.model.salary;
        companyView.lbl.textColor=cBlackColor;
    }
//    __weak EditInformationView *weakCompanyView=companyView;
    companyView.selectBlock=^(NSInteger index){
        [weakSelf showPicViewWithArr:@[@"面议",@"3k以下",@"3k-5k",@"5k-10k",@"10k-20k",@"20k-50k",@"50k以上"] :@"薪资" :21];
    };
    companyView.tag=1004;
    [bgView1 addSubview:companyView];
    UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(0, companyView.bottom, WindowWith, 7.5)];
    lineView4.backgroundColor=RGB(247, 248, 250);
    [bgView1 addSubview:lineView4];
    
    //经验要求
    EditInformationView *positionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView4.bottom, nameEditView.width, nameEditView.height) name:@"经验要求"];
    positionView.tag=1005;
    positionView.lbl.text=@"必填";
    positionView.lbl.textColor=cGrayLightColor;
//    NSString *position;
    if (self.model) {
        positionView.lbl.text=self.model.experience;
        positionView.lbl.textColor=cBlackColor;
    }
//    __weak EditInformationView *weakPositionView=positionView;
    positionView.selectBlock=^(NSInteger index){
        
        [weakSelf showPicViewWithArr:@[@"不限",@"应届生",@"1年内",@"1-3年",@"3-5年",@"5-10年",@"10年以上"] :@"经验" :22];
    };
    [bgView1 addSubview:positionView];
    UIView *lineView5=[[UIView alloc]initWithFrame:CGRectMake(0, positionView.bottom, WindowWith, 1)];
    lineView5.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView5];
    
    //学历要求
    EditInformationView *WebView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView5.bottom, nameEditView.width, nameEditView.height) name:@"学历要求"];
    WebView.tag=1006;
    WebView.lbl.text=@"必填";
    WebView.lbl.textColor=cGrayLightColor;
    if (self.model) {
        WebView.lbl.text=self.model.edu_require;
        WebView.lbl.textColor=cBlackColor;
    }
    // NSString *position;
//    __weak EditInformationView *weakWebView=WebView;
    WebView.selectBlock=^(NSInteger index){
        [weakSelf showPicViewWithArr:@[@"不限",@"大专以下",@"大专",@"本科",@"硕士",@"博士"] :@"学历要求" :23];
    };
    [bgView1 addSubview:WebView];
    UIView *lineView6=[[UIView alloc]initWithFrame:CGRectMake(0, WebView.bottom, WindowWith, 7.5)];
    lineView6.backgroundColor=RGB(247, 248, 250);
    [bgView1 addSubview:lineView6];
    
     //工作城市
    EditInformationView *zhuyingView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView6.bottom, positionView.width, positionView.height) name:@"工作城市"];
    zhuyingView.lbl.text=@"必填";
    zhuyingView.lbl.textColor=cGrayLightColor;
    if (self.model) {
        zhuyingView.lbl.text=[NSString stringWithFormat:@"%@%@",self.model.work_province,self.model.work_city];
        _city=self.model.work_city;
        _province=self.model.work_province;
        provinceId=self.model.province_id;
        cityId=self.model.city_id;
        _latitude=[self.model.job_lat doubleValue];
        _longtitude=[self.model.job_lon doubleValue];
    }
    // __weak NSString *zhuying = _zhuying;
    zhuyingView.selectBlock=^(NSInteger index){
        if (!self.model) {
            [weakSelf chooseAdress:@"城市选择" tag:1];
        }
        
    };
    zhuyingView.tag=1007;
    [bgView1 addSubview:zhuyingView];
    UIView *lineView7=[[UIView alloc]initWithFrame:CGRectMake(0, zhuyingView.bottom, WindowWith, 1)];
    lineView7.backgroundColor=cLineColor;     [bgView1 addSubview:lineView7];
    
    //工作地点
    
    EditInformationView *introductionView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView7.bottom, positionView.width, positionView.height) name:@"工作地点"];
    introductionView.lbl.text=@"必填";
    introductionView.lbl.textColor=cGrayLightColor;
    if (self.model) {
        introductionView.lbl.text=self.model.work_address;
        introductionView.lbl.textColor=cBlackColor;
    }
//    __weak EditInformationView *weakIntrodutionView=introductionView;
    introductionView.selectBlock=^(NSInteger index){
        
        [weakSelf pushToMapVC];
    };
    introductionView.tag=1008;
    
    [bgView1 addSubview:introductionView];
    
    UIView *lineView8=[[UIView alloc]initWithFrame:CGRectMake(0, introductionView.bottom, WindowWith, 1)];
    lineView8.backgroundColor=cLineColor;
    [bgView1 addSubview:lineView8];
    
    //职位描述
    
    EditInformationView *IndustryView=[[EditInformationView alloc]initWithFrame:CGRectMake(companyView.left, lineView8.bottom, nameEditView.width, nameEditView.height) name:@"职位描述"];
    //    NSString *industry;
    IndustryView.lbl.text=@"必填";
    IndustryView.lbl.textColor=cGrayLightColor;
    if (self.model) {
        
        IndustryView.lbl.text=@"已填写";
        IndustryView.lbl.textColor=cBlackColor;
        _jianjie=self.model.job_desc;
    }
//    __weak EditInformationView *weakIndustryView=IndustryView;
    IndustryView.selectBlock=^(NSInteger index){
        
        [weakSelf editWithTitle:@"职位描述" type:SelectPositionIntroductionBlock :YES text:self->_jianjie];
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
    [btn setTitle:@"发  布" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=sysFont(18.8);
    [_BaseScrollView addSubview:btn];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=20;
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, btn.bottom+30+64);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setPosition:) name:NotificationChoosePosition object:nil];
}

-(void)setPosition:(NSNotification *)dic{
    
    EditInformationView *view=[self.view viewWithTag:1002];
    view.lbl.text=dic.userInfo[@"key"];
    view.lbl.textColor=cBlackColor;
    job_type=[dic.userInfo[@"id"] intValue];
}

- (void)chooseAdress:(NSString *)title tag:(NSInteger)tag
{
    
    if(_adressPickView == nil)
    {
        _adressPickView = [[JLAddressPickView alloc] initWithParams:title type:0];
        _adressPickView.tag=tag;
        _adressPickView.ActionSheetDelegate = self;
    }
    [_adressPickView show];
}

- (void)ActionSheetDoneHandle:(JLAddressPickView *)pickViewComponent selectedProData:(NSString *)SelectedStr selectedCityData:(NSString *)SelectedCityStr
{
    _city=SelectedCityStr;
    _province=SelectedStr;
    
    EditInformationView *view=[self.view viewWithTag:1007];
    view.lbl.text=[NSString stringWithFormat:@"%@%@",_province,_city];
    view.lbl.textColor=cBlackColor;
}

- (void)ActionSheetDoneHandle:(JLAddressPickView *)pickViewComponent selectedProIndex:(NSInteger)index selectedCityIndex:(NSInteger)cityIndex{
    
    cityId = (int)cityIndex;
    provinceId = (int)index;
}

-(void)submitClick:(UIButton *)sender{
    
    NSDictionary *Dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
    
    if ([Dic[@"companyinfo"][@"company_name"] isEqualToString:@""]) {
        
        [self addSucessView:@"未绑定公司" type:2];
        return;
    }
    
    EditInformationView *sexView=[_bgView1 viewWithTag:1002];
    NSString *sexy=@"";
    if (![sexView.lbl.text isEqualToString:@"必填"]) {
        sexy=sexView.lbl.text;
    }else
    {
        [self addSucessView:@"未填写职位类型" type:2];
        return;
    }
    
    EditInformationView *companyView=[_bgView1 viewWithTag:1004];
    NSString *company=@"";
    if (![companyView.lbl.text isEqualToString:@"必填"]) {
        company=companyView.lbl.text;
    }else
    {
        [self addSucessView:@"未填写薪资范围" type:2];
        return;
    }
    EditInformationView *phoneView=[_bgView1 viewWithTag:1005];
    NSString *phone=@"";
    if (![phoneView.lbl.text isEqualToString:@"必填"]) {
        phone=phoneView.lbl.text;
    }else{
        [self addSucessView:@"未填写经验要求" type:2];
        return;
    }
    
    EditInformationView *emailView=[_bgView1 viewWithTag:1006];
    NSString *email=@"";
    if (![emailView.lbl.text isEqualToString:@"必填"]) {
        email=emailView.lbl.text;
    }else{
        [self addSucessView:@"未填写学历要求" type:2];
        return;
    }
    
    EditInformationView *positionView=[_bgView1 viewWithTag:1007];
    
    if ([positionView.lbl.text isEqualToString:@"必填"]) {
        
        [self addSucessView:@"未填写工作城市" type:2];
        return;
    }
    
    EditInformationView *IndustryView=[_bgView1 viewWithTag:1008];
    NSString *industry=@"";
    if (![IndustryView.lbl.text isEqualToString:@"必填"]) {
        industry=IndustryView.lbl.text;
        
    }else{
        [self addSucessView:@"未填写工作地点" type:2];
        return;
        
    }
    EditInformationView *positionNameView=[_bgView1 viewWithTag:1009];
    NSString *positionName=@"";
    if (![positionNameView.lbl.text isEqualToString:@"必填"]) {
        positionName=positionNameView.lbl.text;
        
    }else{
        [self addSucessView:@"未填写职位描述" type:2];
        return;
    }
    
    [IHUtility addWaitingView];
    
    [network publishJobInfo:(int)jobId company_id:[Dic[@"companyinfo"][@"company_id"] intValue] user_id:[USERMODEL.userID intValue] job_name:sexy job_name_id:job_type experience:phone edu_require:email work_province:_province work_city:_city work_area:_town work_address:industry job_desc:_jianjie salary:company status:1 province_id:provinceId city_id:cityId area_id:0 job_lon:[NSString stringWithFormat:@"%f",_longtitude] job_lat:[NSString stringWithFormat:@"%f",_latitude] success:^(NSDictionary *obj) {
        
        [IHUtility removeWaitingView];
        
        if (self.model) {
            [self addSucessView:@"职位编辑成功" type:1];
            PositionListModel *model=[[PositionListModel alloc]initWithDictionary:obj[@"content"] error:nil];
            NSDictionary *dic=@{@"key":model};
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationEditPosition object:nil userInfo:dic];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self addSucessView:@"职位发布成功" type:1];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSDictionary *obj2) {
    }];
}

-(void)back:(id)sender
{
    [IHUtility AlertMessage:@"" message:@"是否结束编辑" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:14];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    __weak CreatPositionViewController *weakSelf=self;
    if (alertView.tag==14) {
        if (buttonIndex==0) {
            if (self.model) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

-(void)pushToChooseVC{
    
    ChoosePositionViewController *vc=[[ChoosePositionViewController alloc]init];
    vc.selectBlock=^(NSInteger index,NSString *str){
        EditInformationView *view=[self.view viewWithTag:1002];
        view.lbl.text=str;
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

-(void)displayTiyle:(NSString *)title type:(EditBlock)type{
    
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
    
    if (type==SelectPositionNameBlock) {
        EditInformationView *view=[self.view viewWithTag:1003];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
    
    if (type==SelectAdressBlock) {
        EditInformationView *view=[self.view viewWithTag:1008];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
    
    if (type==SelectPositionIntroductionBlock) {
        EditInformationView *view=[self.view viewWithTag:1009];
        view.lbl.text=@"已填写";
        view.lbl.textColor=cBlackColor;
        _jianjie=title;
    }
}

-(void)pushToMapVC{
    if ([_city isEqualToString:@""]&&[_province isEqualToString:@""]) {
        [IHUtility addSucessView:@"请先选着工作城市" type:2];
    }else{
        AdressChooseViewController *vc=[[AdressChooseViewController alloc]init];
        vc.Province=_province;
        vc.City=_city;
        vc.selectBlock=^(NSString *town,NSString *address,CGFloat latitude,CGFloat longtitude){
            EditInformationView *view=[self.view viewWithTag:1008];
            view.lbl.text=address;
            self->_town=town;
            view.lbl.textColor=cBlackColor;
            self->_latitude=latitude;
            self->_longtitude=longtitude;
        };
        [self pushViewController:vc];
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
    if (pickViewComponent.tag==21) {
        NSLog(@"%@",SelectedStr);
        EditInformationView *urgentView=[_BaseScrollView viewWithTag:1004];
        urgentView.lbl.textColor=cBlackColor;
        urgentView.lbl.text=SelectedStr;
    }else if(pickViewComponent.tag==22)
    {
        NSLog(@"%@",SelectedStr);
        EditInformationView *sexView=[_BaseScrollView viewWithTag:1005];
        sexView.lbl.textColor=cBlackColor;
        sexView.lbl.text=SelectedStr;
    }else if(pickViewComponent.tag==23)
    {
        NSLog(@"%@",SelectedStr);
        EditInformationView *sexView=[_BaseScrollView viewWithTag:1006];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
