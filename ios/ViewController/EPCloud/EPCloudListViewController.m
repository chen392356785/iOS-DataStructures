//
//  EPCloudListViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 5/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "EPCloudListViewController.h"
#import "CustomView+CustomCategory2.h"
#import "EPCloudDetailViewController.h"
//#import "BindenterpriseViewController.h"
#import "JionEPCloudViewController.h"

@interface EPCloudListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    MTBaseTableView *commTableView2;
    int page;
    NSMutableArray *dataArray;
    NSIndexPath *_indexPath;
    AreaView *_areaV;
    MTLogisticsChooseView *_logisticsView;
    SearchView *_searchV;
    NSString *_provice;
    NSString *_city;
    NSString *_scale;
    NSString *_company_name;
    NSString *_design_lv;//设计资质
    NSString *_project_lv;//工程资质
    int level;
    int typeID;
    UIButton *_createBtn;
    
    UIView *_searchView;//搜索结果遮罩
    NSMutableArray *dataArray2;
    ButtonTypesetView *_HotSearchView;//热门搜索
    
}

//#define  WindowHeight-60  WindowHeight-60

@end

@implementation EPCloudListViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
   // [self setRightButtonImage:Image(@"Search Icon.png") forState:UIControlStateNormal];
    //当点击搜索结果进入详情返回来重新显示搜索框
    if (_company_name.length > 0) {
        [self home:nil];
        _searchV.textfiled.text = _company_name;
        _searchView.hidden = YES;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _provice = @"";
    _city = @"";
    _scale = @"";
    _company_name = @"";
    _design_lv = @"";
    _project_lv = @"";
    level = 0;
    typeID = 0;
    
    [self setTitle:@"企业"];
    self.view.backgroundColor= cLineColor;
    
    __weak EPCloudListViewController *weakSelf=self;
    SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(40, 0, WindowWith - 40, 44)];
    searchV.textfiled.placeholder=@"请输入想找的企业名";
    searchV.backgroundColor = [UIColor whiteColor];
    _searchV = searchV;
    //显示遮罩
   
    __weak SearchView *searchSelf = searchV;
    searchV.selectBtnBlock=^(NSInteger index){
       
            if (index == SelectBackVC) {
                if (self->_company_name.length > 0) {
                    self->_company_name = @"";
                    //刷新列表
                    searchSelf.textfiled.text=@"";
                    [weakSelf beginRefesh:ENT_RefreshHeader];
                }
                //隐藏搜索遮罩
                self->_searchView.hidden = YES;
                [self->dataArray2 removeAllObjects];
                
                [searchSelf.textfiled resignFirstResponder];
                
                
            }else if (index == SelectBtnBlock){
                self->_company_name = searchSelf.textfiled.text;
                self->_searchView.hidden = YES;
                //刷新列表
                [weakSelf beginRefesh:ENT_RefreshHeader];
                [weakSelf SaveSearchHistory:self->_company_name];
            }else if (index == openBlock){
                //隐藏筛选条件弹层
                [self removeAreaView];
                
                //开始编辑搜索框内容
                self->_searchView.hidden = NO;
               
            }

        
    };
