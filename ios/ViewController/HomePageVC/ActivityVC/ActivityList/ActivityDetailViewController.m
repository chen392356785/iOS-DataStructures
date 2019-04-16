//
//  ActivityDetailViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/5.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ACtivityTopView.h"
//#import "ActivRegistrationViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "InputKeyBoardView.h"
#import "YLWebViewController.h"
#import "ActivtiesMapViewController.h"
#import "ActivPaymentViewController.h"
#import "ActivityPaySuccessfulViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "XHFriendlyLoadingView.h"
#import "ActivtyCrowdViewController.h"
#import "CrowdFundingViewController.h"
#import "PayMentMangers.h"
#import "UIBarButtonItem+Extents.h"
//#import "PayMentMangers.h"
#import "THNotificationCenter+C.h"

@interface ActivityDetailViewController ()<UITableViewDelegate,HJCActionSheetDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate>

{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    InputKeyBoardView *_keyBoardView;
    UITextField *_pltxt;
    UIView *_lineView;
    UIButton *_commentListBtn;
    UIButton *_collectBtn;
    ActivtiesOrderView *_activOrderView;
    ActivityDetailView *_activityDetailView;
    UIView *_downView;
    
    BottomView *_bottomView;
    UIView *_topView;
    
    float alpha;
    
    int whether;//是否众筹过
    NSString *crowdId;//众筹ID
}
@end

@implementation ActivityDetailViewController

