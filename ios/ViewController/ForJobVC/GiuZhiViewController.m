//
//  GiuZhiViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "GiuZhiViewController.h"
#import "PositionDetailViewController.h"
#import "JLSimplePickViewComponent.h"
//#import "AddressPickView.h"
#import "FMDatabase.h"
#import "JLAddressPickView.h"
#import "JobIntentionViewController.h"

@interface GiuZhiViewController ()<UITableViewDelegate,JLActionSheetDelegate,JLAddressActionSheetDelegate,JobIntentionBackDelegate>
{
    MTBaseTableView *commTableView;
    MTBaseTableView *commTableView2;//搜索结果列表
    MTLogisticsChooseView *_logisticsView;
    
    NSMutableArray *dataArray;
    NSMutableArray *dataArray2;
    
    int page;
    int page2;
    
    NSString *_provice;
    NSString *_city;
    NSString *_salary;
    NSString *_exprienceStr;
    NSString *_staffStr;
    
    UIView *_titleView;
    SMLabel *_titltLbl;
    SearchView *_searchV;
    JLSimplePickViewComponent *_pickView;
    JLAddressPickView *_adressPickView;
    EmptyPromptView *_EPView;
    
    UIView *_searchView;//搜索结果遮罩
    
    int netType;//0 职位列表 1按名字搜索的结果
    
    NSString *jobName;
    
//    FMDatabase *db;
    
    NSDictionary *purposeDic;//用户求职意向
    
    UIImageView *_titleImg;
}
@end

@implementation GiuZhiViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightButtonImage:Image(@"Search Icon.png") forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _provice =@"0";
    _city = @"0";
    _salary= @"";
    _exprienceStr = @"";
    _staffStr = @"";
    
    self.view.backgroundColor = cLineColor;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    titleView.userInteractionEnabled = YES;
    _titleView = titleView;
    
    SMLabel *titltLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, 80, 20) textColor:cGreenColor textFont:sysFont(15)];
    titltLbl.textAlignment = NSTextAlignmentCenter;
    titltLbl.text= @"";
    _titltLbl = titltLbl;
    [titleView addSubview:titltLbl];
    
    UIImage *image = Image(@"Job_down.png");
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(titltLbl.right + 3, 0, image.size.width, image.size.height)];
    rightImg.image = image;
    _titleImg = rightImg;
    rightImg.centerY = titleView.height/2.0;
    [titleView addSubview:rightImg];
    
    self.navigationItem.titleView = titleView;
    
    UITapGestureRecognizer *tapTitle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTitle:)];
    tapTitle.numberOfTapsRequired= 1.0;
    tapTitle.numberOfTouchesRequired= 1.0;
    [titleView addGestureRecognizer:tapTitle];
    
    [self CreatTableView];
    
    //职位名称搜索结果遮罩
    [self addSearchListView];
    
}
- (void)CreatTableView
{
    
    NSArray *arr = @[@"区域",@"薪资",@"经验",@"公司规模"];
    
    MTLogisticsChooseView *logisticsView=[[MTLogisticsChooseView alloc]initWithOrgane:CGPointMake(0, 0) array:arr];
    logisticsView.backgroundColor = [UIColor whiteColor];
    _logisticsView = logisticsView;
    [self.view addSubview:logisticsView];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, logisticsView.bottom, WindowWith, WindowHeight - 43) tableviewStyle:UITableViewStylePlain];
    
    dataArray = [[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:40];
    commTableView.backgroundColor = [UIColor clearColor];
    __weak GiuZhiViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshHeader];
    
    logisticsView.selectBtnBlock=^(NSInteger index,UIButton *sender){
        if (index==SelectStartBlock) {
            NSLog(@"start");
            
            [weakSelf chooseAdress:@"城市选择" tag:sender.tag-1000];
            
        }else if (index==SelectEntBlock){
            NSLog(@"end");
            
            [weakSelf showPicViewWithArr:@[@"面议",@"3k以下",@"3k-5k",@"5k-10k",@"10k-20k",@"20k-50k",@"50k以上"] :@"薪资" :sender.tag-1000];
        }else if (index==SelectTimeBlock){
            NSLog(@"time");
            [weakSelf showPicViewWithArr:@[@"不限",@"应届生",@"一年内",@"1-3年",@"3-5年",@"5-10年",@"10年以上"] :@"经验" :sender.tag-1000];
            
        }else if (index==SelectMoreBlock){
            NSLog(@"more");
            [weakSelf showPicViewWithArr:@[@"默认",@"1-19人",@"20-49人",@"50-99人",@"100-499人",@"500-999人",@"1000人以上"] :@"公司规模" :sender.tag -1000];
        }
    };
    
    //默认
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"目前还没有招聘职位哦~"];
    EPView.hidden = YES;
    _EPView = EPView;
    [commTableView.table addSubview:EPView];
    
}
- (void)addSearchListView
{
    dataArray2 =[[NSMutableArray alloc]init];
    _searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];
    _searchView.backgroundColor=RGB(247, 248, 250);
    _searchView.hidden=YES;
    [self.view addSubview:_searchView];
    
