//
//  MyReleaseChildrenViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/31.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MyReleaseChildrenViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "GongQiuDetailsViewController.h"
#import "MTTopicDetailsViewController.h"
#import "MTNewSupplyAndBuyDetailsViewController.h"
#import "AskProblemDetailViewController.h"
@interface MyReleaseChildrenViewController ()<UITableViewDelegate,GongQiuAgreeDelegate,AgreeAnswerDelegate>
{
	int page;
	int _questionId;
	EmptyPromptView *_EPView;
	NSMutableArray *dataArray;
	NSIndexPath *_selIndexPath;
	MTBaseTableView *commTableView;
}
@end

@implementation MyReleaseChildrenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setbackTopFrame:WindowHeight-60];
    dataArray=[[NSMutableArray alloc]init];
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 50, WindowWith, WindowHeight-50) tableviewStyle:UITableViewStylePlain];
    
    //    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
    //    topView.backgroundColor=cBgColor;
    //
    //    commTableView.table.tableHeaderView=topView;
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    commTableView.buyType=self.type;
    if (self.type==ENT_Buy) {
        
        [commTableView setupData:dataArray index:49];
    }else if(self.type==ENT_Supply)
    {
        
        [commTableView setupData:dataArray  index:49];
        
    }else if (self.type==ENT_Topic){
        
        
        [commTableView setupData:dataArray index:50];
    }else if (self.type==ENT_questions){
        [commTableView setupData:dataArray index:51];
    }
    __weak MyReleaseChildrenViewController *weakSelf=self;
    
    
    
    [self.view addSubview:commTableView];
    
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefresh:refreshView];
        
    }];
    [self beginRefesh:ENT_RefreshFooter];
    
    NSString *str;
    if (self.type==ENT_Buy) {
        
        str = @"还没发布过求购哦~";
        
    }else if (self.type == ENT_Supply)
    {
        str = @"还没发布过供应哦~";
        
    }else if (self.type == ENT_Topic){
        
        str = @"还没发布过话题哦~";
        
    }else if (self.type==ENT_questions){
        
        str = @"还没发布过问题~";
    }
    
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:str];
    EPView.hidden = YES;
    _EPView = EPView;
    [commTableView.table addSubview:EPView];
    
}

