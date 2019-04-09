//
//  PositionListViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 21/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PositionListViewController.h"
#import "PositionDetailViewController.h"

@interface PositionListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    NSMutableArray *dataArray;
    int page;
    EmptyPromptView *_EPView;
}
@end

@implementation PositionListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:self.model.nickname];
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    if (self.type) {
        [self setTitle:@"投递记录"];
        commTableView.type = ENT_UserDeliveryrecord;//投递记录
    }
    [commTableView setupData:dataArray index:40];
    commTableView.backgroundColor = cLineColor;
    __weak PositionListViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshHeader];
    
    if (self.type) {
        _EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"您还没有投递过职位哦~"];
    }else {
        _EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"目前还没有招聘职位哦~"];
    }
    _EPView.hidden = YES;
    [commTableView.table addSubview:_EPView];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    if (!self.type) {
        [network loadCompanyPositionList:self.model.user_id page:page num:10 success:^(NSDictionary *obj) {
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
                if (self->dataArray.count == 0) {
                    
                    self->_EPView.hidden = NO;
                }else{
                    self->_EPView.hidden = YES;
                }
                [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                [self endRefresh];
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
    }else {
        [network getUserDeliveryRecord:USERMODEL.userID page:page num:10 success:^(NSDictionary *obj) {
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
                if (self->dataArray.count == 0) {
                    
                    self->_EPView.hidden = NO;
                }else{
                    self->_EPView.hidden = YES;
                }
                [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                [self endRefresh];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionListModel *model = dataArray[indexPath.row];
    PositionDetailViewController *vc = [[PositionDetailViewController alloc] init];
    vc.selectBtnBlock=^(NSInteger index){
        
        if (index==closeBlock) {
            
        }else if (index==openBlock){
            
        }
    };
    vc.i = 1;
    //    vc.model = model;
    vc.job_id = (int)model.job_id;
    
    [self pushViewController:vc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}

-(void)back:(id)sender{
    if (self.type == ENT_Seek) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

@end
