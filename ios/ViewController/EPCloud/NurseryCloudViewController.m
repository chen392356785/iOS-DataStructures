//
//  NurseryCloudViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/8.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NurseryCloudViewController.h"
#import "SeedCloudDetailViewController.h"

@interface NurseryCloudViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
}
@end

@implementation NurseryCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.nursery_type_name];
    dataArray=[[NSMutableArray alloc]init];
    __weak NurseryCloudViewController *weakSelf=self;
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(5, 0, WindowWith-10, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    commTableView.backgroundColor=RGB(247, 248, 250);
    [commTableView setupData:dataArray index:52];
    [self.view addSubview:commTableView];

    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
     [self beginRefesh:ENT_RefreshHeader];
    
    
    
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
 
        
        [network selectNurseryDetailListByPage:[self.nursery_type_id intValue]
                             nursery_type_name:@""
                                            page:page
                                            num:pageNum
                                             success:^(NSDictionary *obj) {
                                                
                                                 
                                                 NSArray *arr=obj[@"content"];
                                                 
                                                 
                                                 
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



-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NurseryListModel *model=dataArray[indexPath.row];
    return [model.cellHeigh doubleValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NurseryListModel *model = dataArray[indexPath.row];
    SeedCloudDetailViewController *detailVC =[[SeedCloudDetailViewController alloc]init];
    detailVC.listModel = model;
    [self pushViewController:detailVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
