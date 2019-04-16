//
//  MiaoBiInfoViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/22.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "MiaoBiInfoViewController.h"
#import "ActivityListViewController.h"          //活动列表
#import "MyClassSourceController.h"             //我的课程
#import "ReleaseNewVarietyController.h"         //发布新品种
#import "NewSlideHeadingViewController.h"       //资讯
#import "MTPartnerViewController.h"             //申请加入合伙人

#import "PayTypeConstants.h"
#import "PayMentMangers.h"
#import "SuccessViewController.h"   //加入成功
#import "FaBuBuyViewController.h"   //发布求购


static NSString * const KfabuqiuqouPath   = @"fabuqiuqou";         // 去发布求购
static NSString * const KgoActivityPath   = @"baominghuodong";     // 活动列表报名
static NSString * const KgoumaikePath     = @"goumaimiaotubi";     // 去购买课程
static NSString * const KyaoqinghaoPath   = @"yaoqinghaoyou";      // 邀请好友
static NSString * const KmykechengPath    = @"wanchengkecheng";    // 我的课程
static NSString * const KfabuxinpingZPath = @"fabuxinpinzhong";    // 去发布新品种
static NSString * const KyueduzixunPath   = @"yueduzixun";         // 资讯列表阅读资讯
static NSString * const KapplyPartnerPath = @"applyPartner";       // 申请加入合伙人
static NSString * const KJoinVipPath      = @"join";               // 加入vip
static NSString * const KLianxiekefuPath  = @"contact";            // 联系客服
static NSString * const KJoinVipYearPath  = @"jiaruyinian";        // 购买vip 一年
static NSString * const KXvfeiVipYearPath = @"jiaruyinian";        // 续费vip 一年
static NSString * const KbackPath         = @"fanhui";             // 返回
// WKWebView 内存不释放的问题解决
@interface WeakWebViewScriptDelegate : NSObject<WKScriptMessageHandler>

//WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
@implementation WeakWebViewScriptDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
	self = [super init];
	if (self) {
		_scriptDelegate = scriptDelegate;
	}
	return self;
}

#pragma mark - WKScriptMessageHandler
//遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
	if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
		[self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
	}
}

@end



@interface MiaoBiInfoViewController () <WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate> {
	
//	BOOL APayShow;      //是否要显示支付
}
@property (nonatomic, strong) WKWebView * webView;
//网页加载进度视图
@property (nonatomic, strong) UIProgressView * progressView;

@property (nonatomic,copy)NSString *payType;        //付款方式

@end

