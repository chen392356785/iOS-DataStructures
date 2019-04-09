//
//  DFFlowerDetailViewController.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFConstant.h"
#import "DFCustomShareView.h"
#import "DFFlowerDetailViewController.h"
#import "DFDiscernDetailView.h"
#import "DFDiscernFlowerModel.h"
#import "MTLoginViewController.h"
#import "DFIdentifierConstant.h"
#import "THModalNavigationController.h"

@interface DFFlowerDetailViewController ()<UIWebViewDelegate, DFShareViewDelegate>

@property (nonatomic, strong) DFDiscernDetailView *detailView;
@property (nonatomic, strong) DFShareView *shareView;
@property (nonatomic, strong) DFCustomShareView *customShareView;

@end

@implementation DFFlowerDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
}

- (DFDiscernDetailView *)detailView {
    
    return (DFDiscernDetailView *)self.view;
    
}

#pragma mark - 配置页面
- (void)configureView {
    
    DFDiscernDetailView *detailView = [[DFDiscernDetailView alloc]init];
    self.view = detailView;
    
    DFNavigationView *navigationView = detailView.navigationView;
    navigationView.titleLabel.text = DFFlowerDetailString();
    [navigationView.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView.forwardButton addTarget:self action:@selector(skipCameraAction) forControlEvents:UIControlEventTouchUpInside];
    
    detailView.webView.opaque = NO;
    [detailView.webView setScalesPageToFit:NO];
    detailView.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    detailView.webView.delegate = self;
    NSURL *requestUrl = [NSURL URLWithString:self.flowerModel.HtmlUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [detailView.webView loadRequest:request];
    detailView.webView.hidden = YES;
    
    [detailView.confirmButton addTarget:self action:@selector(confirmFlower) forControlEvents:UIControlEventTouchUpInside];
    [detailView.shareButton addTarget:self action:@selector(shareFlowerDetail) forControlEvents:UIControlEventTouchUpInside];
    detailView.toolView.hidden = YES;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [DFTool addWaitingView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [DFTool removeWaitingView:self.view];
    self.detailView.toolView.hidden = NO;
    self.detailView.webView.hidden = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [DFTool removeWaitingView:self.view];
}

#pragma mark - 是此花
- (void)confirmFlower {
    if (!USERMODEL.isLogin) {
        //登录
        MTLoginViewController *vc=[[MTLoginViewController alloc]init];
        THModalNavigationController *nav=[[THModalNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }else
    [DFTool addWaitingView:self.view];
    [HttpRequest postConfirmFlowerWith:self.flowerModel.Id success:^(NSDictionary *result) {
        [DFTool removeWaitingView:self.view];
        
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            [DFTool showTips:result[DFErrMsg]];
        }
    } failure:^(NSError *error) {
        [DFTool removeWaitingView:self.view];
    }];
}

#pragma mark - 分享识花结果
- (void)shareFlowerDetail {
    if (self.flowerModel.HtmlUrl) {
        if (!self.customShareView) {
            self.customShareView = [[DFCustomShareView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            self.customShareView.shareView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:self.customShareView];
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.customShareView.hidden = NO;
            self.customShareView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        }];
    }
}

#pragma mark --分享点击处理--
- (void)shareViewTypeWith:(NSInteger)index {
    [UIView animateWithDuration:0.3 animations:^{
        self.customShareView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    }completion:^(BOOL finished) {
        self.customShareView.hidden = YES;
    }];
    NSString *title = self.flowerModel.ShareTitle;
    NSString *content = self.flowerModel.ShareTitleSub;
    NSString *urlImage = self.flowerModel.ShareImgUrl;
    NSString *contentUrl = self.flowerModel.HtmlUrl;
    
    [IHUtility SharePingTai:title url:contentUrl imgUrl:urlImage content:content PlatformType:index controller:self completion:nil];
//    NSString *shareType = TTSelectShareType(index - 1);
//    [DFTool shareWXWithTitle:title andContent:content andContentURL:contentUrl andUrlImage:urlImage andPresentedController:self withType:@[shareType] result:^(UMSocialResponseEntity *shareResponse) {
//        [self.customShareView hideCustomShareView];
//    }];
    
}

#pragma mark - 返回
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 跳转相机
- (void)skipCameraAction {
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
