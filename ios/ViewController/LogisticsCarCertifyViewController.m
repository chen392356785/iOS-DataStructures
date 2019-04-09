//
//  LogisticsCarCertifyViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/31.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "LogisticsCarCertifyViewController.h"

@interface LogisticsCarCertifyViewController ()
{
    IHTextField *_carIdTextField;
    IHTextField *_capacityTextField;
    IHTextField *_carWithTextField;
    IHTextField *_nameTextFeild;
}
@end

@implementation LogisticsCarCertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"车辆认证"];
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 27)];
    view.backgroundColor=RGB(232, 240, 240);
    [self.view addSubview:view];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, 132, 27) textColor:cBlackColor textFont:sysFont(12)];
    lbl.text=@"资质认证可以提升信任度";
    lbl.center=view.center;
    [view addSubview:lbl];
    UIImage *img=Image(@"fb_uploadimg.png");
    UIImage *photoimg=Image(@"redstar.png");
    NSArray *arr=@[@"真实头像",@"身份证正面",@"行驶证照",@"车辆照片"];
    
    for (NSInteger i=0; i<4; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(0.11*WindowWith+i*0.296*WindowWith, 40+27, 0.181*WindowWith, 0.18*WindowWith);
        if (i==3) {
            btn.frame=CGRectMake(0.11*WindowWith, 180+27, 0.181*WindowWith, 0.18*WindowWith);
        }
        
        btn.tag=i+1000;
        [btn setBackgroundImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        
        UIButton *Btn=[UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame=CGRectMake(0, btn.bottom+25, btn.width+20, 15);
        [Btn setImage:[photoimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        Btn.tag=2000+i;
        [Btn setTitle:arr[i] forState:UIControlStateNormal];
        Btn.titleLabel.font=sysFont(15);
        [Btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        Btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        Btn.centerX=btn.centerX;
        [_BaseScrollView addSubview:Btn];
        [_BaseScrollView addSubview:btn];
    }
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 340, WindowWith, 5)];
    lineView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView];
    
    UIImage *toImg=Image(@"GQ_Left.png");
    
    //车牌号
    UIImageView *varietyImgView=[[UIImageView alloc]initWithImage:photoimg];
    varietyImgView.frame=CGRectMake(20, lineView.bottom+25, photoimg.size.width, photoimg.size.height);
    [_BaseScrollView addSubview:varietyImgView];
    
    SMLabel *varietyLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(varietyImgView.right+15, varietyImgView.top-5, 45, 20) textColor:cBlackColor textFont:sysFont(15)];
    varietyLbl.text=@"车牌号";
    [_BaseScrollView addSubview:varietyLbl];
    
    UIView *varietyView=[[UIView alloc]initWithFrame:CGRectMake(varietyImgView.left, varietyLbl.bottom+15, WindowWith-varietyImgView.left*2, 1)];
    varietyView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:varietyView];
    
    UIImageView *varietyToImageView=[[UIImageView alloc]initWithImage:toImg];
    varietyToImageView.frame=CGRectMake(varietyView.right, varietyLbl.top+5, toImg.size.width, toImg.size.height);
    [_BaseScrollView addSubview:varietyToImageView];
    
    _carIdTextField=[[IHTextField alloc]initWithFrame:CGRectMake(varietyLbl.right+20, varietyLbl.top,varietyToImageView.left-varietyLbl.right-30, 25)];
    _carIdTextField.borderStyle=UITextBorderStyleNone;
    _carIdTextField.textAlignment=NSTextAlignmentRight;
    _carIdTextField.delegate=self;
    
    _carIdTextField.placeholder=@"湘A.BK132";
    
    [_BaseScrollView addSubview:_carIdTextField];
    
    //公司
    MapAnnotationView *carTypeView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(0, varietyView.bottom+5, WindowWith, 48) name:@"车型" ifMust:YES];
    carTypeView.lbl.text=@"尚未填写";
    carTypeView.lbl.textColor=RGBA(232, 121, 117, 1);
//    NSString *carType;
    carTypeView.tag=1001;