@implementation MiaoBiInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (self.navBg != nil) {
		UIImage *bgImage = [[UIImage imageNamed:self.navBg] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
		[self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
		
		[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
		
		
		UIImage *backImg = Image(@"icon_fh_b");
		leftbutton.frame=CGRectMake(0, 0, 34, 40);
		[leftbutton setImage:backImg forState:UIControlStateNormal];
		leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
		
		UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:self.navBg]];
		[self.navigationController.navigationBar setBarTintColor:bgColor];
	}else if (self.navBgColor) {
		UIImage *bgImage1 = [UIImage imageWithColor:self.navBgColor size:CGSizeMake(iPhoneWidth, KtopHeitht)];
		UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
		[self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
		
		[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
		
		UIImage *backImg = Image(@"icon_fh_b");
		leftbutton.frame=CGRectMake(0, 0, 34, 40);
		[leftbutton setImage:backImg forState:UIControlStateNormal];
		leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
	}else if (self.navBarTranslucent) {
		UIImage *backImg=Image(@"icon_fh_b");
		leftbutton.frame=CGRectMake(0, 0, 34, 40);
		[leftbutton setImage:backImg forState:UIControlStateNormal];
		leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
		[self.navigationController setNavigationBarHidden:NO animated:NO];
		//设置导航栏透明
		[self.navigationController.navigationBar setTranslucent:true];
		[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	}
	//处理导航栏有条线的问题
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	if (self.navBarTranslucent) {
		[self.navigationController setNavigationBarHidden:NO animated:NO];
		//设置导航栏透明
		[self.navigationController.navigationBar setTranslucent:false];
	}
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
	[self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
	leftbutton.frame = CGRectMake(0, 0, 44, 44);
	[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}


- (void)back:(id)sender {
	if (self.webView)
	{
		if ([self.webView canGoBack])
		{
			[self.webView goBack];
		}
		else
		{
			if ([self.navigationController.viewControllers indexOfObject:self] == 0)
			{
				[self dismissViewControllerAnimated:YES completion:nil];
			}
			else
			{
				[self.navigationController popViewControllerAnimated:YES];
			}
		}
	}
}

- (WKWebView *)webView {
	if(_webView == nil){
		//创建网页配置对象
		WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
		
		// 创建设置对象
		WKPreferences *preference = [[WKPreferences alloc]init];
		//最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
		preference.minimumFontSize = 0;
		//设置是否支持javaScript 默认是支持的
		preference.javaScriptEnabled = YES;
		// 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
		preference.javaScriptCanOpenWindowsAutomatically = YES;
		config.preferences = preference;
		
		// 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
		config.allowsInlineMediaPlayback = YES;
		//设置视频是否需要用户手动播放  设置为NO则会允许自动播放
		config.requiresUserActionForMediaPlayback = YES;
		//设置是否允许画中画技术 在特定设备上有效
		config.allowsPictureInPictureMediaPlayback = YES;
		//设置请求的User-Agent信息中应用程序名称 iOS9后可用
		config.applicationNameForUserAgent = @"ChinaDailyForiPad";
		
		//自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
		//        WeakWebViewScriptDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptDelegate alloc] initWithDelegate:self];
		//这个类主要用来做native与JavaScript的交互管理
		WKUserContentController * wkUController = [[WKUserContentController alloc] init];
		//注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
		//        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcFunction"];
		
		config.userContentController = wkUController;
		//以下代码适配文本大小
		NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
		//用于进行JavaScript注入
		WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
		[config.userContentController addUserScript:wkUScript];
		if (self.navBarTranslucent) {
			_webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight) configuration:config];
		}else {
			_webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) configuration:config];
		}
		
		// UI代理
		_webView.UIDelegate = self;
		// 导航代理
		_webView.navigationDelegate = self;
		// 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
		_webView.allowsBackForwardNavigationGestures = YES;
		//可返回的页面列表, 存储已打开过的网页
		//        WKBackForwardList * backForwardList = [_webView backForwardList];
		
		if(@available(iOS 11.0, *)) {
			_webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
		}
		[(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
	}
	return _webView;
}

- (UIProgressView *)progressView
{
	if (!_progressView){
		_progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 1)];
		_progressView.tintColor = kColor(@"#7FFF00");
		_progressView.trackTintColor = [UIColor clearColor];
	}
	return _progressView;
}

- (void) addWKwebView {
	[self.view addSubview:self.webView];
	
	//添加监测网页加载进度的观察者
	[self.webView addObserver:self
				   forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
					  options:0
					  context:nil];
	[self.webView addObserver:self
				   forKeyPath:@"title"
					  options:NSKeyValueObservingOptionNew
					  context:nil];
}




-(void)viewDidLoad {
	[super viewDidLoad];
	if (self.type!=1) {
		[self setTitle:self.NameTitle];
	}else if (self.type==1){
		[self setTitle:@"链接"];
	}
	if (self.NameTitle) {
		[self setTitle:self.NameTitle andTitleColor:kColor(@"#FEFEFE")];
		titleLabel.font = darkFont(font(16));
	}
	self.view.backgroundColor = [UIColor whiteColor];
	[self addWKwebView];
	NSURLRequest *request =[NSURLRequest requestWithURL:self.mUrl];
	[_webView loadRequest:request];
	[self.view addSubview:self.progressView];
	
	UIActivityIndicatorView *avt=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-12, (self.view.frame.size.height/2)-12, 24, 24)];
	avt.tag = 8230;
	[avt setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[avt startAnimating];
	[self.view addSubview:avt];
	rightbutton.hidden = YES;
	
}

