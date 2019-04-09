//
//  VotoDetailsViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/21.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "VotoDetailsViewController.h"
#import "XHFriendlyLoadingView.h"
#import "CustomView+CustomCategory2.h"
#import "BuyVoteViewController.h"   //购买选票
@interface VotoDetailsViewController ()<UIWebViewDelegate>
{
    VotoView *_votoView;
    UIWebView *_webView;
    BuyVotoNumView *_buyVotoView;
    NSString *total_piao;
}
@end

@implementation VotoDetailsViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [rightbutton setImage:[UIImage imageNamed:@"shareGreen.png"] forState:UIControlStateNormal];
    rightbutton.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"简介"];
    self.view.backgroundColor=RGB(247, 248, 249);
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NotificationVoteActionBuy:) name:NotificationVoteAction object:nil];
    
//    CGFloat hh = SCREEN_HEIGHT - 49 - kNavigationHeight-kBottomNoSapce;

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,iPhoneHeight - KtopHeitht)];
    _webView.delegate = self;
    [_webView.scrollView setScrollEnabled:YES];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    [self LoadDetail];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, WindowHeight  - 49, WindowWith, 49)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
    lineV.backgroundColor = cLineColor;
    [view addSubview:lineV];
    
    BtnView *btn=[[BtnView alloc]initWithFrame:CGRectMake(WindowWith-140, 6, 128, 37) cornerRadius:20 text:@"我也要投票" image:Image(@"iconfont-zanzan.png")];
    
    [view addSubview:btn];
    [btn addTarget:self action:@selector(voto) forControlEvents:UIControlEventTouchUpInside];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 18.5, kWidth(50), 15) textColor:cGrayLightColor textFont:sysFont(12)];
    lbl.text=@"当前票数";
    [view addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+6, 18.5, kWidth(120), 15) textColor:cGreenColor textFont:sysFont(font(15))];
    lbl.text=@"252票";
    _number=lbl;
    [view addSubview:lbl];
    
    VotoView *votoView=[[VotoView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
    __weak VotoDetailsViewController *weakSelf = self;
    votoView.selectBtnBlock=^(NSInteger index){
        [weakSelf addVoteNumStr:@"1"];
        
    };
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    [widow addSubview:votoView];
    
    _votoView=votoView;
    
}

//详情
-(void)LoadDetail
{
    [self addPushViewWaitingView];
    [network getVoteDetil:stringFormatInt(self.model.project_id) vote_id:(int)self.model.vote_id  success:^(NSDictionary *obj) {
        
        VoteListModel *model = obj[@"content"];
        NSString *header=@".video{line-height:2.2rem;}video{width:100%;height:calc(100vw*9/16);min-height:20rem;background-color:#000;} .video .info{padding:.5rem .8rem;} .video .info p strong { float:left;margin-right:1.4rem ;padding: 0 .5rem;border: .1rem solid #F60; border-radius: .2rem;font-size: 1rem;line-height: 2rem;color: #F60;text-decoration: none; font-size: 1.6rem;} img{width:100%;} <meta name=‘viewport’ content=‘width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no’> ";
        
        NSString *urlStr=[NSString stringWithFormat:@" <head><style> %@ </style></head><body>%@</body>",header,model.introduct];
        
		[self->_webView loadHTMLString:urlStr baseURL:nil];
        
		self->_number.text= [NSString stringWithFormat:@"%ld票",(long)model.vote_num];
        
        if ([obj[@"total_piao"] intValue] >=  [obj[@"surplus"] intValue]) {
			self->_surplus = stringFormatInt([obj[@"total_piao"] intValue] - [obj[@"surplus"] intValue]);
        }else {
			self->_surplus = @"0";
        }
		self->total_piao = obj[@"total_piao"];
		[self->_votoView setContent:self.model lmitNum:obj[@"total_piao"] surplus:self->_surplus];
        
    } failure:^(NSDictionary *obj2) {
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}
-(void)NotificationVoteActionBuy:(NSNotification *)notificaiton{  //发布成功，马上更新列表
    [self LoadDetail];
}
//投票
- (void)addVoteNumStr:(NSString *)numStr
{
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    [self addWaitingView];
    [network getVoteForUser:self.activModel.activities_id project_id:stringFormatInt(self.model.project_id) user_id:userID vote_num:numStr success:^(NSDictionary *obj) {
		self->_surplus = stringFormatInt([self->_surplus intValue] - [numStr integerValue]);
        
		[self->_votoView setContent:self.model lmitNum:self.activModel.user_upper_limit_num surplus:self->_surplus];
        self->_number.text=[NSString stringWithFormat:@"%ld票",(long)[self->_number.text integerValue]+[numStr integerValue]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationVoteSucces" object:nil];
        
        [self.delegate VoteSuccessDelagate:self.model indexPath:self.indexPath];
//        [self addSucessView:@"投票成功，感谢您的参与!" type:1];
        [self removeWaitingView];
    } failure:^(NSDictionary *obj2) {
        [self removeWaitingView];
    }];
}

-(void)voto {
    if (!USERMODEL.isLogin) {
        //登录
        [self prsentToLoginViewController];
        return;
    }
    if ([self.activModel.is_zc_goumai isEqualToString:@"1"]) {
        [self BuyVotoMode:self.model];
    }else {
        [_votoView show];
    }
}
- (void) BuyVotoMode:(VoteListModel *)model{
    _buyVotoView = [[BuyVotoNumView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    [_buyVotoView setContent:model lmitNum:total_piao surplus:_surplus];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:_buyVotoView];
    WS(weakSelf);
    _buyVotoView.selectBtnBlock=^(NSString *NumStr){
        [weakSelf addVoteNumStr:NumStr];
    };
    model.times = self.model.times;
    _buyVotoView.buyVotoBtnBlock = ^{
        BuyVoteViewController *buyVc = [[BuyVoteViewController alloc] init];
        buyVc.model = model;
        buyVc.votoTitle = weakSelf.activModel.activities_titile;
        buyVc.ActiviModel = weakSelf.activModel;
        [weakSelf pushViewController:buyVc];
    };
    _buyVotoView.hideBtnBlock = ^{
        [weakSelf dismissPopupController];
    };
}
#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView {
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupViewController presentPopupControllerAnimated:YES];
}
- (void)dismissPopupController {
    [self.popupViewController dismissPopupControllerAnimated:YES];
}





- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self removePushViewWaitingView];
}

- (void)home:(id)sender {
    NSString *Path = [NSString stringWithFormat:@"pages/activity/voteDetail/vote_project/vote_project?%@&%@&%@",self.activModel.activities_id,stringFormatInt(self.model.project_id),self.activModel.is_zc_goumai];  //示例pages/activity/voteDetail/vote_project/vote_project?378&190&1
    NSDictionary *dict = @{
                           @"appid"     :WXXCXappId,
                           @"appsecret" :WXXCXappSecret,
                           @"projectId" :stringFormatInt(self.model.project_id),
                           @"path"      :Path,
                           };
    [self shareSmallProgramCodeOject:dict httpMethod:2 methoe:VoteActiviShareUrl Vc:self completion:nil];
}

//分享H5链接
/*
- (void)home:(id)sender
{
    NSString *content = [NSString stringWithFormat:@"%@  #%@号  #%@  #%@   投我一票吧！",self.model.name,self.model.project_code,self.model.city,self.model.company_info];
    NSString *urlStr = [NSString stringWithFormat:@"%@vote/tpdx-index.html?project_id=%ld&ch_nm=%@&vote_id=%d",shareURL,(long)self.model.project_id,self.activModel.user_upper_limit_num,[self.activModel.activities_id intValue]];
    [self ShareUrl:self withTittle:@"快来帮我投一票吧！能不能上榜就靠你了！" content:content withUrl:urlStr imgUrl:self.model.head_image];
}
*/
@end
