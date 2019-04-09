//
//  MTCollectionBuyTableViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "OtherUserChildSupplyAndBuyListVC.h"
//#import "MTOtherInfomationMainViewController.h"
#import "GongQiuDetailsViewController.h"
#import "MTTopicDetailsViewController.h"
#import "CreateBuyOrSupplyViewController.h"
#import "MTNewSupplyAndBuyDetailsViewController.h"
@interface OtherUserChildSupplyAndBuyListVC ()<UITableViewDelegate,GongQiuAgreeDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    EmptyPromptView *_EPView;
}
@end

@implementation OtherUserChildSupplyAndBuyListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[[NSMutableArray alloc]init];
    
    CGFloat tableViewHeigh=0;
    if ([self.userID isEqualToString:USERMODEL.userID]) {
        tableViewHeigh=WindowHeight+23+42;
        [self setbackTopFrame:WindowHeight];
    }else{
        tableViewHeigh=WindowHeight+23;
        [self setbackTopFrame:WindowHeight-40];
    }
    
    [self setbackTopFrame:backBtnY-30];
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, tableViewHeigh-20-40-TFXHomeHeight) tableviewStyle:UITableViewStylePlain];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
    topView.backgroundColor=cBgColor;
    
    commTableView.table.tableHeaderView=topView;
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    if (self.type==ENT_Buy) {
        commTableView.type=ENT_qiugou;
        [commTableView setupData:dataArray index:14];
    }else if(self.type==ENT_Supply)
    {    commTableView.type=ENT_gongying;
        
        [commTableView setupData:dataArray index:14];
        
    }else if (self.type==ENT_Topic){
        commTableView.isMe=self.isMe;
        commTableView.type=ENT_Preson;
        [commTableView setupData:dataArray index:15];
    }
    __weak OtherUserChildSupplyAndBuyListVC *weakSelf=self;
    
    [self.view addSubview:commTableView];
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefresh:refreshView];
        
    }];
    [self beginRefesh:ENT_RefreshFooter];
    
    NSString *str;
    if (self.type==ENT_Buy) {
        
        str = @"还没发布过求购哦~";
        
    }else if (self.type == ENT_Supply)
    {
        str = @"还没发布过供应哦~";
        
    }else if (self.type == ENT_Topic){
        
        str = @"还没发布过话题哦~";
    }
    
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:str];
    EPView.hidden = YES;
    _EPView = EPView;
    [commTableView.table addSubview:EPView];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)loadRefresh:(MJRefreshComponent *)refreshView{
    if (self.type==ENT_Supply) {
        [network getSupplyList:page maxResults:pageNum my_user_id:[self.userID intValue] seedling_source_address:@"" varieties:@""  success:^(NSDictionary *obj) {
            
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
                [self endRefresh];
                
                if (self->dataArray.count == 0) {
                    
                    self->_EPView.hidden = NO;
                }else{
                    self->_EPView.hidden = YES;
                }
                return ;
            }
            
            [self->dataArray addObjectsFromArray:arr];
            [self->commTableView.table reloadData];
            [self endRefresh];
            
            if (self->dataArray.count == 0) {
                
                self->_EPView.hidden = NO;
            }else{
                self->_EPView.hidden = YES;
            }
            
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
        }];
        
    }else if(self.type==ENT_Buy){
        
        [network getBuyList:page maxResults:pageNum my_user_id:[self.userID intValue] mining_area:@"" varieties:@"" success:^(NSDictionary *obj) {
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
                [self endRefresh];
                
                if (self->dataArray.count == 0) {
                    
                    self->_EPView.hidden = NO;
                }else{
                    self->_EPView.hidden = YES;
                }
                return ;
            }
            
            [self->dataArray addObjectsFromArray:arr];
            [self->commTableView.table reloadData];
            
            if (self->dataArray.count == 0) {
                
                self->_EPView.hidden = NO;
            }else{
                self->_EPView.hidden = YES;
            }
            [self endRefresh];
            
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
        }];
        
    }else if (self.type==ENT_Topic){
        
        
        [network getTopicList:page maxResults:pageNum userID:[self.userID intValue]  isHot:0 my_user_id:[self.userID intValue] theme_id:0 success:^(NSDictionary *obj) {
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
                [self endRefresh];
                if (self->dataArray.count == 0) {
                    
                    self->_EPView.hidden = NO;
                }else{
                    self->_EPView.hidden = YES;
                }
                return;
            }
            
            [self->dataArray addObjectsFromArray:arr];
            [self->commTableView.table reloadData];
            
            if (self->dataArray.count == 0) {
                
                self->_EPView.hidden = NO;
            }else{
                self->_EPView.hidden = YES;
            }
            [self endRefresh];
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
        }];
    }
}

