//
//  MTCollectionBuyTableViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTCollectionBuyTableViewController.h"
//#import "MTOtherInfomationMainViewController.h"
#import "GongQiuDetailsViewController.h"
@interface MTCollectionBuyTableViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
}
@end

@implementation MTCollectionBuyTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    dataArray=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}



-(void)creatTableView
{
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight+23) tableviewStyle:UITableViewStylePlain];
    commTableView.type=self.type;
    commTableView.personType=self.personType;
    commTableView.attribute=self;
   
    __weak MTCollectionBuyTableViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        if (refreshView==self->commTableView.table.mj_header) {
            self->page=0;
        }
        
       
            
        [network getBuyList:self->page maxResults:pageNum my_user_id:0 mining_area:@"" varieties:@"" success:^(NSDictionary *obj) {
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
   
    
    NSLog(@"%d",commTableView.type);
}

-(UIScrollView *)streachScrollView
{
    return commTableView.table;
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
