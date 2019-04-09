//
//  GongQiuTableListViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "GongQiuTableListViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "GongQiuDetailsViewController.h"
#import "CreateBuyOrSupplyViewController.h"

@interface GongQiuTableListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
//    UISearchController *_search;
    NSString *_varieties;
    NSString *_seedling_source_address;
    NSString *_mining_area;
    IHTextField *_textFiled;
    UIButton *_createBtn;
    BOOL _first;
}
@end

@implementation GongQiuTableListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray =[[NSMutableArray alloc]init];
    
    [self creatTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChoose:) name:NotificationChooseCity object:nil];

    //     self.modalPresentationCapturesStatusBarAppearance = NO;
}

-(void)cityChoose:(NSNotification *)userInfo
{
    NSDictionary *dic=userInfo.userInfo;
    self.city=dic[@"city"];
    
    page=0;
    [dataArray removeAllObjects];
    [commTableView.table reloadData];
    [self beginRefesh:ENT_RefreshHeader]; //进行下拉刷新
}


//-(void)addSupplyAndBuy:(MTSupplyAndBuyListModel *)mod{
//    [dataArray insertObject:mod atIndex:0];
//    [commTableView.table reloadData];
//}


-(void)creatTableView
{
    UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 40)];
    bkView.backgroundColor=[UIColor whiteColor];
    
    UIImage *searchImg=Image(@"search_white2.png");
    searchBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [searchBtn setImage:[searchImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    searchBtn.frame=CGRectMake(WindowWith-searchImg.size.width-5, 8, searchImg.size.width, searchImg.size.height);
    [searchBtn addTarget:self action:@selector(searchVarieties) forControlEvents:UIControlEventTouchUpInside];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, 10, 26) textColor:cGrayLightColor textFont:sysFont(15)];
    lbl.text=@"  ";
    _textFiled=[[IHTextField alloc]initWithFrame:CGRectMake(10, 8, WindowWith-searchBtn.width-25, 26)];
    
    [_textFiled setClearButtonMode:UITextFieldViewModeAlways];
    _textFiled.borderStyle=UITextBorderStyleNone;
    _textFiled.delegate=self;
    _textFiled.backgroundColor=RGB(239, 239, 239);
    _textFiled.placeholder=@"搜索品种/公司/昵称";
    _textFiled.leftView=lbl;
    _textFiled.font = sysFont(12);
    _textFiled.leftViewMode=UITextFieldViewModeAlways;
    _textFiled.layer.cornerRadius=5;
    
    [bkView addSubview:searchBtn];
    [bkView addSubview:_textFiled];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight+50) tableviewStyle:UITableViewStylePlain];
    commTableView.table.tableHeaderView=bkView;
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    
    if (self.type==ENT_Buy) {
        
        commTableView.type=ENT_qiugou;
        
        NSArray *array=[IHUtility getUserdefalutsList:kBuyDefaultUserList];
        
        for (NSDictionary *dic in array) {
            MTSupplyAndBuyListModel *model=[network getSupplyAndBuyForDic:dic type:IH_QueryBuyList];
            [dataArray addObject:model];
        }
        
    }else if(self.type==ENT_Supply)
    {
        commTableView.type=ENT_gongying;
        
        NSArray *array=[IHUtility getUserdefalutsList:kSupplyDefaultUserList];
        
        for (NSDictionary *dic in array) {
            MTSupplyAndBuyListModel *model=[network getSupplyAndBuyForDic:dic type:IH_QuerySupplyList];
            [dataArray addObject:model];
        }
        
    }
    [commTableView setupData:dataArray index:2];
    
    
    [self.view addSubview:commTableView];
    __weak GongQiuTableListViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    
    page=1;
    
    
    [commTableView.table.mj_header beginRefreshing];
    /*
     if (self.type==ENT_Supply) {
     [self refreshTableViewLoading:commTableView data:dataArray dateType:kSupplyUserDate];
     }else if (self.type==ENT_Buy){
     [self refreshTableViewLoading:commTableView data:dataArray dateType:kBuyUserDate];
     }
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noticitionAddSupplyAndBuy:) name:NotificationAddSupplyBuyTopic object:nil];
    
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _createBtn=createBtn;
    createBtn.frame=CGRectMake(WindowWith/2-80/2, WindowHeight-60, 80, 40) ;
    [createBtn setTitle:@"发  布" forState:UIControlStateNormal];
    [createBtn setLayerMasksCornerRadius:20 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(15);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createBtn];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y=scrollView.contentOffset.y;
    
    if (y<=0) {
        [UIView animateWithDuration:0.5f animations:^{
			self->_createBtn.alpha=1;
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
			self->_createBtn.alpha=0;
        } completion:^(BOOL finished) {
        }];
    }
    if (y>_boundHeihgt) {
        [UIView animateWithDuration:0.5f animations:^{
			self->backTopbutton.alpha=1;
			[self.view bringSubviewToFront:self->backTopbutton];
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
			self->backTopbutton.alpha=0;
            
            // [self.view bringSubviewToFront:backTopbutton];
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
		self->_createBtn.alpha=1;
    }];
}

-(void)noticitionAddSupplyAndBuy:(NSNotification *)notificaiton{
    
    NSDictionary *dic=[notificaiton object];
    int type=[dic[@"type"]intValue];
    NSDictionary *contentDic=[dic objectForKey:@"content"];
    if (type==1) { //供应
        if (self.type==ENT_Supply) {
            MTSupplyAndBuyListModel *mod=[network getSupplyAndBuyForDic:contentDic type:IH_QuerySupplyList];
            [dataArray insertObject:mod atIndex:0];
            [commTableView.table reloadData];
        }
    }else if (type==2) {
        if (self.type==ENT_Buy) {
            MTSupplyAndBuyListModel *mod=[network getSupplyAndBuyForDic:contentDic type:IH_QueryBuyList];
            [dataArray insertObject:mod atIndex:0];
            [commTableView.table reloadData];
        }
    }
}

-(void)createBtnClick:(UIButton *)sender{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    
    if ([dic[@"mobile"] isEqualToString:@""]) {
        [self showLoginViewWithType:ENT_Lagin];
        return;
    }
    
    CreateBuyOrSupplyViewController *v=[[CreateBuyOrSupplyViewController alloc]init];
    v.type=self.type;
    v.ifQG=YES;
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:v];
    [self.inviteParentController presentViewController:nav animated:YES completion:nil];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    page=0;
    
    [_textFiled endEditing:YES];
    [_textFiled resignFirstResponder];
    [dataArray removeAllObjects];
    [commTableView.table reloadData];
    [self beginRefesh:ENT_RefreshHeader]; //进行下拉刷新
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_textFiled resignFirstResponder];
}

-(void)searchVarieties
{   page=0;
    [_textFiled resignFirstResponder];
    [dataArray removeAllObjects];
    [commTableView.table reloadData];
    [self beginRefesh:ENT_RefreshHeader]; //进行下拉刷新
    
}

-(void)loadRefesh:(MJRefreshComponent*)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    _varieties=_textFiled.text;
    
    if ([self.city isEqualToString:@"全部"]) {
        self.city=@"";
    }
    
    if (self.type==ENT_Supply) {
        
        [network getSupplyList:page maxResults:pageNum my_user_id:0 seedling_source_address:[ConfigManager returnString:self.city] varieties:[ConfigManager returnString:_varieties] success:^(NSDictionary *obj) {
            NSArray *arr=obj[@"content"];
			if (refreshView==self->commTableView.table.mj_header) {
				[self->dataArray removeAllObjects];
				self->page=0;
                if (arr.count==0) {
					[self->dataArray addObjectsFromArray:arr];
					[self->commTableView.table reloadData];
                }
                //  [IHUtility saveUserDefaluts:arr key:kSupplyDefaultUserList];
            }
            
            
            if (arr.count>0) {
				self->page++;
                if (arr.count<pageNum) {
					[self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
				[self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                [self endRefresh];
                return ;
            }
            
			[self->dataArray addObjectsFromArray:arr];
			[self->commTableView.table reloadData];
            [self endRefresh];
            
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
        }];
        
    }else if(self.type==ENT_Buy){
        
        
        
        [network getBuyList:page maxResults:pageNum my_user_id:0 mining_area:[ConfigManager returnString:self.city] varieties:[ConfigManager returnString:_varieties] success:^(NSDictionary *obj) {
            NSArray *arr=obj[@"content"];
            
			if (refreshView==self->commTableView.table.mj_header) {
				[self->dataArray removeAllObjects];
				self->page=0;
                if (arr.count==0) {
					[self->dataArray addObjectsFromArray:arr];
					[self->commTableView.table reloadData];
                }
                
            }
            
            if (arr.count>0) {
				self->page++;
                if (arr.count<pageNum) {
					[self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
				[self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                [self endRefresh];
                return ;
            }
            
			[self->dataArray addObjectsFromArray:arr];
			[self->commTableView.table reloadData];
            [self endRefresh];
            
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
        }];
    }
}
-(void)headwork:(MTSupplyAndBuyListModel *)model
{
    
    [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.userChildrenInfo.user_id intValue]success:^(NSDictionary *obj) {
        
        MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.userChildrenInfo.user_id :NO dic:obj[@"content"]];
        controller.userMod=model.userChildrenInfo;
        controller.dic=obj[@"content"];
        [self.inviteParentController pushViewController:controller];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

-(void)detail:(MTSupplyAndBuyListModel *)model isComment:(BOOL)isComment indexPath:(NSIndexPath *)indexPath
{
    GongQiuDetailsViewController *vc=[[GongQiuDetailsViewController alloc]init];
    vc.type=self.type;
    vc.model=model;
    vc.isBeginComment=isComment;
    vc.indexPath=indexPath;
    vc.delegate = self;
    vc.commentDelegate = self;
    vc.selectDeleteBlock=^(MTSupplyAndBuyListModel *model ,NSIndexPath *indexPath){
        
		[self->dataArray removeObjectAtIndex:indexPath.row];
        
        
		[self->commTableView.table reloadData];
        
    };
    [self.inviteParentController pushViewController:vc];
}

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    _selIndexPath=indexPath;
    MTSupplyAndBuyListModel *model=dataArray[indexPath.row];
    __weak GongQiuTableListViewController *weakSelf=self;
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
        [self headwork:model];
    }
    if (action==MTCommentActionTableViewCell) {
        NSLog(@"点击了评论");
        
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        [weakSelf detail:model isComment:YES indexPath:indexPath];
        
        
    }
    
    if (action==MTFavriteActionTableViewCell) {
        NSLog(@"收藏");
        
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        if (self.type==ENT_Supply) {
            [network getSupplyCollections:[model.supply_id intValue]user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
				MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                
                mod.hasCollection=YES;
                mod.collectionTotal=mod.collectionTotal+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
				[self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [self addSucessView:@"收藏成功" type:1];
            }];
        }else if (self.type==ENT_Buy)
        {
            [network getBuyCollections:[model.want_buy_id intValue] user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
				MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                
                mod.hasCollection=YES;
                mod.collectionTotal=mod.collectionTotal+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
				[self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [self addSucessView:@"收藏成功" type:1];
            }];
        }
        
    }
    
    if (action==MTShareActionTableViewCell) {
        NSLog(@"分享");
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        if (self.type==ENT_Buy||self.type==ENT_Supply) {
            [self shareView:self.type object:model vc:self];
        }
        
    }
    if (action==MTAgreeActionTableViewCell) {
        NSLog(@"点赞");
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        if (self.type==ENT_Supply) {
            
            [network getAddSupplyClickLike:[USERMODEL.userID intValue]supply_id:[model.supply_id intValue] type:0  success:^(NSDictionary *obj) {
                
				MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                int num=mod.clickLikeTotal;
                mod.hasClickLike=YES;
                mod.clickLikeTotal=num+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
				[self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [self addSucessView:@"点赞成功!" type:1];
            }];
        }else if (self.type==ENT_Buy)
        {
            [network getAddWantBuyClickLike:[USERMODEL.userID intValue]want_buy_id:[model.want_buy_id intValue] type:0  success:^(NSDictionary *obj) {
				MTSupplyAndBuyListModel *mod=[self->dataArray objectAtIndex:indexPath.row];
                mod.hasClickLike=YES;
                mod.clickLikeTotal=mod.clickLikeTotal+1;
                NSArray *indexArray=[NSArray arrayWithObject:indexPath];
				[self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [self addSucessView:@"点赞成功!" type:1];
            }];
        }
    }
}

#pragma mark tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
    return [model.cellHeigh floatValue];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTSupplyAndBuyListModel *model=[dataArray objectAtIndex:indexPath.row];
    
    [self detail:model  isComment:NO indexPath:indexPath];
}


-(void)disPlayAgree:(MTSupplyAndBuyListModel *)model indexPath:(NSIndexPath *)indexPath
{
    MTSupplyAndBuyListModel *mod=[dataArray objectAtIndex:indexPath.row];
    mod.hasClickLike=YES;
    
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

-(void)disPlayComment:(MTSupplyAndBuyListModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

-(void)GongQiuDeleteTableViewCell:(MTSupplyAndBuyListModel *)model indexPath:(NSIndexPath *)indexPath
{
    
    [dataArray replaceObjectAtIndex:indexPath.row withObject:model];
    
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


