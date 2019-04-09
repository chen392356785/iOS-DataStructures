//
//  ScanSuccessJumpVC.m
//  SGQRCodeExample
//
//  Created by kingsic on 16/8/29.
//  Copyright © 2016年 kingsic. All rights reserved.
//

#import "ScanSuccessJumpVC.h"
#import "SGWebView.h"

@interface ScanSuccessJumpVC () <SGWebViewDelegate> {
    UIAsyncImageView *IconimageView;
    UILabel *_TitleLabel;
    UILabel *contLabel;
    UIButton *loginBut;
    UIButton *CancelBut;
}
@property (nonatomic , strong) SGWebView *webView;
@end

@implementation ScanSuccessJumpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.jump_bar_code) {
        [self setupLabel];
    } else {
        if ([self.jump_URL hasPrefix:@"http"]) {
            NSLog(@"结果 ---- %@",self.jump_URL);
            if ([self.jump_URL containsString:@"publicModel/determine"]) {
                self.title = @"扫码登录";
                [self ScanCodeLogin];
            }else {
                [self setupNavigationItem];
                [self setupWebView];
            }
        }else {
            [self setupCodeLabel];
        }
    }
}
- (void) ScanCodeLogin {
    IconimageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, kWidth(119), kWidth(128), kWidth(113))];
    IconimageView.image = Image(@"电脑");
    IconimageView.centerX = self.view.centerX;
    [self.view addSubview:IconimageView];
    
    _TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(IconimageView)+kWidth(30), iPhoneWidth, 20)];
    _TitleLabel.font = boldFont(18);
    _TitleLabel.textAlignment = NSTextAlignmentCenter;
    _TitleLabel.text = @"苗途登录确认";
    [self.view addSubview:_TitleLabel];
    
    contLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(_TitleLabel) + kWidth(8), iPhoneWidth, 20)];
    [self.view addSubview:contLabel];
    contLabel.textColor = kColor(@"#b6b6b6");
    contLabel.text = @"请不要扫描来源不明的二维码";
    contLabel.font = boldFont(18);
    contLabel.textAlignment = NSTextAlignmentCenter;
    
    loginBut = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBut.frame = CGRectMake(kWidth(23), iPhoneHeight - KtopHeitht - kWidth(120), iPhoneWidth - kWidth(46), kWidth(45));
    loginBut.layer.cornerRadius = height(loginBut)/2.;
    [self.view addSubview:loginBut];
    [loginBut setTitle:@"确认登录" forState:UIControlStateNormal];
    loginBut.backgroundColor = kColor(@"#05c1b0");
    [loginBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBut.titleLabel.font = boldFont(18);
    [loginBut addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    CancelBut = [UIButton buttonWithType:UIButtonTypeSystem];
    CancelBut.frame = CGRectMake(kWidth(23), maxY(loginBut) + kWidth(20), iPhoneWidth - kWidth(46),kWidth(45));
    CancelBut.layer.cornerRadius = height(CancelBut)/2.;
    [self.view addSubview:CancelBut];
    [CancelBut setTitle:@"取消登录" forState:UIControlStateNormal];
    [CancelBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CancelBut.titleLabel.font = boldFont(18);
    [CancelBut addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void) loginAction {
    NSString *token;
    NSArray *array = [self getParamsWithUrlString:self.jump_URL];
    NSDictionary *part = array[1];
    NSString *method = array[0];
    if (part[@"token"] != nil) {
        token = part[@"token"];
    }
    NSDictionary *dict = @{
                            @"userId"        :   USERMODEL.userID,
                            @"username"      :   USERMODEL.userName,
                            @"token"         :   token,
                            };
    [self showWaitingHUD:@"加载中..."];
    [network httpRequestTagWithParameter:dict method:method tag:IH_PCLogin success:^(NSDictionary *dic) {
        [self HUDHidden];
        if ([dic[@"errorNo"] integerValue] == 0 ) {
             [self addSucessView:@"登录成功!" type:1];
             [self popViewController:1];
        }
    } failure:^(NSDictionary *dic) {
        [self HUDHidden];
    }];
}
- (void) cancelAction {
     [self popViewController:1];
}
- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(right_BarButtonItemAction)];
}

- (void)back:(id)sender {
    if (self.comeFromVC == ScanSuccessJumpComeFromWB) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (self.comeFromVC == ScanSuccessJumpComeFromWC) {
        [self popViewController:1];
    }
}

- (void)right_BarButtonItemAction {
    [self.webView reloadData];
}

// 添加Label，加载扫描过来的内容
- (void)setupLabel {
    // 提示文字
    UILabel *prompt_message = [[UILabel alloc] init];
    prompt_message.frame = CGRectMake(0, 200, self.view.frame.size.width, 30);
    prompt_message.text = @"您扫描的条形码结果如下： ";
    prompt_message.textColor = [UIColor redColor];
    prompt_message.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:prompt_message];
    
    // 扫描结果
    CGFloat label_Y = CGRectGetMaxY(prompt_message.frame);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, label_Y, self.view.frame.size.width, 30);
    label.text = self.jump_bar_code;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)setupCodeLabel {
    // 提示文字
    UILabel *prompt_message = [[UILabel alloc] init];
    prompt_message.frame = CGRectMake(0, 200, self.view.frame.size.width, 30);
    prompt_message.text = @"您扫描的二维码结果如下： ";
    prompt_message.textColor = [UIColor redColor];
    prompt_message.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:prompt_message];
    
    // 扫描结果
    CGFloat label_Y = CGRectGetMaxY(prompt_message.frame);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, label_Y, self.view.frame.size.width, 48);
    label.text = self.jump_URL;
    label.numberOfLines = 0;
    label.font = sysFont(17);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    CGFloat webViewX = 0;
    CGFloat webViewY = 0;
    CGFloat webViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webViewH = [UIScreen mainScreen].bounds.size.height;
    self.webView = [SGWebView webViewWithFrame:CGRectMake(webViewX, webViewY, webViewW, webViewH)];
    self.webView.SGQRCodeDelegate = self;
    if (self.comeFromVC == ScanSuccessJumpComeFromWB) {
        _webView.progressViewColor = [UIColor orangeColor];
    };
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.jump_URL]]];
    _webView.SGQRCodeDelegate = self;
    [self.view addSubview:_webView];
}