-(UIScrollView *)streachScrollView
{
    return commTableView.table;
}

-(void)edit:(MTSupplyAndBuyListModel *)model type:(buyType)type indexPath:(NSIndexPath *)indexPath{
    CreateBuyOrSupplyViewController *v=[[CreateBuyOrSupplyViewController alloc]init];
    v.selectEditBlock=^(MTSupplyAndBuyListModel *Model){
        NSLog(@"%ld",(long)indexPath.row);
        [self->dataArray removeObjectAtIndex:indexPath.row];
        [self->dataArray insertObject:Model atIndex:indexPath.row];
        [self->commTableView.table beginUpdates];
        [self->commTableView.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        [self->commTableView.table endUpdates];
    };
    v.ifEdit=YES;
    v.type=type;
    v.model=model;
    [self presentViewController:v];
}

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    _selIndexPath=indexPath;
    __weak OtherUserChildSupplyAndBuyListVC *weakSelf=self;
    if (action==MTShareActionTableViewCell) {  //分享
        
        [self shareView:self.type object:attribute vc:self];
        
    }else if (action==MTCommentActionTableViewCell){ //评论
        [self selectIndexPath:indexPath];
    }else if (action==MTEditActionTableViewCell){
        
    }else if (action==MTDeleteActionTableViewCell){
        if (self.type==ENT_Supply) {
            
            [IHUtility AlertMessage:@"" message:@"确定删除该供应信息？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:12];
            
            
        }else if (self.type==ENT_Buy){
            
            [IHUtility AlertMessage:@"" message:@"确定删除该求购信息？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:13];
            
            
        }else if (self.type==ENT_Topic){
            
            [IHUtility AlertMessage:@"" message:@"确定删除该条话题信息？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:14];
        }
        
    } if (action==MTFavriteActionTableViewCell) {
        NSLog(@"收藏");
        
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        if (self.type==ENT_Supply) {
            MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
            [network getSupplyCollections:[model.supply_id intValue]user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
                MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                
                mod.hasCollection=YES;
                mod.collectionTotal=mod.collectionTotal+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
                [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [IHUtility addSucessView:@"收藏成功" type:1];
            }];
        }else if (self.type==ENT_Buy)
        {
            MTSupplyAndBuyListModel *model=[self->dataArray objectAtIndex:indexPath.row];
            [network getBuyCollections:[model.want_buy_id intValue] user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
                MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                
                mod.hasCollection=YES;
                mod.collectionTotal=mod.collectionTotal+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
                [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [IHUtility addSucessView:@"收藏成功" type:1];
            }];
        }
        
    }else if (action==MTAgreeActionTableViewCell) {
        NSLog(@"点赞");
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        if (self.type==ENT_Supply) {
            MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
            [network getAddSupplyClickLike:[USERMODEL.userID intValue]supply_id:[model.supply_id intValue] type:0 success:^(NSDictionary *obj) {
                
                MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                int num=mod.clickLikeTotal;
                mod.hasClickLike=YES;
                mod.clickLikeTotal=num+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
                [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [IHUtility addSucessView:@"点赞成功!" type:1];
            }];
        }else if (self.type==ENT_Buy)
        {
            MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
            [network getAddWantBuyClickLike:[USERMODEL.userID intValue]want_buy_id:[model.want_buy_id intValue] type:0 success:^(NSDictionary *obj) {
                MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                
                mod.hasClickLike=YES;
                mod.clickLikeTotal=mod.clickLikeTotal+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
                [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [IHUtility addSucessView:@"点赞成功!" type:1];
            }];
        }else if (self.type==ENT_Topic){
            
            MTTopicListModel *mod= (MTTopicListModel*)attribute;
            [network getTopicAddLike:USERMODEL.userID topic_id:mod.topic_id success:^(NSDictionary *obj) {
                
                MTTopicListModel *mod2=[self->dataArray objectAtIndex:indexPath.row];
                int num=mod2.clickLikeTotal;
                mod2.hasClickLike=YES;
                mod2.clickLikeTotal=num+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
                [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [IHUtility addSucessView:@"点赞成功!" type:1];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
        }
        
    }else if (action==MTcancelAgreeActionTableViewCell){
        
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        if (self.type==ENT_Supply) {
            MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
            [network getAddSupplyClickLike:[USERMODEL.userID intValue]supply_id:[model.supply_id intValue] type:1 success:^(NSDictionary *obj) {
                
                MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                int num=mod.clickLikeTotal;
                mod.hasClickLike=NO;
                mod.clickLikeTotal=num-1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
                [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [IHUtility addSucessView:@"取消点赞成功!" type:1];
            }];
        }else if (self.type==ENT_Buy)
        {
            MTSupplyAndBuyListModel *model=[self->dataArray objectAtIndex:indexPath.row];
            [network getAddWantBuyClickLike:[USERMODEL.userID intValue]want_buy_id:[model.want_buy_id intValue] type:1 success:^(NSDictionary *obj) {
                MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                
                mod.hasClickLike=NO;
                mod.clickLikeTotal=mod.clickLikeTotal-1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
                [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [IHUtility addSucessView:@"取消点赞成功!" type:1];
            }];
        }else if (self.type==ENT_Topic){
            
            [IHUtility addSucessView:@"您已点赞" type:2];
            //            MTTopicListModel *mod= (MTTopicListModel*)attribute;
            //            [network getTopicAddLike:USERMODEL.userID topic_id:mod.topic_id success:^(NSDictionary *obj) {
            //
            //                MTTopicListModel *mod2=[dataArray objectAtIndex:indexPath.row];
            //                int num=mod2.clickLikeTotal;
            //                mod2.hasClickLike=YES;
            //                mod2.clickLikeTotal=num+1;
            //                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
            //                [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
            //                [IHUtility addSucessView:@"点赞成功!" type:1];
            //
            //            } failure:^(NSDictionary *obj2) {
            //
            //            }];
        }
    }
    else if (action==MTEditActionTableViewCell){
        MTSupplyAndBuyListModel *model=dataArray[indexPath.row];
        if (self.type==ENT_Supply) {
            [weakSelf edit:model type:ENT_Supply indexPath:indexPath];
            
        }else if (self.type==ENT_Buy){
            [weakSelf edit:model type:ENT_Buy indexPath:indexPath];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag==12) {
        
        if (buttonIndex==0) {
            [self addWaitingView];
            MTSupplyAndBuyListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
            [network getDeleteSupply:[mod1.supply_id intValue] success:^(NSDictionary *obj) {
                self.selectBtnBlock(deleteSupplyBlock);
                [IHUtility addSucessView:@"删除成功!" type:1];
                [self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
                [self->commTableView.table reloadData];
            }];
        }
        
        
    }else if (alertView.tag==13){
        
        if (buttonIndex==0) {
            MTSupplyAndBuyListModel *mod1=[dataArray objectAtIndex:self->_selIndexPath.row];
            [network getDeleteBuy:[mod1.want_buy_id intValue] success:^(NSDictionary *obj) {
                self.selectBtnBlock(deleteBuyBlock);
                [IHUtility addSucessView:@"删除成功!" type:1];
                [self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
                [self->commTableView.table reloadData];
            }];
        }
        
    }else if (alertView.tag==14){
        if (buttonIndex==0) {
            MTTopicListModel *mod1=[dataArray objectAtIndex:self->_selIndexPath.row];
            [network getDeleteTopic:[mod1.topic_id intValue] success:^(NSDictionary *obj) {
                self.selectBtnBlock(deleteTopicBlock);
                [IHUtility addSucessView:@"删除成功!" type:1];
                [self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
                [self->commTableView.table reloadData];
            }];
        }
        
    }
}

#pragma mark tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type==ENT_Supply ||self.type==ENT_Buy) {
        MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
        
        return [model.cellHeigh floatValue]-60;
    }else if (self.type==ENT_Topic){
        
        MTTopicListModel *model=[dataArray objectAtIndex:indexPath.row];
        return [model.cellHeigh floatValue]-50;
    }
    return 10;
}

#pragma mark GongQiuDeleteDelgate
-(void)GongQiuDeleteTableViewCell:(MTSupplyAndBuyListModel *)model indexPath:(NSIndexPath *)indexPath integer:(NSInteger)integer {
    
    [self->dataArray removeObjectAtIndex:_selIndexPath.row];
    [self->commTableView.table reloadData];
}

-(void)selectIndexPath:(NSIndexPath *)indexPath{
    if (self.type==ENT_Supply ||self.type==ENT_Buy) {
        MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
        MTNewSupplyAndBuyDetailsViewController *vc=[[MTNewSupplyAndBuyDetailsViewController alloc]init];
        vc.type=self.type;
        if (model.supply_id) {
            vc.newsId=model.supply_id;
        }else{
            vc.newsId=model.want_buy_id;
        }
        
        [self pushViewController:vc];
    }else if (self.type==ENT_Topic){
        MTTopicListModel *model=[dataArray objectAtIndex:indexPath.row];
        MTTopicDetailsViewController *vc=[[MTTopicDetailsViewController alloc]init];
        vc.model=model;
        [self pushViewController:vc];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{   NSLog(@"cell选中");
    _selIndexPath=indexPath;
    [self selectIndexPath:indexPath];
}

@end
