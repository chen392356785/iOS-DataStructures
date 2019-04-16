//
//  QuestionsViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/28.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "QuestionsViewController.h"
#import "AskBarViewController.h"
#import "MTOtherInfomationMainViewController.h"

@interface QuestionsViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
//    float lastContentOffset;
    NSMutableArray *_indexPathArr;
//    UIImageView *_redImageView;
    NSIndexPath *_indexPath;
}

@end

@implementation QuestionsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray=[[NSMutableArray alloc]init];
    // self.view.backgroundColor=cLineColor;
    _indexPathArr=[[NSMutableArray alloc]init];
    backTopbutton.frame=CGRectMake(WindowWith-55, WindowHeight-60, 42, 42);
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    commTableView.backgroundColor=cLineColor;
    commTableView.i=self.i;
    [commTableView setupData:dataArray index:46];
    [self.view addSubview:commTableView];
    if (self.i==1) {
        [self setRedImageView];
    }
    
    __weak QuestionsViewController *weakSelf=self;
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    page=1;
    // [self refreshTableViewLoading:commTableView data:dataArray dateType:kThemeUserDate];
    [self beginRefesh:ENT_RefreshHeader];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setRedImageView) name:NotificationQusetion object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableView) name:NotificationSeeQuestion object:nil];
}


-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)reloadTableView{
    MyQuestionModel *model = dataArray[_indexPath.row];
    model.view_num=[NSString stringWithFormat:@"%ld",[model.view_num integerValue]+1];
    [dataArray replaceObjectAtIndex:_indexPath.row withObject:model];
    
    NSArray *indexArray=[NSArray arrayWithObject:_indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    
}

-(void)setRedImageView{
    if (dataArray>0) {
        for (NSInteger i=0; i<dataArray.count; i++) {
            MyQuestionModel *model=dataArray[i];
            if ([model.user_id isEqualToString:USERMODEL.userID]) {
                NSIndexPath *indexPath=_indexPathArr[i];
                QuestionTableViewCell *cell=[commTableView.table cellForRowAtIndexPath:indexPath];
                cell.redImageView.hidden=NO;
                
            }
        }
    }
}

-(void)hideRedImageView{
    if (dataArray>0) {
        for (NSInteger i=0; i<dataArray.count; i++) {
            MyQuestionModel *model=dataArray[i];
            if ([model.user_id isEqualToString:USERMODEL.userID]) {
                NSIndexPath *indexPath=_indexPathArr[i];
                QuestionTableViewCell *cell=[commTableView.table cellForRowAtIndexPath:indexPath];
                cell.redImageView.hidden=YES;
            }
        }
    }
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    [network forumTopicListpage:page num:pageNum success:^(NSDictionary *obj) {
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
        if (self->dataArray.count>0) {
            for (NSInteger i=0;i<self->dataArray.count;i++) {
                
                MyQuestionModel *model=self->dataArray[i];
                if ([model.user_id isEqualToString:USERMODEL.userID]) {
                    [self->dataArray exchangeObjectAtIndex:0 withObjectAtIndex:i];
                }
            }
        }
        
        [self->commTableView.table reloadData];
        [self endRefresh];
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_indexPathArr addObject:indexPath];
    return 160+0.48*WindowWith;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath=indexPath;
    
    MyQuestionModel *model = dataArray[indexPath.row];
    
    [self hideRedImageView];
    if ([model.user_id isEqualToString:USERMODEL.userID]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationNavViewHide object:nil];
    }
    
    AskBarViewController *vc = [[AskBarViewController alloc] init];
    vc.Title = model.Description;
    vc.form_id = model.Id;
    
    [self.inviteParentController pushViewController:vc];
    
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{//cell分支点击
    __weak QuestionsViewController *weakSelf=self;
    
    if (action==MTHeadViewActionTableViewCell) {
        
        MyQuestionModel *model=dataArray[indexPath.row];
        [weakSelf tapNameHead:model.user_id];
    }
}

-(void)tapNameHead:(NSString *)userId{
    [self addWaitingView];
    [network selectUseerInfoForId:[userId intValue]
                          success:^(NSDictionary *obj) {
                              MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                              UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                              [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[userId intValue]success:^(NSDictionary *obj) {
                                  [self removeWaitingView];
                                  MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:userId :NO dic:obj[@"content"]];
                                  controller.userMod=usermodel;
                                  controller.dic=obj[@"content"];
                                  [self.inviteParentController pushViewController:controller];
                              } failure:^(NSDictionary *obj2) {
                                  
                              }];
                              
                          } failure:^(NSDictionary *obj2) {
                              
                          }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