//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
					 ofObject:(id)object
					   change:(NSDictionary<NSKeyValueChangeKey,id> *)change
					  context:(void *)context{
	if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
		&& object == _webView) {
		NSLog(@"网页加载进度 = %f",_webView.estimatedProgress);
		self.progressView.progress = _webView.estimatedProgress;
		if (_webView.estimatedProgress >= 1.0f) {
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				self.progressView.progress = 0;
			});
		}
		
	}else if([keyPath isEqualToString:@"title"]
			 && object == _webView){
		if (!isFinish) {
			if (self.type==1) {
				[self setTitle:_webView.title];
			}
			isFinish=YES;
		}
		[self setTitle:_webView.title];
	}else{
		[super observeValueForKeyPath:keyPath
							 ofObject:object
							   change:change
							  context:context];
	}
}


//解决第一次进入的cookie丢失问题
//- (NSString *)readCurrentCookieWithDomain:(NSString *)domainStr {
//    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSMutableString * cookieString = [[NSMutableString alloc]init];
//    for (NSHTTPCookie*cookie in [cookieJar cookies]) {
//        [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
//    }
//
//    //删除最后一个“;”
//    if ([cookieString hasSuffix:@";"]) {
//        [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
//    }
//
//    return cookieString;
//}

//解决 页面内跳转（a标签等）还是取不到cookie的问题
- (void)getCookie{
	//取出cookie
	NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	//js函数
	NSString *JSFuncString =
	@"function setCookie(name,value,expires)\
	{\
	var oDate=new Date();\
	oDate.setDate(oDate.getDate()+expires);\
	document.cookie=name+'='+value+';expires='+oDate+';path=/'\
	}\
	function getCookie(name)\
	{\
	var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
	if(arr != null) return unescape(arr[2]); return null;\
	}\
	function delCookie(name)\
	{\
	var exp = new Date();\
	exp.setTime(exp.getTime() - 1);\
	var cval=getCookie(name);\
	if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
	}";
	
	//拼凑js字符串
	NSMutableString *JSCookieString = JSFuncString.mutableCopy;
	for (NSHTTPCookie *cookie in cookieStorage.cookies) {
		NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
		[JSCookieString appendString:excuteJSString];
	}
	//执行js
	[_webView evaluateJavaScript:JSCookieString completionHandler:nil];
	
}

//OC调用Js
//- (void)ocToJs {
//    //OC调用JS  changeColor()是JS方法名，completionHandler是异步回调block
//    NSString *jsString = [NSString stringWithFormat:@"changeColor('%@')", @"Js参数"];
//    [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
//        NSLog(@"改变HTML的背景色");
//    }];
//    //改变字体大小 调用原生JS方法
//    NSString *jsFont = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", arc4random()%99 + 100];
//    [_webView evaluateJavaScript:jsFont completionHandler:nil];
//
//}

//被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
	NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
	//用message.body获得JS传出的参数体
	//    NSDictionary * parameter = message.body;
	//JS调用OC
	if([message.name isEqualToString:@"jsToOcFunction"]){
		
	}else if([message.name isEqualToString:@"jsToOcWithPrams"]){
		
	}
	
}

#pragma mark -- WKNavigationDelegate
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
	
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
	[self.progressView setProgress:0.0f animated:NO];
	
	UIView* view = [self.view viewWithTag:8230];
	if (view!=nil) {
		[view removeFromSuperview];
	}
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
	
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
	UIView* view = [self.view viewWithTag:8230];
	if (view!=nil) {
		[view removeFromSuperview];
	}
	[self getCookie];
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
	[self.progressView setProgress:0.0f animated:NO];
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
	
}


// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
	
	NSString * urlStr = navigationAction.request.URL.absoluteString;
	NSLog(@"发送跳转请求：%@",urlStr);
	NSRange range = [urlStr rangeOfString:@"?"];
	NSDictionary *paramDic;
	if (range.location != NSNotFound) {
		paramDic = [IHUtility getURLParameters:urlStr];
		NSRange range = [urlStr rangeOfString:@"?"];
		urlStr = [urlStr substringToIndex:range.location];
	}
	
	//自己定义的协议头
	if ([urlStr.lastPathComponent isEqualToString:KfabuqiuqouPath]) {           //发布求购
		[self releaseCreateBuyOrSupply];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KgoActivityPath]) {     //活动列表报名
		[self pushActivity];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KgoumaikePath]) {       //去购买课程
		[self pushGoumaikecheng];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KyaoqinghaoPath]) {     //邀请好友
		[self pushYaoqinghaoyou];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KmykechengPath]) {      //我的课程
		[self MyClassSource];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KfabuxinpingZPath]) {    //去发布新品种
		[self releaseXinPinZ];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KyueduzixunPath]) {     //资讯列表阅读资讯
		[self pushZixunVc];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KapplyPartnerPath]) {   //申请加入合伙人
		[self pushPartner];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KJoinVipPath]) {        //加入会员
		[self BuyJoinVIP:paramDic];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KLianxiekefuPath]) {    //联系客服
		[self pushKefu];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KJoinVipYearPath]) {    //购买 VIP 一年
		NSDictionary *dict = @{
							   @"type" :@"year",
							   @"money":self.userInfo.vipPrice,
							   };
		[self BuyJoinVIP:dict];
		decisionHandler(WKNavigationActionPolicyCancel);
	}else if ([urlStr.lastPathComponent isEqualToString:KXvfeiVipYearPath]) {   //续费VIP 一年
		NSDictionary *dict = @{
							   @"type" :@"year",
							   @"money":self.userInfo.vipPrice,
							   };
		[self BuyJoinVIP:dict];
		decisionHandler(WKNavigationActionPolicyCancel);
	} else if ([urlStr.lastPathComponent containsString:@"tel:"]) { //联系客服拨打电话
		NSString *phone = [[urlStr.lastPathComponent componentsSeparatedByString:@":"] lastObject];
		NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
		decisionHandler(WKNavigationActionPolicyCancel);
	} else if ([urlStr.lastPathComponent isEqualToString:KbackPath]) {           //返回
		[self backAction];
		decisionHandler(WKNavigationActionPolicyCancel);
	} else{
		decisionHandler(WKNavigationActionPolicyAllow);
	}
	
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSURL *url = request.URL;
	if ([url.lastPathComponent isEqualToString:@"qufabu"]) {//领取新人礼包，获取优惠券
		return NO;
	}
	return YES;
}
//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
	//用户身份信息
	NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
	//为 challenge 的发送方提供 credential
	[challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
	completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
	
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
	
}


#pragma mark -- WKUIDelegate

