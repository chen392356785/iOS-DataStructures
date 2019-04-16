//
//  EPCloudDetailViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 5/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "EPCloudDetailViewController.h"
#import "EPCloudCommentListViewController.h"
#import "GongQiuDetailsViewController.h"
#import "EPCloudFeedbackViewController.h"
#import "AdView.h"
#import "MTNewSupplyAndBuyDetailsViewController.h"
#import "YLWebViewController.h"
#import "CustomView+CustomCategory2.h"

@interface EPCloudDetailViewController ()<UITableViewDelegate,EPCloudCommentNumDelegate> {
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
//    NSIndexPath *_indexPath;
    EPCloudDetailTopView *_topDetaiView;
    UIView *_topView;
    UIView *_downView;
    SMLabel *_numberLbl;
//    UIView *_lineView;
    NSMutableArray *imageArr;
//    AdView *_imagev;
}
@end

@implementation EPCloudDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self setNavBarItem:NO];
//    searchBtn.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem:NO];
    searchBtn.hidden = YES;
    self.navigationItem.rightBarButtonItems = nil;
    UIBarButtonItem *barMoreBtn=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = barMoreBtn;
    
    page=0;
    [self setTitle:@"企业详情"];
    
    [self creatTableView];
//     [self setbackTopFrame:backBtnY-60];
}
-(void)creatTableView
{
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight - 49) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    imageArr = [[NSMutableArray alloc] init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:28];
    commTableView.backgroundColor = cLineColor;
    
    __weak EPCloudDetailViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshFooter];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 200)];
    _topView = topView;
    topView.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *Arr = [NSMutableArray array];
    
    for (MTPhotosModel *mod in self.model.imageArr) {
        [Arr addObject:mod.imgUrl];
    }
    
    for (NSString *str in Arr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:str forKey:@"activities_pic"];
        [imageArr addObject:dic] ;
    }
    
    AdView *v=[AdView adScrollViewWithFrame:CGRectMake(0, 0, WindowWith, WindowWith*0.47) imageLinkURL:imageArr placeHoderImageName:@"defaulLogo.png" pageControlShowStyle:UIPageControlShowStyleRight];
    v.isNeedCycleRoll = NO;
//    _imagev=v;
    v.callBack=^(NSInteger index,NSDictionary * dic){
//        [weakSelf weakPushWebVC:dic];
    };
    
    [topView addSubview:v];
    
    EPCloudDetailTopView *topDetaiView = [[EPCloudDetailTopView alloc] initWithFrame:CGRectMake(0, WindowWith*0.47, WindowWith, 525)];
    _topDetaiView = topDetaiView;
    [topDetaiView setDetail:self.model];
    topDetaiView.selectBlock = ^(NSInteger index){
        if (index == commentBlock) {
            //评论列表
            EPCloudCommentListViewController *vc = [[EPCloudCommentListViewController alloc] init];
            vc.model = weakSelf.model;
            vc.delegate = weakSelf;
            [weakSelf pushViewController:vc];
        }else if (index == SelectCompanyWebBlock){
            NSString *url = weakSelf.model.website;
            if([weakSelf.model.website rangeOfString:@"http://"].location ==NSNotFound||[weakSelf.model.website rangeOfString:@"https://"].location ==NSNotFound)//_roaldSearchText
            {
                url = [NSString stringWithFormat:@"http://%@",url];
            }
            [weakSelf webViewUrl:[NSURL URLWithString:weakSelf.model.website]];
            
        }else if (index == SelectTelphoneBlock){
            [weakSelf getPhoneweak];
            
        }else {
            [weakSelf addTopview];
        }
    };
    [topView addSubview:topDetaiView];

    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, topDetaiView.bottom, WindowWith, 37)];
    downView.backgroundColor=[UIColor whiteColor];
    _downView = downView;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, WindowWith- 24, 1)];
    lineView.backgroundColor = cLineColor;
    [downView addSubview:lineView];
    
    CGSize size=[IHUtility GetSizeByText:@"企业动态" sizeOfFont:15 width:100];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20,lineView.bottom, size.width, 36) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(15)];
    lbl.text=@"企业动态";
    [downView addSubview:lbl];
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%d",(int)self.model.comment_num] sizeOfFont:15 width:100];
    SMLabel *numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+5, lbl.top, size.width, 36) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(15)];
    numberLbl.text=@"";
    _numberLbl = numberLbl;
    [downView addSubview:numberLbl];
    [topView addSubview:downView];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, 36, numberLbl.right - lbl.left, 2)];
    lineView2.backgroundColor=RGBA(85, 201, 196, 1);
