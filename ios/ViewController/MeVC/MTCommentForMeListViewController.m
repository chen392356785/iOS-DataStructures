//
//  MTCommentForMeListViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTCommentForMeListViewController.h"
#import "MTNetworkData+ForModel.h"
#import "GongQiuDetailsViewController.h"
#import "MTTopicDetailsViewController.h"
#import "MTNewSupplyAndBuyDetailsViewController.h"
@interface MTCommentForMeListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    EmptyPromptView *_EPView;
}
@end

@implementation MTCommentForMeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"评论我的"];
    dataArray=[[NSMutableArray alloc]init];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
    topView.backgroundColor=cBgColor;
    
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView.table.tableHeaderView=topView;
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:7];
    [self.view addSubview:commTableView];
    
    __weak MTCommentForMeListViewController *weakSelf = self;
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshFooter];
    
    EmptyPromptView *view  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"还没有人评论呢~"];
    view.hidden = YES;
    _EPView = view;
    [commTableView.table addSubview:view];
    
    
    // Do any additional setup after loading the view.
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    [network getCommentMeList:USERMODEL.userID num:pageNum page:page success:^(NSDictionary *obj) {
        if (refreshView==commTableView.table.mj_header) {
            [dataArray removeAllObjects];
            page=0;
        }
        NSArray *arr=obj[@"content"];
        if (arr.count>0) {
            page++;
            if (arr.count<pageNum) {
                [commTableView.table.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            
            if (dataArray.count == 0) {
                
                _EPView.hidden = NO;
            }else{
                _EPView.hidden = YES;
            }
            [commTableView.table.mj_footer endRefreshingWithNoMoreData];
            [self endRefresh];
            return;
        }
        
        [dataArray addObjectsFromArray:arr];
        [commTableView.table reloadData];
        
        if (dataArray.count == 0) {
            
            _EPView.hidden = NO;
        }else{
            _EPView.hidden = YES;
        }
        [self endRefresh];
        
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
}

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    __weak MTCommentForMeListViewController *weakSelf= self;
    if (action==MTDetailActionTalbeViewCell) {
        MTCommentMeModel *mod=(MTCommentMeModel*)attribute;
        
        if (mod.comment_type==1) {
            
            
            MTNewSupplyAndBuyDetailsViewController *vc=[[MTNewSupplyAndBuyDetailsViewController alloc]init];
            vc.type=ENT_Supply;
            vc.newsId=stringFormatInt(mod.busness_id);
            [self pushViewController:vc];
            
            
            //            [network getSupplyDetailID:USERMODEL.userID supply_id:stringFormatInt(mod.busness_id)  success:^(NSDictionary *obj) {
            //                NSDictionary *dic=obj[@"content"];
            //                [weakSelf pushVC:dic type:1];
            //
            //            } failure:^(NSDictionary *obj2) {
            //
            //            }];
        }else if (mod.comment_type==3){
            
            MTNewSupplyAndBuyDetailsViewController *vc=[[MTNewSupplyAndBuyDetailsViewController alloc]init];
            vc.type=ENT_Buy;
            vc.newsId=stringFormatInt(mod.busness_id);
            [self pushViewController:vc];
            
            //            [network getBuyDetailID:USERMODEL.userID want_buy_id:stringFormatInt(mod.busness_id) success:^(NSDictionary *obj) {
            //                NSDictionary *dic=obj[@"content"];
            //                [weakSelf pushVC:dic type:2];
            //
            //            } failure:^(NSDictionary *obj2) {
            //
            //            }];
        }else if (mod.comment_type==2){
            [self addWaitingView];
            [network getTopicDetailID:USERMODEL.userID topic_id:stringFormatInt(mod.busness_id) success:^(NSDictionary *obj) {
                NSDictionary *dic=obj[@"content"];
                [weakSelf pushVC:dic type:3];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
        }
    }
}

-(void)pushVC:(NSDictionary *)dic type:(int)type{
    [self removeWaitingView];
    if (type==3) {
        
        MTTopicListModel *mod=[network getTopicModelForDic:dic];
        
        MTTopicDetailsViewController *vc=[[MTTopicDetailsViewController alloc]init];
        vc.model=mod;
        [self pushViewController:vc];
        
        
    }else{
        int type2;
        if (type==1) {
            type2=IH_QuerySupplyList;
        }else if (type==2){
            type2=IH_QueryBuyList;
        }
        
        MTSupplyAndBuyListModel *mod=[network getSupplyAndBuyForDic:dic type:type2];
        GongQiuDetailsViewController *vc=[[GongQiuDetailsViewController alloc]init];
        vc.model=mod;
        if (type==1) {
            vc.type=ENT_Supply;
        }else if (type==2){
            vc.type=ENT_Buy;
        }
        [self pushViewController:vc];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MTCommentMeModel *mod=[dataArray objectAtIndex:indexPath.row];
    
    return [mod.cellHeigh floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
