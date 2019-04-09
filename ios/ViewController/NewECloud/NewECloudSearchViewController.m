//
//  NewECloudSearchViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/21.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NewECloudSearchViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "EPCloudDetailViewController.h"
#import "SeedCloudDetailViewController.h"
@interface NewECloudSearchViewController ()<UITableViewDelegate>
{
    SearchView *_searchV;
    MTBaseTableView *commTableView;
    MTBaseTableView *commTableView2;
    int page;
    NSMutableArray *dataArray;
    NSMutableArray *btnArray;//热门搜索或者附近的人
    NSArray *array;//附近的人
    NSIndexPath *_indexPath;
    UIView *_searchView;
    SearchType _searchType;
    NSString *_nickName;
    NSInteger btnIndex;//选择按钮的索引
    NSString *_nursery;
}
@end

@implementation NewECloudSearchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self home:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"人脉搜索"];
    if (self.type==ENT_company) {
        [self setTitle:@"企业搜索"];
    }else if (self.type==ENT_nursery){
        [self setTitle:@"苗木搜索"];
    }
    _searchType=ENT_CloseSearch;
    _nickName=@"";
    _nursery=@"";
    // [self setRightButtonImage:Image(@"Search Icon.png") forState:UIControlStateNormal];
    dataArray=[[NSMutableArray alloc]init];
    btnArray =[[NSMutableArray alloc]init];
    
    
    if (self.type == ENT_company) {
        
        [network getHistoryEPCloudByList:1 success:^(NSDictionary *obj) {
            NSArray *Arr = obj[@"content"];
            [self->btnArray removeAllObjects];
            for (NSDictionary *dic in Arr) {
                [self->btnArray addObject:dic[@"searchWord"]];
            }
            //创建搜索历史和热门搜索
            [self initViews];
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else if (self.type==ENT_nursery){
        
        
        [network getHistoryEPCloudByList:3 success:^(NSDictionary *obj) {
            NSArray *Arr = obj[@"content"];
            [self->btnArray removeAllObjects];
            for (NSDictionary *dic in Arr) {
                [self->btnArray addObject:dic[@"searchWord"]];
            }
            //创建搜索历史和热门搜索
            [self initViews];
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
    else {
        
        [network getQueryUserByList:2
                                num:15
                               page:0
                           latitude:USERMODEL.latitude
                          longitude:USERMODEL.longitude
                           nickname:@""
                            version:@"2"
                            success:^(NSDictionary *obj) {
                                
                                NSArray *Arr=obj[@"content"];
                                self->array = Arr;
                                [self->btnArray removeAllObjects];
                                for (MTNearUserModel *model in Arr) {
                                    [self->btnArray addObject:model.nickname];
                                }
                                //创建搜索历史和附近的人
                                [self initViews];
                                
                            } failure:^(NSDictionary *obj2) {
                                
                            }];
    }
    
}
- (void)initViews
{
    __weak NewECloudSearchViewController *weakSelf=self;
    NSString *title;
    if (self.type == ENT_company) {
        title = @"热门搜索";
    }else if (self.type==ENT_nursery){
        title = @"热门搜索";
    }
    else {
        title = @"附近的人";
    }
    //热门搜索
    ButtonTypesetView *HotSearchView = [[ButtonTypesetView alloc] initWithFrame:CGRectMake(0, 15, WindowWith, 100) dataArr:btnArray title:title];
    HotSearchView.selectBlock = ^(NSInteger index){
        
        [weakSelf creatSearch:index];
        
    };
    [self.view addSubview:HotSearchView];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, HotSearchView.bottom, WindowWith-24, 1)];
    lineView.backgroundColor=cLineColor;
    [self.view addSubview:lineView];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, lineView.bottom+10, WindowWith, WindowHeight - lineView.bottom-10) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    NSArray *Arr2=[IHUtility getUserdefalutsList:kSearchHistory];
    if (self.type == ENT_company) {
        Arr2=[IHUtility getUserdefalutsList:kEPCloudSearchHistory];
    }else if(self.type==ENT_nursery){
        Arr2=[IHUtility getUserdefalutsList:kNurserySearchHistory];
    }
    [commTableView setupData:Arr2 index:45];
    if (Arr2.count==0) {
        commTableView.hidden=YES;
    }
    [self.view addSubview:commTableView];
    
    _searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];
    _searchView.hidden=YES;
    _searchView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_searchView];
    
    [self.view bringSubviewToFront:_searchView];
    
    commTableView2=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView2.attribute=self;
    commTableView2.table.delegate=self;
    commTableView2.backgroundColor = cLineColor;
    
    [_searchView addSubview:commTableView2];
}