- (void)webView:(SGWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    self.title = webView.navigationItemTitle;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
    self.title = [webView1 stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (NSArray*)getParamsWithUrlString:(NSString*)urlString {
    
    if(urlString.length==0) {
        
        NSLog(@"链接为空！");
        
        return @[@"",@{}];
        
    }
    
    
    
    //先截取问号
    
    NSArray*allElements = [urlString componentsSeparatedByString:@"?"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//待set的参数字典
    
    
    
    if(allElements.count==2) {
        
        //有参数或者?后面为空
        
        NSString*myUrlString = allElements[0];
        
        NSString*paramsString = allElements[1];
        
        
        
        //获取参数对
        
        NSArray*paramsArray = [paramsString componentsSeparatedByString:@"&"];
        
        
        
        if(paramsArray.count>=2) {
            
            
            
            for(NSInteger i = 0; i < paramsArray.count; i++) {
                
                
                
                NSString*singleParamString = paramsArray[i];
                
                NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
                
                
                
                if(singleParamSet.count==2) {
                    
                    NSString*key = singleParamSet[0];
                    
                    NSString*value = singleParamSet[1];
                    
                    
                    
                    if(key.length>0|| value.length>0) {
                        
                        [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                        
                    }
                    
                }
                
            }
            
        }else if(paramsArray.count==1) {
            
            //无 &。url只有?后一个参数
            
            NSString*singleParamString = paramsArray[0];
            
            NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
            
            
            
            if(singleParamSet.count==2) {
                
                NSString*key = singleParamSet[0];
                
                NSString*value = singleParamSet[1];
                
                
                
                if(key.length>0|| value.length>0) {
                    
                    [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                    
                }
                
            }else{
                
                //问号后面啥也没有 xxxx?  无需处理
                
            }
            
        }
        
        
        
        //整合url及参数
        
        return@[myUrlString,params];
        
    }else if(allElements.count>2) {
        
        NSLog(@"链接不合法！链接包含多个\"?\"");
        
        return @[@"",@{}];
        
    }else{
        
        NSLog(@"链接不包含参数！");
        
        return@[urlString,@{}];
        
    }
    
    
    
}
@end

