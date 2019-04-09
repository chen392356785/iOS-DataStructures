//
//  NewsViewController.m
//  MiaoTuProject
//
//  Created by XBL on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NewsTableListViewController.h"
//#import "YLWebViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "NewsDetailViewController.h"
#import "NewsImageDetailViewController.h"
#import "ActivtiesVoteViewController.h"
//#import "ActivityDetailViewController.h"
#import "CrowdFundingViewController.h"
#import "PayMentMangers.h"
#import "MTTopicListViewController.h"
#import "ActivityPaySuccessfulViewController.h"
#import "THNotificationCenter+C.h"
#import "ActivRegistrationViewController.h"
#import "ActivPaymentViewController.h"
//#import "PayMentMangers.h"
#import "ActivesCrowdFundController.h"

@interface NewsTableListViewController ()<UITableViewDelegate,NewsDataSourceDelegate,CrowdSuccesssDelegate,CCAppDelegate_C>
{
    MTBaseTableView * commTableView;
    NSIndexPath *_indexPath;

    int page;
}

@end
#define  bactTopWidth  42
@implementation NewsTableListViewController
@synthesize dataArray;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"资讯列表"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"资讯列表"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[THNotificationCenter singleton]addDeletegate:self];
    
    __weak NewsTableListViewController *weakSelf=self;
    
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight-40) tableviewStyle:UITableViewStylePlain];
    if (self.i==1) {
        commTableView.height=WindowHeight;
    }
    commTableView.table.delegate=self;
    commTableView.attribute=self;
    backTopbutton.frame=CGRectMake(WindowWith-55, WindowHeight-60-TFTabBarHeight, bactTopWidth, bactTopWidth);
    
    
    if (self.program_id == 19) {
        commTableView.actvType = @"1";
        [commTableView setupData:dataArray index:18];
    }else if (self.program_id == 18){
        [commTableView setupData:dataArray index:25];
    }else{
        [commTableView setupData:dataArray index:17];
    }
    [self.view addSubview:commTableView];
    
    //刷新加载
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    
    if (self.i==1) {
        [self beginRefresh];
        [self setTitle:self.titl];
    }
    
    page=0;
}


