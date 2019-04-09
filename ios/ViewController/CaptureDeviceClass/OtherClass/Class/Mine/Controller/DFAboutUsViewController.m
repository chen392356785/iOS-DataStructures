//
//  DFAboutUsViewController.m
//  DF
//
//  Created by Tata on 2017/12/6.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFIdentifierConstant.h"
#import "DFAboutUsViewController.h"

@interface DFAboutUsViewController ()<UIWebViewDelegate, TFShowEmptyViewDelegate>
/**底部*/
@property (strong, nonatomic)  UIWebView *mWebView;
@end

@implementation DFAboutUsViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavi];
    
    [self setUpWebView];
    
}

#pragma mark - 创建导航栏
- (void)setUpNavi {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, DFStatusHeight, 40, 40);
    [backButton setImage:kImage(BackArrowGreen) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((iPhoneWidth - 200)/2, DFStatusHeight, 200, 40)];
    titleLabel.text = DFAboutUsString();
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:PingFangLightFont() size:18 * TTUIScale()];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, DFNavigationBar - 0.5, iPhoneWidth, 0.5)];
    lineView.backgroundColor = THLineColor;
    [self.view addSubview:lineView];
}

#pragma mark - 创建webview
- (void)setUpWebView {
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, DFNavigationBar, iPhoneWidth, iPhoneHeight - DFNavigationBar - DFXHomeHeight)];
    self.mWebView = webView;
    webView.delegate = self;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:self.GameDetailsUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

#pragma mark - 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView {
    [DFTool addWaitingView:self.view];
}

#pragma mark - 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [DFTool removeWaitingView:self.view];
}

#pragma mark - 加载出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [DFTool removeWaitingView:self.view];
    
    if ([error code] == NSURLErrorCancelled) {
        return;
    }
    else if (error.code == NSURLErrorCannotConnectToHost||error.code == NSURLErrorNotConnectedToInternet) {
        
        self.emptyDataView.delegate = self;
        [self.view addSubview:self.emptyDataView];
        
    }
    else if(error.code == 3840) {    //服务器返回格式问题
        self.emptyTimeOutDataView.delegate = self;
        [self.view addSubview:self.emptyTimeOutDataView];
    }
    else if(error.code == NSURLErrorTimedOut)
    {
        self.emptyTimeOutDataView.delegate = self;
        [self.view addSubview:self.emptyTimeOutDataView];
    }
}

#pragma mark --点击重试处理(TFShowEmptyViewDelegate)--
- (void)showEmptyViewFinished {
    if (self.emptyDataView) {
        [self.emptyDataView removeFromSuperview];
    }
    if (self.emptyTimeOutDataView) {
        [self.emptyTimeOutDataView removeFromSuperview];
    }
    NSString *webUrl = self.GameDetailsUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
    self.mWebView.scalesPageToFit = NO;
    [self.mWebView loadRequest:request];
}

#pragma mark - 返回
- (void)backAction {
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
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
