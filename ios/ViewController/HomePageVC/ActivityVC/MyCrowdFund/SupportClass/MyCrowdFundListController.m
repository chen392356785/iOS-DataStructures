//
//  MyCrowdFundListController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/5.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyCrowdFundListController.h"
#import "OnGoingTableCell.h"
#import "SucceTableViewCell.h"
#import "FailureTableViewCell.h"
#import "MyCrowdListDetailController.h"     //众筹详情
#import "PlayAmountViewController.h"    //自己支持
@interface MyCrowdFundListController () <UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *dataArr;
    int page;
    int type_c;
    UIView *_topView;
    EmptyPromptView *_EPView;//没有活动的时候默认的提示
    NSString *status;
}

@end

static NSString *OnGoingTableCellId = @"OnGoingTableCellId";
static NSString *SuccessTableCellId = @"SuccessTableCellId";
static NSString *FailureTableCellId = @"FailureTableCellId";

@implementation MyCrowdFundListController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的众筹";
    self.view.backgroundColor = cBgColor;
    [self createTableView];
    dataArr = [[NSMutableArray alloc] init];
    status = [NSString stringWithFormat:@"%ld",(long)self.Type];
}

- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KStatusBarHeight - kWidth(64) + KTabSpace - 20) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0.;
    [self.view addSubview:_tableView];
    __weak MyCrowdFundListController *weakSelf = self;
    [self addBaseTableViewRefesh:_tableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [_tableView.mj_header beginRefreshing];
    NSString *context = @"暂无相关众筹信息哦~";
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:_tableView.frame context:context];
    EPView.hidden = YES;
    _EPView = EPView;
    [_tableView addSubview:EPView];
    page = 1;
    type_c = 4;
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView == _tableView.mj_header) {
        page=0;
    }

    NSDictionary *dict = @{
                           @"user_id"   :  USERMODEL.userID,
                           @"page"      :  stringFormatInt(page),
                           @"num"       :  @"10",
                           @"model"     :  @"8",
                           @"status"    :  status,
                           };
    [network httpRequestTagWithParameter:dict method:MyActivitiesorListUrl tag:IH_UserActivityList success:^(NSDictionary *obj) {
        NSArray *arr= obj[@"content"];
        
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
            if (arr.count<pageNum) {
				[self->_tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else {
            //如果返回的数据为0 判断原先数组的数量来决定默认提示的显示与影藏
			if (self->dataArr.count == 0) {
				self->_EPView.hidden = NO;
            }else{
				self->_EPView.hidden = YES;
            }
			[self->_tableView.mj_footer endRefreshingWithNoMoreData];
            [self endRefresh];
            return;
        }
        for (ActivitiesListModel *model in arr) {
            NSLog(@"model --- %@",model);
			[self->dataArr addObject:model];
        }
		[self->_tableView reloadData];
		if (self->dataArr.count == 0) {
			self->_EPView.hidden = NO;
        }else{
			self->_EPView.hidden = YES;
        }
         [self endRefresh];
    } failure:^(NSDictionary *dic) {
         [self endRefresh];
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (OnGoingType == self.Type) {
        ActivitiesListModel *model =  dataArr[indexPath.section];
        NSLog(@"%@ ====== ",model.huodong_status);
        if ([model.huodong_status integerValue] == 1) {
            return kWidth(177);
        }else{
            return kWidth(222);
        }
    }else if (SuccessfulType == self.Type) {
        return kWidth(173);
    }else if (FailureType == self.Type) {
        return kWidth(173);
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (OnGoingType == self.Type) {
//        OnGoingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:OnGoingTableCellId];
//        if (!cell) {
           OnGoingTableCell *cell = [[OnGoingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OnGoingTableCellId];
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setActivitiesListModel:dataArr[indexPath.section]];
        cell.otherPeopleblock = ^{
            [self lookforPeopleCrowdFund:indexPath];
        };
        cell.supportBlock = ^{
            [self selfSupportCrowdFundIndex:indexPath];
        };
        return cell;
    }else if (SuccessfulType == self.Type) {
        SucceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SuccessTableCellId];
        if (!cell) {
            cell = [[SucceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SuccessTableCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setActivitiesListModel:dataArr[indexPath.section]];
        return cell;
    }else if (FailureType == self.Type) {
        FailureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FailureTableCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[FailureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FailureTableCellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setActivitiesListModel:dataArr[indexPath.section]];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kWidth(8);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kWidth(8);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCrowdListDetailController *DetailVc = [[MyCrowdListDetailController alloc] init];
    if ([status intValue] == 0 ) {
        DetailVc.crowType = CrowdFundOn;
    }else if ([status intValue] == 1 ) {
        DetailVc.crowType = CrowdFundSucces;
    }else if ([status intValue] == 2 ) {
        DetailVc.crowType = CrowdFundFail;
    }
    DetailVc.model = dataArr[indexPath.section];
    [self pushViewController:DetailVc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selfSupportCrowdFundIndex:(NSIndexPath* )index {
    NSLog(@"自己支持%@",index);
    ActivitiesListModel *model = dataArr[index.section];
    PlayAmountViewController *selfPlayVc = [[PlayAmountViewController alloc] init];
    [network selectCrowdDetailByCrowdId:[model.crowd_id intValue] openid:@"" success:^(NSDictionary *obj) {
        selfPlayVc.model = obj[@"content"];
        selfPlayVc.ActiModel = model;
        [self pushViewController:selfPlayVc];
    } failure:^(NSDictionary *obj2) {
       
        
    }];
    
}
- (void)lookforPeopleCrowdFund:(NSIndexPath* )index {
    NSLog(@"找人帮我众筹%@",index);
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    ActivitiesListModel *model = dataArr[index.section];
    [self shareView2:ENT_MyCrowdList object:model vc:self];
}


@end
