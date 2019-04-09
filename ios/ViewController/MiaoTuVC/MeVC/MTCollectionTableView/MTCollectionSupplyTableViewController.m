//
//  MTCollectionSupplyTableViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTCollectionSupplyTableViewController.h"
//#import "MTOtherInfomationMainViewController.h"
#import "GongQiuDetailsViewController.h"

@interface MTCollectionSupplyTableViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
}
@end


@implementation MTCollectionSupplyTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     dataArray=[[NSMutableArray alloc]init];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight+23) tableviewStyle:UITableViewStylePlain];
    commTableView.type=self.type;
    commTableView.personType=self.personType;
    commTableView.attribute=self;
    
    __weak MTCollectionSupplyTableViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        if (refreshView==self->commTableView.table.mj_header) {
            self->page=0;
        }
        [network getSupplyList:self->page maxResults:pageNum my_user_id:[USERMODEL.userID  intValue]seedling_source_address:@"" varieties:@""  success:^(NSDictionary *obj) {
            
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
                return ;
            }
            
            [self->dataArray addObjectsFromArray:arr];
            [self->commTableView.table reloadData];
            [weakSelf endRefresh];
            
        } failure:^(NSDictionary *obj2) {
            [weakSelf endRefresh];
        }];
        
        
    }];
    [self beginRefesh:ENT_RefreshHeader];
    
    
    
    
    
    [commTableView setupData:dataArray index:2];
    commTableView.table.delegate=self;
    [self.view addSubview:commTableView];
    
    // Do any additional setup after loading the view.
}
 
 

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
    }
}

#pragma mark tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
   
    
   if (self.type==ENT_Preson)
   {
        return [model.cellHeigh floatValue]-60;
   }
    return [model.cellHeigh floatValue];
 
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{   NSLog(@"cell选中");
    GongQiuDetailsViewController *vc=[[GongQiuDetailsViewController alloc]init];
    
    [self pushViewController:vc];
}

@end