-(void)becomeKeyBoard{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    self.isReply=NO;
    [_pltxt becomeFirstResponder];
    [_keyBoardView.txtView becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    //进入详情判断是否已众筹 如果已众筹获取众筹ID 点击报名按钮进入众筹也是带过去
    [network getWhetherCrowdWithUserID:userID activities_id:self.model.activities_id success:^(NSDictionary *obj) {
        
        self->whether = [obj[@"content"][@"crowdStatus"] intValue];
        if (self->whether == 1) {
            self->crowdId = [NSString stringWithFormat:@"%@",obj[@"content"][@"crowd_id"]];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize size = [IHUtility GetSizeByText:@"活动详情" sizeOfFont:15 width:200];
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, size.width, size.height) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text = @"活动详情";
    self.navigationItem.titleView = lbl;
    
    agreeArr=[[NSMutableArray alloc]init];
    
    backTopbutton.top = backTopbutton.top - 50;
    
    _barlineView.alpha=0;
    
    //活动列表进入直接获取从列表带过来的详情数据  我的活动进入需根据活动ID请求详情信息
    if ([self.type isEqualToString:@"1"]) {
        
        [self creatTableView];
        [self addPushViewWaitingView];
        
    }else {
        [self reloadWaitingView];
    }
    
    //设置导航栏按钮
    [self addNavgationItems];
}

#pragma mark网络断开 从新链接
-(void)reloadWaitingView{
    [self addPushViewWaitingView];
    [network getActivitiesDetail:self.model.activities_id type:self.model.model success:^(NSDictionary *obj) {
        
        ActivitiesListModel *detailModel = obj[@"content"];
        self.model = detailModel;
        
        [self creatTableView];
        
        //判断是否已经收藏
        if ([self.model.hasCollection isEqualToString:@"1"]){
            self->_collectBtn.selected = YES;
        }
        
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}
- (void)addActivOrderView
{
    //报名提交用户信息弹层
    _activOrderView.hidden = NO;
    if ([IHUtility overtime:self.model.curtime inputDate:self.model.activities_expiretime]) {
        [self addSucessView:@"该活动已过期" type:2];
    }else {
        [UIView animateWithDuration:.3 animations:^{
            self->_activOrderView.backgroundColor = RGBA(0, 0, 0, 0.3);
        }completion:^(BOOL finished) {
            self->_activOrderView.top = 0;
        }];
    }
}
- (void)addNavgationItems
{
    UIBarButtonItem *shareItem = [UIBarButtonItem barButtonItem:@"shareGreen.png" withTarget:self withAction:@selector(shareActivt)];
    
    UIBarButtonItem *customItem = [UIBarButtonItem barButtonItem:@"Group 11.png" withTarget:self withAction:@selector(getPhoneweak)];

    
    self.navigationItem.rightBarButtonItems = @[customItem,shareItem];
    
}
-(void)creatTableView
{
    __weak ActivityDetailViewController *weakSelf=self;
    
    dataArray = [[NSMutableArray alloc] init];
    
    UIView *topView=[[UIView alloc]init];
    _topView = topView;
    //活动图片及信息
    ACtivityTopView *activityTopView = [[ACtivityTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 195)];
    [activityTopView setImageURl:self.model.activities_pic signNum:self.model.sign_up_num title:self.model.activities_titile skimNum:self.model.onlookers_user uint_price:self.model.payment_amount];
//    _activityTopView = activityTopView;
    [topView addSubview:activityTopView];
    
    //活动地址，时间
    ActivityMidView *activityMidView=[[ActivityMidView alloc]initWithFrame:CGRectMake(0, activityTopView.bottom, WindowWith, 97)];
    activityMidView.backgroundColor = [UIColor whiteColor];
    [activityMidView setDataWith:self.model.activities_starttime address:self.model.activities_address unit_price:self.model.payment_amount endTime:self.model.activities_endtime];
    [topView addSubview:activityMidView];
    //地图
    UITapGestureRecognizer *mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getaddressTomap:)];
    mapTap.numberOfTapsRequired = 1;
    mapTap.delegate = self;
    mapTap.numberOfTouchesRequired = 1;
    [activityMidView.addressView addGestureRecognizer:mapTap];
    
    //活动的详细说明利用webView加载
    ActivityDetailView *activityDetailView=[[ActivityDetailView alloc]initWithFrame:CGRectMake(0, activityMidView.bottom, WindowWith, 50)];
    activityDetailView.clipsToBounds= YES;
    activityDetailView.backgroundColor = [UIColor whiteColor];
    _activityDetailView = activityDetailView;
    activityDetailView.contentLabel.delegate= self;
    NSString *header=@".video{line-height:2.2rem;}video{width:100%;height:calc(100vw*9/16);min-height:20rem;background-color:#000;} .video .info{padding:.5rem .8rem;} .video .info p strong { float:left;margin-right:1.4rem ;padding: 0 .5rem;border: .1rem solid #F60; border-radius: .2rem;font-size: 1rem;line-height: 2rem;color: #F60;text-decoration: none; font-size: 1.6rem;} img{width:100%;} <meta name=‘viewport’ content=‘width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no’> ";
    
    NSString *urlStr=[NSString stringWithFormat:@" <head><style> %@ </style></head><body>%@</body>",header,self.model.html_content];
    
    [activityDetailView.contentLabel loadHTMLString:urlStr baseURL:nil];
    [topView addSubview:activityDetailView];
    
    //活动点赞
    AgreeView *agreeView=[[AgreeView alloc]initWithFrame:CGRectMake(0, activityDetailView.bottom + 5, WindowWith, 55)  number:stringFormatString(self.model.clickLikeTotal)];
    _agreeView=agreeView;
    __weak AgreeView *agreeSelf = agreeView;
    agreeView.selectBlock=^(NSInteger index){
        if (index==agreeBlock){
            [weakSelf getAddAgreeNum];
        }else if (index == cancelagreeBlock){
            if (self.model.hasClickLike) {
                [weakSelf addSucessView:@"该活动已点赞" type:2];
                agreeSelf.agreeBtn.selected = YES;
            }
        }else{
            [weakSelf getAgreeHeadNetWork:index];
        }
    };
    
    [topView addSubview:agreeView];
    
    //获取活动的点赞列表
    [network getQueryClickLikeListType:4 business_id:self.model.activities_id num:10 page:0 success:^(NSDictionary *obj) {
        NSArray *arr=[obj objectForKey:@"content"];
        [self->agreeArr addObjectsFromArray:arr];
        [agreeView setData:arr totalNum:stringFormatString(self.model.clickLikeTotal) hasClickLike:[self.model.hasClickLike boolValue]];
    } failure:^(NSDictionary *obj2) {
    }];
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, agreeView.bottom + 5, WindowWith, 37)];
    downView.backgroundColor=[UIColor whiteColor];
    _downView = downView;
    
    UIImage *comImg = Image(@"comment.png");
    UIButton *commentListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentListBtn.frame = CGRectMake(15, 0, 50, 36);
    [commentListBtn setImage:[comImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [commentListBtn setTitle:stringFormatString(self.model.commentTotal) forState:UIControlStateNormal];
    [commentListBtn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
    commentListBtn.titleLabel.font=sysFont(14);
    commentListBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 0);
    _commentListBtn = commentListBtn;
    [downView addSubview:commentListBtn];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(commentListBtn.left, 36, commentListBtn.width, 2)];
    lineView2.backgroundColor=RGBA(85, 201, 196, 1);
    _lineView = lineView2;
    [downView addSubview:lineView2];
    [topView addSubview:downView];
    topView.frame=CGRectMake(0, 0, WindowWith,downView.bottom);
    
    CGFloat hhhh = kBottomNoSapce;
    CGFloat navi_h = kNavigationHeight;
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-navi_h-42-hhhh) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    
    commTableView.table.tableHeaderView=topView;
    [commTableView setupData:dataArray index:3];
    commTableView.table.delegate=self;
    [self.view addSubview:commTableView];
    
    BottomView *bottomView=[[BottomView alloc]initWithisSelf:NO type:ENT_activity];
    _bottomView = bottomView;
    [bottomView setDataWithActivModel:self.model];
    bottomView.selectBlock=^(NSInteger index){
        
        if (!USERMODEL.isLogin) {
            [weakSelf prsentToLoginViewController];
            return ;
        }
        if (index==SelectCommentBlock) {
            NSLog(@"评论");
            self->_activOrderView.hidden = YES;
            [weakSelf becomeKeyBoard];
        }
        else if (index==SelectAgreeBlock ) {
            NSLog(@"点赞");
            [weakSelf getAddAgreeNum];
        }
        else  if (index==SelectBaomingBlock) {
            NSLog(@"报名");
            if ([self.model.model isEqualToString:@"8"]) {
                
                if (self->whether == 0) {
                    ActivtyCrowdViewController *vc = [[ActivtyCrowdViewController alloc]init];
                    vc.model = self.model;
                    vc.indexPath = self.indexPath;
                    [self pushViewController:vc];
                }else if (self->whether == 1){
                    CrowdFundingViewController *vc = [[CrowdFundingViewController alloc] init];
                    vc.Type = @"2";
                    vc.crowdID = self->crowdId;
                    PayMentMangers *paymentManager = [[PayMentMangers alloc]init];
                    vc.payBlock = ^(NSString *price, NSString *orderNo, NSString *type, NSString *subject,NSString *crowId,SMBaseViewController *vc) {
                        [paymentManager payment:orderNo orderPrice:price type:type subject:subject crowID:crowId activitieID:self.model.activities_id  parentVC:vc resultBlock:^(BOOL isPaySuccess, NSString *msg) {
                            if (isPaySuccess) {
                                [[THNotificationCenter singleton]notifiyCrowdSuccess:self.indexPath];
                            }else{
                                //支付取消或者支付失败
                            }
                        }];
                    };
                    [self pushViewController:vc];
                }
            }else {
                //普通活动提交报名信息
                [weakSelf addActivOrderView];
            }
        }
    };
    
    [self.view addSubview:bottomView];
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshFooter];
    
    UITextField *txt=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0)];
    _pltxt=txt;
    [self.view addSubview:txt];
    _keyBoardView=[[InputKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)  submit:^(NSString *str) {
        [weakSelf createComment:str];
    } back:^{
        [weakSelf resignKeyBoard];
    }];
    txt.inputAccessoryView =_keyBoardView;
    
    
    if (self.isBeginComment) {
        [self performSelector:@selector(becomeKeyBoard) withObject:nil afterDelay:0.8];
    }
    
    //报名视图
    ActivtiesOrderView *activOrderView = [[ActivtiesOrderView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) activImage:self.model.activities_pic price:self.model.payment_amount dic:self.model.userinfoDic];
    activOrderView.top = self.view.height;
    _activOrderView = activOrderView;
    _activOrderView.hidden = YES;
    activOrderView.backgroundColor = RGBA(0, 0, 0, 0);
    [activOrderView.referBtu addTarget:self action:@selector(addOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activOrderView];
}