//    __weak GiuZhiViewController *weakSelf=self;
    dataArray2=[[NSMutableArray alloc]init];
    commTableView2=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView2.table.delegate=self;
    commTableView2.attribute=self;
    [commTableView2 setupData:dataArray2 index:40];
    
    [_searchView addSubview:commTableView2];
}
- (void)tapTitle:(UITapGestureRecognizer *)tap{
    
    NSArray *arr;
    if (purposeDic[@"job_name"]!=nil ) {
        _titltLbl.text = [NSString stringWithFormat:@"%@",purposeDic[@"job_name"]];
        arr = @[purposeDic[@"job_name"],@"管理求职意向"];
    }else {
        return;
    }
    NSArray *imgArr = @[@"",@""];
    
    SelectedView *view = [[SelectedView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) array:arr imageArr:imgArr rectY:60 rectX:WindowWith/2.0 - 70 width:140];
    view.selectBlock = ^(NSInteger index){
        
        if (index == 10) {
            
        }else {
            //求职 意向
            JobIntentionViewController *VC = [[JobIntentionViewController alloc] init];
            VC.delegate = self;
            VC.purposeDic = self->purposeDic;
            
            [self pushViewController:VC];
            
        }
    };
    
    view.imageView.centerX = WindowWith/2.0;
    //    [self.view addSubview:view];
}

