//
//  PersonUserInfromationViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/18.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PersonUserInfromationViewController.h"
#import "EditPersonInformationViewController.h"
@interface PersonUserInfromationViewController ()<personInfoDelegate>
{
//    PersonInformationView *_personView;
    UIImageView *_positionImageView;
    SMLabel *_positionLabel;
    UIImageView *_pohoneImageView;
    SMLabel *_pohoneLabel;
    UIImageView *_telpohoneImageView;
    SMLabel *_telpohoneLabel;
    UIImageView *_emailImageView;
    SMLabel *_emailLabel;
    SMLabel *_ZYlbl;
    SMLabel *_JJlbl;
    SMLabel *_qyLbl;
    NSDictionary *_dic;
    UIView *_lineView4;
    UIView *_lineView5;
//    UIImageView *_companyImageView;
}

@end

@implementation PersonUserInfromationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self creatView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setData) name:NotificationUpdateUserinfo object:nil];
}

-(void)personDelegate:(NSInteger )index{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatView
{
    // UIImage *bkImg=Image(@"bgimage.png");
    PersonInformationView *personView=[[PersonInformationView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 245)];
    personView.delegate=self;
    
    //    personView.selectBlock=^(NSInteger index){
    //        if (index==SelectheadImageBlock) {
    //            NSLog(@"block");
    //
    //        }
    //    };
    
//    _personView=personView;
	
    [_BaseScrollView addSubview:personView];
    
    UIButton *editBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    CGSize BtnSize=[IHUtility GetSizeByText:@"编辑" sizeOfFont:17 width:100];
    editBtn.frame=CGRectMake(0.85*WindowWith, 30, BtnSize.width , BtnSize.height);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font=sysFont(17);
    [editBtn addTarget:self action:@selector(editPersonInformtion) forControlEvents:UIControlEventTouchUpInside];
    [personView addSubview:editBtn];
    
    
    if (![self.userid isEqualToString:USERMODEL.userID]) {
        editBtn.hidden=YES;
    }
    
    SMLabel *informtionLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.053*WindowWith, personView.bottom+15, 60, 20) textColor:cGreenColor textFont:sysFont(15)];
    informtionLbl.text=@"个人资料";
    [_BaseScrollView addSubview:informtionLbl];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(informtionLbl.left, informtionLbl.bottom+2, WindowWith-informtionLbl.left*2, 2)];
    lineView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView];
    
    UIImage *companyImg=Image(@"iconfont-gongsi.png");
    UIImageView *companyImageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left, lineView.bottom+10, companyImg.size.width, companyImg.size.height)];