- (void)pushToPaySuccessfulVC{
    ActivityPaySuccessfulViewController *vc=[[ActivityPaySuccessfulViewController alloc]init];
    vc.indexPath = self.indexPath;
    vc.model = self.model;
    [self pushViewController:vc];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:self.indexPath];
}

-(void)webViewUrl:(NSURL *)url{
    YLWebViewController *controller=[[YLWebViewController alloc]init];
    controller.type=1;
    controller.mUrl=url;
    [self pushViewController:controller];
}
-(void)resignKeyBoard{
    [_keyBoardView.txtView resignFirstResponder];
    [_pltxt resignFirstResponder];
}
//提交报名信息接口调用
- (void)addOrder:(UIButton *)button
{
   
    NSString *nameStr;
    if (_activOrderView.nameText != nil) {
        if (_activOrderView.nameText.text.length <= 0) {
            [self addSucessView:@"请输入联系人" type:2];
            return;
        }
        nameStr = _activOrderView.nameText.text;
    }else {
        nameStr = @"";
    }
    
    NSString *jobStr;
    if (_activOrderView.jobText != nil) {
        if (_activOrderView.jobText.text.length <= 0) {
            [self addSucessView:@"请输入职位" type:2];
            return;
        }
        jobStr = _activOrderView.jobText.text;
    }else {
        jobStr = @"";
    }
    
    NSString *companyStr;
    if (_activOrderView.companyText != nil) {
        if (_activOrderView.companyText.text.length <= 0) {
            [self addSucessView:@"请输入公司名称" type:2];
            return;
        }
        companyStr = _activOrderView.companyText.text;
    }else {
        companyStr = @"";
    }
    
    NSString *phonrStr;
    if (_activOrderView.phoneText != nil) {
        if (![IHUtility checkPhoneValidate:_activOrderView.phoneText.text]) {
            return;
        }
        phonrStr = _activOrderView.phoneText.text;
    }else {
        phonrStr = @"";
    }
     [_activOrderView cancleOrder];     //取消上谈框
    
     [self addWaitingView];
    
    [network getAddActivtiesOrder:1 activities_id:[NSString stringWithFormat:@"%@",self.model.activities_id] contacts_people:nameStr contacts_phone:phonrStr job:jobStr company_name:companyStr email:@"" success:^(NSDictionary *obj) {
        [self removeWaitingView];
        ActivitiesListModel *model = obj[@"content"];
        
        //如果活动为免费活动 则直接报名成功 否则就跳转支付界面
        if (self.model.payment_amount == nil ||[self.model.payment_amount isEqualToString:@""]||[self.model.payment_amount isEqualToString:@"0"]) {
            ActivityPaySuccessfulViewController *paySuccessVC = [[ActivityPaySuccessfulViewController alloc] init];
            paySuccessVC.model = model;
            paySuccessVC.indexPath = self.indexPath;
            [self pushViewController:paySuccessVC];
        }else {
            ActivPaymentViewController *paymentVC = [[ActivPaymentViewController alloc] init];
            paymentVC.model = model;
            paymentVC.indexPath = self.indexPath;
            PayMentMangers *paymentManager = [[PayMentMangers alloc]init];
            paymentVC.payBlock = ^(NSString *price, NSString *orderNo, NSString *type, NSString *subject, SMBaseViewController *vc) {
                [paymentManager payment:orderNo orderPrice:price type:type subject:subject activitieID:model.activities_id parentVC:vc resultBlock:^(BOOL isPaySuccess, NSString *msg) {
                    if (isPaySuccess) {
                        [self pushToPaySuccessfulVC];
                    }
                }];
            };
            [self pushViewController:paymentVC];
        }
        
    } failure:^(NSDictionary *obj2) {
        
    }];
    
}
-(void)getAddAgreeNum{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    [network getAddActivtiesClickLike:[USERMODEL.userID intValue] activities_id:[self.model.activities_id intValue] success:^(NSDictionary *obj) {
        NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
        UserChildrenInfo *infoModel=[[UserChildrenInfo alloc]initWithDic:dic];
        [self->agreeArr addObject:infoModel];
        self.model.clickLikeTotal = [NSString stringWithFormat:@"%d",[self.model.clickLikeTotal intValue]+1];
        self.model.hasClickLike = @"1";
        [self->_agreeView setData:self->agreeArr totalNum:stringFormatString(self.model.clickLikeTotal) hasClickLike:self.model.hasClickLike];
        [self.delegate disPlayActivtCollect:self.model indexPath:self.indexPath];
        [self->_bottomView setDataWithActivModel:self.model];
        [self addSucessView:@"点赞成功!" type:1];
        
    }];
    
}

