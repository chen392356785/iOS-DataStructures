//
//  LogisticsFindCarDetailsViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/26.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory2.h"
#import "LogisticsFindCarDetailsViewController.h"

@interface LogisticsFindCarDetailsViewController ()

@end

@implementation LogisticsFindCarDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"车源详情"];
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
    
    UIImage  *img=Image(@"che.png");
    UIImageView   *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, logisticsHeaderView.bottom+10, img.size.width, img.size.height)];;
    imageView.image=img;
    [bkView addSubview:imageView];
    
    SMLabel  *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+12, imageView.top, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"车牌号：湘AKB4321";
    [bkView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+12, lbl.bottom+10, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"车   型：高栏车";
    [bkView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+12, lbl.bottom+10, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"车   长：9.6米";
    [bkView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+12, lbl.bottom+10, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"载   重：10吨";
    [bkView addSubview:lbl];
    
    CGSize  size=[IHUtility GetSizeByText:@"有车从湖南长沙出发，到北京，两天往返，有货需要从两地运输的可联系我。我的电话：13888111231，望能长期合作" sizeOfFont:15 width:WindowWith-30];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, imageView.bottom+10, size.width, size.height) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"有车从湖南长沙出发，到北京，两天往返，有货需要从两地运输的可联系我。我的电话：13888111231，望能长期合作";
    lbl.numberOfLines=0;
    [bkView addSubview:lbl];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lbl.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [lbl.text length])];
    lbl.attributedText = attributedString;
    
    [lbl sizeToFit];
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(15, lbl.bottom+20, WindowWith-30, 1)];
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
    NSArray *titleArr=@[@"打个招呼",@"打电话",@"预约"];
    MTBottomView *bottomView=[[MTBottomView alloc]initWithImgArr:imgArr TitleArr:titleArr];;
    [self.view addSubview:bottomView];
}

-(void)headTap:(UIButton *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