//    _companyImageView=companyImageView;
    companyImageView.image=companyImg;
    [_BaseScrollView addSubview:companyImageView];
    
    SMLabel *companyLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(companyImageView.right+10, companyImageView.top, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
    //  _positionLabel=companyLabel;
    
    [_BaseScrollView addSubview:companyLabel];
    
    UIImage *positionImg=Image(@"Group 44.png");
    UIImageView *positionImageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left, companyImageView.bottom+10, positionImg.size.width, positionImg.size.height)];
    _positionImageView=positionImageView;
    positionImageView.image=positionImg;
    [_BaseScrollView addSubview:positionImageView];
    
    SMLabel *positionLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(positionImageView.right+10, positionImageView.top, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
    _positionLabel=positionLabel;
    
    [_BaseScrollView addSubview:positionLabel];
    
    
    UIImage   *img=Image(@"RM_m.png");
    UIImageView  *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(positionLabel.right+10, positionImageView.top+3, img.size.width, img.size.height)];
    imageView.image=img;
    // _imageView=imageView;
    [_BaseScrollView addSubview:imageView];
    
    
    SMLabel   *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+3, imageView.top+2, 48, 12) textColor:cBlackColor textFont:sysFont(12)];
    lbl.text=@"苗木基地";
    //_typeLbl=lbl;
    [_BaseScrollView addSubview:lbl];
    
    UIImage *adressImg=Image(@"homeadd.png");
    UIImageView *adressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(positionImageView.left, positionImageView.bottom+10, adressImg.size.width, adressImg.size.height)];
    // _pohoneImageView=pohoneImageView;
    adressImageView.image=adressImg;
    [_BaseScrollView addSubview:adressImageView];
    
    
    SMLabel *adressLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(adressImageView.right+10, adressImageView.top-3, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
    //_pohoneLabel=pohoneLabel;
    
    [_BaseScrollView addSubview:adressLabel];
    
    UIImage *phoneImg=Image(@"iconfont-lianxidianhua.png");
    UIImageView *pohoneImageView=[[UIImageView alloc]initWithFrame:CGRectMake(adressImageView.left, adressImageView.bottom+10, phoneImg.size.width, phoneImg.size.height)];
    _pohoneImageView=pohoneImageView;
    pohoneImageView.image=phoneImg;
    [_BaseScrollView addSubview:pohoneImageView];
    
    
    SMLabel *pohoneLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(pohoneImageView.right+10, pohoneImageView.top, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
    _pohoneLabel=pohoneLabel;
    
    [_BaseScrollView addSubview:pohoneLabel];
    
    UIImage *telphoneImg=Image(@"phoneG.png");
    UIImageView *telpohoneImageView=[[UIImageView alloc]initWithFrame:CGRectMake(pohoneImageView.left, pohoneImageView.bottom+10, telphoneImg.size.width, telphoneImg.size.height)];
    _telpohoneImageView=telpohoneImageView;
    
    telpohoneImageView.image=telphoneImg;
    [_BaseScrollView addSubview:telpohoneImageView];
    
    
    SMLabel *telpohoneLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(telpohoneImageView.right+10, telpohoneImageView.top, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
    
    _telpohoneLabel=telpohoneLabel;
    [_BaseScrollView addSubview:telpohoneLabel];
    
    UIImage *emailImg=Image(@"messageG.png");
    UIImageView *emailImageView=[[UIImageView alloc]initWithFrame:CGRectMake(telpohoneImageView.left, telpohoneImageView.bottom+10, emailImg.size.width, emailImg.size.height)];
    _emailImageView=emailImageView;
    emailImageView.image=emailImg;
    [_BaseScrollView addSubview:emailImageView];
    
    
    SMLabel *emailLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(emailImageView.right+10, emailImageView.top, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
    _emailLabel=emailLabel;
    
    [_BaseScrollView addSubview:emailLabel];
    
    CGSize companySize=[IHUtility GetSizeByText:self.dic[@"company_name"] sizeOfFont:14 width:WindowWith-companyImageView.right-10];
    if ([self.dic[@"company_name"] isEqualToString:@""]) {
        companyLabel.hidden=YES;
        companyImageView.hidden=YES;
    }else
    {
        companyLabel.text=self.dic[@"company_name"];
        companyLabel.size=CGSizeMake(companySize.width, companySize.height);
    }
    
    CGSize positionSize=[IHUtility GetSizeByText:self.dic[@"position"] sizeOfFont:14 width:200];
    if ([self.dic[@"position"] isEqualToString:@""]) {
        _positionLabel.hidden=YES;
        _positionImageView.hidden=YES;
    }else
    {
        _positionLabel.text=self.dic[@"position"];
        _positionLabel.size=CGSizeMake(positionSize.width, 14);
    }
    
    imageView.origin=CGPointMake(_positionLabel.right+10, _positionLabel.top);
    lbl.origin=CGPointMake(imageView.right+3, imageView.top+2);
    if ([self.dic[@"i_type_id"] integerValue]==1) {
        imageView.image=Image(@"RM_m.png");
        lbl.text=@"苗木基地";
        
    }else if ([self.dic[@"i_type_id"] integerValue]==2)
    {
        imageView.image=Image(@"RM_j.png");
        lbl.text=@"景观设计";
    }else if ([self.dic[@"i_type_id"] integerValue]==3)
    {   lbl.text=@"施工企业";
        imageView.image=Image(@"RM_g.png");
        
    }else if ([self.dic[@"i_type_id"] integerValue]==4){
        imageView.image=Image(@"RM_c.png");
        lbl.text=@"园林资材";
    }else if ([self.dic[@"i_type_id"] integerValue]==5){
        imageView.image=Image(@"RM_s.png");
        lbl.text=@"花木市场";
    }
    
    CGSize adressSize=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@%@%@%@",self.dic[@"addressInfo"][@"company_province"],self.dic[@"addressInfo"][@"company_city"],self.dic[@"addressInfo"][@"company_area"],self.dic[@"addressInfo"][@"company_street"]] sizeOfFont:14 width:WindowWith-adressImageView.right-10];
    
    if ([self.dic[@"addressInfo"][@"company_province"] isEqualToString:@""] &&[self.dic[@"addressInfo"][@"company_city"] isEqualToString:@""]&&[self.dic[@"addressInfo"][@"company_area"] isEqualToString:@""]&&[self.dic[@"addressInfo"][@"company_street"] isEqualToString:@""]) {
        adressLabel.hidden=YES;
        adressImageView.hidden=YES;
    }else
    {
        adressLabel.text=[NSString stringWithFormat:@"%@%@%@%@",self.dic[@"addressInfo"][@"company_province"],self.dic[@"addressInfo"][@"company_city"],self.dic[@"addressInfo"][@"company_area"],self.dic[@"addressInfo"][@"company_street"]];
        adressLabel.size=CGSizeMake(adressSize.width, 14);
    }
    
    CGSize pohoneSize=[IHUtility GetSizeByText:self.dic[@"mobile"] sizeOfFont:14 width:200];
    if (_positionLabel.hidden) {
        if (self.dic[@"mobile"]==0) {
            _pohoneImageView.hidden=YES;
            _pohoneLabel.hidden=YES;
        }else
        {
            _pohoneLabel.text=self.dic[@"mobile"];
            _pohoneImageView.origin=CGPointMake(_positionImageView.left, _positionImageView.top);
            _pohoneLabel.frame=CGRectMake(_pohoneImageView.right+10, _pohoneImageView.top, pohoneSize.width, 14);
        }
    }else
    {
        if (self.dic[@"mobile"]==0) {
            _pohoneImageView.hidden=YES;
            _pohoneLabel.hidden=YES;
        }else
        {
            _pohoneLabel.text=self.dic[@"mobile"] ;
            _pohoneLabel.size=CGSizeMake(pohoneSize.width, 14);
        }
    }
    CGSize telpohoneSize=[IHUtility GetSizeByText:self.dic[@"landline"] sizeOfFont:14 width:200];
    
    if (_pohoneLabel.hidden) {
        if ([self.dic[@"landline"] isEqualToString:@""]) {
            _telpohoneImageView.hidden=YES;
            _telpohoneLabel.hidden=YES;
        }else
        {
            _telpohoneLabel.text=self.dic[@"landline"];
            _telpohoneImageView.origin=CGPointMake(_pohoneImageView.left, _pohoneImageView.top);
            _telpohoneLabel.frame=CGRectMake(_telpohoneImageView.right+10, _telpohoneImageView.top, telpohoneSize.width, 14);
        }
    }else
    {
        if ([self.dic[@"landline"] isEqualToString:@""]) {
            _telpohoneImageView.hidden=YES;
            _telpohoneLabel.hidden=YES;
        }else
        {
            _telpohoneLabel.text=self.dic[@"landline"];
            _telpohoneLabel.size=CGSizeMake(telpohoneSize.width, 14);
        }
    }
    
    CGSize emailSize=[IHUtility GetSizeByText:self.dic[@"email"] sizeOfFont:14 width:200];
    if (_telpohoneLabel.hidden) {
        if ([self.dic[@"email"] isEqualToString:@""]) {
            _emailImageView.hidden=YES;
            _emailLabel.hidden=YES;
        }else
        {
            _emailLabel.text=self.dic[@"email"];
            _emailImageView.origin=CGPointMake(_telpohoneImageView.left, _telpohoneImageView.top);
            _emailLabel.frame=CGRectMake(_emailImageView.right+10, _emailImageView.top-3, emailSize.width, 14);
        }
    }else
    {
        if ([self.dic[@"email"] isEqualToString:@""]) {
            _emailImageView.hidden=YES;
            _emailLabel.hidden=YES;
        }else
        {
            _emailLabel.text=self.dic[@"email"];
            _emailLabel.size=CGSizeMake(emailSize.width, 14);
        }
    }
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, emailImageView.bottom+20, WindowWith, 12)];
    lineView2.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView2];
    
    
    SMLabel *zyLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(emailImageView.left, lineView2.bottom+10, 60, 21) textColor:cGreenColor textFont:sysFont(15)];
    zyLbl.text=@"主营业务";
    [_BaseScrollView addSubview:zyLbl];
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(zyLbl.left, zyLbl.bottom+2, WindowWith-2*zyLbl.left, 1)];
    lineView3.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView3];
    
    
    CGSize ZYSize=[IHUtility GetSizeByText:[NSString stringWithFormat:@"   %@",self.dic[@"business_direction"]] sizeOfFont:14 width:lineView3.width-10];
    SMLabel *ZYlbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView3.left, lineView3.bottom+10, ZYSize.width, ZYSize.height) textColor:cBlackColor textFont:sysFont(14)];
    ZYlbl.numberOfLines=0;
    ZYlbl.text=self.dic[@"business_direction"];
    _ZYlbl=ZYlbl;
    
    [_BaseScrollView addSubview:ZYlbl];
    
    UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(0, ZYlbl.bottom+10, WindowWith, 12)];
    _lineView4=lineView4;
    lineView4.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView4];
    
    SMLabel *qyLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(emailImageView.left, lineView4.bottom+10, 60, 21) textColor:cGreenColor textFont:sysFont(15)];
    _qyLbl=qyLbl;
    qyLbl.text=@"企业简介";
    [_BaseScrollView addSubview:qyLbl];
    
    UIView *lineView5=[[UIView alloc]initWithFrame:CGRectMake(qyLbl.left, qyLbl.bottom+2, WindowWith-2*zyLbl.left, 1)];
    _lineView5=lineView5;
    lineView5.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView5];
    
    
    CGSize JJSize=[IHUtility GetSizeByText:[NSString stringWithFormat:@"   %@",self.dic[@"brief_introduction"]] sizeOfFont:14 width:lineView5.width-10];
    SMLabel *JJlbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView5.left, qyLbl.bottom+10, JJSize.width, JJSize.height) textColor:cBlackColor textFont:sysFont(14)];
    JJlbl.numberOfLines=0;
    _JJlbl=JJlbl;
    JJlbl.text=self.dic[@"brief_introduction"];
    [_BaseScrollView addSubview:JJlbl];
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, 666);
    if (JJlbl.bottom>666) {
        _BaseScrollView.contentSize=CGSizeMake(WindowWith, JJlbl.bottom);
        
    }
    //  [_personView setDataWithModel:self.UserModel arr:self.arr];
    
}