-(void)headWeak:(UserChildrenInfo *)mod{
    NSLog(@"点击头像");
    [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.user_id intValue]success:^(NSDictionary *obj) {
        
        MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.user_id :NO dic:obj[@"content"]];
        controller.userMod=mod;
        controller.dic=obj[@"content"];
        [self pushViewController:controller];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)collectActivties:(UIButton *)button
{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (_collectBtn.selected) {
        [self addSucessView:@"已收藏" type:2];
        return;
    }
    
    __weak ActivityDetailViewController *weakSelf = self;
    [network collectActivties:self.model.activities_id success:^(NSDictionary *obj) {
        [weakSelf addSucessView:@"你成功喜欢" type:1];
        self.model.collectionTotal = [NSString stringWithFormat:@"%d",[self.model.collectionTotal intValue] + 1];
        self.model.hasCollection = @"1";
        self->_collectBtn.selected = YES;
        [self.delegate disPlayActivtCollect:self.model indexPath:self.indexPath];
    }];
}

- (void)shareActivt{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    if ([IHUtility overtime:self.model.curtime inputDate:self.model.activities_expiretime]) {
        [self addSucessView:@"该活动已过期" type:2];
    }else {
        
        [self shareView:ENT_Activties object:self.model vc:self];
    }
}
//获取点赞用户的信息
-(void)getAgreeHeadNetWork:(NSInteger)index{
    UserChildrenInfo *mod=[agreeArr objectAtIndex:index];
    [self headWeak:mod];
    
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    [network getActivtiesCommentList:page maxResults:10 activities_id:self.model.activities_id success:^(NSDictionary *obj) {
        if (refreshView==self->commTableView.table.mj_header) {
            [self->dataArray removeAllObjects];
            self->page=0;
        }
        NSArray *arr=obj[@"content"];
        if (arr.count>0) {
            self->page++;
            if (arr.count<pageNum) {
                [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        
        [self->dataArray addObjectsFromArray:arr];
        [self->commTableView.table reloadData];
        [self endRefresh];
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat f;
    CommentListModel *model=[dataArray objectAtIndex:indexPath.row];
    f=[model.cellHeigh floatValue];
    
    return f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_activOrderView cancleOrder];
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    CommentListModel *mod1=[dataArray objectAtIndex:indexPath.row];
    _selIndexPath=indexPath;
    if ([mod1.userChildrenInfo.user_id isEqualToString:USERMODEL.userID]) {
        HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"删除", nil];
        sheet.tag=22; //删除
        [sheet show];
    }else {
        [_pltxt becomeFirstResponder];
        [_keyBoardView.txtView becomeFirstResponder];
        self.isReply=YES;
        if (_keyBoardView.txtView.text.length==0) {
            _keyBoardView.txtView.placeholder=[NSString stringWithFormat:@"回复%@",mod1.userChildrenInfo.nickname];
        }else{
            _keyBoardView.txtView.placeholder=@"";
        }
    }
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
        UserChildrenInfo *mod = (UserChildrenInfo *)attribute;
        [self headWeak:mod];
    }
}
//评论活动
-(void)createComment:(NSString *)content{
    
    
    int commentType=0;
    int replyComment_id=0;
    int replyUserID=0;
    NSString *replyUserName;
    if (self.isReply) {
        commentType=1;
        CommentListModel *mod=[dataArray objectAtIndex:_selIndexPath.row];
        replyComment_id =mod.comment_id;
        replyUserID=[mod.userChildrenInfo.user_id intValue];
        replyUserName=mod.userChildrenInfo.nickname;
    }else{
        replyUserID=[self.model.userChildrenInfo.user_id intValue];
        replyUserName=self.model.userChildrenInfo.nickname;
    }
    __weak typeof(self) weakSelf = self;
    
    [self addWaitingView];
    
    [network getAddActivtiesComment:[self.model.activities_id intValue] user_id:[USERMODEL.userID intValue] reply_user_id:replyUserID reply_nickname:replyUserName activities_comment:content comment_type:commentType reply_activities_comment_id:replyComment_id success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSDictionary *dic=[obj objectForKey:@"content"];
        NSDictionary *commentDic=[dic objectForKey:@"commentInfo"];
        [weakSelf addComment:commentDic];
    }];
}

-(void)addComment:(NSDictionary *)commentDic{
    CommentListModel *mod=[[CommentListModel alloc]initWithDictionary:commentDic error:nil];
    CGSize size=[IHUtility GetSizeByText:mod.comment_cotent sizeOfFont:15 width:WindowWith-75];
    mod.cellHeigh=[NSNumber numberWithFloat:48+size.height];
    [dataArray insertObject:mod atIndex:0];
    self.model.commentTotal = stringFormatInt([self.model.commentTotal intValue] + 1);
    [_commentListBtn setTitle:stringFormatString(self.model.commentTotal) forState:UIControlStateNormal];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [commTableView.table insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self addSucessView:@"评论成功" type:1];
    _keyBoardView.txtView.text=@"";
}

- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        CommentListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
        [self addWaitingView];
        [network getDeleteActivtiesCommentID:mod1.comment_id userID:USERMODEL.userID success:^(NSDictionary *obj) {
            //[self addSucessView:@"删除成功!" type:1];
            [self removeWaitingView];
            [self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
            [self->commTableView.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:self->_selIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            self.model.commentTotal = stringFormatInt([self.model.commentTotal intValue] -1);
            [self->_commentListBtn setTitle:stringFormatString(self.model.commentTotal) forState:UIControlStateNormal];
        }];
    }
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}
//拨打电话
-(void)getPhoneweak{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    NSString *phoneString = [NSString stringWithFormat:@"tel:%@",KTelNum];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
    [self.view addSubview:callWebview];
}
//根据活动地址经纬度在地图上进行标注定位
- (void)getaddressTomap:(UITapGestureRecognizer *)tap
{
    UIView *label = (UIView *)tap.view;
    ActivtiesMapViewController *ActivtiesMapVC = [[ActivtiesMapViewController alloc] init];
    CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake([[NSString stringWithFormat:@"%@",self.model.activities_address_lat] doubleValue],[[NSString stringWithFormat:@"%@",self.model.activities_address_lon] doubleValue]);
    
    ActivtiesMapVC.coordinate = coordinate;
    ActivtiesMapVC.name = self.model.activities_address;
    [self pushViewController:ActivtiesMapVC];
    
    label.backgroundColor = [UIColor whiteColor];
}
//活动详情信息记载完成之后 调整试图布局
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    NSLog(@"++++%f,%@",webView.scrollView.contentSize.height,clientheight_str);
    
    _activityDetailView.contentLabel.height = [clientheight_str floatValue];
    if (_activityDetailView.contentLabel.height <= 0) {
        _activityDetailView.height = 0 ;
    }else {
        _activityDetailView.height = _activityDetailView.contentLabel.height + 60;
    }
    [_activityDetailView setcontentText:_activityDetailView.height];
    [self reSetFrame];
    [self removePushViewWaitingView];
}

- (void)reSetFrame
{
    _agreeView.top = _activityDetailView.bottom + 5;
    _downView.top = _agreeView.bottom + 5;
    _topView.frame = CGRectMake(0, 0, WindowWith,_downView.bottom);
    commTableView.table.tableHeaderView = _topView;
}

//点击活动详情中的链接
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlstr = [request.URL absoluteString];
    if ( [urlstr hasPrefix:@"http://"] || [urlstr hasPrefix:@"https://"] || [urlstr hasPrefix:@"www."]|| [urlstr hasPrefix:@".com"]|| [urlstr hasPrefix:@".cn"]) {
        [self webViewUrl:[NSURL URLWithString:urlstr]];
        return NO;
    };
    return YES;
}


@end
