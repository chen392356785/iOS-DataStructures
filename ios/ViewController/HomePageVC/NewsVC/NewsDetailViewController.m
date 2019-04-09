//
//  NewsDetailViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 24/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "InputKeyBoardView.h"
#import "MTOtherInfomationMainViewController.h"
#import "NewsImageDetailViewController.h"
#import "XHFriendlyLoadingView.h"
#import "showImageController.h"
#import "CustomView+CustomCategory2.h"

#define NewUrlStr @"http://baishi.baidu.com/watch/8005438397072094016.html?page=videoMultiNeed"
@interface NewsDetailViewController ()<UIWebViewDelegate,UITableViewDelegate,UITextFieldDelegate,HJCActionSheetDelegate>
{
    UIWebView *_webView ;
    MTBaseTableView *recomTableView;//推荐列表
    MTBaseTableView *commTableView;//评论列表
    int page;
    NSMutableArray *dataArray;
    NSMutableArray *newsArray;
    UITextField *_pltxt;
    InputKeyBoardView *_keyBoardView;
    UIView *_recommendView;
    UIView *_lineView;
    UIView *_downView;
    UIView *_topView;
    NSIndexPath *_selIndexPath;
    SMLabel *_numberLbl;
}
@property (strong,nonatomic) NSMutableArray *mUrlArray;
@property (strong,nonatomic) NSString *imageUrl;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray = [[NSMutableArray alloc] init];
    newsArray = [[NSMutableArray alloc] init];
    
    self.title = @"资讯详情";
    [self setTitle:@"资讯详情"];
    [self reloadWaitingView];
    
    if (self.infoModel.hasCollection == 1) {
        [self setNavBarItem:YES];
    }else {
        [self  setRightNavBarItem];  //设置右侧导航
        //        [self setNavBarItem:NO];
    }
    //    backTopbutton.bottom = WindowHeight-60;
    
    [self addObserverNotification];
}

#pragma mark  --通知
-(void)addObserverNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidBecomeHidden:) name:UIWindowDidBecomeHiddenNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //     [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}
-(void)windowDidBecomeHidden:(NSNotification *)noti {
    UIWindow * win = (UIWindow *)noti.object;
    if(win) {
        UIViewController *rootVC = win.rootViewController;
        NSArray<__kindof UIViewController *> *vcs = rootVC.childViewControllers;
        if([vcs.firstObject isKindOfClass:NSClassFromString(@"AVPlayerViewController")]) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        }
    }
}