-(void)loadRefresh:(MJRefreshComponent *)refreshView{
    if (self.type==ENT_Supply) {
        [network getSupplyList:page maxResults:pageNum my_user_id:[USERMODEL.userID intValue] seedling_source_address:@"" varieties:@""  success:^(NSDictionary *obj) {
            
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
        
    }else if(self.type==ENT_Buy){
        
        [network getBuyList:page maxResults:pageNum my_user_id:[USERMODEL.userID intValue] mining_area:@"" varieties:@"" success:^(NSDictionary *obj) {
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
            
            if (self->dataArray.count == 0) {
                self->_EPView.hidden = NO;
            }else{
                self->_EPView.hidden = YES;
            }
            [self endRefresh];
            
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
        }];
        
    }else if (self.type==ENT_Topic){
        
        
        [network getTopicList:page maxResults:pageNum userID:[USERMODEL.userID intValue]  isHot:0 my_user_id:[USERMODEL.userID intValue] theme_id:0 success:^(NSDictionary *obj) {
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
        
    }else if (self.type==ENT_questions){
        
        [network selectMyQuestionByUserId:[USERMODEL.userID intValue] page:page num:pageNum success:^(NSDictionary *obj) {
            if (refreshView==self->commTableView.table.mj_header) {
                [self->dataArray removeAllObjects];
                self->page=0;
            }
            
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMyNavViewHide object:nil];
            
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

-(UIScrollView *)streachScrollView
{
    return commTableView.table;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
    
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}


#pragma mark GongQiuDeleteDelgate
-(void)GongQiuDeleteTableViewCell:(MTSupplyAndBuyListModel *)model indexPath:(NSIndexPath *)indexPath integer:(NSInteger)integer{
    _selIndexPath=indexPath;
    if (integer==1) {
        [dataArray removeObjectAtIndex:_selIndexPath.row];
        [commTableView.table reloadData];
        if (dataArray.count==0) {
            _EPView.hidden=NO;
        }
        
    }else if (integer==2){
        
        [dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        
        NSArray *indexArray=[NSArray arrayWithObject:_selIndexPath];
        [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{//cell分支点击
    __weak MyReleaseChildrenViewController *weakSelf=self;
    
    if (action==MTHeadViewActionTableViewCell) {
        if (self.type==ENT_questions) {
            MyQuestionModel *model=dataArray[indexPath.row];
            
            [weakSelf tapNameHead:model.user_id];
        }
        
    }else if (action==MTHeadViewActionTableViewCell2){
        if (self.type==ENT_questions) {
            MyQuestionModel *model=dataArray[indexPath.row];
            
            [weakSelf tapNameHead:[NSString stringWithFormat:@"%d",model.answerInfo.user_id]];
        }
        
    }else if (action==MTDeleteActionTableViewCell){
        MyQuestionModel *model=dataArray[indexPath.row];
        [weakSelf delete:[model.Id intValue] indexPath:indexPath];
    }
    
}

-(void)delete:(int)questionid indexPath:(NSIndexPath *)indexPath{
    
    _questionId=questionid;
    
    [IHUtility AlertMessage:@"温馨提示" message:@"确认删除问题么" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:2016];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==2016) {
        if (buttonIndex==0){
            [network deleteNoReplyQuestion:_questionId success:^(NSDictionary *obj) {
				[self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
                [self->commTableView.table reloadData];
                [IHUtility addSucessView:@"删除成功" type:1];
            } failure:^(NSDictionary *obj2) {
                [IHUtility addSucessView:@"删除失败" type:2];
            }];
        }
    }
}

- (void)deleteNoReplyQuestion:(ReplyProblemListModel *)model indexPath:(NSIndexPath *)indexPath{
    [dataArray removeObjectAtIndex:indexPath.row];
    [commTableView.table reloadData];
    [IHUtility addSucessView:@"删除成功" type:1];
}

-(void)tapNameHead:(NSString *)userId {
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

-(void)selectIndexPath:(NSIndexPath *)indexPath {
    if (self.type==ENT_Supply ||self.type==ENT_Buy) {
        MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
        MTNewSupplyAndBuyDetailsViewController *vc=[[MTNewSupplyAndBuyDetailsViewController alloc]init];
        vc.type=self.type;
        if (model.supply_id) {
            vc.newsId=model.supply_id;
        }else{
            vc.newsId=model.want_buy_id;
        }
        vc.delegate=self;
        
        [self.inviteParentController pushViewController:vc];
    }else if (self.type==ENT_Topic){
        MTTopicListModel *model=[dataArray objectAtIndex:indexPath.row];
        MTTopicDetailsViewController *vc=[[MTTopicDetailsViewController alloc]init];
        vc.model=model;
        [self.inviteParentController pushViewController:vc];
    }else if (self.type==ENT_questions){
        MyQuestionModel *model=dataArray[indexPath.row];
        if ([model.answer_status intValue]==0) {
            
        }else{
            AskProblemDetailViewController *vc=[[AskProblemDetailViewController alloc]init];
            vc.answer_id=model.Id;
            vc.delegate=self;
            vc.indexPath=indexPath;
            [self.inviteParentController pushViewController:vc];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{   NSLog(@"cell选中");
    _selIndexPath=indexPath;
    [self selectIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type==ENT_questions) {
        MyQuestionModel *model=dataArray[indexPath.row];
        if ([model.answer_status intValue]==0) {
            CGSize size=[IHUtility GetSizeByText:model.title sizeOfFont:13 width:WindowWith-35-13-40];
            return 175-38+size.height;
        }else if([model.answer_status intValue]==1){
            CGSize size=[IHUtility GetSizeByText:model.title sizeOfFont:13 width:WindowWith-35-13-40];
            CGSize size2=[IHUtility GetSizeByText:model.answerInfo.answer_content sizeOfFont:13 width:WindowWith-35-13-40];
            
            return 225-19-38+size.height+size2.height;
        }
        return 0;
    }else if (self.type==ENT_Supply){
        MTSupplyAndBuyListModel *model=dataArray[indexPath.row];
        if (![model.supply_url isEqualToString:@""]) {
            return 95+0.24*WindowWith+20;
        }
        return 95;
    }else if (self.type==ENT_Buy){
        MTSupplyAndBuyListModel *model=dataArray[indexPath.row];
        if (![model.want_buy_url isEqualToString:@""]) {
            return 95+0.24*WindowWith+20;
        }
        return 95;
    }else if (self.type==ENT_Topic)
    {
        MTTopicListModel *model=dataArray[indexPath.row];
        if (![model.topic_url isEqualToString:@""]) {
            if (model.topic_content.length>20) {
                return 95+0.24*WindowWith+20;
            }else{
                return 95+0.24*WindowWith+20-22;
            }
            
        }
        return 95;
    }
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