//    self.navigationItem.titleView = _searchV;
    [self.navigationController.navigationBar addSubview:_searchV];
    
    [self creatTableView];
    
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createBtn.frame=CGRectMake(WindowWith/2-128/2, WindowHeight-60, 128, 38) ;
    [createBtn setTitle:@"+ 加入园林云" forState:UIControlStateNormal];
    _createBtn=createBtn;
    [createBtn setLayerMasksCornerRadius:20 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(15);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    if (USERMODEL.auth_status!=2) {
        [self.view addSubview:createBtn];
    }
    [createBtn addTarget:self action:@selector(addCompanyCloud:) forControlEvents:UIControlEventTouchUpInside];
    
    //职位名称搜索历史和热门搜索遮罩
    [self addSearchListView];
    
}
-(void)creatTableView
{
    
    
    NSArray *arr = @[@"区域",@"行业类型",@"资质",@"规模"];
    MTLogisticsChooseView *logisticsView=[[MTLogisticsChooseView alloc]initWithOrgane:CGPointMake(0, 0) array:arr];
    logisticsView.backgroundColor = [UIColor whiteColor];
    _logisticsView = logisticsView;
    [self.view addSubview:logisticsView];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, logisticsView.bottom, WindowWith, WindowHeight - 43) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:29];
    commTableView.backgroundColor = cLineColor;
    __weak EPCloudListViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshHeader];
    

    

    logisticsView.selectBtnBlock=^(NSInteger index,UIButton *sender){
        if (index==SelectStartBlock) {
            NSLog(@"start");
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"dataArea" ofType:@"plist"];
            NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
            [weakSelf addScreenView:dataDic grade:2 string:@"区域" sender:sender];
            
        }else if (index==SelectEntBlock){
            NSLog(@"end");

            NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
            NSArray *hyArray=[[NSMutableArray alloc]initWithArray:dic2[@"industryInfoList"]];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in hyArray) {
                [arr addObject:dic[@"i_name"]];
            }
            NSDictionary *hyDic = [NSDictionary dictionaryWithObject:arr forKey:@"行业"];
            [weakSelf addScreenView:hyDic grade:1 string:@"行业类别" sender:sender];
            
        }else if (index==SelectTimeBlock){
            NSLog(@"time");
            
            NSArray *arr1 = @[@"甲级资质",@"乙级资质"];
            NSArray *arr = @[@"一级资质",@"二级资质",@"三级资质"];
            NSMutableDictionary *gradeDic = [[NSMutableDictionary alloc] init];
            [gradeDic setObject:arr1 forKey:@"设计"];
            [gradeDic setObject:arr forKey:@"工程"];
            [weakSelf addScreenView:gradeDic grade:1 string:@"资质" sender:sender];
        }else if (index==SelectMoreBlock){
            NSLog(@"more");
            
            NSArray *arr = @[@"1-19人",@"20-49人",@"50-99人",@"100-499人",@"500-999人",@"1000-9999人",@"10000以上"];
            
            NSDictionary *scaleDic = [NSDictionary dictionaryWithObject:arr forKey:@"规模"];
            [weakSelf addScreenView:scaleDic grade:1 string:@"规模" sender:sender];
        }
    };
    
    

}
- (void)addSearchListView
{
    __weak EPCloudListViewController *weakSelf=self;
    dataArray2 =[[NSMutableArray alloc]init];
    _searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];
    _searchView.backgroundColor=[UIColor whiteColor];
    _searchView.hidden=YES;
    [self.view addSubview:_searchView];
    
    [network getHistoryEPCloudByList:1 success:^(NSDictionary *obj) {
        NSArray *Arr = obj[@"content"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in Arr) {
            [array addObject:dic[@"searchWord"]];
        }
        //创建搜索历史和热门搜索
        //热门搜索
        ButtonTypesetView *HotSearchView = [[ButtonTypesetView alloc] initWithFrame:CGRectMake(0, 15, WindowWith, 100) dataArr:array title:@"热门搜索"];
        HotSearchView.selectBlock = ^(NSInteger index){
        
            //参数赋值 搜索历史弹层隐藏
            [weakSelf companyName:array index:index];
            //刷新列表
            [weakSelf beginRefesh:ENT_RefreshHeader];
        };
        
        [self->_searchView addSubview:HotSearchView];

        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, HotSearchView.bottom, WindowWith-24, 1)];
        lineView.backgroundColor=cLineColor;
        [self->_searchView addSubview:lineView];
        
        //搜索历史列表
        self->commTableView2=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, lineView.bottom+10, WindowWith, WindowHeight - lineView.bottom-10) tableviewStyle:UITableViewStylePlain];
        self->commTableView2.attribute=self;
        self->commTableView2.table.delegate=self;
        NSArray *Arr2=[IHUtility getUserdefalutsList:kEPCloudSearchHistory];
        [self->commTableView2 setupData:Arr2 index:45];
        if (Arr2.count==0) {
            self->commTableView2.hidden=YES;
        }
        
        [self->_searchView addSubview:self->commTableView2];

    } failure:^(NSDictionary *obj2) {
        
    }];

}
- (void)companyName:(NSArray *)array index:(NSInteger)index
{
    _company_name = array[index];
    [_searchV.textfiled resignFirstResponder];
    _searchV.textfiled.text = _company_name;
    _searchView.hidden = YES;
}
//保存搜索的历史到本地
- (void)SaveSearchHistory:(NSString *)searchText
{
    //获取本地保存的搜索历史记录
    NSArray *Arr=[IHUtility getUserdefalutsList:kEPCloudSearchHistory];
    
    //判断是否已存在这条记录  如果存在就先删除原有的在保存最新的
    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:Arr];
    for (NSString *str in Arr) {
        if ([str isEqualToString:searchText]) {
            [arr removeObject:str];
        }
    }
    [arr addObject:searchText];
    [IHUtility saveUserDefaluts:arr key:kEPCloudSearchHistory];
    
    
    //搜索完之后及时更新搜索历史记录
    NSArray *Arr2=[IHUtility getUserdefalutsList:kEPCloudSearchHistory];
    [commTableView2 setupData:Arr2 index:45];
    if (Arr2.count==0) {
        commTableView2.hidden=YES;
    }else{
        commTableView2.hidden=NO;
    }
    
}