//    _lineView = lineView2;
    [downView addSubview:lineView2];
    [topView addSubview:downView];
    
    _topView.height = _downView.bottom;

    commTableView.table.tableHeaderView=topView;
    

    NSArray *titlArr = @[@"反馈",@"查看评价",@"电话"];
    NSArray *imagesArr = @[@"feedback.png",@"hi.png",@"iconfont-lianxidianhua.png"];
    EPCloudListBottonView *bottomView = [[EPCloudListBottonView alloc] initWithFrame:CGRectMake(0, WindowHeight-KTabBarHeight, WindowWith, 49) btnTitle:titlArr images:imagesArr];
    bottomView.selectBlock = ^(NSInteger index){
        //加入企业云
        if (index == 200) {
            
            if (!USERMODEL.isLogin) {
                [weakSelf prsentToLoginViewController];
                return;
            }
            
            //反馈
            EPCloudFeedbackViewController *vc = [[EPCloudFeedbackViewController alloc]init];
            vc.model = weakSelf.model;
            [weakSelf pushViewController:vc];
            
        }else if(index == 201){

            //评论列表
            EPCloudCommentListViewController *vc = [[EPCloudCommentListViewController alloc] init];
            vc.model = weakSelf.model;
            vc.delegate = weakSelf;
            [weakSelf pushViewController:vc];
            
        }else if (index == 202){
            
            [weakSelf getPhoneweak];
        }
    };
    [self.view addSubview:bottomView];
    
    
}
- (void)addTopview
{
    _downView.top = _topDetaiView.bottom;
    _topView.height = _downView.bottom;
    commTableView.table.tableHeaderView=_topView;
}
-(void)webViewUrl:(NSURL *)url{
    YLWebViewController *controller=[[YLWebViewController alloc]init];
    controller.type=1;
    controller.mUrl=url;
    [self pushViewController:controller];
}
-(void)getPhoneweak{
    
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (![self.model.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",self.model.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
    
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    [network getCompanyTrackListWithCompanyID:(int)self.model.company_id page:page num:10 success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"];

        NSString *number = [NSString stringWithFormat:@"%@",obj[@"totalCount"]];
        CGSize size=[IHUtility GetSizeByText:number sizeOfFont:15 width:100];
        self->_numberLbl.text = number;
        self->_numberLbl.width = size.width;
        
        if (refreshView==self->commTableView.table.mj_header) {
            
            [self->dataArray removeAllObjects];
            self->page=0;
            if (arr.count==0) {
                [self->dataArray addObjectsFromArray:arr];
                [self->commTableView.table reloadData];
            }
            
            [self->commTableView.table.mj_footer resetNoMoreData];
        }
        
        if (arr.count>0) {
            self->page++;
            if (arr.count<pageNum) {
                [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            [self endRefresh];
            return;
        }
        
        [self->dataArray addObjectsFromArray:arr];
        [self->commTableView.table reloadData];
        [self endRefresh];
        
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyTrackModel *model = dataArray[indexPath.row];
 
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    
    
    MTNewSupplyAndBuyDetailsViewController *vc=[[MTNewSupplyAndBuyDetailsViewController alloc]init];
      if ([model.type isEqualToString:@"供应"]) {
        vc.type=ENT_Supply;
      }else if([model.type isEqualToString:@"求购"]) {
         vc.type=ENT_Buy;
      }
    vc.newsId = stringFormatInt(model.news_id);
    [self pushViewController:vc];
}

-(void)pushVC:(NSDictionary *)dic type:(int)type{
    [self removeWaitingView];

    int type2 = 0;
        if (type==1) {
            type2=IH_QuerySupplyList;
        }else if (type==2){
            type2=IH_QueryBuyList;
        }
        
        MTSupplyAndBuyListModel *mod=[network getSupplyAndBuyForDic:dic type:type2];
        MTNewSupplyAndBuyDetailsViewController *vc=[[MTNewSupplyAndBuyDetailsViewController alloc]init];
//        vc.model=mod;
    
        vc.userId = mod.userChildrenInfo.user_id;
    
        if (type==1) {
            vc.type=ENT_Supply;
            vc.newsId = mod.supply_id;
        }else if (type==2){
            vc.type=ENT_Buy;
            vc.newsId = mod.want_buy_id;
        }
    
    
        [self pushViewController:vc];
    
}


- (void)share
{
    NSString *title = [NSString stringWithFormat:@"【园林云】%@",self.model.company_name];
    
    NSString *content ;
    if (self.model.main_business.length > 0) {
        content = [NSString stringWithFormat:@"主营：%@",self.model.main_business];
    }else {
        

        content = [NSString stringWithFormat:@"%@园林云，易传播，易分享的园林行业专属名片。",KAppName];

    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%ld",shareURL,shareEPCloud,(long)self.model.company_id];
    if (self.model.imageArr.count > 0) {
        MTPhotosModel *mod  = self.model.imageArr[0];
        [self ShareUrl:self withTittle:title content:content withUrl:urlStr imgUrl:mod.imgUrl];
    }else {
        
        [self ShareUrl:self withTittle:title content:content withUrl:urlStr imgUrl:@""];
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    float y = commTableView.table.contentOffset.y;
//    if (y<0) {
//        _imagev.top = y;
//        _imagev.frame = CGRectMake(0, y, WindowWith, WindowWith*0.47+fabsf(y));
//        _imagev.adScrollView.height = WindowWith*0.47+fabsf(y);
//    }
//    
//}
- (void)disPalyCommentNum:(EPCloudListModel *)model
{
    [_topDetaiView setDetail:self.model];
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