-(void)beginRefresh{
    [self beginRefesh:ENT_RefreshHeader];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

- (void)loadRefesh:(MJRefreshComponent *)refreshView
{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    THWeakSelf;
    [network getNewsList:page num:10 program_id:self.program_id user_id:[USERMODEL.userID intValue]success:^(NSDictionary *obj) {
        THStrongSelf;
        NSMutableArray *arr=obj[@"content"];
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
#pragma mark tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.program_id == 18) {
        return 0.48*WindowWith+80;
    }else if (self.program_id == 19){
        ActivitiesListModel *model = [dataArray objectAtIndex:indexPath.row];
        return [model.cellHeigh floatValue];
    }else{
        NewsListModel * model=dataArray[indexPath.row];
        return [model.cellHeigh integerValue];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [commTableView.table deselectRowAtIndexPath:indexPath animated:YES];
    if (self.program_id == 18) {
        ThemeListModel *model=[dataArray objectAtIndex:indexPath.row];
        [self didSelectThemList:model];
    }else if (self.program_id == 19) {
        ActivitiesListModel *model = dataArray[indexPath.row];
        [self didSelectActivityList:model indexPath:indexPath];
    }else{
        NewsListModel * model=dataArray[indexPath.row];
        [self didSelectNewsList:model indexPath:indexPath];
    }
}

- (void)didSelectNewsList:(NewsListModel *)model indexPath:(NSIndexPath *)indexPath{
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
        //  vc.model = mod;
        vc.indexPath = indexPath;
        vc.delegate = self;
        [self pushViewController:vc];
    }
}

- (void)didSelectActivityList:(ActivitiesListModel *)model indexPath:(NSIndexPath *)indexPath{
    
    if ([model.model isEqualToString:@"7"]){
        //投票活动
        ActivtiesVoteViewController *vc = [[ActivtiesVoteViewController alloc] init];
        vc.model = model;
        vc.indexPath = indexPath;
        [self pushViewController:vc];
    }else if ([model.model isEqualToString:@"8"]){
        
        //众筹活动  type 1为活动列表进入详情  2 为我的活动列表进入众筹页
        if ([self.type isEqualToString:@"1"]) {
            ActivesCrowdFundController *CFVc = [[ActivesCrowdFundController alloc] init];
            CFVc.model = model;
            CFVc.indexPath = indexPath;
            CFVc.type = self.type;
            [self pushViewController:CFVc];
            
/*V2.0.9前园林资讯进入活动详情
            ActivityDetailViewController *vc=[[ActivityDetailViewController alloc]init];
            vc.model = model;
            vc.indexPath = indexPath;
            vc.type = self.type;
            [self pushViewController:vc];
//*/
        }else {
            CrowdFundingViewController *vc = [[CrowdFundingViewController alloc] init];
            vc.crowdID = model.crowd_id;
            vc.Type = self.type;
            vc.delgate = self;
            vc.indexPath = indexPath;
            PayMentMangers *paymentManager = [[PayMentMangers alloc]init];
            vc.payBlock = ^(NSString *price, NSString *orderNo, NSString *type, NSString *subject,NSString*crowId, SMBaseViewController *vc) {
                [paymentManager payment:orderNo orderPrice:price type:type subject:subject crowID:crowId activitieID:model.activities_id parentVC:vc resultBlock:^(BOOL isPaySuccess, NSString *msg) {
                    if (isPaySuccess) {
                        [[THNotificationCenter singleton]notifiyCrowdSuccess:indexPath];
                    }
                }];
            };
            [self pushViewController:vc];
        }
    }else{
        ActivesCrowdFundController *vc=[[ActivesCrowdFundController alloc]init];
        vc.model = model;
        vc.indexPath = indexPath;
        vc.type = self.type;
        [self pushViewController:vc];
    }
}

- (void)didSelectThemList:(ThemeListModel *)model{
    MTTopicListViewController *vc=[[MTTopicListViewController alloc]init];
    vc.themeMod=model;
    vc.type=ENT_topic;
    vc.isHot=0;
    [self pushViewController:vc];
}

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    ActivitiesListModel *mod=[dataArray objectAtIndex:indexPath.row];
    
    if (action==MTActivityBMTableViewCell) {
        //点击立即报名
        ActivRegistrationViewController *activRegistrationVC = [[ActivRegistrationViewController alloc] init];
        activRegistrationVC.model = mod;
        activRegistrationVC.type = self.type;
        activRegistrationVC.indexPath = indexPath;
        [self pushViewController:activRegistrationVC];
        
    }else if (action == MTActivityBMZFTableViewCell){
        //点击立即支付
        [self payWith:mod indexPath:indexPath];
        
    }else if(action == MTActivityQXBMTableViewCell){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否取消报名该活动" message:@"" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        self.orderId = mod.a_order_id;
        _indexPath = indexPath;
        [alert show];
        
    }else if (action == MTActivityBMYZFTableViewCell){
        
        ActivityPaySuccessfulViewController *vc=[[ActivityPaySuccessfulViewController alloc]init];
        vc.model = mod;
        vc.indexPath = indexPath;
        [self pushViewController:vc];
    }else if (action == MTActivityShareActivTableViewCell){
        
        //活动列表分享
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        if ([IHUtility overtime:mod.curtime inputDate:mod.activities_expiretime]) {
            [self addSucessView:@"该活动已过期" type:2];
        }else {
            
            [self shareView:ENT_Activties object:mod vc:self];
        }
        
    }else if (action == MTActivityCollectBMTableViewCell){
        
        //活动收藏
        
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        [network getAddActivtiesClickLike:[USERMODEL.userID intValue] activities_id:[mod.activities_id intValue]  success:^(NSDictionary *obj) {
            mod.hasClickLike = @"1";
            mod.clickLikeTotal = [NSString stringWithFormat:@"%d",[mod.clickLikeTotal intValue] + 1];
            [self addSucessView:@"点赞成功" type:1];
            NSArray *indexArray=[NSArray arrayWithObject:indexPath];
            [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //取消活动报名
    if (buttonIndex == 0) {
		[network cancleActivtiesOrder:self.orderId success:^(NSDictionary *obj) {
			ActivitiesListModel *mod=[self->dataArray objectAtIndex:self->_indexPath.row];
			mod.order_status = @"3";
			NSArray *indexArray=[NSArray arrayWithObject:self->_indexPath];
			[self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
		}];
    }
}

- (void)payWith:(ActivitiesListModel *)model indexPath:(NSIndexPath *)indexPath{
    ActivPaymentViewController *paymentVC = [[ActivPaymentViewController alloc] init];
    paymentVC.model = model;
    paymentVC.indexPath = indexPath;
    paymentVC.orderType = self.type;
    
    PayMentMangers *paymentManager = [[PayMentMangers alloc]init];
    paymentVC.payBlock = ^(NSString *price, NSString *orderNo, NSString *type, NSString *subject, SMBaseViewController *vc) {
        [paymentManager payment:orderNo orderPrice:price type:type subject:subject activitieID:model.activities_id parentVC:vc resultBlock:^(BOOL isPaySuccess, NSString *msg) {
            if (isPaySuccess) {
                [self pushToPaySuccessfulVC:model indexPath:indexPath];
            }
        }];
    };
    [self pushViewController:paymentVC];
}

- (void)pushToPaySuccessfulVC:(ActivitiesListModel *)model indexPath:(NSIndexPath *)indexPath{
    ActivityPaySuccessfulViewController *vc=[[ActivityPaySuccessfulViewController alloc]init];
    vc.indexPath = indexPath;
    vc.model = model;
    [self pushViewController:vc];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:indexPath];
}

#pragma mark -- CCAppDelegate_C
- (void)onCrowdSuccess:(NSIndexPath *)indexPath{
    [self crowdSuccessIndexPath:indexPath];
}

#pragma mark -- CrowdSuccesssDelegate
- (void)crowdSuccessIndexPath:(NSIndexPath *)indexPath
{
    [self crowdSuccessIndexPath:indexPath];
}

-(void)crowdOnSuccessWith:(NSIndexPath *)indexPath{
    ActivitiesListModel *mod=[dataArray objectAtIndex:indexPath.row];
    if ([self.type isEqualToString:@"2"]) {
        mod.crowd_status = @"1";
        mod.obtain_money = mod.total_money;
    }
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

- (void)disPalyNewsCollect:(NewsListModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

- (void)dealloc{
    [[THNotificationCenter singleton]removeDeletegate:self];
}

@end