- (void) setRightNavBarItem {
    UIImage *shareImg=Image(@"shareGreen.png");
    moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(0, 0, 40, 40);
    [moreBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:shareImg forState:UIControlStateNormal];
    moreBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);
    UIBarButtonItem *barMoreBtn=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    NSArray *rightBtns=[NSArray arrayWithObjects:barMoreBtn, nil];
    self.navigationItem.rightBarButtonItems=rightBtns;
}
#pragma mark网络断开 从新链接
-(void)reloadWaitingView{
    [self addPushViewWaitingView];
    [network getNewsDetail:stringFormatInt(self.infoModel.info_id) success:^(NSDictionary *obj) {
        NewDetailModel *mod = obj[@"content"];
        [self GreartTableView:mod];
        self->commTableView.alpha=0;
        [self removeWaitingView];
    } failure:^(NSDictionary *obj2) {
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}


- (void)GreartTableView:(NewDetailModel *)model
{
    // [self addWaitingView];
    __weak NewsDetailViewController *weakSelf = self;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _topView = topView;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    _webView.delegate = self;
    [_webView.scrollView setScrollEnabled:NO];
    NSString *header=@".video{line-height:2.2rem;}video{width:100%;height:calc(100vw*9/16);min-height:20rem;background-color:#000;} .video .info{padding:.5rem .8rem;} .video .info p strong { float:left;margin-right:1.4rem ;padding: 0 .5rem;border: .1rem solid #F60; border-radius: .2rem;font-size: 1rem;line-height: 2rem;color: #F60;text-decoration: none; font-size: 1.6rem;} img{max-width: 100%;} <meta name=‘viewport’ content=‘width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no’> ";
    _webView.allowsInlineMediaPlayback = YES;
    NSString *urlStr=[NSString stringWithFormat:@"<head><style>%@</style></head><body>%@</body>",header,model.html_content];
    //    urlStr = [_webView stringByEvaluatingJavaScriptFromString:urlStr];
    //    [_webView loadHTMLString:urlStr baseURL:nil];
    if ([self.infoModel.detail_url isEqualToString:@""] ) {
        [_webView loadHTMLString:urlStr baseURL:nil];
    }else {
        NSURL *url = [NSURL URLWithString:self.infoModel.detail_url];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
    _webView.backgroundColor = [UIColor whiteColor];
    [topView addSubview:_webView];
    
    UIView *recommendView = [[UIView alloc]initWithFrame:CGRectMake(0, _webView.bottom, kScreenWidth, 40)];
    recommendView.backgroundColor = [UIColor whiteColor];
    _recommendView = recommendView;
    
    SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, 5, recommendView.width - 30, 30) textColor:RGB(135, 134, 140) textFont:sysFont(15)];
    label.text = @"推荐你看";
    [recommendView addSubview:label];
    [topView addSubview:recommendView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 39.5 , kScreenWidth - 20, 0.5)];
    lineView1.backgroundColor = cLineColor;
    [recommendView addSubview:lineView1];
    
    [newsArray addObjectsFromArray:model.listModel];
    recomTableView = [[MTBaseTableView alloc]initWithFrame:CGRectMake(0, recommendView.bottom, WindowWith, 0.266*WindowWith*model.listModel.count) tableviewStyle:UITableViewStylePlain];
    recomTableView.attribute=self;
    [recomTableView setupData:newsArray index:26];
    recomTableView.table.delegate=self;
    recomTableView.backgroundColor  = [UIColor whiteColor];
    [topView addSubview:recomTableView];
    
    if (newsArray.count == 0) {
        recommendView.height = 0;
        recommendView.clipsToBounds = YES;
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, recomTableView.bottom , kScreenWidth, 5)];
    lineView.backgroundColor = cLineColor;
    _lineView = lineView;
    [topView addSubview:lineView];
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, lineView.bottom, WindowWith, 37)];
    downView.backgroundColor=[UIColor whiteColor];
    _downView = downView;
    
    UIImage *img = Image(@"comment_select.png");
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, img.size.width, img.size.height)];
    imageV.image = img;
    imageV.centerY = downView.height/2.0;
    [downView addSubview:imageV];
    CGSize size=[IHUtility GetSizeByText:@"所有评论" sizeOfFont:15 width:100];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageV.right + 6.5,0, size.width, 36) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(15)];
    lbl.text=@"所有评论";
    [downView addSubview:lbl];
    
    SMLabel *numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+5, lbl.top, size.width, 36) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(15)];
    numberLbl.text=stringFormatInt(self.infoModel.commentTotal);
    _numberLbl = numberLbl;
    [downView addSubview:numberLbl];
    [topView addSubview:downView];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight - 40) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.tableHeaderView=topView;
    [commTableView setupData:dataArray index:3];
    commTableView.table.delegate=self;
    [self.view addSubview:commTableView];
    
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshFooter];
    
    NewsBottomView *bottomView =[[NewsBottomView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - KtopHeitht - 40, WindowWith, 40)];
    bottomView.textfield.enabled = NO;
    [bottomView.Btn addTarget:self action:@selector(commentNews) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomView];
    
    UITapGestureRecognizer *commTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentNews)];
    commTap.numberOfTapsRequired= 1;
    commTap.numberOfTouchesRequired= 1;
    [bottomView addGestureRecognizer:commTap];
    
    UITextField *txt=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0)];
    _pltxt=txt;
    [self.view addSubview:txt];
    _keyBoardView=[[InputKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)  submit:^(NSString *str) {
        [weakSelf createComment:str];
    } back:^{
        [weakSelf resignKeyBoard];
    }];
    txt.inputAccessoryView =_keyBoardView;
    
}
-(void)becomeKeyBoard{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    self.isReply=NO;
    [_pltxt becomeFirstResponder];
    [_keyBoardView.txtView becomeFirstResponder];
}
-(void)resignKeyBoard{
    [_keyBoardView.txtView resignFirstResponder];
    [_pltxt resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
        //        replyUserID=[self.model.userChildrenInfo.user_id intValue];
        //        replyUserName=self.model.userChildrenInfo.nickname;
    }
    __weak typeof(self) weakSelf = self;
    
    [self addWaitingView];
    
    [network getAddNewsComment:self.infoModel.info_id user_id:[USERMODEL.userID intValue] reply_user_id:replyUserID reply_nickname:replyUserName info_comment:content comment_type:commentType reply_info_comment_id:replyComment_id success:^(NSDictionary *obj) {
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
    
    _numberLbl.text = [NSString stringWithFormat:@"%d",[_numberLbl.text intValue] + 1];
    self.infoModel.commentTotal = [_numberLbl.text intValue];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [commTableView.table insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self addSucessView:@"评论成功" type:1];
    _keyBoardView.txtView.text=@"";
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView
{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    [network getNewsCommentList:page maxResults:10 info_id:[NSString stringWithFormat:@"%ld",(long)self.infoModel.info_id] success:^(NSDictionary *obj) {
        
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
    [self removeWaitingView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    NSLog(@"++++%f,%@",webView.scrollView.contentSize.height,clientheight_str);
    
    //HTML5的高度
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    
    NSString *htmlWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
    //宽高比
    float i = [htmlWidth floatValue] / [htmlHeight floatValue];
    //webview控件的最终高度
    float height = iPhoneWidth / i;
    
    _webView.height = height;
    //    _webView.height = [webView sizeThatFits:CGSizeZero].height;
    
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    \
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return imgScr;\
    };";
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    _mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    
    
    [IHUtility ViewAnimateWith:commTableView];
    [self removePushViewWaitingView];
    [self reSetFrame];
    [self removeWaitingView];
    
}



-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        _imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        //获取当前图片的url在整个链接地址中位置
        NSInteger index = [_mUrlArray indexOfObject:_imageUrl];
        [self showBigImage:_mUrlArray atIndex:index];//创建视图并显示图片
        return NO;
    }
    return YES;
}

#pragma mark 显示大图片
- (void)showBigImage:(NSArray *)imageUrls atIndex:(NSInteger )index{
    NSMutableArray *marray = [[NSMutableArray alloc] init];
    for (NSString *obj in imageUrls) {
        if (![obj isEqualToString:@""]) {
            nurseryNewDetailListModel *model = [[nurseryNewDetailListModel alloc] init];
            model.showPic = obj;
            [marray addObject:model];
            NSLog(@"------ %@",obj);
        }
    }
    
    showImageController *showImagVc = [[showImageController alloc] initWithSourceArr:marray index:index];
    [self pushViewController:showImagVc];
    
}
- (void)commentNews
{
    [self becomeKeyBoard];
}

- (void)reSetFrame
{
    _recommendView.top = _webView.bottom;
    recomTableView.top = _recommendView.bottom;
    _lineView.top = recomTableView.bottom;
    _downView.top = _lineView.bottom;
    _topView.height = _downView.bottom;
    commTableView.table.tableHeaderView = _topView;
    commTableView.table.contentSize = CGSizeMake(0,_topView.height);
    [commTableView.table reloadData];
}

- (void)share
{
    NSString *imgUrl;
    if (self.infoModel.imgArray == nil||self.infoModel.imgArray.count== 0)
    {
        imgUrl = @"";
    }else {
        MTPhotosModel * photo=self.infoModel.imgArray[0];
        imgUrl = photo.imgUrl;
    }
    
    [self ShareUrl:self withTittle:self.infoModel.info_title content:self.infoModel.infomation_desc withUrl:[NSString stringWithFormat:@"%@&platform=wechat&appkey=%@",self.infoModel.infomation_url,APP_KEY] imgUrl:imgUrl];
}
- (void)collection
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    __weak NewsDetailViewController *weakSelf = self;
    [network collectNews:[NSString stringWithFormat:@"%d",self.infoModel.info_id] success:^(NSDictionary *obj) {
        [weakSelf addSucessView:@"你成功喜欢" type:1];
        self.infoModel.hasCollection = 1;
        [self setNavBarItem:YES];
        [self.delegate disPalyNewsCollect:self.infoModel indexPath:self.indexPath];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat f;
    if (tableView == recomTableView.table) {
        NewsListModel  *model=[newsArray objectAtIndex:indexPath.row];
        f = [model.cellHeigh floatValue];
    }else {
        CommentListModel *model =[dataArray objectAtIndex:indexPath.row];
        f=[model.cellHeigh floatValue];
    }
    return f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == commTableView.table){
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
    }else if (tableView == recomTableView.table){
        
        NewsListModel * model=newsArray[indexPath.row];
        
        if (model.img_type == 3) {
            [self addWaitingView];
            [network getImageNewsDetail:stringFormatInt(model.info_id) success:^(NSDictionary *obj) {
                [self removeWaitingView];
                
                NewsListModel *mod = obj[@"content"];
                NewsImageDetailViewController *vc = [[NewsImageDetailViewController alloc] init];
                vc.infoModel = mod;
                vc.indexPath = indexPath;
                vc.delegate = self;
                [self pushViewController:vc];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
            
        }else {
            
            NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
            vc.infoModel = model;
            //    vc.model = mod;
            vc.indexPath = indexPath;
            vc.delegate = self;
            [self pushViewController:vc];
            
            //            [network getNewsDetail:stringFormatInt(model.info_id) success:^(NSDictionary *obj) {
            //                NewDetailModel *mod = obj[@"content"];
            //
            //                [self removeWaitingView];
            //
            //
            //
            //            } failure:^(NSDictionary *obj2) {
            //
            //            }];
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

- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        CommentListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
        [self addWaitingView];
        [network getDeleteNewsCommentID:mod1.comment_id userID:USERMODEL.userID success:^(NSDictionary *obj) {
            [self addSucessView:@"删除成功!" type:1];
            [self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
            [self->commTableView.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:self->_selIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            self->_numberLbl.text = [NSString stringWithFormat:@"%d",[self->_numberLbl.text intValue] - 1];
            self.infoModel.commentTotal = [self->_numberLbl.text intValue];
        }];
    }
}
- (void)disPalyNewsCollect:(NewsListModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [recomTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

@end