/**
 *  web界面中有弹出警告框时调用
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
	NSLog(@"HTML的弹出框");
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler();
	}])];
	[self presentViewController:alertController animated:YES completion:nil];
}

// 确认框
//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
	NSLog(@"确认框");
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(NO);
	}])];
	[alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(YES);
	}])];
	[self presentViewController:alertController animated:YES completion:nil];
}

// 输入框
//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		textField.text = defaultText;
	}];
	[alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(alertController.textFields[0].text?:@"");
	}])];
	[self presentViewController:alertController animated:YES completion:nil];
}

// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
	if (!navigationAction.targetFrame.isMainFrame) {
		[webView loadRequest:navigationAction.request];
	}
	return nil;
}

- (void)dealloc {
	NSLog(@"移除");
	//移除注册的js方法
	[[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcNoPrams"];
	[[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcWithPrams"];
	//移除观察者
	[_webView removeObserver:self
				  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
	[_webView removeObserver:self
				  forKeyPath:NSStringFromSelector(@selector(title))];
}

- (void) backAction {
	if (self.webView)
	{
		if ([self.webView canGoBack])
		{
			[self.webView goBack];
		}
		else
		{
			if ([self.navigationController.viewControllers indexOfObject:self] == 0)
			{
				[self dismissViewControllerAnimated:YES completion:nil];
			}
			else
			{
				[self.navigationController popViewControllerAnimated:YES];
			}
		}
	}
}

//联系客服
- (void) pushKefu {
	NSLog(@"联系客服");
	if (self.lianxiKefuBlock) {
		self.lianxiKefuBlock();
	}
}

//发布求购
- (void) releaseCreateBuyOrSupply {
	NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
	if (!USERMODEL.isLogin) {
		[self prsentToLoginViewController];
		return ;
	}
	if ([dic[@"mobile"] isEqualToString:@""]) {
		[self showLoginViewWithType:ENT_Lagin];
		return;
	}
	NSLog(@"发布求购");
	FaBuBuyViewController *v=[[FaBuBuyViewController alloc]init];
	v.type = ENT_Buy;
	[self presentViewController:v];
	
}
//我的活动
- (void) pushActivity {
	ActivityListViewController *actvitVC  = [[ActivityListViewController alloc] init];
	actvitVC.type =@"1";
	[self pushViewController:actvitVC];
}
//我的课程
- (void) MyClassSource {
	MyClassSourceController *myClassVc = [[MyClassSourceController alloc] init];
	[self pushViewController:myClassVc];
}
//发布新品种
- (void) releaseXinPinZ {
	if (!USERMODEL.isLogin) {
		[self prsentToLoginViewController];
		return ;
	}
	ReleaseNewVarietyController *vc = [[ReleaseNewVarietyController alloc] init];
	[self presentViewController:vc];
}
//资讯
- (void) pushZixunVc {
	NewSlideHeadingViewController * newVC=[[NewSlideHeadingViewController alloc]init];
	[self pushViewController:newVC];
}

//邀请好友
- (void) pushYaoqinghaoyou {
	if (self.yaoqinghaoyouBlock) {
		self.yaoqinghaoyouBlock();
	}
}
//购买课程
- (void) pushGoumaikecheng {
	[self.navigationController popToRootViewControllerAnimated:NO];
	[self.tabBarController setSelectedIndex:3];
	[[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabBarSelectedIndex object:[NSNumber numberWithInt:3]];
}
//申请加入合伙人
- (void) pushPartner {
	MTPartnerViewController *partVc = [[MTPartnerViewController alloc] init];
	[self pushViewController:partVc];
}


//购买VIP
- (void) BuyJoinVIP:(NSDictionary *)dict {
	NSLog(@"购买VIP %@",dict);
	if (!USERMODEL.isLogin) {
		[self prsentToLoginViewController];
		return ;
	}
	ApliayView *alipayView = [[ApliayView alloc] initWithFrame:self.view.window.bounds];
	[alipayView setPlayMoneyNum:[NSString stringWithFormat:@"￥%@",dict[@"money"]]];
	alipayView.top = kScreenHeight;
//	APayShow=YES;
	NSString *viptypeStr;
	if ([dict[@"type"] isEqualToString:@"year"]) {
		viptypeStr = @"0";
	}else {
		viptypeStr = @"1";
	}
	alipayView.selectBlock = ^(NSInteger index){
		if (index == ENT_top) {
			self.payType = [NSString stringWithFormat:@"%d",WEICHAT_TYPE];
			[self toPlayAndvipType:viptypeStr];
		}else if (index == ENT_midden){
			self.payType = [NSString stringWithFormat:@"%d",AlIPAY_TYPE];
			[self toPlayAndvipType:viptypeStr];
		}
	};
	[self.view.window addSubview:alipayView];
	[UIView animateWithDuration:.5 animations:^{
		alipayView.top = 0;
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:.3 animations:^{
			alipayView.backgroundColor = RGBA(0, 0, 0, 0.3);
//			self->APayShow=NO;
		}];
	}];
}
//支付
- (void) toPlayAndvipType:(NSString *)vipType {
	NSDictionary *dic = @{
						  @"userId"    :USERMODEL.userID,
						  @"type"      :self.payType,
						  @"vipType"   :vipType,
						  };
	[[PayMentMangers manager] saveJoinVipOrder:dic playType:self.payType parentVC:self resultBlock:^(BOOL isPaySuccess, NSString *msg) {
		[IHUtility removeWaitingView];
		if (isPaySuccess) {
			[self joinSuccessPushSucVc];
			USERMODEL.isDue = 1;
			if (self.paySuccesrefreshBlack) {
				self.paySuccesrefreshBlack();
			}
		}
	}];
}
- (void) joinSuccessPushSucVc {
	SuccessViewController *succVc = [[SuccessViewController alloc] init];
	if ([self.userInfo.isDue isEqualToString:@"1"]) {
		succVc.titleName = @"续费成功";
		[succVc setSucceStr:@"续费成功" andInfoStr:@"恭喜您，续费成功"];
	}else {
		succVc.titleName = @"加入成功";
		[succVc setSucceStr:@"加入成功" andInfoStr:@"恭喜您，成功加入VIP会员"];
	}
	[self pushViewController:succVc];
}


@end



