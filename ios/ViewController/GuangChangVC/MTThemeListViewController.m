//
//  MTThemeListViewController.m
//  MiaoTuProject
//
//  Created by 徐斌 on 16/5/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTThemeListViewController.h"
//#import "CustomScrollCell.h"
#import "MTTopicListViewController.h"
#define  bactTopWidth  42
@interface MTThemeListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
//    float lastContentOffset;
    NSIndexPath *_indexPath;
}
@end

@implementation MTThemeListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    lastContentOffset = scrollView.contentOffset.y;
//}
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    //    if (lastContentOffset < scrollView.contentOffset.y) {
//    //        [self setHomeTabBarHidden:YES];
//    //    }else{
//    //        [self setHomeTabBarHidden:NO];
//    //    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"话题"];
    dataArray=[[NSMutableArray alloc]init];
    page=1;
    backTopbutton.frame=CGRectMake(WindowWith-55, WindowHeight-60, bactTopWidth, bactTopWidth);
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    NSArray *array=[IHUtility getUserdefalutsList:kThemeDefaultUserList];
    for (NSDictionary *dic in array) {
        ThemeListModel *model=[network parseThemeList:dic];
        [dataArray addObject:model];
    }
    [commTableView setupData:dataArray index:25];
    [self.view addSubview:commTableView];
    
    __weak MTThemeListViewController *weakSelf=self;
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    page=1;
    [self refreshTableViewLoading:commTableView data:dataArray dateType:kThemeUserDate];
    [self beginRefesh:ENT_RefreshHeader];
    // [self setbackTopFrame:backBtnY];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableView) name:NotificationSeeTopic object:nil];
}


-(void)reloadTableView{
    ThemeListModel *model = dataArray[_indexPath.row];
    model.onlookers_user_num=[NSString stringWithFormat:@"%ld",[model.onlookers_user_num integerValue]+1];
    [dataArray replaceObjectAtIndex:_indexPath.row withObject:model];
    
    NSArray *indexArray=[NSArray arrayWithObject:_indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    [network getThemeList:page num:pageNum success:^(NSDictionary *obj) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.48*WindowWith+80;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    for (CustomScrollCell *cell in commTableView.table.visibleCells) {
//        [cell updateViewFrameWithScrollView:scrollView];
//    }
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
    ThemeListModel *mod=[dataArray objectAtIndex:indexPath.row];
    
    MTTopicListViewController *vc=[[MTTopicListViewController alloc]init];
    vc.themeMod=mod;
    vc.type=ENT_topic;
    vc.isHot=0;
    [self.inviteParentController pushViewController:vc];
}

@end
