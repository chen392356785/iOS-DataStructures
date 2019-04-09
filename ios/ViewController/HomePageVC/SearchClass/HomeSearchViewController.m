//
//  HomeSearchViewController.m
//  MiaoTuProject
//
//  Created by tinghua on 2018/9/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "HomeSearchViewController.h"
//#import "ULBCollectionViewFlowLayout.h"     //分区背景色
#import "MTHomeSearchView.h"
#import "HomeSearchCollectionViewCell.h"
#import "XHFriendlyLoadingView.h"
//#import "HomSearchModel.h"
#import "SeedCloudDetailViewController.h"   //园林云
#import "MTOtherInfomationMainViewController.h" //人脉云
#import "EPCloudDetailViewController.h"         //企业
@interface HomeSearchViewController () <UITableViewDelegate,UITableViewDataSource,TFFlowerSearchViewDelegate,BCBaseTableViewCellDelegate> {
    MTHomeSearchView * searchTextfiled;
    NSMutableArray *dataArr;
    EmptyPromptView *_EPView;//没有搜索内容时候默认的提示
    NSInteger page;
    UITableView *_tableView;
}
@end

static NSString *YuanLinHomeSearchViewCellId  = @"YuanLinHomeSearchViewCell";
static NSString *QiYeHomeSearchViewCellId     = @"QiYeHomeSearchViewCell";
static NSString *RenMaiHomeSearchViewCellId   = @"RenMaiHomeSearchViewCell";

@implementation HomeSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *bgImage = [[UIImage imageNamed:@"biejing"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cBgColor;
    [self setnaviegation];
    [self createTableView];
    [self initDataAndCollection];
}
#pragma mark- 设置导航
- (void) setnaviegation {
    leftbutton.frame=CGRectMake(0, 0, 30, 44);
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 8);
    MTHomeSearchView *searchView = [[MTHomeSearchView alloc] initWithFrame:CGRectMake(0, 0,iPhoneWidth,28)];
    searchView.layer.borderWidth = 0.0;
    searchView.layer.cornerRadius = 4.1;
    searchView.clipsToBounds = YES;
    searchView.layer.borderColor = kColor(@"#666666").CGColor;
    searchView.delegate = self;
    searchTextfiled = searchView;
    searchView.searchTextField.text = self.TfStr;
    self.navigationItem.titleView = searchView;
    self.navigationItem.rightBarButtonItem = nil;
//    [searchView.searchTextField becomeFirstResponder];
}
#pragma mark -

- (void) initDataAndCollection {
    dataArr = [[NSMutableArray alloc] init];
    page = 0;
    [self addPushViewWaitingView];
    
    NSDictionary *dict = @{
                           @"type"   : @"0",
                           @"page"   : stringFormatInt(page),
                           @"title"  : searchTextfiled.searchTextField.text,
                           };
    [network httpRequestWithParameter:dict method:HomeSearchUrl success:^(NSDictionary *dic) {
        self->page = 1;
        [self removePushViewWaitingView];
        NSArray *arr= dic[@"content"];
        for (NSDictionary *tempDic in arr) {
            HomSearchModel *model = [[HomSearchModel alloc] initWithDictionary:tempDic error:nil];
            [self->dataArr addObject:model];
        }
        [self->_tableView reloadData];
        
        if (self->dataArr.count == 0 ) {
            self->_EPView.hidden = NO;
        }else{
            self->_EPView.hidden = YES;
        }
    } failure:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}
- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor] ;
    _tableView.separatorColor = [UIColor clearColor];
    
