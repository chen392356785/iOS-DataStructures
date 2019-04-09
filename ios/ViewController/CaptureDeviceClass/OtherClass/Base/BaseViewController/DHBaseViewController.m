//
//  DHBaseViewController.m
//  DF
//
//  Created by Tata on 2017/11/20.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DHBaseViewController.h"
#import "DFNetworkRemindViewController.h"
#import "DFNavigationController.h"

@interface DHBaseViewController ()
/**无网络指引*/
@property (nonatomic,strong)TFRemindView *remindView;
@end

@implementation DHBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (TFShowEmptyView *)emptyDataView {
    
    if (!_emptyDataView) {
        
        TFShowEmptyView *emptyDataView = [TFShowEmptyView showEmptyView];
        emptyDataView.emptyStyle = TFShowEmptyStyleFaileData;
        self.emptyDataView = emptyDataView;
        CGFloat emptyOrderViewX = 0;
        CGFloat emptyOrderViewY = DFNavigationBar;
        CGFloat emptyOrderViewW = iPhoneWidth;
        CGFloat emptyOrderViewH = iPhoneHeight - DFNavigationBar - DFXHomeHeight;
        emptyDataView.frame = CGRectMake(emptyOrderViewX, emptyOrderViewY, emptyOrderViewW, emptyOrderViewH);
    }
    return _emptyDataView;
}
- (TFShowEmptyView *)emptyTimeOutDataView {
    
    if (!_emptyTimeOutDataView) {
        
        TFShowEmptyView *emptyTimeOutDataView = [TFShowEmptyView showEmptyView];
        emptyTimeOutDataView.emptyStyle = TFShowEmptyStyleNetTimeOut;
        self.emptyTimeOutDataView = emptyTimeOutDataView;
        CGFloat emptyOrderViewX = 0;
        CGFloat emptyOrderViewY = DFNavigationBar;
        CGFloat emptyOrderViewW = iPhoneWidth;
        CGFloat emptyOrderViewH = iPhoneHeight - DFNavigationBar - DFXHomeHeight;
        emptyTimeOutDataView.frame = CGRectMake(emptyOrderViewX, emptyOrderViewY, emptyOrderViewW, emptyOrderViewH);
    }
    return _emptyTimeOutDataView;
}


- (TFRemindView *)remindView {
    
    if (!_remindView) {
        
        TFRemindView *remindView = [[TFRemindView alloc] initWithFrame:CGRectMake(0, DFNavigationBar, iPhoneWidth, 50)];
        self.remindView = remindView;
        remindView.remndStyle = TFRemindStyleNote;
        remindView.message = @"网络请求失败,请检查您的网络设置";
        [remindView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remindViewTap:)]];
    }
    return _remindView;
}


#pragma mark --创建网络监测--
- (void)setupNetCheck
{

	
}

#pragma mark --添加无网络指引--
//- (void)createNetWorkChanged {
//
//    [self.remindView show];
//}
#pragma mark --删除无网络指引--
- (void)hideRemindView {
    [self.remindView hide];
}

#pragma mark--点击处理--
- (void)remindViewTap:(UITapGestureRecognizer *)gesture {
    
    DFNetworkRemindViewController *netRemindVC = [[DFNetworkRemindViewController alloc] init];
    DFNavigationController *navigationViewController = (DFNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [navigationViewController pushViewController:netRemindVC animated:YES];
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
