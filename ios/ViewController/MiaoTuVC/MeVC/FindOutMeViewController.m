//
//  FindOutMeViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "FindOutMeViewController.h"
#import "MTOtherInfomationMainViewController.h"
@interface FindOutMeViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    EmptyPromptView *_EPView;
}
@end

@implementation FindOutMeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //  self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"看过我的"];
    [self creatTableView];
}

-(void)creatTableView{
    dataArray=[[NSMutableArray alloc]init];
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    __weak FindOutMeViewController *weakSelf = self;
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    
    [self beginRefesh:ENT_RefreshHeader]; //进行下拉刷新
    [commTableView setupData:dataArray index:9];
    [self.view addSubview:commTableView];
    
    EmptyPromptView *view  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"还没有人看过您呢~"];
    view.hidden = YES;
    _EPView = view;
    [commTableView.table addSubview:view];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    [network getSelectViewsList:[USERMODEL.userID intValue]
                           page:page
                            num:10
                        success:^(NSDictionary *obj) {
                            
                            
                            if (refreshView==self->commTableView.table.mj_header) {
                                [self->dataArray removeAllObjects];
                                self->page=0;
                            }
                            NSArray *arr=obj[@"userChildrenInfo"];
                            
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
                                [self->commBaseTableView.table.mj_header endRefreshing];
                                [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                                [self endRefresh];
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(void)headwork:(UserChildrenInfo *)model
{
    [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]success:^(NSDictionary *obj) {
        NSLog(@"%@",obj);
        
        
        MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.user_id :NO dic:obj[@"content"]];
        controller.userMod=model;
        
        controller.dic=obj[@"content"];
        [self pushViewController:controller];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{  UserChildrenInfo *model=dataArray[indexPath.row];
//    __weak FindOutMeViewController *weakSelf=self;
	
    [self headwork:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
