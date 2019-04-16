//
//  EPCloudFansViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "EPCloudFansViewController.h"
#import "MTOtherInfomationMainViewController.h"
@interface EPCloudFansViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
//    NSIndexPath *_indexPath;
    EmptyPromptView *_EPView;
}


@end

@implementation EPCloudFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self setTitle:@"Ta的粉丝"];
    if (self.type==ENT_fowller) {
      [self setTitle:@"Ta的关注"];
    }
    
    
    if ([self.userId isEqualToString:USERMODEL.userID]) {
        [self setTitle:@"我的粉丝"];
        if (self.type==ENT_fowller) {
            [self setTitle:@"我的关注"];
        }

    }
    
    
    
    if ([self.userId isEqualToString:USERMODEL.userID]) {
        
        [network selectUseerInfoForId:[self.userId intValue]
                              success:^(NSDictionary *obj) {
                               
                               //   NSDictionary *dic= [IHUtility getUserDefalutsDicKey:KFansDefalutInfo];;
                                  
                                  NSDictionary *Dic=@{@"fansNum":[NSString stringWithFormat:@"%@",obj[@"content"][@"fansNum"]],
                                                      @"followNum":[NSString stringWithFormat:@"%@",obj[@"content"][@"followNum"]]
                                                      };
                                  [IHUtility setUserDefaultDic:Dic key:KFansDefalutInfo];
                                  
                                  
                                  
                                  
                              } failure:^(NSDictionary *obj2) {
                                  
                              }];

        
    }
    
    
    
    [self creatTableView];
}

-(void)creatTableView{
     [self setbackTopFrame:backBtnY];
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:32];
    commTableView.backgroundColor = RGB(247, 248, 249);
    
    __weak EPCloudFansViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshHeader];
    [self.view addSubview:commTableView];
    
    NSString *str;
    if (self.type==ENT_fowller) {
        str = @"还没有人关注呢~";
    }else {
        str = @"还没有粉丝呢~";
    }
    EmptyPromptView *view  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:str];
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
    
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    
    if (self.type==ENT_fans) {
        [network selectFansUserList:[USERMODEL.userID intValue]
                          follow_id:[self.userId intValue]
                                num:10
                               page:page
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

    }else if(self.type==ENT_fowller)
    {
        [network selectFollowUserList:[USERMODEL.userID intValue]
                          follow_id:[self.userId intValue]
                                num:10
                               page:page
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MTFansModel *model=dataArray[indexPath.row];
    [self addWaitingView];
    [network selectUseerInfoForId:[model.follow_id intValue]
                         success:^(NSDictionary *obj) {
                             MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                             UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                             [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.follow_id intValue]success:^(NSDictionary *obj) {
                                 [self removeWaitingView];
                                 MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.follow_id :NO dic:obj[@"content"]];
                                 controller.userMod=usermodel;
                                 controller.dic=obj[@"content"];
                                 [self pushViewController:controller];
                             } failure:^(NSDictionary *obj2) {
                                 
                             }];

                             
                             
                         } failure:^(NSDictionary *obj2) {
                             
                         }];
    
   
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    
    MTFansModel *model=dataArray[indexPath.row];
    if (action==MTActivityFollowBMTableViewCell) {
        
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        
        [self addWaitingView];
        [network followUser:[USERMODEL.userID intValue]follow_id:[model.follow_id intValue]type:@"0" success:^(NSDictionary *obj) {
            [self removeWaitingView];
               self.selectBlock(SelectFollowBlock);
            [self addSucessView:@"关注成功" type:1];
            NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
            NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
            [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]+1] forKey:@"followNum"];
            
            [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];

        } failure:^(NSDictionary *obj2) {
            
        }];

        
    }else if (action==MTActivityUpFollowBMTableViewCell){
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        
        [self addWaitingView];
        [network followUser:[USERMODEL.userID intValue]follow_id:[model.follow_id intValue]type:@"1" success:^(NSDictionary *obj) {
            [self removeWaitingView];
             self.selectBlock(SelectUpFollowBlock);
            [self addSucessView:@"取消关注成功" type:1];
            NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
            NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
            
            [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]-1] forKey:@"followNum"];
            [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
        } failure:^(NSDictionary *obj2) {
            
        }];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}



@end
