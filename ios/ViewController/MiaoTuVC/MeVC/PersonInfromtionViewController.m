//
//  PersonInfromtionViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/22.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PersonInfromtionViewController.h"

@implementation PersonInfromtionViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
     
}


-(void)viewDidLoad
{
    [super viewDidLoad];
   UIImage *bkImg=Image(@"bgimage.png");
    PersonInformationView *personView=[[PersonInformationView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, bkImg.size.height) :nil :nil];
    [_BaseScrollView addSubview:personView];
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, personView.bottom, WindowWith, 7)];
    lineView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView];
    
    SMLabel *positionLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.053*WindowWith, lineView.bottom+20, 30, 15) textColor:cGreenColor textFont:[UIFont systemFontOfSize:15]];
    positionLbl.text=@"职位";
    [_BaseScrollView addSubview:positionLbl];
    
    
    SMLabel *positionLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(positionLbl.right+10, positionLbl.top, 0.26*WindowWith, positionLbl.height) textColor:cBlackColor textFont:[UIFont systemFontOfSize:15]];
    positionLabel.text=@"销售经理";
    [_BaseScrollView addSubview:positionLabel];
    
    
    SMLabel *mobileLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(positionLbl.left, positionLbl.bottom+10, 30, 15) textColor:cGreenColor textFont:[UIFont systemFontOfSize:15]];
    mobileLbl.text=@"手机";
    [_BaseScrollView addSubview:mobileLbl];
    
    SMLabel *mobileLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(mobileLbl.right+10, mobileLbl.top, 0.26*WindowWith, mobileLbl.height) textColor:cBlackColor textFont:[UIFont systemFontOfSize:15]];
    mobileLabel.text=@"18976331234";
    [_BaseScrollView addSubview:mobileLabel];
    
    
    
    SMLabel *emailLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.49*WindowWith, positionLbl.top, 30, 15) textColor:cGreenColor textFont:[UIFont systemFontOfSize:15]];
    emailLbl.text=@"邮箱";
    [_BaseScrollView addSubview:emailLbl];
    
    
    SMLabel *emailLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(emailLbl.right+10, emailLbl.top, 0.36*WindowWith, emailLbl.height) textColor:cBlackColor textFont:[UIFont systemFontOfSize:15]];
    emailLabel.text=@"31325729@qq.com";
    [_BaseScrollView addSubview:emailLabel];
    
    
    
    
    SMLabel *phoneLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(emailLbl.left, emailLbl.bottom+10, 30, 15) textColor:cGreenColor textFont:[UIFont systemFontOfSize:15]];
    phoneLbl.text=@"座机";
    [_BaseScrollView addSubview:phoneLbl];
    
    SMLabel *phoneLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(phoneLbl.right+10, phoneLbl.top, 0.36*WindowWith, phoneLbl.height) textColor:cBlackColor textFont:[UIFont systemFontOfSize:15]];
    phoneLabel.text=@"0731-88331124";
    [_BaseScrollView addSubview:phoneLabel];

    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(mobileLbl.left, mobileLbl.bottom+10, WindowWith-2*mobileLbl.left, 1)];
    
    
    lineView2.backgroundColor=cGreenColor;
    [_BaseScrollView addSubview:lineView2];
    
    SMLabel *zhuying=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView2.left, lineView2.bottom+10, 30, 15) textColor:cGreenColor textFont:[UIFont systemFontOfSize:15]];
    zhuying.text=@"主营";
    [_BaseScrollView addSubview:zhuying];
    
    SMLabel *yewu=[[SMLabel alloc]initWithFrameWith:CGRectMake(zhuying.left, zhuying.bottom+5, 30, 15) textColor:cGreenColor textFont:[UIFont systemFontOfSize:15]];
    yewu.text=@"业务";
    [_BaseScrollView addSubview:yewu];
    
    
    CGSize ZYSize=[IHUtility GetSizeByText:@"大丽花、紫萝兰、美国柏、黄叶银杏、红叶紫薇、中国红樱花。" sizeOfFont:14 width:lineView2.width-zhuying.width-10];
    SMLabel *ZYlbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(zhuying.right+10, zhuying.top, ZYSize.width, ZYSize.height) textColor:cBlackColor textFont:[UIFont systemFontOfSize:14]];
    ZYlbl.numberOfLines=0;
    ZYlbl.text=@"大丽花、紫萝兰、美国柏、黄叶银杏、红叶紫薇、中国红樱花。";
    [_BaseScrollView addSubview:ZYlbl];
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(lineView2.left, ZYlbl.bottom+20, lineView2.width, lineView2.height)];
    lineView3.backgroundColor=cGreenColor;
    [_BaseScrollView addSubview:lineView3];
    
    
    SMLabel *qiye=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView3.left, lineView3.bottom+10, 40, 40) textColor:cGreenColor textFont:[UIFont systemFontOfSize:15]];
    qiye.text=@"企业简介";
    qiye.numberOfLines=2;
    [_BaseScrollView addSubview:qiye];
    
//    SMLabel *jianjie=[[SMLabel alloc]initWithFrameWith:CGRectMake(qiye.left, qiye.bottom+5, 30, 15) textColor:cGreenColor textFont:[UIFont systemFontOfSize:15]];
//    jianjie.text=@"";
//    [_BaseScrollView addSubview:jianjie];
    
    
    CGSize JJSize=[IHUtility GetSizeByText:@"浏阳正河苗圃基地位于浏阳市苗木产业园内，热诚欢迎各界朋友前来参观、考察、洽谈业务。" sizeOfFont:14 width:lineView2.width-qiye.width-10];
    SMLabel *JJlbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(qiye.right+10, qiye.top, JJSize.width, JJSize.height) textColor:cBlackColor textFont:[UIFont systemFontOfSize:14]];
    JJlbl.numberOfLines=0;
    JJlbl.text=@"浏阳正河苗圃基地位于浏阳市苗木产业园内，热诚欢迎各界朋友前来参观、考察、洽谈业务。";
    [_BaseScrollView addSubview:JJlbl];


    
    
}
@end
