//
//  ZhaoPingViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ZhaoPingViewController.h"
#import "CurriculumVitaeViewController.h"
#import "MJPopView.h"
#import "CreatPositionViewController.h"
#import "JLSimplePickViewComponent.h"
#import "JionEPCloudViewController.h"
@interface ZhaoPingViewController ()<UITableViewDelegate,JLActionSheetDelegate>
{
    MTBaseTableView *commTableView;
    MTBaseTableView *commTableView2;
    int page;
    int page2;
    NSMutableArray *dataArray;
    
    MTLogisticsChooseView *_logisticsView;
    SearchView *_searchV;
    UIButton* _createBtn;
    UIButton *_centerButton;
    NSString * _academic;
    NSString *_experience;
    NSString *_salary;
    NSString *_jobName;
    NSString *_jobNameSearce;
    NSMutableArray *_jobNameArr;
    UIView *_searchView;
    int job_name_id;
    SearchType _type;
    NSMutableArray *dataArray2;
    EmptyPromptView *_EPView;
    EmptyPromptView *_EPView2;
    NSInteger i;
}

@end

@implementation ZhaoPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [self setTitle:@"我要招聘"];
    _type=ENT_CloseSearch;
    [self creatTableView];
    
    UIImage *image = Image(@"Job_down.png");
    _centerButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _centerButton.frame=CGRectMake(0, 0, 150, 15);
    [_centerButton setTitle:@"牛人推荐" forState:UIControlStateNormal];
    [_centerButton setImage:image forState:UIControlStateNormal];
    [_centerButton setTitleColor:cGreenColor forState:UIControlStateNormal];
    
    CGSize size=[IHUtility GetSizeByText:@"牛人推荐" sizeOfFont:15 width:WindowWith];
    _centerButton.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
    _centerButton.titleEdgeInsets=UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width+3);
    
    _centerButton.titleLabel.font=sysFont(15);
    self.navigationItem.titleView=_centerButton;
    [_centerButton addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    
    _searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];
    _searchView.backgroundColor=RGB(247, 248, 250);
    _searchView.hidden=YES;
    [self.view addSubview:_searchView];
    
    //  __weak ZhaoPingViewController *weakSelf=self;
    dataArray2=[[NSMutableArray alloc]init];
    commTableView2=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView2.Mytype=ENT_Position;
    commTableView2.table.delegate=self;
    commTableView2.attribute=self;
    [commTableView2 setupData:dataArray2 index:39];
    _EPView2  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"当前未搜索到相关简历~"];
    _EPView2.hidden = YES;
    [commTableView2.table addSubview:_EPView2];
    
    [_searchView addSubview:commTableView2];
    
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createBtn.frame=CGRectMake(WindowWith/2-80/2, WindowHeight-60, 80, 38) ;
    [createBtn setTitle:@"发布" forState:UIControlStateNormal];
    _createBtn=createBtn;
    [createBtn setLayerMasksCornerRadius:20 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(15);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(creatPosition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createBtn];
}

