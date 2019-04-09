//
//  JobIdentViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "JobIdentViewController.h"
#import "GiuZhiViewController.h"
#import "ZhaoPingViewController.h"
#import "MyJobViewController.h"
#import "PositionListViewController.h"
@interface JobIdentViewController ()
{
    UIView *_view1;
    UIView *_view2;
}
@end

@implementation JobIdentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"招聘求职"];
    self.view.backgroundColor=RGB(247, 248, 250);
    UIImage *img=Image(@"qiuzhi.png");
    UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
    imageView.frame=CGRectMake(0, 0, img.size.width, img.size.height);
    _view1=[[UIView alloc]initWithFrame:CGRectMake(0, 20, WindowWith, img.size.height)];
    [self.view addSubview:_view1];
    _view1.backgroundColor=[UIColor whiteColor];
    [_view1 addSubview:imageView];
    
    _view1.tag=1001;
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+0.09*WindowWith, 15, 100, 20) textColor:cBlackColor textFont:sysFont(20)];
    lbl.text=@"我要求职";
    [_view1 addSubview:lbl];
    
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, 10+lbl.bottom, 150, 13) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text=@"为您提供卓越企业信息";
    [_view1 addSubview:lbl];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnTap:)];
    [_view1 addGestureRecognizer:tap];
    
    img=Image(@"zhaoping.png");
    imageView=[[UIImageView alloc]initWithImage:img];
    imageView.frame=CGRectMake(0, 0, img.size.width, img.size.height);
    _view2=[[UIView alloc]initWithFrame:CGRectMake(0, _view1.bottom+7, WindowWith, img.size.height)];
    [self.view addSubview:_view2];
    _view2.backgroundColor=[UIColor whiteColor];
    [_view2 addSubview:imageView];
    
    _view2.tag=1002;
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+0.09*WindowWith, 15, 100, 20) textColor:cBlackColor textFont:sysFont(20)];
    lbl.text=@"我要招聘";
    [_view2 addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, 10+lbl.bottom, 150, 13) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text=@"为您提供高级人才信息";
    [_view2 addSubview:lbl];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnTap:)];
    [_view2 addGestureRecognizer:tap2];
    
}

-(void)BtnTap:(UITapGestureRecognizer *)tap
{
    
    [[NSUserDefaults standardUserDefaults] setInteger:tap.view.tag forKey:kJobIdentKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ( [[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1002)
    {
        
        [network updateRecruitUserIdentity:[USERMODEL.userID intValue]identity_flag:2 success:^(NSDictionary *obj) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserIdentity object:nil];
            
            
            if (self.type==ENT_Invite) {
                MyJobViewController *vc=[[MyJobViewController alloc]init];
                vc.text=@"我的招聘";
                vc.arr=@[@"接收简历",@"发布职位"];
                vc.type=ENT_Invite;
                [self pushViewController:vc];
                
            }else if (self.type == ENT_Seek){
                ZhaoPingViewController *vc = [[ZhaoPingViewController alloc] init];
                [self pushViewController:vc];
                
            }else{
                
                [self popViewController:1];
            }
            
            return;
            
        }];
    }else if ([[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1001){
        [network updateRecruitUserIdentity:[USERMODEL.userID intValue]identity_flag:1 success:^(NSDictionary *obj) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserIdentity object:nil];
            
            
            if (self.type==ENT_Invite) {
                PositionListViewController *zhaoping=[[PositionListViewController alloc]init];
                zhaoping.type=ENT_Seek;
                zhaoping.Mytype=ENT_Position;
                [self pushViewController:zhaoping];
            }else if (self.type == ENT_Seek){
                GiuZhiViewController *vc = [[GiuZhiViewController alloc] init];
                [self pushViewController:vc];
                
            }else{
                [self popViewController:1];
            }
            
        }];
        
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
