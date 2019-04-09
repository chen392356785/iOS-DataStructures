//
//  ActivRegistrationViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivRegistrationViewController.h"
#import "ACtivityTopView.h"
//#import "ActvRegInfoView.h"
//#import "ActivPaymentViewController.h"

@interface ActivRegistrationViewController ()
{
//    ActvRegInfoView *_infoView;
}
@end

@implementation ActivRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"立即报名";
    _BaseScrollView.backgroundColor = RGB(228, 235, 235);
    
    ACtivityTopView *activityTopView = [[ACtivityTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220*(kScreenWidth/375)+70)];
    [activityTopView setImageURl:self.model.activities_pic signNum:self.model.user_upper_limit_num title:self.model.activities_titile skimNum:@"231" uint_price:self.model.payment_amount];
    [_BaseScrollView addSubview:activityTopView];
    
    CGFloat bottom = kBottomSapce;
    UIButton *referBtu = [[UIButton alloc] initWithFrame:CGRectMake(18, SCREEN_HEIGHT-40-bottom-64, SCREEN_WIDTH - 36, 40)];
    referBtu.backgroundColor = RGB(72, 192, 186);
    [referBtu setTitle:@"提交" forState:UIControlStateNormal];
    [referBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [referBtu addTarget:self action:@selector(referInfor:) forControlEvents:UIControlEventTouchUpInside];
    referBtu.layer.cornerRadius= 20.0;
    referBtu.layer.masksToBounds = YES;
    [_BaseScrollView addSubview:referBtu];
    
    _BaseScrollView.contentSize = CGSizeMake(kScreenWidth, referBtu.bottom + 85);
}

//-(void)addNum:(UIButton *)addBut
//{
//
//
//}
//- (void)reduceNum:(UIButton *)reduceBut
//{
//
//}
- (void)referInfor:(UIButton *)referBtu
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}

@end