- (void)addScreenView:(NSDictionary *)dic grade:(int)grade string:(NSString *)str sender:(UIButton *)sender
{
    if (sender.selected) {
        
            if (_areaV) {
                _areaV.alpha =0 ;
                [_areaV removeFromSuperview];
            }
            AreaView *areaV = [[AreaView alloc] initWithFrame:CGRectMake(0, -(WindowHeight- _logisticsView.bottom), WindowWith, WindowHeight- _logisticsView.bottom) dataDic:dic grade:grade];
            _areaV=areaV;
        if ([str isEqualToString:@"资质"]) {
            [_areaV.btn setTitle:@"不限" forState:UIControlStateNormal];
        }
        areaV.backgroundColor = RGBA(0, 0, 0, 0);
        areaV.selectBtnBlock=^(NSInteger index){
            
        };
        areaV.selectBlock = ^(NSString *provice,NSString *city){
                sender.selected = NO;
            //如果筛选条件为一级的时候 只取返回字段city即所选择的筛选条件  如果筛选条件像城市区域筛选一样是二级选择 那Provice即为第一级所选条件 city为第二级所选条件
                if (grade == 1) {
                    if (city.length > 0) {
                        [sender setTitle:city forState:UIControlStateNormal];
                        [sender setTitleColor:cGreenColor forState:UIControlStateNormal];
                    }else
                    {
                        if (city) {
                        [sender setTitle:str forState:UIControlStateNormal];
                        [sender setTitleColor:cGrayLightColor forState:UIControlStateNormal];
                        }

                    }
                }else{
                    if (provice.length > 0) {
                        [sender setTitle:provice forState:UIControlStateNormal];
                        [sender setTitleColor:cGreenColor forState:UIControlStateNormal];
                    }else
                    {
                        if (provice) {
                        [sender setTitle:str forState:UIControlStateNormal];
                        [sender setTitleColor:cGrayLightColor forState:UIControlStateNormal];
                        }

                    }
                }
                CGSize size = [IHUtility GetSizeByText:sender.titleLabel.text sizeOfFont:13 width:(WindowWith-36)/4.0];
                sender.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
                sender.titleEdgeInsets=UIEdgeInsetsMake(0, -sender.imageView.frame.size.width, 0, sender.imageView.frame.size.width+3);

            //判断所选择的筛选条件对应不同的参数赋值
                if ([str isEqualToString:@"区域"]) {
                    self->_provice =  provice;
                    self->_city = city;
                }else if ([str isEqualToString:@"行业类别"]){
                    NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
                    NSArray *hyArray=[[NSMutableArray alloc]initWithArray:dic2[@"industryInfoList"]];
                    if (city.length >0) {
                        for (NSDictionary *dic in hyArray) {
                            if ([city isEqualToString:dic[@"i_name"]]) {
                                self->typeID = [dic[@"i_type_id"] intValue];
                            }
                        }
                    }else if([city isEqualToString:@""]) {
                        self->typeID = 0;
                    }
                }else if ([str isEqualToString:@"资质"]){
                    if (city.length>0) {
                        if ([provice isEqualToString:@"设计"]) {
                            self->_design_lv = [city substringToIndex:2];
                            self->_project_lv = @"";
                        }else if ([provice isEqualToString:@"工程"]){
                            self->_project_lv = [city substringToIndex:2];
                            self->_design_lv = @"";
                        }
                    }else if([city isEqualToString:@""]){
                        self->_design_lv = @"";
                        self->_project_lv = @"";
                    }
                    
                }else if ([str isEqualToString:@"规模"]){
                    if (city) {
                        self->_scale = city;
                    }else{
//                       self->_scale = @"";
                    }
                    
                }
                
                __weak EPCloudListViewController *weakSelf=self;
                if (provice!=nil||city!=nil) {
                    //刷新列表
                    [weakSelf beginRefesh:ENT_RefreshHeader];
                }

            };
            [self.view addSubview:areaV];
            [UIView animateWithDuration:.3 animations:^{
                areaV.top = self->_logisticsView.bottom;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:.2 animations:^{
                   areaV.backgroundColor = RGBA(0, 0, 0, 0.1);
                }];
            }];

    }else{
        [UIView animateWithDuration:.2 animations:^{
            self->_areaV.backgroundColor = RGBA(0, 0, 0, 0);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                self->_areaV.top = -(WindowHeight- self->_logisticsView.bottom);
            }completion:^(BOOL finished) {
                [self->_areaV removeFromSuperview];
            }];
        }];
        
    }
    

    
}
//加入园林云响应事件
- (void)addCompanyCloud:(UIButton *)button
{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    JionEPCloudViewController *VC=[[JionEPCloudViewController alloc]init];
    
    [self pushViewController:VC];
}
-(void)getPhoneweak{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    NSString *phoneString = [NSString stringWithFormat:@"tel:%@",KTelNum];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
    [self.view.window addSubview:callWebview];
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
    NSString *company_label_Id;
    if (self.company_label_id != 1) {
        company_label_Id = @"0";
    }else {
        company_label_Id = @"1";
    }
        [network getEPCloudListWithProvice:_provice City:_city Area:@"" company_name:_company_name design_lv:_design_lv project_lv:_project_lv company_label_id:company_label_Id TypeID:typeID Level:level page:page num:10 staff_size:_scale success:^(NSDictionary *obj) {
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
    if (tableView == commTableView.table) {
        return 77 + 163*WindowWith/375.0;
    }else{
        return 40;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == commTableView.table) {
        EPCloudListModel *model = dataArray[indexPath.row];
        EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
        detailVC.model = model;
        [self pushViewController:detailVC];

    }else if (tableView == commTableView2.table){
        NSArray *Arr=[IHUtility getUserdefalutsList:kEPCloudSearchHistory];
        _company_name = Arr[indexPath.row];
        [_searchV.textfiled resignFirstResponder];
        _searchV.textfiled.text = _company_name;
        _searchView.hidden = YES;

        //刷新列表
        [self beginRefesh:ENT_RefreshHeader];
    }
    
}
//段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == commTableView2.table) {
        return 30;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    if (tableView == commTableView2.table) {
        return 30;
    }
    return 0;
}


#pragma mark - 外观代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView == commTableView2.table) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 52)];
        view.backgroundColor=[UIColor whiteColor];
        
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15 , 5, 80, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"搜索历史";
        [view addSubview:lbl];
        
        
        
        return view;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == commTableView2.table) {
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
    return nil;
    
}
-(void)clean{
    commTableView2.hidden=YES;
    [IHUtility saveUserDefaluts:@[] key:kEPCloudSearchHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//隐藏筛选条件弹层
- (void)removeAreaView
{
    //隐藏筛选条件弹层
    if (_areaV) {
        _areaV.alpha =0 ;
        [_areaV removeFromSuperview];
    }
    NSArray *views = _logisticsView.subviews;
    for (UIView *view in views) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
            
        }
    }
}