-(void)creatSearch:(NSInteger)index{
    __weak NewECloudSearchViewController *weakSelf=self;
    btnIndex = index;
    if (self.type == ENT_company ||self.type==ENT_nursery) {
        
        _searchType=ENT_Search;
        _searchView.hidden=NO;
        _nickName = btnArray[index];
        
        [weakSelf home:_nickName];
        [weakSelf CreateBaseRefesh:commTableView2 type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
            [weakSelf loadRefesh:refreshView];
        }];
        [weakSelf beginRefesh:ENT_RefreshHeader];
        if (self.type == ENT_company) {
            [commTableView2 setupData:dataArray index:29];
        }else if (self.type==ENT_nursery){
            [commTableView2 setupData:dataArray index:52];
        }
    }else {
        MTNearUserModel *model=array[index];
        [weakSelf addWaitingView];
        [network selectUseerInfoForId:[model.user_id intValue]
                              success:^(NSDictionary *obj) {
                                  
                                  UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:model];
                                  [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]success:^(NSDictionary *obj) {
                                      [weakSelf removeWaitingView];
                                      MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.user_id :NO dic:obj[@"content"]];
                                      controller.userMod=usermodel;
                                      controller.dic=obj[@"content"];
                                      [weakSelf pushViewController:controller];
                                  } failure:^(NSDictionary *obj2) {
                                      
                                  }];
                              } failure:^(NSDictionary *obj2) {
                                  
                              }];
    }
}

