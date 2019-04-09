//
//  RecommendChatGroupListViewController.m
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/12/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "RecommendChatGroupListViewController.h"
#import "ChatViewController.h"
@interface RecommendChatGroupListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    NSMutableArray *dataArray;
    NSIndexPath *_indexPath;
}
@end

@implementation RecommendChatGroupListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[[NSMutableArray alloc]init];
    
    [self setTitle:@"推荐圈子"];
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, iPhoneHeight - KtopHeitht) tableviewStyle:UITableViewStylePlain];
    
    commTableView.attribute=self;
    commTableView.table.delegate = self;
    [commTableView setupData:dataArray index:59];
    [self.view addSubview:commTableView];
    
    __weak RecommendChatGroupListViewController *weakSelf=self;
    
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshHeader successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefresh:refreshView];
    }];
    
    
    [commTableView.table.mj_header beginRefreshing];
    
    
    // Do any additional setup after loading the view.
}


-(void)loadRefresh:(MJRefreshComponent *)refreshView{
 
    
    [network getChatGroupListSuccess:^(NSDictionary *obj) {
        [self->dataArray removeAllObjects];
        NSArray *arr=obj[@"content"];
        [self->dataArray addObjectsFromArray:arr];
        [self->commTableView.table reloadData];
        [self endRefresh];
    } failure:^(NSDictionary *obj2) {
         [self endRefresh];
    }];
 
}


-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    _indexPath=indexPath;
    
    if (action==MTActionApplyChatGroupTableViewCell) {
        
        
            [IHUtility AlertMessage:@"温馨提示" message:@"确认是否加入该聊天室？" delegate:self cancelButtonTitle:@"我要加入" otherButtonTitles:@"取消" tag:2016];
        
        
    }
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==2016) {
        if (buttonIndex==0){
            [self addWaitingView];
          
            __weak RecommendChatGroupListViewController *weakSelf = self;
            NSDictionary *dic=[dataArray objectAtIndex:_indexPath.row];
            
            [self addWaitingView];
            
            
            [[EaseMob sharedInstance].chatManager asyncJoinPublicGroup:dic[@"group_id"] completion:^(EMGroup *group, EMError *error) {
                
              //  if(!error)
              //  {
               
                if ([IHUtility getUserdefalutsList:USERMODEL.userID]) {
                     NSMutableArray *Arr=[[NSMutableArray alloc]initWithArray:[IHUtility getUserdefalutsList:USERMODEL.userID]];
                    NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:dic];
                    [Dic setObject:@"Yes" forKey:@"ifJion"];
                    
                    NSMutableDictionary *Dic1=[[NSMutableDictionary alloc]initWithObjectsAndKeys:Dic,Dic[@"group_id"], nil];
                    [Arr addObject:Dic1];
                    [IHUtility saveUserDefaluts:Arr key:USERMODEL.userID];
                    
                }else{
                    
                    NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:dic];
                    [Dic setObject:@"Yes" forKey:@"ifJion"];
                    NSMutableDictionary *Dic1=[[NSMutableDictionary alloc]initWithObjectsAndKeys:Dic,Dic[@"group_id"], nil];
                    NSMutableArray *arr=[[NSMutableArray alloc]init];
                    [arr addObject:Dic1];
                    [IHUtility saveUserDefaluts:arr key:USERMODEL.userID];
                }
                if (error == nil) {
                    NSDictionary *paramets = @{
                                               @"user_id"   :   USERMODEL.userID,
                                               @"group_id"  :   dic[@"group_id"],
                                               };
                    [network httpRequestWithParameter:paramets method:JoinCharGroupUrl success:^(NSDictionary *dic) {
                        NSLog(@"-----  %@",dic);
                    }];
                }
                
                    [self removeWaitingView];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
               // }
              //  else{
                    
                    
                //    NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:dic];
                  //  [Dic setObject:@"Yes" forKey:@"ifJion"];
                  //  NSMutableDictionary *Dic1=[[NSMutableDictionary alloc]initWithObjectsAndKeys:Dic,Dic[@"group_id"], nil];
                    
                  //  [IHUtility setUserDefaultDic:Dic1 key:USERMODEL.userID];

                  //  [weakSelf showHint:NSLocalizedString(@"group.join.fail", @"again failed to join the group, please")];
                
                    
                    
                    
                    
                //}
            } onQueue:nil];

            
        }
        
    }
    
}



#pragma mark tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=dataArray[indexPath.row];
  
    CGSize  size=[IHUtility GetSizeByText:[dic objectForKey:@"description"] sizeOfFont:13 width:WindowWith-11-40-12-12-16];
    
    return 147-35+size.height-3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    
//    NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
//
//    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:dic[@"group_id"] isGroup:YES];
//    chatController.title = dic[@"group_name"];
//    [self.navigationController pushViewController:chatController animated:YES];
    
    
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
