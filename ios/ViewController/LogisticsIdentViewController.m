//
//  LogisticsIdentViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/24.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "LogisticsIdentViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "LogisticsFindCarListViewController.h"
#import "LogisticsFindGoodsListViewController.h"
@interface LogisticsIdentViewController ()
{
    UIButton *_btn2;
    UIButton *_btn1;
    UIImageView *_imageView;
    UIView *_view1;
    UIView *_view2;
    
}
@end

@implementation LogisticsIdentViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //    UIColor *color=RGBA(255, 255, 255, 0.8);
    //    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"身份选择"];
    self.view.backgroundColor=RGB(232, 240, 240);
    
    UIImage *img=Image(@"ident.png");
    _imageView=[[UIImageView alloc]init];
    _imageView.image=img;
    
    _view1=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 0.93*WindowWith, 0.4*WindowWith)];
    _view1.centerX=self.view.centerX;
    _view1.backgroundColor=[UIColor whiteColor];
    _view1.layer.cornerRadius=10;
    _view1.tag=1001;
    [self.view addSubview:_view1];
    [_view1 setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cGreenColor];
    _imageView.frame=CGRectMake(_view1.right-img.size.width+5, _view1.top-5, img.size.width, img.size.height);
    [self.view addSubview:_imageView];
    
    img=Image(@"zhaoche.png");
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0.2*_view1.height, 0.371*_view1.width, 0.8*_view1.height)];
    imageView.image=img;
    [_view1 addSubview:imageView];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+50, 0.43*_view1.height, 68, 16) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"我要找车";
    
    [_view1 addSubview:lbl];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnTap:)];
    [_view1 addGestureRecognizer:tap];
    
    _view2=[[UIView alloc]initWithFrame:CGRectMake(0, _view1.bottom+15, 0.93*WindowWith, 0.4*WindowWith)];
    _view2.centerX=self.view.centerX;
    _view2.backgroundColor=[UIColor whiteColor];
    _view2.layer.cornerRadius=10;
    [self.view addSubview:_view2];
    _view2.tag=1002;
    
    img=Image(@"zhaohuo.png");
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0.2*_view2.height, 0.371*_view2.width, 0.8*_view2.height)];
    imageView.image=img;
    [_view2 addSubview:imageView];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+50, 0.43*_view2.height, 68, 16) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"我要找货";
    [_view2 setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cGrayLightColor];
    [_view2 addSubview:lbl];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnTap:)];
    [_view2 addGestureRecognizer:tap2];
    if ( [[NSUserDefaults standardUserDefaults] integerForKey:kIdentKey]==1002) {
        img=Image(@"ident.png");
        _imageView.origin=CGPointMake(_view2.right-img.size.width+5, _view2.top-5);
        [self.view bringSubviewToFront:_imageView];
        [_view2 setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cGreenColor];
        [_view1 setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cGrayLightColor];
    }
}

-(void)BtnTap:(UITapGestureRecognizer *)tap
{
    UIImage *img=Image(@"ident.png");
    [_view1 setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cGrayLightColor];
    [_view2 setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cGrayLightColor];
    [tap.view setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cGreenColor];
    _imageView.origin=CGPointMake(tap.view.right-img.size.width+5, tap.view.top-5);
    [self.view bringSubviewToFront:_imageView];
    [[NSUserDefaults standardUserDefaults] setInteger:tap.view.tag forKey:kIdentKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ( [[NSUserDefaults standardUserDefaults] integerForKey:kIdentKey]==1002)
    {
        LogisticsFindGoodsListViewController *vc=[[LogisticsFindGoodsListViewController alloc]init];
        [self pushViewController:vc];
        return;
    }else if ([[NSUserDefaults standardUserDefaults] integerForKey:kIdentKey]==1001){
        LogisticsFindCarListViewController *vc=[[LogisticsFindCarListViewController alloc]init];
        [self pushViewController:vc];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
