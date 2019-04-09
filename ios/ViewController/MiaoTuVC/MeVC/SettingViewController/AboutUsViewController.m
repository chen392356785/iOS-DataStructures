//
//  AboutUsViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
    [self setTitle:@"关于我们"];
    self.view.backgroundColor=RGBA(220,232,238,1);
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.enabled=NO;
    UIImage *img=Image(@"Icon-Small-40.png");
    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
   
    [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(21);
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0);
   
    

    [btn setTitle:KAppName2 forState:UIControlStateNormal];
    CGSize size=[IHUtility GetSizeByText:KAppName2 sizeOfFont:21 width:200];
    


    
    
    btn.frame=CGRectMake(WindowWith/2-img.size.width-size.width, 50, img.size.width+size.width+20, img.size.height);
   
    [self.view addSubview:btn];
    
    NSDictionary *dic=[[NSBundle mainBundle] infoDictionary];
    NSString *str=[dic objectForKey:@"CFBundleShortVersionString"];
    
    size=[IHUtility GetSizeByText:str sizeOfFont:15 width:200];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(btn.right+5, 0, size.width+10, size.height) textColor:cGreenColor textFont:sysFont(14)];
    lbl.centerY=btn.centerY;
    lbl.text=str;
    //lbl.font=sysFont(14);
    lbl.textAlignment=NSTextAlignmentCenter;
    [lbl setLayerMasksCornerRadius:8 BorderWidth:1 borderColor:cGreenColor];
    [self.view addSubview:lbl];
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"     %@是基于行业地图LBS系统的就近供需平台，旨在打造一个轻量、易用、轻松的苗木供求及社交平台，帮助园林从业人士更快的找苗、卖苗、互助互通。",KAppName] sizeOfFont:15 width:250];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake((WindowWith-size.width)/2.0, btn.bottom+40, size.width, size.height) textColor:cBlackColor textFont:sysFont(15)];
    lbl.numberOfLines=0;
   
    
  lbl.text=[NSString stringWithFormat:@"     %@是基于行业地图LBS系统的就近供需平台，旨在打造一个轻量、易用、轻松的苗木供求及社交平台，帮助园林从业人士更快的找苗、卖苗、互助互通。",KAppName];
    

    lbl.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lbl];
    
    img=Image(@"yangjuan.png");
    size=[IHUtility GetSizeByText:@"长沙中苗会 版权所有" sizeOfFont:14 width:200];

    CGFloat bottom = kBottomNoSapce;
    SMLabel * lbl1=[[SMLabel alloc]initWithFrameWith:CGRectMake((WindowWith-size.width)/2.0, WindowHeight-size.height-105-bottom, size.width, size.height) textColor:cBlackColor textFont:sysFont(14)];
    lbl1.text=@"长沙中苗会 版权所有";
    lbl1.textAlignment=NSTextAlignmentCenter;
   
    [self.view addSubview:lbl1];
    
    
    size=[IHUtility GetSizeByText:@"Copyright © 2015-2021 SheepStell Inc. All Rights Reserved." sizeOfFont:14 width:250];
    
    SMLabel * lbl2=[[SMLabel alloc]initWithFrameWith:CGRectMake((WindowWith-size.width)/2.0, lbl1.bottom+10, size.width, size.height) textColor:cBlackColor textFont:sysFont(14)];
    lbl2.text=@"Copyright © 2015-2021 SheepStell Inc. All Rights Reserved.";
    lbl2.textAlignment=NSTextAlignmentCenter;
    lbl2.numberOfLines=0;
    [self.view addSubview:lbl2];
    
    
    

    
    img=Image(@"telphone4.png");
    size=[IHUtility GetSizeByText:@"13396578980" sizeOfFont:18 width:200];
      btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [btn setTitle:@"13396578980" forState:UIControlStateNormal];
    [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(18);
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    btn.frame=CGRectMake((WindowWith-img.size.width-size.width-15)/2.0, WindowHeight-size.height-20-bottom, img.size.width+size.width+15, img.size.height);
    [btn addTarget:self action:@selector(phoneCall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
}


-(void)phoneCall
{
    NSString *phoneString = [NSString stringWithFormat:@"tel:%@",KTelNum];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
    [self.view addSubview:callWebview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