- (void)home:(id)sender
{
    __weak NewECloudSearchViewController *weakSelf=self;
    if (_searchV==nil) {
        SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 44)];
        // searchV.backgroundColor = self.navigationController.navigationBar.backgroundColor;
        _searchV = searchV;
    }
    
    if ([sender isKindOfClass:[NSString class]]) {
        _searchV.textfiled.text = sender;
    }
    if (self.type == ENT_company) {
        _searchV.textfiled.placeholder=@" 请输入公司名";
    }else if(self.type == ENT_nursery){
        _searchV.textfiled.placeholder=@" 请输入苗木名称";
    }else{
        _searchV.textfiled.placeholder=@" 请输入用户名";
    }
    __weak SearchView *searchSelf = _searchV;
    _searchV.selectBtnBlock = ^(NSInteger index){
        if (index == SelectBackVC) {
            
            [searchSelf removeFromSuperview];
            
            [weakSelf selectBack];
            
        }else if (index == SelectBtnBlock){
            
            
            [weakSelf selectBtn];
            
        }
    };
    
    [self.navigationController.navigationBar addSubview:_searchV];
    rightbutton.hidden = YES;
    [_searchV.textfiled becomeFirstResponder];
}
//点击搜索
-(void)selectBtn{
    
    __weak NewECloudSearchViewController *weakSelf=self;
    __weak SearchView *searchSelf = _searchV;
    NSArray *Arr;
    if (self.type == ENT_company) {
        Arr=[IHUtility getUserdefalutsList:kEPCloudSearchHistory];
    }else if (self.type==ENT_nursery){
        Arr=[IHUtility getUserdefalutsList:kNurserySearchHistory];
    }
    else{
        Arr=[IHUtility getUserdefalutsList:kSearchHistory];
    }
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    [arr addObjectsFromArray:Arr];
    for (NSString *str in Arr) {
        if ([str isEqualToString:searchSelf.textfiled.text]) {
            [arr removeObject:str];
        }
    }
    [arr addObject:searchSelf.textfiled.text];
    if (self.type == ENT_company) {
        [IHUtility saveUserDefaluts:arr key:kEPCloudSearchHistory];
    }else if (self.type==ENT_nursery){
        [IHUtility saveUserDefaluts:arr key:kNurserySearchHistory];
    }
    else {
        [IHUtility saveUserDefaluts:arr key:kSearchHistory];
    }
    
    _searchType=ENT_Search;
    _searchView.hidden=NO;
    _nickName=searchSelf.textfiled.text;
    [self CreateBaseRefesh:commTableView2 type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [weakSelf beginRefesh:ENT_RefreshHeader];
    if (self.type == ENT_company) {
        [commTableView2 setupData:dataArray index:29];
    }else if (self.type==ENT_nursery){
        [commTableView2 setupData:dataArray index:52];
    }
    else{
        [commTableView2 setupData:dataArray index:33];
    }
}

//点击取消
-(void)selectBack{
    _searchType=ENT_CloseSearch;
    //rightbutton.hidden = NO;
    _searchView.hidden=YES;
    
    [self back:nil];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    [_searchV.textfiled resignFirstResponder];  //放弃第一响应
    
    if (refreshView==commTableView2.table.mj_header) {
        page=0;
    }
    
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    if (self.type == ENT_company) {
        [network getEPCloudListWithProvice:@"" City:@"" Area:@"" company_name:_nickName design_lv:@"" project_lv:@"" company_label_id:@"0" TypeID:0 Level:0 page:page num:10 staff_size:@"" success:^(NSDictionary *obj) {
            NSArray *arr=obj[@"content"];
            
            if (refreshView==self->commTableView2.table.mj_header) {
                
                [self->dataArray removeAllObjects];
                self->page=0;
                if (arr.count==0) {
                    [self->dataArray addObjectsFromArray:arr];
                    [self->commTableView2.table reloadData];
                }
                
                [self->commTableView2.table.mj_footer resetNoMoreData];
            }
            
            if (arr.count>0) {
                self->page++;
                if (arr.count<pageNum) {
                    [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                [self endRefresh];
                return;
            }
            
            [self->dataArray addObjectsFromArray:arr];
            [self->commTableView2.table reloadData];
            [self endRefresh];
            
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
        }];
        
    }else if (self.type==ENT_nursery){
        [network selectNurseryDetailListByPage:0
                             nursery_type_name:_nickName
                                          page:page
                                           num:10
         
                                       success:^(NSDictionary *obj) {
                                           NSArray *arr=obj[@"content"];
                                           
                                           
                                           
                                           if (refreshView==self->commTableView2.table.mj_header) {
                                               
                                               [self->dataArray removeAllObjects];
                                               self->page=0;
                                               if (arr.count==0) {
                                                   [self->dataArray addObjectsFromArray:arr];
                                                   [self->commTableView2.table reloadData];
                                               }
                                               
                                               [self->commTableView2.table.mj_footer resetNoMoreData];
                                           }
                                           
                                           if (arr.count>0) {
                                               self->page++;
                                               if (arr.count<pageNum) {
                                                   [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                                               }
                                           }else{
                                               [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                                               [self endRefresh];
                                               return;
                                           }
                                           
                                           [self->dataArray addObjectsFromArray:arr];
                                           [self->commTableView2.table reloadData];
                                           [self endRefresh];
                                           
                                       } failure:^(NSDictionary *obj2) {
                                           [self endRefresh];
                                       }];
    }
    else{
        
        [network selectUserInfoCloudListtWithProvice:@""
                                                City:@""
                                                Area:@""
                                               title:@""
                                            job_type:0
                                             user_id:[USERMODEL.userID intValue]
                                            nickname:_nickName
                                                page:page
                                                 num:10
                                               order:@""
                                             success:^(NSDictionary *obj) {
                                                 NSArray *arr=obj[@"content"];
                                                 
                                                 
                                                 
                                                 if (refreshView==self->commTableView2.table.mj_header) {
                                                     
                                                     [self->dataArray removeAllObjects];
                                                     self->page=0;
                                                     if (arr.count==0) {
                                                         [self->dataArray addObjectsFromArray:arr];
                                                         [self->commTableView2.table reloadData];
                                                     }
                                                     
                                                     [self->commTableView2.table.mj_footer resetNoMoreData];
                                                 }
                                                 
                                                 if (arr.count>0) {
                                                     self->page++;
                                                     if (arr.count<pageNum) {
                                                         [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                                                     }
                                                 }else{
                                                     [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                                                     [self endRefresh];
                                                     return;
                                                 }
                                                 
                                                 [self->dataArray addObjectsFromArray:arr];
                                                 [self->commTableView2.table reloadData];
                                                 [self endRefresh];
                                                 
                                             } failure:^(NSDictionary *obj2) {
                                                 [self endRefresh];
                                             }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchV removeFromSuperview];
    
    _searchType=ENT_CloseSearch;
    rightbutton.hidden = NO;
    _searchView.hidden=YES;
    
    
    NSArray *Arr=[IHUtility getUserdefalutsList:kSearchHistory];
    if (self.type == ENT_company) {
        Arr=[IHUtility getUserdefalutsList:kEPCloudSearchHistory];
    }else if (self.type==ENT_nursery){
        Arr=[IHUtility getUserdefalutsList:kNurserySearchHistory];
    }
    if (Arr.count!=0) {
        commTableView.hidden=NO;
    }
    [commTableView setupData:Arr index:45];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchType==ENT_Search) {
        if (self.type == ENT_Connections) {
            return 0.421*WindowWith;
        }else if (self.type==ENT_nursery){
            NurseryListModel *model=dataArray[indexPath.row];
            return [model.cellHeigh doubleValue];
        }
        else{
            return 77 + 163*WindowWith/375.0;//企业云单元格的高度
        }
    }
    return 40;
}

//段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchType==ENT_Search) {
        return 0;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_searchType==ENT_Search) {
        return 0;
    }
    return 30;
}

#pragma mark - 外观代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 52)];
    view.backgroundColor=[UIColor whiteColor];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15 , 5, WindowWith-30, 14) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text=@"搜索历史";
    [view addSubview:lbl];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 52)];
    view.backgroundColor=[UIColor whiteColor];
    view.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clean)];
    [view addGestureRecognizer:tap];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15 , 10, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text=@"清除历史记录";
    lbl.centerX=self.view.centerX;
    [view addSubview:lbl];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    __weak NewECloudSearchViewController *weakSelf=self;
    
    if (_searchType==ENT_Search) {
        if (self.type==ENT_nursery) {
            NurseryListModel *model = dataArray[indexPath.row];
            SeedCloudDetailViewController *detailVC =[[SeedCloudDetailViewController alloc]init];
            detailVC.listModel=model;
            [self pushViewController:detailVC];
            
        }else if (self.type==ENT_company){
            EPCloudListModel *model=dataArray[indexPath.row];
            EPCloudDetailViewController *vc=[[EPCloudDetailViewController alloc]init];
            vc.model=model;
            [self pushViewController:vc];
        }else{
            
            MTConnectionModel *model=dataArray[indexPath.row];
            [self addWaitingView];
            [network selectUseerInfoForId:[model.user_id intValue]
                                  success:^(NSDictionary *obj) {
                                      MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                                      UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                                      [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]success:^(NSDictionary *obj) {
                                          [self removeWaitingView];
                                          MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.user_id :NO dic:obj[@"content"]];
                                          controller.delegate = (id<Follwer>)self;
                                          controller.userMod=usermodel;
                                          controller.dic=obj[@"content"];
                                          controller.indexPath=indexPath;
                                          [self pushViewController:controller];
                                      } failure:^(NSDictionary *obj2) {
                                          
                                      }];
                                      
                                  } failure:^(NSDictionary *obj2) {
                                      
                                  }];
        }
    }else if (_searchType==ENT_CloseSearch){
        
        NSArray *Arr2=[IHUtility getUserdefalutsList:kSearchHistory];
        if (self.type == ENT_company) {
            Arr2=[IHUtility getUserdefalutsList:kEPCloudSearchHistory];
        }else if (self.type==ENT_nursery){
            Arr2=[IHUtility getUserdefalutsList:kNurserySearchHistory];
        }
        _nickName=Arr2[indexPath.row];
        _searchType=ENT_Search;
        _searchView.hidden=NO;
        [self CreateBaseRefesh:commTableView2 type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
            [weakSelf loadRefesh:refreshView];
        }];
        [weakSelf beginRefesh:ENT_RefreshHeader];
        if (self.type == ENT_company) {
            [commTableView2 setupData:dataArray index:29];
        }else if (self.type==ENT_nursery){
            [commTableView2 setupData:dataArray index:52];
        }
        else{
            [commTableView2 setupData:dataArray index:33];
        }
        [self home:_nickName];
    }
}

//清楚搜索历史
-(void)clean{
    
    
    commTableView.hidden=YES;
    
    if (self.type==ENT_company) {
        [IHUtility saveUserDefaluts:@[] key:kEPCloudSearchHistory];
    }else if (self.type==ENT_nursery){
        [IHUtility saveUserDefaluts:@[] key:kNurserySearchHistory];
    }else{
        NSArray *Arr=[IHUtility getUserdefalutsList:kSearchHistory];
        
        NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:Arr];
        [arr removeAllObjects];
        [IHUtility saveUserDefaluts:arr key:kSearchHistory];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