- (void)home:(id)sender
{
    __weak EPCloudListViewController *weakSelf=self;
    SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 44)];
    //searchV.backgroundColor = self.navigationController.navigationBar.backgroundColor;
     searchV.textfiled.placeholder=@"请输入想找的企业名";
    _searchV = searchV;
    //隐藏筛选条件弹层
    [self removeAreaView];
    //显示遮罩
    _searchView.hidden = NO;
    
    __weak SearchView *searchSelf = searchV;
    searchV.selectBtnBlock = ^(NSInteger index){
        if (index == SelectBackVC) {
            if (self->_company_name.length > 0) {
                self->_company_name = @"";
                //刷新列表
                [weakSelf beginRefesh:ENT_RefreshHeader];
            }
            //隐藏搜索遮罩
            self->_searchView.hidden = YES;
            [self->dataArray2 removeAllObjects];
            
            [searchSelf removeFromSuperview];
            self->rightbutton.hidden = NO;
            
           
        }else if (index == SelectBtnBlock){
            self->_company_name = searchSelf.textfiled.text;
            self->_searchView.hidden = YES;
            //刷新列表
            [weakSelf beginRefesh:ENT_RefreshHeader];
            [weakSelf SaveSearchHistory:self->_company_name];
        }else if (index == openBlock){
            
            //隐藏筛选条件弹层
            [self removeAreaView];
            
            //开始编辑搜索框内容
            
            self->_searchView.hidden = NO;
            
        }
        
    };
    
    [self.navigationController.navigationBar addSubview:searchV];
   
     [searchV.textfiled becomeFirstResponder];
    
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchV removeFromSuperview];
    
    //隐藏遮罩
    _searchView.hidden = YES;
    [dataArray2 removeAllObjects];
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
    
    if (scrollView == commTableView2.table) {
        [_searchV.textfiled resignFirstResponder];
    }
}

- (void)scrollViewDidEndDecelerating:(MTBaseTableView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        self->_createBtn.alpha=1;
    }];
    
}


@end