- (void)home:(id)sender
{
    __weak GiuZhiViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView2 type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    //搜索框
    SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 44)];
    // searchV.backgroundColor = self.navigationController.navigationBar.backgroundColor;
    _searchV = searchV;
    _searchV.textfiled.placeholder = @"请输入职位名称";
    _searchView.hidden = NO;
    __weak SearchView *searchSelf = searchV;
    searchV.selectBtnBlock = ^(NSInteger index){
        if (index == SelectBackVC) {
            //点击取消隐藏遮罩试图别移除数据刷新表视图
            self->jobName = @"";
            [searchSelf removeFromSuperview];
            self->rightbutton.hidden = NO;
            self->_searchView.hidden = YES;
            [self->dataArray2 removeAllObjects];
            [self->commTableView2.table reloadData];
            self->netType = 0;
            
        }else if (index == SelectBtnBlock){
            
            self->netType = 1;
            self->jobName = searchSelf.textfiled.text;
            [self beginRefesh:ENT_RefreshFooter];
        }
    };
    
    [self.navigationController.navigationBar addSubview:searchV];
    rightbutton.hidden = YES;
    
    [_searchV.textfiled becomeFirstResponder];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchV removeFromSuperview];
    
    _searchView.hidden = YES;
    [dataArray2 removeAllObjects];
    [commTableView2.table reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    
    if (netType == 1) {
        //搜索
        if (refreshView==commTableView2.table.mj_header){
            page2 = 0;
        }
        [network searchPositionWithName:jobName province:_provice city:_city salary:_salary workYear:_exprienceStr staff:_staffStr page:page2 num:10 success:^(NSDictionary *obj) {
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
                self->page2++;
                if (arr.count<pageNum) {
                    [self->commTableView2.table.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                
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
        
    }else {
        if (refreshView==commTableView.table.mj_header) {
            page=0;
        }
        [network getPositionList:[USERMODEL.userID intValue] province:_provice city:_city salary:_salary workYear:_exprienceStr staff:_staffStr page:page num:10 success:^(NSDictionary *obj) {
            
            self->purposeDic = obj[@"purpose"];
            
            if (self->purposeDic.allKeys.count==0) {
                self->_provice=@"0";
                self->_city=@"0";
            }else{
                //获取用户的省份城市ID
                self->_provice = [NSString stringWithFormat:@"%@",self->purposeDic[@"province_id"]];
                self->_city = [NSString stringWithFormat:@"%@",self->purposeDic[@"city_id"]];
            }
            
            
            if (self->purposeDic[@"job_name"]!=nil) {
                CGSize size = [IHUtility GetSizeByText:self->purposeDic[@"job_name"] sizeOfFont:15 width:WindowWith - 70];
                
                self->_titltLbl.width = size.width;
                self->_titleView.width = self->_titltLbl.width + 20;
                self->_titleImg.left = self->_titltLbl.right + 3;
                self->_titltLbl.text = self->purposeDic[@"job_name"];
                self->_titleImg.hidden= NO;
            }else {
                self->_titltLbl.text = @"职位推荐";
                self->_titleImg.hidden= YES;
            }
            
            NSArray *arr=obj[@"content"];
            if (refreshView==self->commTableView.table.mj_header) {
                [self->dataArray removeAllObjects];
                self->page = 0;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionListModel *model;
    if (tableView == commTableView.table) {
        model = dataArray[indexPath.row];
    }else if (tableView == commTableView2.table){
        model = dataArray2[indexPath.row];
    }
    PositionDetailViewController *vc = [[PositionDetailViewController alloc] init];
    vc.job_id = (int)model.job_id;
    [self pushViewController:vc];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}
-(void)back:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//选择城市地址
- (void)chooseAdress:(NSString *)title tag:(NSInteger)tag
{
    
    if(_adressPickView == nil)
    {
        _adressPickView = [[JLAddressPickView alloc] initWithParams:title type:1];
        _adressPickView.tag=tag;
        _adressPickView.ActionSheetDelegate = self;
    }
    [_adressPickView show];
    
}
//选择经验 薪资 公司规模
-(void)showPicViewWithArr:(NSArray *)arr :(NSString *)title :(NSInteger)tag
{
    
    JLSimplePickViewComponent *pickView =(JLSimplePickViewComponent*)[self.view viewWithTag:tag];
    if(pickView == nil)
    {
        
        pickView = [[JLSimplePickViewComponent alloc] initWithParams:title withData:arr];
        pickView.tag=tag;
        pickView.ActionSheetDelegate = self;
    }
    _pickView = pickView;
    [pickView show];
    
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}
//选择经验 薪资 公司规模回调返回选中结果显示
-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedData:(NSString *)SelectedStr
{
    UIButton *button = [_logisticsView viewWithTag:pickViewComponent.tag + 1000];
    button.selected = !button.selected;
    
    [button setTitle:SelectedStr forState:UIControlStateNormal];
    [button setTitleColor:cGreenColor forState:UIControlStateNormal];
    
    if (button.tag == 1001 && [SelectedStr isEqualToString:@"面议"]) {
        [button setTitle:@"薪资" forState:UIControlStateNormal];
        [button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        
        _salary = @"";
        
    }else if (button.tag == 1002 && [SelectedStr isEqualToString:@"不限"]){
        [button setTitle:@"经验" forState:UIControlStateNormal];
        [button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        
        _exprienceStr = @"";
    }else if (button.tag == 1003 && [SelectedStr isEqualToString:@"默认"]){
        [button setTitle:@"公司规模" forState:UIControlStateNormal];
        [button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        
        _staffStr = @"";
    }else {
        if (button.tag == 1001) {
            _salary = SelectedStr;
        }else if (button.tag == 1002){
            _exprienceStr = SelectedStr;
        }else if (button.tag == 1003){
            _staffStr = SelectedStr;
        }
    }
    
    CGSize size = [IHUtility GetSizeByText:button.titleLabel.text sizeOfFont:13 width:(WindowWith-36)/4.0];
    button.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
    button.titleEdgeInsets=UIEdgeInsetsMake(0, -button.imageView.frame.size.width, 0, button.imageView.frame.size.width+3);
    
    [self beginRefesh:ENT_RefreshHeader];
    
}
//取消选择
- (void)ActionSheetCancelHandler
{
    
    UIButton *button = [_logisticsView viewWithTag:_pickView.tag + 1000];
    button.selected = !button.selected;
}
//地址选择结构回调
- (void)ActionSheetDoneHandle:(JLAddressPickView *)pickViewComponent selectedProData:(NSString *)SelectedStr selectedCityData:(NSString *)SelectedCityStr
{
    UIButton *button = [_logisticsView viewWithTag:pickViewComponent.tag + 1000];
    button.selected = !button.selected;
    if ([SelectedStr isEqualToString:@"不限"]){
        [button setTitle:@"区域" forState:UIControlStateNormal];
        [button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        _provice= @"0";
        _city = @"0";
    }else{
        [button setTitle:SelectedCityStr forState:UIControlStateNormal];
        [button setTitleColor:cGreenColor forState:UIControlStateNormal];
    }
    CGSize size = [IHUtility GetSizeByText:button.titleLabel.text sizeOfFont:13 width:(WindowWith-36)/4.0];
    button.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
    button.titleEdgeInsets=UIEdgeInsetsMake(0, -button.imageView.frame.size.width, 0, button.imageView.frame.size.width+3);
}
//地址选择返回省份和城市ID
- (void)ActionSheetDoneHandle:(JLAddressPickView *)pickViewComponent selectedProIndex:(NSInteger)index selectedCityIndex:(NSInteger)cityIndex
{
    if (index>0) {
        _provice = [NSString stringWithFormat:@"%d",(int)index];
    }else {
        _provice= @"0";
    }
    
    if (cityIndex>0) {
        _city = [NSString stringWithFormat:@"%d",(int)cityIndex];
    }else {
        _city= @"0";
    }
    
    [self beginRefesh:ENT_RefreshHeader];
}
- (void)AdressActionSheetCancelHandler
{
    UIButton *button = [_logisticsView viewWithTag:_adressPickView.tag + 1000];
    button.selected = !button.selected;
}

//根据管理求职意向重新刷新职位列表
- (void)disPalyJobIntention:(NSString *)positionType Pro_id:(NSString *)Pro_id ProStr:(NSString *)proStr city_id:(NSString *)city_id cityStr:(NSString *)cityStr
{
    _provice = Pro_id;
    _city = city_id;
    [self beginRefesh:ENT_RefreshHeader];
}

@end
