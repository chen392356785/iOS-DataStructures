//
//  MiaoTuVipViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/18.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MiaoTuVipViewController.h"

//#import "UINavigationBar+Awesome.h"
#import <WebKit/WebKit.h>

#import "PayTypeConstants.h"
#import "PayMentMangers.h"
#import "SuccessViewController.h"   //加入成功

@interface MiaoTuVipViewController () <WKUIDelegate, WKNavigationDelegate>{
    UIScrollView *_bgScrollView;
    UIImageView *_vipBgimagV;        //VIP
    UIAsyncImageView *_headerImageView;
    UILabel *_nameLab;
    UILabel *_infoLab;
    UIButton *_joinVIPBut;
    
    UILabel *_vipPriLab; //VIP特权
    WKWebView * _webView;
    
    BOOL APayShow;      //是否要显示支付
}
@property (nonatomic,copy)NSString *payType;        //付款方式
@end

@implementation MiaoTuVipViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UIImage *backImg=Image(@"icon_fh_b");
    leftbutton.frame=CGRectMake(0, 0, 34, 40);
    [leftbutton setImage:backImg forState:UIControlStateNormal];
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.userInfo.isDue isEqualToString:@"1"]) {
         [self setTitle:@"我的VIP会员" andTitleColor:kColor(@"#FEFEFE")];
    }else if ([self.userInfo.isDue isEqualToString:@"0"]) {
         [self setTitle:@"加入VIP会员" andTitleColor:kColor(@"#FEFEFE")];
    }else {
        if (self.titleName != nil) {
            [self setTitle:self.titleName andTitleColor:kColor(@"#FEFEFE")];
        }
    }
    [self createHeadInfoView];
}
- (void) createHeadInfoView {
    self.view.backgroundColor = kColor(@"#FFFFFF");
    UIImageView * topBgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(200) + KStatusBarHeight)];
    topBgImgV.image = kImage(@"img_myvip_bg");
    [self.view addSubview:topBgImgV];
    topBgImgV.layer.shadowColor = kColor(@"#000000").CGColor;
    topBgImgV.layer.shadowOffset = CGSizeMake(2, 4);
    topBgImgV.layer.shadowOpacity = 0.1;
    topBgImgV.layer.shadowRadius = 1.5;
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KtopHeitht, iPhoneWidth, iPhoneHeight - KtopHeitht)];
    [self.view addSubview:_bgScrollView];

    [self addTopVIPSubView];
    
    _vipPriLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _vipBgimagV.bottom + kWidth(56), 0, kWidth(16))];
    _vipPriLab.text = @"尊享特权";
    _vipPriLab.textColor = kColor(@"#333333");
    _vipPriLab.font = sysFont(font(16));
    [_bgScrollView addSubview:_vipPriLab];
    [_vipPriLab sizeToFit];
    _vipPriLab.centerX = _bgScrollView.centerX;
    
    UILabel *lineLab1 = [[UILabel alloc] initWithFrame:CGRectMake(_vipPriLab.left - kWidth(12) - kWidth(56), 0, kWidth(56), 1)];
    lineLab1.centerY = _vipPriLab.centerY;
    lineLab1.backgroundColor = kColor(@"#9D62CD");
    [_bgScrollView addSubview:lineLab1];
    
    UILabel *lineLab2 = [[UILabel alloc] initWithFrame:CGRectMake(_vipPriLab.right + kWidth(12), 0, kWidth(56), kWidth(1))];
    lineLab2.centerY = _vipPriLab.centerY;
    lineLab2.backgroundColor = kColor(@"#9D62CD");
    [_bgScrollView addSubview:lineLab2];
    
    [self addWKwebView];
    NSURL *url = [NSURL URLWithString:self.allUrl.jiaruvip_Url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}