-(void)creatPosition{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    NSDictionary *Dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
    
    if ([Dic[@"companyinfo"][@"status"] intValue]==0) {
        
        [IHUtility AlertMessage:@"温馨提示" message:[NSString stringWithFormat:@"为了营造真实的招聘环境，提高求职者对贵司的信心和求职意愿，请您申请加入%@企业云，认证您的真实身份。",KAppName] delegate:self cancelButtonTitle:@"申请企业云" otherButtonTitles:@"取消" tag:15];
        
    }else if ([Dic[@"companyinfo"][@"status"] intValue]==1){
        [IHUtility AlertMessage:@"温馨提示" message:@"很抱歉，您的企业云申请正在审核中，暂时无法发布招聘信息。" delegate:self cancelButtonTitle:@"查看企业云" otherButtonTitles:@"取消" tag:15];
    }else if ([Dic[@"companyinfo"][@"status"] intValue]==3){
        [IHUtility AlertMessage:@"温馨提示" message:@"很抱歉，您的企业云申请未成功，暂时无法发布招聘信息。" delegate:self cancelButtonTitle:@"查看企业云" otherButtonTitles:@"取消" tag:15];
    }else if ([Dic[@"companyinfo"][@"status"] intValue]==2){
        CreatPositionViewController *vc=[[CreatPositionViewController alloc]init];
        [self presentViewController:vc];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //__weak ZhaoPingViewController *weakSelf=self;
    if (alertView.tag==15) {
        if (buttonIndex==0) {
            JionEPCloudViewController *VC=[[JionEPCloudViewController alloc]init];
            
            [self pushViewController:VC];
        }
    }
}

-(void)choose{
    __weak ZhaoPingViewController *weakSelf=self;
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (NSDictionary *dic in _jobNameArr) {
        [arr addObject:dic[@"job_name"]];
    }
    
    MJPopView *popView=[[MJPopView alloc]initWithOrgin:self.navigationItem.titleView.bottom+20 x:self.view.centerX-50 arr:arr i:(int)arr.count img:Image(@"popbg2.png")];
    
    popView.selectBlock=^(NSInteger index){
        
		self->_jobName=arr[index];
		NSDictionary *dic=self->_jobNameArr[index];
		self->job_name_id=[dic[@"job_name_id"] intValue];
        
		[self->_centerButton setTitle:[NSString stringWithFormat:@"%@ v",self->_jobName] forState:UIControlStateNormal];
        [weakSelf beginRefesh:ENT_RefreshHeader];
    };
    [self.view addSubview:popView];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)creatTableView{
    
    
    _salary=@"";
    _academic=@"";
    _experience=@"";
    _jobName=@"";
    _jobNameSearce=@"";
    job_name_id=0;
    dataArray=[[NSMutableArray alloc]init];
    __weak ZhaoPingViewController *weakSelf=self;
    [self setbackTopFrame:WindowHeight-60];
    NSArray *arr = @[@"学历",@"经验",@"薪资"];
    MTLogisticsChooseView *logisticsView=[[MTLogisticsChooseView alloc]initWithOrgane:CGPointMake(0, 0) array:arr];
    logisticsView.backgroundColor = [UIColor whiteColor];
    _logisticsView = logisticsView;
    [self.view addSubview:logisticsView];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, logisticsView.bottom, WindowWith, WindowHeight-43) tableviewStyle:UITableViewStylePlain];
    //    commTableView.table.tableHeaderView=logisticsView;
    self.view.backgroundColor=RGB(247, 248, 250);
    commTableView.Mytype=ENT_Position;
    commTableView.table.delegate=self;
    commTableView.attribute=self;
    [commTableView setupData:dataArray index:39];
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshHeader];
    _EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"目前还没有简历信息哦~"];
    _EPView.hidden = YES;
    [commTableView.table addSubview:_EPView];
    logisticsView.selectBtnBlock=^(NSInteger index,UIButton *btn){
        if (index==SelectStartBlock) {
            NSLog(@"start");
            [weakSelf showPicViewWithArr:@[@"不限",@"大专以下",@"大专",@"本科",@"硕士",@"博士"] :@"学历" :21];
            
        }else if (index==SelectEntBlock){
            NSLog(@"end");
            [weakSelf showPicViewWithArr:@[@"不限",@"应届生",@"1年内",@"1-3年",@"3-5年",@"5-10年",@"10年以上"] :@"经验" :22];
            
        }else if (index==SelectTimeBlock){
            NSLog(@"time");
            [weakSelf showPicViewWithArr:@[@"不限",@"面议",@"3k以下",@"3k-5k",@"5k-10k",@"10k-20k",@"20k-50k",@"50k以上"] :@"薪资" :23];
        }
    };
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    
    if (_type==ENT_CloseSearch) {
        
        if (refreshView==commTableView.table.mj_header) {
            page=0;
        }
        
        [network selectRecruitList:_academic
                            salary:_salary
                        experience:_experience
                       job_name_id:job_name_id
                           user_id:[USERMODEL.userID intValue]
                              page:page
                               num:10
                           success:^(NSDictionary *obj) {
                               
                               NSArray *arr=obj[@"resumeList"];
							   if (self->job_name_id==0) {
								   [self->_jobNameArr removeAllObjects];
								   self->_jobNameArr=[[NSMutableArray alloc]initWithArray:obj[@"jobNames"]];
								   if (self->_jobNameArr.count>0) {
                                       NSDictionary *dic=@{@"job_name_id": @0,
                                                           @"job_name": @"牛人推荐"};
									   [self->_jobNameArr insertObject:dic atIndex:0];
                                   }
                               }
                               
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
								   self->_EPView.hidden=YES;
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
                               [self endRefresh];
                               
                           } failure:^(NSDictionary *obj2) {
                               [self endRefresh];
                           }];
        
    }else{
        
        if (refreshView==commTableView2.table.mj_header) {
            page2=0;
        }
        
        
        [network selectRecruitListWithSearch:_jobNameSearce
                                        page:page2
                                         num:10
                                     success:^(NSDictionary *obj) {
                                         
                                         NSArray *arr=obj[@"content"];
                                         
										 if (refreshView==self->commTableView2.table.mj_header) {
                                             
											 [self->dataArray2 removeAllObjects];
											 self->page2=0;
                                             if (arr.count==0) {
												 [self->dataArray2 addObjectsFromArray:arr];
												 [self->commTableView2.table reloadData];
                                             }
                                             
											 [self->commTableView2.table.mj_footer resetNoMoreData];
                                         }
                                         
                                         if (arr.count>0) {
											 self->_EPView2.hidden=YES;
											 self->page2++;
                                             if (arr.count<pageNum) {
												 [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                                             }
                                         }else{
											 if (self->dataArray2.count == 0) {
                                                 
												 self->_EPView2.hidden = NO;
                                             }else{
												 self->_EPView2.hidden = YES;
                                             }
                                             
											 [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                                             [self endRefresh];
                                             return;
                                         }
                                         
										 [self->dataArray2 addObjectsFromArray:arr];
										 [self->commTableView2.table reloadData];
                                         [self endRefresh];
                                         
                                     } failure:^(NSDictionary *obj2) {
                                         [self endRefresh];
                                     }];
    }
    
}

-(void)showPicViewWithArr:(NSArray *)arr :(NSString *)title :(NSInteger)tag
{
    JLSimplePickViewComponent *pickView =(JLSimplePickViewComponent*)[self.view viewWithTag:tag];
    if(pickView == nil)
    {
        
        pickView = [[JLSimplePickViewComponent alloc] initWithParams:title withData:arr];
        pickView.tag=tag;
        pickView.ActionSheetDelegate = self;
    }
    [pickView show];
    
}


-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedData:(NSString *)SelectedStr
{
    UIButton *button = [_logisticsView viewWithTag:pickViewComponent.tag -21 + 1000];
    button.selected = !button.selected;
    
    [button setTitle:SelectedStr forState:UIControlStateNormal];
    [button setTitleColor:cGreenColor forState:UIControlStateNormal];
    if (pickViewComponent.tag==21) {
        _academic=SelectedStr;
        if ([SelectedStr isEqualToString:@"不限"]) {
            [button setTitle:@"不限" forState:UIControlStateNormal];
            [button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
            _academic=@"";
        }
    }else if(pickViewComponent.tag==22)
    {
        
        _experience=SelectedStr;
        if ([SelectedStr isEqualToString:@"不限"]) {
            [button setTitle:@"不限" forState:UIControlStateNormal];
            [button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
            _experience=@"";
        }
        
    }else if(pickViewComponent.tag==23)
    {
        
        _salary=SelectedStr;
        if ([SelectedStr isEqualToString:@"不限"]) {
            [button setTitle:@"不限" forState:UIControlStateNormal];
            [button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
            _salary=@"";
        }
    }
    
    CGSize size = [IHUtility GetSizeByText:button.titleLabel.text sizeOfFont:13 width:(WindowWith-36)/4.0];
    button.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
    button.titleEdgeInsets=UIEdgeInsetsMake(0, -button.imageView.frame.size.width, 0, button.imageView.frame.size.width+3);
    
    [self beginRefesh:ENT_RefreshHeader];
}

- (void)home:(id)sender
{
    __weak ZhaoPingViewController *weakSelf=self;
    
    if (i!=1) {
        i=1;
        
        [self CreateBaseRefesh:commTableView2 type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
            [weakSelf loadRefesh:refreshView];
        }];
    }
    
    SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 44)];
    //searchV.backgroundColor = self.navigationController.navigationBar.backgroundColor;
    _searchV = searchV;
    searchV.textfiled.placeholder=@" 请输入用户名";
    __weak SearchView *searchSelf = searchV;
    _searchView.hidden=NO;
    _type=ENT_Search;
    [searchV.textfiled becomeFirstResponder];
    searchV.selectBtnBlock = ^(NSInteger index){
        if (index == SelectBackVC) {
            
			[self->dataArray2 removeAllObjects];
			[self->commTableView2.table reloadData];
			self->page2=0;
            
			self->_searchView.hidden=YES;
            [searchSelf removeFromSuperview];
			self->rightbutton.hidden = NO;
            
			self->_jobName=@"";
			self->_jobNameSearce=@"";
			self->_type=ENT_CloseSearch;
            // [weakSelf beginRefesh:ENT_RefreshHeader];
            
        }else if (index == SelectBtnBlock){
            
			self->_jobNameSearce=searchSelf.textfiled.text;
            
            [weakSelf beginRefesh:ENT_RefreshFooter];
			[self->commTableView2.table reloadData];
        }
    };
    
    [self.navigationController.navigationBar addSubview:searchV];
    rightbutton.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchV removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightButtonImage:Image(@"Search Icon.png") forState:UIControlStateNormal];
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

- (void)scrollViewDidEndDecelerating:(MTBaseTableView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
		self->_createBtn.alpha=1;
    }];
    
}
-(void)back:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    _searchView.hidden=YES;
    [dataArray2 removeAllObjects];
    [commTableView2.table reloadData];
    page2=0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    jianliModel *model;
    if (_type==ENT_CloseSearch) {
        model=dataArray[indexPath.row];
    }else{
        model=dataArray2[indexPath.row];
    }
    
    CGSize size=[IHUtility GetSizeByText:model.advantage sizeOfFont:12 width:WindowWith-10-11*2];
    
    return 121+13+8+size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    jianliModel *model;
    if (_type==ENT_CloseSearch) {
        model=dataArray[indexPath.row];
    }else{
        model=dataArray2[indexPath.row];
    }
    CurriculumVitaeViewController *vc=[[CurriculumVitaeViewController alloc]init];
    vc.resume_id=[model.resume_id intValue];
    vc.useId=model.user_id;
    [self pushViewController:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
