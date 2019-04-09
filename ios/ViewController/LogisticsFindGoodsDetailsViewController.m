//
//  LogisticsFindGoodsDetailsViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "LogisticsFindGoodsDetailsViewController.h"
//#import "LogisticsCarCertifyViewController.h"
#import "CustomView+CustomCategory2.h"

@interface LogisticsFindGoodsDetailsViewController ()

@end

@implementation LogisticsFindGoodsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"货源详情"];
    [self setNavBarItem:NO];
    
    self.view.backgroundColor=RGB(239, 239, 239);
    
    UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, WindowWith, 400)];
    bkView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bkView];
    
    LogisticsAdressView *logisticsAdressView=[[LogisticsAdressView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 104)];
    
    [bkView addSubview:logisticsAdressView];
    
    LogisticsHeaderView *logisticsHeaderView=[[LogisticsHeaderView alloc]initWithFrame:CGRectMake(0, logisticsAdressView.bottom, WindowWith, 65)];
    [bkView addSubview:logisticsHeaderView];
    
    UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(15, logisticsHeaderView.bottom, WindowWith-30, 1)];
    lineView.backgroundColor=cLineColor;
    [bkView addSubview:lineView];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.left, lineView.bottom+15, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"货物品名：香樟";
    [bkView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"数   量：50";
    [bkView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"用车规格：高栏车/9.6米/10吨";
    [bkView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"用车数量：2辆";
    [bkView addSubview:lbl];
    
    CGSize size=[IHUtility GetSizeByText:@"非诚勿扰。" sizeOfFont:15 width:WindowWith-30];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, size.width, size.height) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"非诚勿扰。";
    lbl.numberOfLines=0;
    [bkView addSubview:lbl];
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(15, lbl.bottom+15, WindowWith-30, 1)];
    lineView.backgroundColor=cLineColor;
    [bkView addSubview:lineView];
    
    bkView.size=CGSizeMake(WindowWith, lineView.bottom+45);
    
    UIImage *timeImg=Image(@"fav_time.png");
    UIImageView *timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left, lineView.bottom+15, timeImg.size.width, timeImg.size.height)];
    timeImageView.image=timeImg;
    
    [bkView addSubview:timeImageView];
    
    SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(timeImageView.right+5, timeImageView.top, 150, 15) textColor:cGrayLightColor textFont:sysFont(15)];
    timeLbl.text=@"15小时前";
    [bkView addSubview:timeLbl];
    
    size=[IHUtility GetSizeByText:@"距我1.38公里" sizeOfFont:15 width:150];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.right-size.width, timeLbl.top, size.width, size.height) textColor:cGrayLightColor textFont:sysFont(15)];
    lbl.text=@"距我1.38公里";
    [bkView addSubview:lbl];
    
    NSArray *imgArr=@[@"hi_black.png",@"telphone.png",@"qiangdan.png"];
    NSArray *titleArr=@[@"咨询议价",@"打电话",@"抢单"];
    MTBottomView *bottomView=[[MTBottomView alloc]initWithImgArr:imgArr TitleArr:titleArr];
    
    [self.view addSubview:bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