- (void) addTopVIPSubView {
    UIImageView *vipBgimagV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(27), kWidth(351), kWidth(197))];
    _vipBgimagV = vipBgimagV;
    if ([self.userInfo.isDue isEqualToString:@"1"]) {
        vipBgimagV.image = kImage(@"img_vip");
    }else if ([self.userInfo.isDue isEqualToString:@"0"]) {
         vipBgimagV.image = kImage(@"img_myvip_top");
    }else {
        
    }
    vipBgimagV.centerX = _bgScrollView.width/2.;
    [_bgScrollView addSubview:vipBgimagV];
    
    _headerImageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(29), kWidth(27), kWidth(60), kWidth(60))];
    _headerImageView.layer.cornerRadius = _headerImageView.height/2.;
    _headerImageView.layer.borderWidth = 1.5;
    _headerImageView.layer.borderColor = kColor(@"#FFFFFF").CGColor;
    [vipBgimagV addSubview:_headerImageView];
    
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    [_headerImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
    [_headerImageView canClickItWithDuration:0.3 ThumbUrl:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]]];
    
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headerImageView.right + kWidth(13), _headerImageView.top + kWidth(8), kWidth(100), kWidth(16))];
    _nameLab.text = dic[@"nickname"];
    _nameLab.font = darkFont(font(17));
    _nameLab.textColor = kColor(@"#FFFFFF");
    [vipBgimagV addSubview:_nameLab];
    
    _infoLab = [[UILabel alloc] initWithFrame:CGRectMake(_nameLab.left, _nameLab.bottom + kWidth(16), kWidth(130), kWidth(12))];
    if ([self.userInfo.isDue isEqualToString:@"1"]) {
        _infoLab.text = [NSString stringWithFormat:@"%@ 到期",self.userInfo.due_time];;
         _infoLab.textColor = kColor(@"#C90B0B");
    }else if ([self.userInfo.isDue isEqualToString:@"0"]) {
        _infoLab.text = @"暂未加入会员";
         _infoLab.textColor = kColor(@"#FFFFFF");
    }else {
        
    }
    _infoLab.font = darkFont(font(12));
    [vipBgimagV addSubview:_infoLab];
    
    _joinVIPBut = [UIButton buttonWithType:UIButtonTypeSystem];
    _joinVIPBut.frame = CGRectMake(0, vipBgimagV.height - kWidth(29) - kWidth(29), kWidth(200), kWidth(29));
    [vipBgimagV addSubview:_joinVIPBut];
    _joinVIPBut.layer.cornerRadius = _joinVIPBut.height/2.;
    _joinVIPBut.layer.borderWidth = 1;
    _joinVIPBut.titleLabel.font = sysFont(font(13));
    [_joinVIPBut addTarget:self action:@selector(JoinAction:) forControlEvents:UIControlEventTouchUpInside];
    _joinVIPBut.centerX = vipBgimagV.width/2.;
    if ([self.userInfo.isDue isEqualToString:@"1"]) {
        [_joinVIPBut setTitle:@"立即续费" forState:UIControlStateNormal];
        _joinVIPBut.layer.borderColor = kColor(@"#6C4D16").CGColor;
        [_joinVIPBut setTitleColor:kColor(@"#6C4D16") forState:UIControlStateNormal];
    }else if ([self.userInfo.isDue isEqualToString:@"0"]) {
        [_joinVIPBut setTitle:@"加入会员" forState:UIControlStateNormal];
        _joinVIPBut.layer.borderColor = kColor(@"#FFFFFF").CGColor;
        [_joinVIPBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    }else {
        
    }
    _joinVIPBut.hidden = YES;
    _vipBgimagV.userInteractionEnabled = YES;
    
}

- (void) addWKwebView{
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
    
    //以下代码适配文本大小
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //用于进行JavaScript注入
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [config.userContentController addUserScript:wkUScript];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _vipPriLab.bottom + kWidth(40), iPhoneWidth, iPhoneHeight - _vipPriLab.bottom - kWidth(40) ) configuration:config];
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    //可返回的页面列表, 存储已打开过的网页
//    WKBackForwardList * backForwardList = [_webView backForwardList];
    [_bgScrollView addSubview:_webView];
    
    UIActivityIndicatorView *avt=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(iPhoneWidth/2, iPhoneHeight/2, 24, 24)];
    avt.tag = 8230;
    [avt setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [avt startAnimating];
    [_bgScrollView addSubview:avt];
    
    [_webView.scrollView setScrollEnabled:NO];
}
- (void) JoinAction:(UIButton *) but {
    if ([self.userInfo.isDue isEqualToString:@"1"]) {
//        NSLog(@"立即续费");
        [self PlayMoneyButAction];
    }else if ([self.userInfo.isDue isEqualToString:@"0"]) {
//        NSLog(@"加入VIP");
        [self PlayMoneyButAction];
    }else {
        
    }
}




// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    UIView* view = [self.view viewWithTag:8230];
    
    _joinVIPBut.hidden = NO;    //显示续费操作
    //HTML5的高度
    [webView evaluateJavaScript:@"Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            if(!error) {
                NSNumber * height = result;
				self->_webView.size = CGSizeMake(iPhoneWidth,  [height floatValue]);
				self->_bgScrollView.contentSize = CGSizeMake(iPhoneWidth, [height floatValue] + self->_webView.top);
            }
    }];
    if (view!=nil) {
        [view removeFromSuperview];
    }
    [self getCookie];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    UIView* view = [self.view viewWithTag:8230];
    if (view!=nil) {
        [view removeFromSuperview];
    }
}
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

#pragma - mark 加入会员
- (void) PlayMoneyButAction {
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    ApliayView *alipayView = [[ApliayView alloc] initWithFrame:self.view.window.bounds];
    [alipayView setPlayMoneyNum:[NSString stringWithFormat:@"￥%@",self.userInfo.vipPrice]];
    alipayView.top = kScreenHeight;
    APayShow=YES;
    alipayView.selectBlock = ^(NSInteger index){
        if (index == ENT_top) {
            self.payType = [NSString stringWithFormat:@"%d",WEICHAT_TYPE];
            [self toPlay];
        }else if (index == ENT_midden){
            self.payType = [NSString stringWithFormat:@"%d",AlIPAY_TYPE];
            [self toPlay];
        }
    };
    [self.view.window addSubview:alipayView];
    [UIView animateWithDuration:.5 animations:^{
        alipayView.top = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            alipayView.backgroundColor = RGBA(0, 0, 0, 0.3);
			self->APayShow=NO;
        }];
    }];
}
//支付
- (void) toPlay {
    
//    return;
    
    NSDictionary *dict = @{
                           @"userId"    :USERMODEL.userID,
                           @"type"      :self.payType,
                           @"vipType"   :@"0",
                        };
    [[PayMentMangers manager] saveJoinVipOrder:dict playType:self.payType parentVC:self resultBlock:^(BOOL isPaySuccess, NSString *msg) {
        [IHUtility removeWaitingView];
        if (isPaySuccess) {
             [self joinSuccessPushSucVc];
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