//    __weak MapAnnotationView *weakcarTypeView=carTypeView;
    carTypeView.selectBlock=^(NSInteger index){
        NSLog(@"车型");
    };
    [_BaseScrollView addSubview:carTypeView];
    
    //载重
    UIImageView *capacityImgView=[[UIImageView alloc]initWithImage:photoimg];
    capacityImgView.frame=CGRectMake(20, carTypeView.bottom+20, photoimg.size.width, photoimg.size.height);
    [_BaseScrollView addSubview:capacityImgView];
    
    SMLabel *capacityLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(capacityImgView.right+15, capacityImgView.top-5, 45, 20) textColor:cBlackColor textFont:sysFont(15)];
    capacityLbl.text=@"载重";
    [_BaseScrollView addSubview:capacityLbl];
    
    UIView *capacityView=[[UIView alloc]initWithFrame:CGRectMake(capacityImgView.left, capacityLbl.bottom+15, WindowWith-capacityImgView.left*2, 1)];
    capacityView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:capacityView];
    
    UIImageView *capacityToImageView=[[UIImageView alloc]initWithImage:toImg];
    capacityToImageView.frame=CGRectMake(capacityView.right, capacityLbl.top+5, toImg.size.width, toImg.size.height);
    [_BaseScrollView addSubview:capacityToImageView];
    
    _capacityTextField=[[IHTextField alloc]initWithFrame:CGRectMake(capacityLbl.right+20, capacityLbl.top,varietyToImageView.left-capacityLbl.right-30, 25)];
    _capacityTextField.borderStyle=UITextBorderStyleNone;
    _capacityTextField.textAlignment=NSTextAlignmentRight;
    _capacityTextField.delegate=self;
    _capacityTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _capacityTextField.placeholder=@"5.0T";
    
    [_BaseScrollView addSubview:_capacityTextField];
    
    //车长
    UIImageView *carwithImgView=[[UIImageView alloc]initWithImage:photoimg];
    carwithImgView.frame=CGRectMake(20, capacityView.bottom+20, photoimg.size.width, photoimg.size.height);
    [_BaseScrollView addSubview:carwithImgView];
    
    SMLabel *carwithLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(carwithImgView.right+15, carwithImgView.top-5, 45, 20) textColor:cBlackColor textFont:sysFont(15)];
    carwithLbl.text=@"车长";
    [_BaseScrollView addSubview:carwithLbl];
    
    UIView *carwithView=[[UIView alloc]initWithFrame:CGRectMake(carwithImgView.left, carwithLbl.bottom+15, WindowWith-carwithImgView.left*2, 1)];
    carwithView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:carwithView];
    
    UIImageView *carwithToImageView=[[UIImageView alloc]initWithImage:toImg];
    carwithToImageView.frame=CGRectMake(carwithView.right, carwithLbl.top+5, toImg.size.width, toImg.size.height);
    [_BaseScrollView addSubview:carwithToImageView];
    
    _carWithTextField=[[IHTextField alloc]initWithFrame:CGRectMake(carwithLbl.right+20, carwithLbl.top,varietyToImageView.left-carwithLbl.right-30, 25)];
    _carWithTextField.borderStyle=UITextBorderStyleNone;
    _carWithTextField.textAlignment=NSTextAlignmentRight;
    _carWithTextField.delegate=self;
    _carWithTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _carWithTextField.placeholder=@"8.3米";
    
    [_BaseScrollView addSubview:_carWithTextField];
    
    //真实姓名
    UIImageView *nameImgView=[[UIImageView alloc]initWithImage:photoimg];
    nameImgView.frame=CGRectMake(20, carwithView.bottom+20, photoimg.size.width, photoimg.size.height);
    [_BaseScrollView addSubview:nameImgView];
    
    SMLabel *nameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(nameImgView.right+15, nameImgView.top-5, 60, 20) textColor:cBlackColor textFont:sysFont(15)];
    nameLbl.text=@"真实姓名";
    [_BaseScrollView addSubview:nameLbl];
    
    UIView *nameView=[[UIView alloc]initWithFrame:CGRectMake(nameImgView.left, nameLbl.bottom+15, WindowWith-nameImgView.left*2, 1)];
    nameView.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:nameView];
    
    UIImageView *nameToImageView=[[UIImageView alloc]initWithImage:toImg];
    nameToImageView.frame=CGRectMake(nameView.right, nameLbl.top+5, toImg.size.width, toImg.size.height);
    [_BaseScrollView addSubview:nameToImageView];
    
    _nameTextFeild=[[IHTextField alloc]initWithFrame:CGRectMake(nameLbl.right+20, nameLbl.top,varietyToImageView.left-nameLbl.right-30, 25)];
    _nameTextFeild.borderStyle=UITextBorderStyleNone;
    _nameTextFeild.textAlignment=NSTextAlignmentRight;
    _nameTextFeild.delegate=self;
    //_nameTextFeild.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _nameTextFeild.placeholder=@"裴小军";
    
    [_BaseScrollView addSubview:_nameTextFeild];
    
    //公司
    MapAnnotationView *introdutionView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(0, nameView.bottom+5, WindowWith, 48) name:@"业务介绍" ifMust:NO];
    introdutionView.lbl.text=@"尚未填写";
    introdutionView.lbl.textColor=RGBA(232, 121, 117, 1);
    introdutionView.tag=1005;
//    __weak MapAnnotationView *weakintrodutionView=introdutionView;
    introdutionView.selectBlock=^(NSInteger index){
        NSLog(@"车型");
    };
    [_BaseScrollView addSubview:introdutionView];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, introdutionView.bottom-1, WindowWith, 200)];
    lineView2.backgroundColor=cLineColor;
    [_BaseScrollView addSubview:lineView2];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0, 20, WindowWith-80, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTintColor:[UIColor whiteColor]];
//    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
	
    btn.tag=20;
    [btn setTitle:@"提   交" forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(18.8);
    [lineView2 addSubview:btn];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=21;
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, 800);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
