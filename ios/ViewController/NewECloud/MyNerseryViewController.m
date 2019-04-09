//
//  MyNerseryViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MyNerseryViewController.h"
#import "SeedCloudDetailViewController.h"
//#import "CreatNerseryViewController.h"
@interface MyNerseryViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    NSMutableArray *dataArray;
    int page;
    EmptyPromptView *_EPView;
    NSIndexPath *_indexPath;
}

@end

@implementation MyNerseryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的苗木云"];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(5, 50, WindowWith-10, WindowHeight) tableviewStyle:UITableViewStylePlain];
    dataArray=[[NSMutableArray alloc]init];
    commTableView.table.showsVerticalScrollIndicator=NO;
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:53];
    commTableView.backgroundColor = RGB(247, 248, 250);
    __weak MyNerseryViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshHeader];
    
    _EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"您还没有发布过苗木云哦~"];
    
    _EPView.hidden = YES;
    [commTableView.table addSubview:_EPView];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    [network myNurseryInfo:page num:pageNum success:^(NSDictionary *obj) {
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

-(void)deleteMyNersery{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath=indexPath;
    SeedCloudDetailViewController *vc=[[SeedCloudDetailViewController alloc]init];
    NurseryListModel *model=[[NurseryListModel alloc]init];
    MyNerseryModel *Model=dataArray[indexPath.row];
    model.nursery_id=Model.nursery_id;
    model.plant_name=Model.plant_name;
    vc.listModel=model;
    vc.delegate=self;
    
    // if (Model.status==0) {
    
    [self.inviteParentController pushViewController:vc];
    
    //    }else if (Model.status==2){
    //         [IHUtility AlertMessage:@"温馨提示" message:@"信息审核中，请耐心等待"];
    //
    //    }else if (Model.status==1){
    //
    //        [network GetSeedCloudDetailByNursery_id:(int)Model.nursery_id success:^(NSDictionary *obj) {
    //            CreatNerseryViewController *CreatVC=[[CreatNerseryViewController alloc]init];
    //            CreatVC.type=ENT_Edit;
    //            NurseryListModel *listModel=obj[@"content2"];
    //            CreatVC.listModel=listModel;
    //            [self pushViewController:CreatVC];
    //            CreatVC.selectEditBlock=^(NurseryListModel *model){//编辑
    //                MyNerseryModel *Model=[[MyNerseryModel alloc]initWitListModel:model];
    //                Model.status=2;
    //                [dataArray replaceObjectAtIndex:_indexPath.row withObject:Model];
    //                NSArray *indexArray=[NSArray arrayWithObject:_indexPath];
    //                [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    //
    //
    //            };
    ////            [self pushViewController:CreatVC];
    //
    //
    //        } failure:^(NSDictionary *obj2) {
    //
    //        }];
    //
    //
    //           }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==2017) {
        if (buttonIndex==0){
            MyNerseryModel *model=dataArray[_indexPath.row];
            [network deleteNurseryDetail:[USERMODEL.userID intValue] nursery_id:(int)model.nursery_id success:^(NSDictionary *obj) {
                [IHUtility addSucessView:@"删除成功" type:1];
                [self->dataArray removeObjectAtIndex:self->_indexPath.row];
                [self->commTableView.table reloadData];
                if (self->dataArray.count==0) {
                    self->_EPView.hidden=NO;
                }
                
                
            } failure:^(NSDictionary *obj2) {
                [IHUtility addSucessView:@"删除失败" type:2];
            }];
        }
    }
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    _indexPath=indexPath;
    if (action==MTDeleteActionTableViewCell) {
        
        [IHUtility AlertMessage:@"温馨提示" message:@"确认删除本条数据？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:2017];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