-(NSDictionary *)reload
{
    [self addWaitingView];
    [network selectUseerInfoForId:[self.userid intValue]success:^(NSDictionary *obj) {
        [self removeWaitingView];
        self->_dic=obj[@"content"];        
    } failure:^(NSDictionary *obj2) {
        
    }];
    return _dic;
    
}

-(void)editPersonInformtion
{
    NSLog(@"edit");
    EditPersonInformationViewController *editVC=[[EditPersonInformationViewController alloc]init];
    
    [self pushViewController:editVC];
}

-(void)setData
{
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    //UserChildrenInfo *model=[[UserChildrenInfo alloc]initWithDic:dic];
    // [_personView setDa taWithModel:model arr:self.arr];
    CGSize positionSize=[IHUtility GetSizeByText:dic[@"position"] sizeOfFont:14 width:200];
    if ([dic[@"position"] isEqualToString:@""]) {
        _positionLabel.hidden=YES;
        _positionImageView.hidden=YES;
    }else
    {
        _positionLabel.text=dic[@"position"];
        _positionLabel.size=CGSizeMake(positionSize.width, positionSize.height);
    }

    CGSize pohoneSize=[IHUtility GetSizeByText:dic[@"mobile"] sizeOfFont:14 width:200];
    if (_positionLabel.hidden) {
        if ([dic[@"mobile"] integerValue]==0) {
            _pohoneImageView.hidden=YES;
            _pohoneLabel.hidden=YES;
        }else
        {
            _pohoneLabel.text=dic[@"mobile"];
            _pohoneImageView.origin=CGPointMake(_positionImageView.left, _positionImageView.top);
            _pohoneLabel.frame=CGRectMake(_pohoneImageView.right+10, _pohoneImageView.top, pohoneSize.width, pohoneSize.height);
        }
    }else
    {
        if ([dic[@"mobile"] integerValue]==0) {
            _pohoneImageView.hidden=YES;
            _pohoneLabel.hidden=YES;
        }else
        {
            _pohoneLabel.text=dic[@"mobile"] ;
            
            _pohoneLabel.size=CGSizeMake(pohoneSize.width, pohoneSize.height);
        }
        
    }
    CGSize telpohoneSize=[IHUtility GetSizeByText:dic[@"landline"] sizeOfFont:14 width:200];
    
    if (_pohoneLabel.hidden) {
        if ([dic[@"landline"] isEqualToString:@""]) {
            _telpohoneImageView.hidden=YES;
            _telpohoneLabel.hidden=YES;
        }else
        {
            _telpohoneLabel.text=dic[@"landline"];
            _telpohoneImageView.origin=CGPointMake(_pohoneImageView.left, _pohoneImageView.top);
            _telpohoneLabel.frame=CGRectMake(_telpohoneImageView.right+10, _telpohoneImageView.top, telpohoneSize.width, telpohoneSize.height);
        }
    }else
    {
        if ([dic[@"landline"] isEqualToString:@""]) {
            _telpohoneImageView.hidden=YES;
            _telpohoneLabel.hidden=YES;
        }else
        {
            _telpohoneLabel.text=dic[@"landline"];
            _telpohoneLabel.size=CGSizeMake(telpohoneSize.width, telpohoneSize.height);
        }
    }
    
    
    CGSize emailSize=[IHUtility GetSizeByText:dic[@"email"] sizeOfFont:14 width:200];
    if (_telpohoneLabel.hidden) {
        if ([dic[@"email"] isEqualToString:@""]) {
            _emailImageView.hidden=YES;
            _emailLabel.hidden=YES;
        }else
        {
            _emailLabel.text=dic[@"email"];
            _emailImageView.origin=CGPointMake(_telpohoneImageView.left, _telpohoneImageView.top);
            _emailLabel.frame=CGRectMake(_emailImageView.right+10, _emailImageView.top-3, emailSize.width, emailSize.height);
        }
    }else
    {
        if ([dic[@"email"] isEqualToString:@""]) {
            _emailImageView.hidden=YES;
            _emailLabel.hidden=YES;
        }else
        {
            _emailLabel.text=dic[@"email"];
            _emailLabel.size=CGSizeMake(emailSize.width, emailSize.height);
        }
    }
    
    CGSize ZYSize=[IHUtility GetSizeByText:[NSString stringWithFormat:@"   %@",dic[@"business_direction"]] sizeOfFont:14 width:WindowWith-_pohoneImageView.left-10];
    _ZYlbl.text=[NSString stringWithFormat:@"   %@",dic[@"business_direction"]];
    _ZYlbl.size=CGSizeMake(ZYSize.width, ZYSize.height);
    
    _lineView4.frame=CGRectMake(0, _ZYlbl.bottom+10, WindowWith, 12);
    
    _qyLbl.frame=CGRectMake(_emailImageView.left, _lineView4.bottom+10, 60, 21);
    CGRectMake(_qyLbl.left, _qyLbl.bottom+2, WindowWith-2*_emailImageView.left, 1);
    CGSize JJSize=[IHUtility GetSizeByText:[NSString stringWithFormat:@"   %@",dic[@"brief_introduction"]] sizeOfFont:14 width:WindowWith-_pohoneImageView.left-10];
    _JJlbl.text=[NSString stringWithFormat:@"   %@",dic[@"brief_introduction"]];
    
    _JJlbl.frame=CGRectMake(_lineView5.left, _lineView5.bottom+10, JJSize.width, JJSize.height);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCompany object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
