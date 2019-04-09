//
//  MTShoppingViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/12/23.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTShoppingViewController.h"
#import "CacheUserInfo.h"
#import "UnsuggestMethod.h"

#import <YZBase/YZBase.h>

/**商城地址*/
static NSString *StaticUrl = @"https://wap.koudaitong.com/v2/feature/utpo8pn1";

@interface MTShoppingViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation MTShoppingViewController

- (void)dealloc {
    //Demo中 退出当前controller就清除用户登录信息
    [YZSDK logout];
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"商场"];
    
    //实例化webview
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];

    [self loginAndloadUrl:StaticUrl];
    
    _webView.scalesPageToFit = YES;
    _webView.delegate=self;
    
    [self.view addSubview: _webView];
}

//#pragma mark - YouzanSDK Method
///**
// *  通知有赞网页 开始初始化环境
// */
//- (void)initYouzanSDK {
//    
//    [_webView stringByEvaluatingJavaScriptFromString:[[YZSDK sharedInstance] jsBridgeWhenWebDidLoad]];
//}
//
///**
// *  触发分享功能
// */
//- (void)shareButtonItemAction {
//    NSString *jsonString = [[YZSDK sharedInstance] jsBridgeWhenShareBtnClick];
//    [_webView stringByEvaluatingJavaScriptFromString:jsonString];
//}
//
///**
// *  解析分享数据
// *
// *  @param data
// */
//- (void)parseShareData:(NSURL *)data {
//    
//    NSDictionary * shareDic = [[YZSDK sharedInstance] shareDataInfo:data];
//    NSString *message = [NSString stringWithFormat:@"%@\r%@" , shareDic[@"title"],shareDic[@"link"]];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据已经复制到黏贴版" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//    [alertView show];
//    //复制到粘贴板
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = message;
//}

- (void)loginAndloadUrl:(NSString*)urlString {
    
    CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
    cacheModel.isLogined = USERMODEL.isLogin;
    
    if(cacheModel.isLogined) {
        
        [UnsuggestMethod loginWithOpenUid:cacheModel.userId completionBlock:^(NSDictionary *resultInfo) {
            if (resultInfo) {
                //用户登陆成功
                [YZSDK setToken:resultInfo[@"data"][@"access_token"] key:resultInfo[@"data"][@"cookie_key"] value:resultInfo[@"data"][@"cookie_value"]];
                cacheModel.isLogined = YES;
                [self loadWithString:urlString];

            } else {
            
                cacheModel.isLogined = NO;
                [self prsentToLoginViewController];
                return ;

            }
        }];

//        YZUserModel *userModel = [CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel];
//        //同步买家信息
//        [YZSDK registerYZUser:userModel callBack:^(NSString *message, BOOL isError) {
//            // HWLog(@"---%@",message);
//            if(isError) {
//                
//                cacheModel.isLogined = NO;
//                [self prsentToLoginViewController];
//                return ;
//                
//            } else {
//                
//                cacheModel.isLogined = YES;
//                
//                NSURL *url = [NSURL URLWithString:urlString];
//                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//                [_webView loadRequest:urlRequest];
//            }
//        }];
        
    } else {
        
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
        [self loadWithString:urlString];
    }
}
- (void)loadWithString:(NSString *)urlStr {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [YZSDK initYouzanWithUIWebView:webView];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = [request URL];
    YZNotice *noticeFromYZ = [YZSDK noticeFromYouzanWithUrl:url];
    if(noticeFromYZ.notice & YouzanNoticeLogin) {//登录
        
        [self loginAndloadUrl:StaticUrl];

//          [self presentNativeLoginViewWithBlock:^(BOOL success){
//            if (success) {
//                [webView reload];
//            } else {
//                if ([webView canGoBack]) {
//                    [webView goBack];
//                }
//            };
//        }];
        return NO;
    } else if(noticeFromYZ.notice & YouzanNoticeShare) {//分享
        [self alertShareData:noticeFromYZ.response];
        return NO;
    } else if(noticeFromYZ.notice & YouzanNoticeReady) {//有赞环境初始化成功，分享按钮可用
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return NO;
    } else if (noticeFromYZ.notice & IsYouzanNotice) {
        return NO;
    }
    
    //加载新链接时，分享按钮先置为不可用，直到有赞环境初始化成功方可使用
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    return YES;
}

/**
 *  显示分享数据
 *
 *  @param data
 */
- (void)alertShareData:(id)data {
    
    NSDictionary *shareDic = (NSDictionary *)data;
    NSString *message = [NSString stringWithFormat:@"%@\r%@" , shareDic[@"title"],shareDic[@"link"]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据已经复制到黏贴版" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
    //复制到粘贴板
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = message;
}



////重新定制webview的布局
//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    
//    [_webView.scrollView setContentInset:UIEdgeInsetsZero];
//}
//
////开始加载
//-(void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [self addPushViewWaitingView];
//}
//
////加载完毕
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [self initYouzanSDK];
//    [self removePushViewWaitingView];
//}
//
//-(void)back:(id)sender{
//    if ([_webView canGoBack]) {
//        [_webView goBack];
//    }else
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
