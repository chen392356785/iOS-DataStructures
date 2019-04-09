//
//  VotoChartsListViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/21.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory2.h"
#import "VotoChartsListViewController.h"
#import "VotoDetailsViewController.h"
@interface VotoChartsListViewController ()<UITableViewDelegate,VoteSuccessDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
}
@end

@implementation VotoChartsListViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [rightbutton setImage:[UIImage imageNamed:@"shareGreen.png"] forState:UIControlStateNormal];
//    rightbutton.hidden = NO;
    rightbutton.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"排行榜"];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, WindowHeight-49, WindowHeight, 49)];
    view.backgroundColor=[UIColor whiteColor];
    //    [self.view addSubview:view];
    
    BtnView *btn=[[BtnView alloc]initWithFrame:CGRectMake(0, 6, 128, 37) cornerRadius:20 text:@"我也要投票" image:Image(@"iconfont-zanzan.png")];
    btn.centerX=self.view.centerX;
    [view addSubview:btn];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self creatTableView];
}
-(void)creatTableView{
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:36];
//    commTableView.backgroundColor = RGB(247, 248, 249);
    commTableView.backgroundColor = kColor(@"#F9F9F9");
    __weak VotoChartsListViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshHeader];
    [self.view addSubview:commTableView];
    
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    [network getVoteChartsList:self.model.activities_id page:page num:10 success:^(NSDictionary *obj) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 0.22*WindowWith;
    return kWidth(120);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VoteListModel *model = dataArray[indexPath.row];
    VotoDetailsViewController *vc=[[VotoDetailsViewController alloc]init];
    vc.model = model;
    vc.activModel = self.model;
    //    vc.surplus = _surplus;
    vc.delegate = self;
    vc.indexPath = indexPath;
    [self pushViewController:vc];
}

- (void)VoteSuccessDelagate:(VoteListModel *)model indexPath:(NSIndexPath *)indexPath
{
    //    _surplus = stringFormatInt([_surplus intValue] +1);
    //    model.vote_num++;
    //    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    //    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    
    [self beginRefesh:ENT_RefreshHeader];
}
- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.updataViewBlock) {
        self.updataViewBlock();
    }
}
- (void)home:(id)sender
{
    NSString *title = [NSString stringWithFormat:@"%@ - 最新排行榜",self.model.activities_titile];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@vote/phb-index.html?vote_id=%d",shareURL,[self.model.activities_id intValue]];
    
    [self ShareUrl:self withTittle:@"行业最火爆的排行榜数据！" content:title withUrl:urlStr imgUrl:self.model.activities_pic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
