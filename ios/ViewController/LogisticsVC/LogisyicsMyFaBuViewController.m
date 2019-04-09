//
//  LogisyicsMyFaBuViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/12/29.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "LogisyicsMyFaBuViewController.h"
#import "LogisticsFaBuViewController.h"

@interface LogisyicsMyFaBuViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    NSIndexPath *_indexPath;
     EmptyPromptView *_EPView;
}

@end

@implementation LogisyicsMyFaBuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的发布"];
    dataArray=[[NSMutableArray alloc]init];
    __weak LogisyicsMyFaBuViewController *weakSelf=self;
    self.view.backgroundColor=cBgColor;
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(12, 0, WindowWith-24, WindowHeight) tableviewStyle:UITableViewStylePlain];
    //commTableView.table.tableHeaderView=logisticsView;
    commTableView.table.delegate=self;
    
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"还没有发布货源～"];
    EPView.hidden = YES;
    _EPView = EPView;
    [commTableView.table addSubview:EPView];
    commTableView.attribute=self;
    [commTableView setupData:dataArray index:61];
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    // page=1;
    // [self refreshTableViewLoading:commTableView data:dataArray dateType:kThemeUserDate];
    [self beginRefesh:ENT_RefreshHeader];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(edit:) name:NotificationEditLogistics object:nil];

    [self.view addSubview:commTableView];
    
}

-(void)edit:(NSNotification *)notification{
    OwnerFaBuModel *model=[[OwnerFaBuModel alloc]initWithDictionary:notification.userInfo[@"content"] error:nil];
    
    [dataArray replaceObjectAtIndex:_indexPath.row withObject:model];
    
     [commTableView.table reloadRowsAtIndexPaths:@[_indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}


-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    
    [network selectOwnerOrderByUserId:[USERMODEL.userID intValue]
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

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
      OwnerFaBuModel *model=dataArray[indexPath.row];
    _indexPath=indexPath;
    if (action==MTEditActionTableViewCell) {
        
        [self pushToFaBuVC:model];
    }else if (action==MTDeleteActionTableViewCell){
     
        
        
        _indexPath=indexPath;
        [IHUtility AlertMessage:@"" message:@"确定删除本条简历吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:13];
        
        
    }
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    __weak LogisticsFaBuViewController *weakSelf = self;
     OwnerFaBuModel *model=dataArray[_indexPath.row];
    if (alertView.tag==13) {
        if (buttonIndex==0) {
                       [network deleteOwnerOrder:[model.ownerOrderId intValue] success:^(NSDictionary *obj) {
						   [self->dataArray removeObjectAtIndex:self->_indexPath.row];
						   [self->commTableView.table deleteRowsAtIndexPaths:@[self->_indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
						   [self->commTableView.table reloadData];
                [IHUtility addSucessView:@"删除成功" type:1];
                
                
            } failure:^(NSDictionary *obj2) {
                
            }];
           
        }
    }
    
    
}


-(void)pushToFaBuVC:(OwnerFaBuModel *)model{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }

    LogisticsFaBuViewController *vc=[[LogisticsFaBuViewController alloc]init];
    vc.model=model;
    [self presentViewController:vc];
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OwnerFaBuModel *model=dataArray[indexPath.row];
    
    CGSize size=[IHUtility GetSizeByText:model.remark sizeOfFont:12 width:WindowWith-24-12-60-12];
    if ([model.remark isEqualToString:@""]) {
        return 195-22;

    }else{
        return 195-14+size.height;

    }
    return 195-22;
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
