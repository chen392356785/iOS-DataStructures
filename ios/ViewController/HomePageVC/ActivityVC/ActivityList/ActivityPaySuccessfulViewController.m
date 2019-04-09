//
//  ActivityPaySuccessfulViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/10.
//  Copyright © 2016年 xubin. All rights reserved.
//

//#import "ActivityDetailViewController.h"
#import "ActivityPaySuccessfulViewController.h"
#import "orderStateView.h"
#import "ActivtiesVoteViewController.h"
#import "ActivesCrowdFundController.h"  //v2.9.10

@interface ActivityPaySuccessfulViewController ()

@end

@implementation ActivityPaySuccessfulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"支付结果"];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImage *img=Image(@"paySuccess.png");
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45, img.size.width, img.size.height)];
    imageView.image=img;
    imageView.right= WindowWith/2.0;
    [self.view addSubview:imageView];
    
    CGSize size = [IHUtility GetSizeByText:@"报名成功" sizeOfFont:20 width:200];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right + 13, imageView.bottom+20, size.width, 28) textColor:RGB(85, 201, 196) textFont:sysFont(20)];
    lbl.text=@"报名成功";
    lbl.centerY=imageView.centerY;
    [self.view addSubview:lbl];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, imageView.bottom + 27 , WindowWith - 30, 0.5)];
    lineView.backgroundColor = RGB(239, 239, 239);
    [self.view addSubview:lineView];
    
    orderStateView *orderView = [[orderStateView alloc] initWithFrame:CGRectMake(0, lineView.bottom + 8, kScreenWidth, 100)];
    [orderView setActivtiesData:self.model];
    [self.view addSubview:orderView];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(comeActivtDetail:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired= 1;
    [orderView addGestureRecognizer:tap];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, orderView.bottom+8, WindowWith, 20) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text=[NSString stringWithFormat:@"订单编号:%@",self.model.order_no];
    [self.view addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, lbl.bottom+8, WindowWith, 20) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text=[NSString stringWithFormat:@"交易时间:%@",self.model.uploadtime];
    [self.view addSubview:lbl];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake((WindowWith - 240)/3.0, lbl.bottom+45, 120, 42);
    [btn setTitle:@"我的订单" forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(18.8);
    [btn addTarget:self action:@selector(finishPay) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
    [btn setLayerMasksCornerRadius:2 BorderWidth:1 borderColor:cBlackColor];
    [self.view addSubview:btn];
    
    UIButton *Btn=[UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame=CGRectMake(btn.right + (WindowWith - 240)/3.0, btn.top, 120, 42);
    [Btn setTitle:@"返回首页" forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(myActicity) forControlEvents:UIControlEventTouchUpInside];
    Btn.titleLabel.font=sysFont(18.8);
    [Btn setTitleColor:cBlackColor forState:UIControlStateNormal];
    [Btn setLayerMasksCornerRadius:2 BorderWidth:1 borderColor:cBlackColor];
    [self.view addSubview:Btn];
}

-(void)finishPay
{
    [self popViewController:1];
}

-(void)back:(id)sender{
    [self popViewController:1];
}

//返回活动主页
-(void)myActicity
{
    [self popViewController:0];
}
- (void)comeActivtDetail:(UITapGestureRecognizer *)tap
{
    [network getActivitiesDetail:self.model.activities_id type:self.model.model success:^(NSDictionary *obj) {
        ActivitiesListModel *detailModel = obj[@"content"];
        if ([detailModel.model isEqualToString:@"7"])
        {
            
            ActivtiesVoteViewController *vc = [[ActivtiesVoteViewController alloc] init];
            vc.model = detailModel;
            vc.indexPath = self.indexPath;
            [self pushViewController:vc];
        }else {
            ActivesCrowdFundController *vc=[[ActivesCrowdFundController alloc]init];
            vc.model = detailModel;
            vc.indexPath = self.indexPath;
            vc.type = @"1";
            [self pushViewController:vc];
        }
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
