//
//  MTMyChlidSupplyAndBuyListViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/14.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTMyChlidSupplyAndBuyListViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "GongQiuDetailsViewController.h"
#import "MTTopicDetailsViewController.h"
#import "MTNewSupplyAndBuyDetailsViewController.h"
@interface MTMyChlidSupplyAndBuyListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    NSIndexPath *_selIndexPath;
    EmptyPromptView *_EPView;
}

@end

@implementation MTMyChlidSupplyAndBuyListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight-40) tableviewStyle:UITableViewStylePlain];
    
    if (self.type==ENT_Buy) {
        commTableView.type=ENT_qiugou;
    }else if (self.type==ENT_Supply){
        commTableView.type=ENT_gongying;
    }
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    if (self.type==ENT_Supply||self.type==ENT_Buy) {
         [commTableView setupData:dataArray index:12];
    }else if (self.type==ENT_Topic){
         [commTableView setupData:dataArray index:13];
    }
    
    
   
 
    [self.view addSubview:commTableView];
    __weak MTMyChlidSupplyAndBuyListViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
        
    }];
    [self beginRefesh:ENT_RefreshHeader];
   [self setbackTopFrame:backBtnY];
    
    NSString *str;
    if (self.type==ENT_Supply) {
        str = @"您还没有收藏供应信息哦~";
    }else if (self.type==ENT_Buy){

        str = @"您还没有收藏求购信息哦~";
    }else if (self.type==ENT_Topic){
        str = @"您还没有收藏话题哦~";
    }

    EmptyPromptView *view  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:str];
    view.hidden = YES;
    _EPView = view;
    [commTableView.table addSubview:view];
    // Do any additional setup after loading the view.
}

-(void)loadRefesh:(MJRefreshComponent*)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    int tag;
    if (self.type==ENT_Supply) {
        tag=1;
    }else if (self.type==ENT_Buy){
        tag=3;
    }else if (self.type==ENT_Topic){
        tag=2;
    }
    
    
    [network getCollectionTypeList:tag user_id:USERMODEL.userID  num:pageNum page:page success:^(NSDictionary *obj) {
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
            return ;
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

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    _selIndexPath=indexPath;
    
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
        if (self.type==ENT_Supply||self.type==ENT_Buy) {
            MTSupplyAndBuyListModel *mod=(MTSupplyAndBuyListModel *)attribute;
            [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.userChildrenInfo.user_id intValue]success:^(NSDictionary *obj) {
                NSLog(@"%@",obj);
                
                
                MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.userChildrenInfo.user_id :NO dic:obj[@"content"]];
                controller.userMod=mod.userChildrenInfo;
                
                controller.dic=obj[@"content"];
                [self.inviteParentController pushViewController:controller];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
            
        }else if (self.type==ENT_Topic){
            MTTopicListModel *mod=(MTTopicListModel*)attribute;
            [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.userChildrenInfo.user_id intValue]success:^(NSDictionary *obj) {
                
                MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.userChildrenInfo.user_id :NO dic:obj[@"content"]];
                controller.userMod=mod.userChildrenInfo;
                controller.dic=obj[@"content"];
                [self pushViewController:controller];
            } failure:^(NSDictionary *obj2) {
                
            }];
            
            
        }
        
        
        
    }else if (action==MTcancelFavriteBuyActionTableViewCell ||action==MTcancelFavriteSupplyActionTableViewCell){
        
        MTSupplyAndBuyListModel *mod=(MTSupplyAndBuyListModel*)attribute;
        
        if (action==MTcancelFavriteSupplyActionTableViewCell) {
            [network getUnselCollectionMyType:1 user_id:USERMODEL.userID business_id:mod.supply_id  success:^(NSDictionary *obj) {
                
                
                [dataArray removeObjectAtIndex:indexPath.row];
                [commTableView.table reloadData];
                [self addSucessView:@"取消收藏成功!" type:1];
            }];
        }
        else if (action==MTcancelFavriteBuyActionTableViewCell){
            [network getUnselCollectionMyType:3 user_id:USERMODEL.userID business_id:mod.want_buy_id  success:^(NSDictionary *obj) {
                
                [dataArray removeObjectAtIndex:indexPath.row];
                [commTableView.table reloadData];
                [self addSucessView:@"取消收藏成功!" type:1];
            }];
        }
    }else if (action==MTcancelFavriteTopicActionTableViewCell){
        MTTopicListModel *mod=(MTTopicListModel*)attribute;
        [network getUnselCollectionMyType:2 user_id:USERMODEL.userID business_id:mod.topic_id  success:^(NSDictionary *obj) {
            [self addSucessView:@"取消收藏成功!" type:1];
            [dataArray removeObjectAtIndex:indexPath.row];
            [commTableView.table reloadData];
        }];
        
    }
    
}

#pragma mark tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type==ENT_Supply||self.type==ENT_Buy) {
        MyCollectionSupplyAndBuyModel *model=[dataArray objectAtIndex:indexPath.row];
        
        return [model.supplyBuyInfo.cellHeigh floatValue];
    }else if (self.type==ENT_Topic){
        MyCollectionTopicModel *model=[dataArray objectAtIndex:indexPath.row];
        
        return [model.topicInfo.cellHeigh floatValue];
    }
    
    
    return 10;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{   NSLog(@"cell选中");
    if (self.type==ENT_Supply||self.type==ENT_Buy) {
        
        MyCollectionSupplyAndBuyModel *mod=[dataArray objectAtIndex:indexPath.row];
        MTNewSupplyAndBuyDetailsViewController *vc=[[MTNewSupplyAndBuyDetailsViewController alloc]init];
        
        vc.type=self.type;
        
        if (self.type == ENT_Supply) {
            vc.newsId=mod.supplyBuyInfo.supply_id;
        }else if (self.type==ENT_Buy){
            vc.newsId=mod.supplyBuyInfo.want_buy_id;
        }
        
//        [self pushViewController:vc];
        [self.inviteParentController pushViewController:vc];
      
    }else if (self.type==ENT_Topic){
        
        MyCollectionTopicModel *mod=[dataArray objectAtIndex:indexPath.row];
        MTTopicDetailsViewController *vc=[[MTTopicDetailsViewController alloc]init];
        vc.model=mod.topicInfo;
        [self.inviteParentController pushViewController:vc];
        
    }
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
