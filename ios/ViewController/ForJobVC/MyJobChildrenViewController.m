//
//  MyJobChildrenViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/19.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MyJobChildrenViewController.h"
#import "CurriculumVitaeViewController.h"
//#import "CreatPositionViewController.h"
#import "PositionDetailViewController.h"
//#import "ChatViewController.h"

@interface MyJobChildrenViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    NSIndexPath *_indexPath;
    NSIndexPath *_indexPath2;
    EmptyPromptView *_EPView;
}
@end

@implementation MyJobChildrenViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=RGB(247, 248, 250);
    [self setbackTopFrame:WindowHeight-140];
    __weak MyJobChildrenViewController *weakSelf=self;
    
    if (self.type==ENT_Seek) {
        
        
    }else if (self.type==ENT_Invite){
        
        dataArray=[[NSMutableArray alloc]init];
        
        commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight-40-60) tableviewStyle:UITableViewStylePlain];
        
        commTableView.attribute=self;
        commTableView.table.delegate=self;
        [self.view addSubview:commTableView];
        
        [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
            [weakSelf loadRefresh:refreshView];
            
        }];
        [self beginRefesh:ENT_RefreshFooter];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame=CGRectMake(0, WindowHeight-10-40-40, WindowWith-50, 40);
        btn.backgroundColor=cGreenColor;
        [btn setTintColor:[UIColor whiteColor]];
        [btn setTitle:@"发  布" forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=sysFont(18.8);
        btn.centerX=self.view.centerX;
        btn.layer.cornerRadius=20;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setview:) name:NotificationEditPosition object:nil];
        
        if (self.Mytype==ENT_CurriculumVitae) {
            
            commTableView.Mytype=ENT_CurriculumVitae;
            [commTableView setupData:dataArray index:39];
            _EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"目前还没有收到简历~"];
            
        }else if (self.Mytype==ENT_Position){
            
            [self.view addSubview:btn];
            
            [commTableView setupData:dataArray index:42];
            _EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"您还没有发布职位哦~"];
        }
        
        _EPView.hidden = YES;
        [commTableView.table addSubview:_EPView];
    }
}

