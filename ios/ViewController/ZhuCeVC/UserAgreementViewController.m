//
//  UserAgreementViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/5.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "UserAgreementViewController.h"

@interface UserAgreementViewController ()

@end

@implementation UserAgreementViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //  self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //  self.navigationController.navigationBar.hidden=NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"注册协议"];
    self.view.backgroundColor=RGBA(220,232,238,1);
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 20, 200, 29) textColor:cBlackColor textFont:sysFont(18)];
    lbl.text=[NSString stringWithFormat:@"%@用户协议",KAppName];
    lbl.centerX=self.view.centerX;
    lbl.textAlignment=NSTextAlignmentCenter;
    // [self.view addSubview:lbl];
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(20, 30, WindowWith-40, WindowHeight-lbl.bottom-35)];
    textView.textColor=cBlackColor;
    textView.font=sysFont(14);
    textView.backgroundColor=[UIColor clearColor];
    
#ifdef APP_MiaoTu
    NSString *textFileContents=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"用户协议" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
#elif defined APP_YiLiang
    NSString *textFileContents=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"宜良用户协议" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
#endif
    textView.text=textFileContents;
    [textView resignFirstResponder];
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