//    _tableView.estimatedSectionFooterHeight = 0.1;
//    _tableView.estimatedSectionHeaderHeight = 0.1;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
     __weak HomeSearchViewController *weakSelf = self;
    [self addBaseTableViewRefesh:_tableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    
    [self.view addSubview:_tableView];
    _EPView = [[EmptyPromptView alloc] initWithFrame:_tableView.frame context:@"抱歉，没有找到相关内容"];
    _EPView.imagNameStr = @"nores";
    _EPView.hidden = NO;
    _EPView.centerY = self.view.centerY;
    [_tableView addSubview:_EPView];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView == _tableView.mj_header) {
        page=0;
    }
    NSDictionary *dict = @{
                           @"type"   : @"0",
                           @"page"   : stringFormatInt(page),
                           @"title"  : searchTextfiled.searchTextField.text,
                           };
    [network httpRequestWithParameter:dict method:HomeSearchUrl success:^(NSDictionary *dic) {
        self->_EPView.hidden = YES;
        
        NSArray *arr= dic[@"content"];
        if (refreshView == self->_tableView.mj_header) {
             [self->_tableView.mj_header endRefreshing];
            [self->dataArr removeAllObjects];
           self->page = 0;
            if (arr.count == 0) {
                [self->_tableView reloadData];
            }
        }
        if (arr.count > 0) {
           self->page++;
            if (arr.count < 3) {
                [self->_tableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self->_tableView.mj_footer endRefreshing];
            }
        }else {
            //如果返回的数据为0 判断原先数组的数量来决定默认提示的显示与影藏
            if (self->dataArr.count == 0 ) {
                self->_EPView.hidden = NO;
            }else{
                self->_EPView.hidden = YES;
            }
//            [_tableView.mj_footer endRefreshing];
            [self endRefresh];
            return ;
        }
        for (NSDictionary *tempDic in arr) {
            HomSearchModel *model = [[HomSearchModel alloc] initWithDictionary:tempDic error:nil];
			if (refreshView == self->_tableView.mj_footer && self->page <= 1) {
            }else {
                [self->dataArr addObject:model];
            }
           
        }
        [self->_tableView reloadData];
        if (self->dataArr.count == 0 ) {
            self->_EPView.hidden = NO;
        }else{
            self->_EPView.hidden = YES;
        }
//        [_tableView.mj_footer endRefreshingWithNoMoreData];
        [self endRefresh];
    } failure:^(NSDictionary *dic) {
        [self->_tableView.mj_footer endRefreshingWithNoMoreData];
       [self endRefresh];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HomSearchModel *model = dataArr[section];
    if ([model.type isEqualToString:@"14"]) {     //企业云
         NSArray *arr=[network getJsonForString:model.qiyeimageUrl];
        NSInteger rowcount = [self fetchRowDataArr:arr rowNum:2];
        return rowcount;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomSearchModel *model = dataArr[indexPath.section];
    if ([model.type isEqualToString:@"15"]) {   //苗木云
        YuanLinSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YuanLinHomeSearchViewCellId];
        if (cell == nil) {
            cell = [[YuanLinSearchViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YuanLinHomeSearchViewCellId];
        }
        [cell setHomeSearchCellModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([model.type isEqualToString:@"14"]) {     //企业云
        QiYeSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QiYeHomeSearchViewCellId];
        if (cell == nil) {
            cell = [[QiYeSearchViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QiYeHomeSearchViewCellId];
        }
        NSArray *arr=[network getJsonForString:model.qiyeimageUrl];
        NSMutableArray *mArray = [[NSMutableArray alloc] initWithArray:arr];
        NSArray *DataArray = [self SwithfetchRowDataArr:mArray rowNum:2];
        cell.delegate = self;
        HomeCompanyModel * rowGV = DataArray[indexPath.row];
        cell.ItemArray = rowGV.hotArray;
        
        return cell;
    }
    RenMaiSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RenMaiHomeSearchViewCellId];
    if (cell == nil) {
        cell = [[RenMaiSearchViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RenMaiHomeSearchViewCellId];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setHomeSearchCellModel:model];
    return cell;
}

-(NSMutableArray *)SwithfetchRowDataArr:(NSMutableArray *)tempArr rowNum :(int)rowNum{
    
    NSMutableArray * rowDataArray = [[NSMutableArray alloc]init];
    NSInteger rowcount = 0;//计算行数
    if (tempArr.count%rowNum==0) {
        rowcount = tempArr.count/rowNum;
    }else{
        rowcount = tempArr.count/rowNum+1;
    }
    for (int j = 0; j < rowcount; j++) {
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        int startCount = j*rowNum;
        int endCount = (j+1)*rowNum;
        
        for (int i = startCount; i < endCount; i++) {
            
            if (tempArr.count>i) {
                [arr addObject:[tempArr objectAtIndex:i]];
            }
        }
        HomeCompanyModel * rowGV = [[HomeCompanyModel alloc] initWithIndex:j DataArr:arr];//一行数据
        [rowDataArray addObject:rowGV];//多行数据
       
    }
    return rowDataArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     HomSearchModel *model = dataArr[indexPath.section];
    if ([model.type isEqualToString:@"15"]) {   //苗木云
        return kWidth(249);
    }else if ([model.type isEqualToString:@"14"]) {     //企业云
        NSArray *arr=[network getJsonForString:model.qiyeimageUrl];
        NSInteger rowcount = [self fetchRowDataArr:arr rowNum:2];
        return  kWidth(175) * rowcount;
    }
    return kWidth(57);
}

-(NSInteger )fetchRowDataArr:(NSArray *)tempArr rowNum :(int)rowNum {
    NSInteger rowcount = 0;//计算行数
    if (tempArr.count%rowNum==0) {
        rowcount = tempArr.count/rowNum;
    }else{
        rowcount = tempArr.count/rowNum+1;
    }
    return rowcount;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    HomSearchModel *model = dataArr[section];
    if ([model.type isEqualToString:@"15"]) {   //苗木云
        return kWidth(8);
    }else if ([model.type isEqualToString:@"14"]) {     //企业云
        return  kWidth(0);
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    HomSearchModel *model = dataArr[section];
    if ([model.type isEqualToString:@"14"]) {     //企业云
        return  kWidth(0);
    }
    return 0.001f;
}
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action==MYActionHomePageZhanlueQiyeTableViewAction) {  //战略合作企业
        NSLog(@"11");
        NSDictionary *dic=(NSDictionary*)attribute;
        [self addWaitingView];
        [network getCompanyHomePage:dic[@"company_id"] success:^(NSDictionary *obj) {
            [self removeWaitingView];
            EPCloudListModel *model = obj[@"content"];
            EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
            detailVC.model = model;
            
            [self pushViewController:detailVC];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     HomSearchModel *Smodel = dataArr[indexPath.section];
    if ([Smodel.type isEqualToString:@"15"]) {
        NurseryListModel *model = [[NurseryListModel alloc] init];
        model.nursery_id = [Smodel.tid integerValue];
        model.plant_name = Smodel.title;
        SeedCloudDetailViewController *detailVC =[[SeedCloudDetailViewController alloc]init];
        detailVC.listModel = model;
        [self pushViewController:detailVC];
    }
    if ([Smodel.type isEqualToString:@"13"]) {
        [self addWaitingView];
        [network selectUseerInfoForId:[Smodel.user_id intValue]
                              success:^(NSDictionary *obj) {
                  MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                  UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                  [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[Smodel.user_id intValue] success:^(NSDictionary *obj) {
                      [self removeWaitingView];
                      
                      MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:Smodel.user_id :NO dic:obj[@"content"]];
                      controller.userMod=usermodel;
                      controller.dic=obj[@"content"];
                      [self pushViewController:controller];
                  } failure:^(NSDictionary *obj2) {
                      
                  }];
          } failure:^(NSDictionary *obj2) {
              
          }];
    }
}
#pragma mark - 搜索代理
- (void)flowerSearchViewWithText:(NSString *)searchText textField:(UITextField *)textField {
    [textField resignFirstResponder];
    page = 0;
    NSDictionary *dict = @{
                           @"type"   : @"0",
                           @"page"   : stringFormatInt(page),
                           @"title"  : searchTextfiled.searchTextField.text,
                           };
    [network httpRequestWithParameter:dict method:HomeSearchUrl success:^(NSDictionary *dic) {
        self->_EPView.hidden = YES;
        self->page = 1;
        [self->dataArr removeAllObjects];
        NSArray *arr= dic[@"content"];
        for (NSDictionary *tempDic in arr) {
            HomSearchModel *model = [[HomSearchModel alloc] initWithDictionary:tempDic error:nil];
            [self->dataArr addObject:model];
        }
        [self->_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
}
@end