-(void)setview:(NSNotification *)dic{
    
    PositionListModel *Model=dic.userInfo[@"key"];
    ReleasePositionModel *model=[[ReleasePositionModel alloc]initWithModel:Model];
    
    if (self.type==ENT_Invite){
        if (self.Mytype==ENT_CurriculumVitae) {
            
        }else if (self.Mytype==ENT_Position){
            [dataArray replaceObjectAtIndex:_indexPath2.row withObject:model];
            
            NSArray *indexArray=[NSArray arrayWithObject:_indexPath2];
            [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
        }
    }else{
        
    }
}

-(void)loadRefresh:(MJRefreshComponent *)refreshView{
    
    if (self.type==ENT_Invite){
        
        if (self.Mytype==ENT_CurriculumVitae) {
            
            [network selectReceiveResruitList:[USERMODEL.userID intValue] page:0 num:10 success:^(NSDictionary *obj) {
                
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
                    
                    if (self->dataArray.count == 0) {
                        
                        self->_EPView.hidden = NO;
                    }else{
                        self->_EPView.hidden = YES;
                    }
                    
                    [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                    [self endRefresh];
                    
                    return ;
                }
                
                [self->dataArray addObjectsFromArray:arr];
                [self->commTableView.table reloadData];
                [self endRefresh];
                
                if (self->dataArray.count == 0) {
                    self->_EPView.hidden = NO;
                }else{
                    self->_EPView.hidden = YES;
                }
            } failure:^(NSDictionary *obj2) {
                [self endRefresh];
            }];            
        }else if (self.Mytype==ENT_Position){
            
            [network selectPublishJboList:[USERMODEL.userID intValue] page:0 num:10 success:^(NSDictionary *obj) {
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
                    
                    if (self->dataArray.count == 0) {
                        self->_EPView.hidden = NO;
                    }else{
                        self->_EPView.hidden = YES;
                    }
                    return ;
                }
                
                [self->dataArray addObjectsFromArray:arr];
                [self->commTableView.table reloadData];
                [self endRefresh];
                
                if (self->dataArray.count == 0) {
                    self->_EPView.hidden = NO;
                }else{
                    self->_EPView.hidden = YES;
                }
                
            } failure:^(NSDictionary *obj2) {
                [self endRefresh];
            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==ENT_Invite){
        if (self.Mytype==ENT_CurriculumVitae) {
            
            return 167;
            
        }else if (self.Mytype==ENT_Position){
            return 76;
        }
    }else{
        
    }
    return 167;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type==ENT_Seek) {
        
    }else if (self.type==ENT_Invite){
        
        if (self.Mytype==ENT_CurriculumVitae) {
            
            CurriculumVitaeViewController *vc=[[CurriculumVitaeViewController alloc]init];
            jianliModel *model=dataArray[indexPath.row];
            vc.resume_id=[model.resume_id intValue];
            [self.inviteParentController pushViewController:vc];
            
            
        }else if (self.Mytype==ENT_Position){
            PositionDetailViewController *vc=[[PositionDetailViewController alloc]init];
            vc.i=1;
            vc.delegate=self;
            _indexPath2=indexPath;
            
            ReleasePositionModel *model=dataArray[indexPath.row];
            vc.job_id = (int)model.job_id ;
            [self.inviteParentController pushViewController:vc];
        }
    }
}

-(void)closeOrOpenPosition:(BOOL)close{
    MyPositionTableViewCell *cell=[commTableView.table cellForRowAtIndexPath:_indexPath2];
    if (close) {
        cell.lbl.text=@"已关闭";
    }else{
        cell.lbl.text=@"";
    }
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
//    __weak MyJobChildrenViewController *weakSelf=self;
    jianliModel *model=dataArray[indexPath.row];
    if (action==MTCommentActionTableViewCell) {//沟通
        
        NSDictionary *dic=@{@"key":model};
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationJobCommunite object:nil userInfo:dic];
    }
    if (action==MTDeleteActionTableViewCell) {//删除
        
        _indexPath=indexPath;
        [IHUtility AlertMessage:@"" message:@"确定删除本条简历吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:13];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    __weak MyJobChildrenViewController *weakSelf=self;
    if (alertView.tag==13) {
        if (buttonIndex==0) {
            jianliModel *model=dataArray[_indexPath.row];
            [weakSelf delete1:model indexPath:_indexPath];
        }
    }
    if (alertView.tag==16) {
        if (buttonIndex==0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationEcloud object:nil];
        }
    }
}

-(void)delete1:(jianliModel *)model indexPath:(NSIndexPath *)indexPath{
    
    [network deleteReceiveJob:[model.receive_id intValue] success:^(NSDictionary *obj) {
        
        [self->dataArray removeObjectAtIndex:indexPath.row];
        [self->commTableView.table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self->commTableView.table reloadData];
        [IHUtility addSucessView:@"删除成功" type:1];
    }];
}

-(void)submitClick:(UIButton *)sender{
    
    if (self.type==ENT_Seek) {
        
    }else if (self.type==ENT_Invite){
        
        NSDictionary *Dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
        
        if ([Dic[@"companyinfo"][@"status"] intValue]==0) {
            
            [IHUtility AlertMessage:@"温馨提示" message:[NSString stringWithFormat:@"为了营造真实的招聘环境，提高求职者对贵司的信心和求职意愿，请您申请加入%@企业云，认证您的真实身份。",KAppName] delegate:self cancelButtonTitle:@"申请企业云" otherButtonTitles:@"取消" tag:16];
            
        }else if ([Dic[@"companyinfo"][@"status"] intValue]==1){
            [IHUtility AlertMessage:@"温馨提示" message:@"很抱歉，您的企业云申请正在审核中，暂时无法发布招聘信息。" delegate:self cancelButtonTitle:@"查看企业云" otherButtonTitles:@"取消" tag:16];
        }else if ([Dic[@"companyinfo"][@"status"] intValue]==3){
            [IHUtility AlertMessage:@"温馨提示" message:@"很抱歉，您的企业云申请未成功，暂时无法发布招聘信息。" delegate:self cancelButtonTitle:@"查看企业云" otherButtonTitles:@"取消" tag:16];
        }else if ([Dic[@"companyinfo"][@"status"] intValue]==2){
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationAddPosition object:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
