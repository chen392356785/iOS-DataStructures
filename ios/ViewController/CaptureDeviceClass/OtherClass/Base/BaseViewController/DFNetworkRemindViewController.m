//
//  DFNetworkRemindViewController.m
//  DF
//
//  Created by Tata on 2017/12/5.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFNetworkRemindViewController.h"

@interface DFNetworkRemindViewController ()

@end

@implementation DFNetworkRemindViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self hideRemindView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    [self createCustomUI];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self setupNetCheck];
}

#pragma mark --设置导航栏--
- (void)setUpNav {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, KStatusBarHeight, 40, 40);
    [backButton setImage:kImage(@"back_green") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((iPhoneWidth - 200)/2, KStatusBarHeight, 200, 40)];
    titleLabel.text = @"无网络连接";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:18 * TTUIScale()];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, KNavBarHeight - 0.5, iPhoneWidth, 0.5)];
    lineView.backgroundColor = THLineColor;
    [self.view addSubview:lineView];
    
}

#pragma mark --创建UI--
- (void)createCustomUI {
    
    self.view.backgroundColor = THGlobalBg;
    //顶部背景View
    UIView *topBgView = [[UIView alloc] init];
    topBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topBgView];
    
    //设置
    UILabel *settingLab = [[UILabel alloc] init];
    settingLab.textColor = THTitleColor1;
    settingLab.font = kLightFont(15);
    settingLab.text = @"请设置你的网络";
    [topBgView addSubview:settingLab];
    //约束
    [settingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(topBgView.mas_left).offset(20);
        make.top.equalTo(topBgView.mas_top).offset(20);
    }];
    //描述
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.font = kLightFont(13);
    detailLab.textColor = THTextColor;
    detailLab.numberOfLines = 0;
    detailLab.text = @"1.打开设备的\"系统设置\" > \"无线和网络\" > \"移动网络\"。";
    detailLab.lineBreakMode = NSLineBreakByWordWrapping;
    [topBgView addSubview:detailLab];
    //约束
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(settingLab.mas_left);
        make.top.equalTo(settingLab.mas_bottom).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    //设置描述
    UILabel *settingDetail = [[UILabel alloc] init];
    settingDetail.font = kLightFont(13);
    settingDetail.textColor = THTextColor;
    settingDetail.numberOfLines = 0;
    settingDetail.text = @"2.打开设备的\"系统设置\" > \"WLAN\",\"启动WLAN\"后从中选择一个可用的热点连接。";
    settingDetail.lineBreakMode = NSLineBreakByWordWrapping;
    [topBgView addSubview:settingDetail];
    //约束
    [settingDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(settingLab.mas_left);
        make.top.equalTo(detailLab.mas_bottom).offset(15);
        make.right.equalTo(detailLab.mas_right);
    }];
    //设置背景
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.bottom.equalTo(settingDetail.mas_bottom).offset(20);
    }];
    
    //底部背景
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    //约束
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(topBgView.mas_bottom).offset(20);
        make.right.equalTo(topBgView.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //提示
    UILabel *remindLab = [[UILabel alloc] init];
    remindLab.textColor = THTitleColor1;
    remindLab.font = kLightFont(15);
    remindLab.text = @"如果你已经连接Wi-Fi网络";
    [bottomView addSubview:remindLab];
    [remindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(bottomView.mas_top).offset(20);
        make.right.equalTo(bottomView.mas_right).offset(-20);
    }];
    //详情
    UILabel *remindDetailLab = [[UILabel alloc] init];
    remindDetailLab.textColor = THTextColor;
    remindDetailLab.font = kLightFont(13);
    remindDetailLab.text = @"请确认你所接入的Wi-Fi网络已经连入互联网,或者确认你的设备是否被允许访问该热点。";
    remindDetailLab.numberOfLines = 0;
    remindDetailLab.lineBreakMode = NSLineBreakByWordWrapping;
    [bottomView addSubview:remindDetailLab];
    
    [remindDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(remindLab.mas_left);
        make.right.equalTo(remindLab.mas_right);
        make.top.equalTo(remindLab.mas_bottom).offset(20);
        
    }];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
