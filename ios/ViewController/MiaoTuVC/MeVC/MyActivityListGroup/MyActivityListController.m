//
//  MyActivityListController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/9.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyActivityListController.h"
#import "MyActivityOrderCell.h"
#import "ActiviOrderDetailController.h"
#import "PayTypeConstants.h"

#import "OnGoingTableCell.h"
#import "SucceTableViewCell.h"
#import "FailureTableViewCell.h"
#import "MyCrowdListDetailController.h"     //众筹详情
#import "PlayAmountViewController.h"    //自己支持
@interface MyActivityListController () <UITableViewDelegate,UITableViewDataSource>{
    UIView  *_topView;
    UIView *_lineVew;
    UITableView *_tableView;
    EmptyPromptView *_EPView;//没有活动的时候默认的提示
    NSString * type_c;     //空-全部 0-未支付待付款 1-已支付
     int page;
    NSMutableArray *dataArr;
    BOOL APayShow;      //是否要显示支付
    NSString *type;

    
}

@end
static NSString *const MyActivityOrderCellID = @"MyActivityOrderCell";

//众筹
static NSString *OnGoingTableCellId = @"OnGoingTableCellId";
static NSString *SuccessTableCellId = @"SuccessTableCellId";
static NSString *FailureTableCellId = @"FailureTableCellId";

@implementation MyActivityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的活动";
    self.view.backgroundColor = cBgColor;
    [self createtableView];
    dataArr = [[NSMutableArray alloc] init];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:@"paySuccess" object:nil];
}

- (void) createtableView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    
    UIView *lineVew = [[UIView alloc] initWithFrame:CGRectMake(0, 39, iPhoneWidth/4, 1)];
    lineVew.backgroundColor = RGB(6, 183, 174);
    _lineVew = lineVew;
    [topView addSubview:lineVew];
    [self.view addSubview:_topView];
    
    NSArray *arr = @[@"全部",@"进行中",@"已成功",@"已失败"];
    for (int i =0; i<arr.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowWith/arr.count*i, 0, WindowWith/arr.count, 39)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:cBlackColor forState:UIControlStateNormal];
        [button setTitleColor:RGB(6, 193, 174) forState:UIControlStateSelected];
        button.titleLabel.font = sysFont(13);
        [button addTarget:self action:@selector(activtyType:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            button.selected = YES;
            _lineVew.centerX = button.center.x;
        }
        button.tag = 10+i;
        [topView addSubview:button];
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, iPhoneWidth, iPhoneHeight  - KtopHeitht - 40) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0.;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"MyActivityOrderCell" bundle:nil] forCellReuseIdentifier:MyActivityOrderCellID];
    
    type_c = @"";
     page = 1;
    __weak MyActivityListController *weakSelf = self;
    [self addBaseTableViewRefesh:_tableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
     [_tableView.mj_header beginRefreshing];
    NSString *context = @"暂无相关众筹信息哦~";
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:_tableView.frame context:context];
    EPView.hidden = YES;
    _EPView = EPView;
    [_tableView addSubview:EPView];
    
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView == _tableView.mj_header) {
        page=0;
    }
    
    NSDictionary *dict = @{
                           @"user_id"   :  USERMODEL.userID,
                           @"page"      :  stringFormatInt(page),
                           @"num"       :  @"10",
                           @"model"     :  @"4&8",
                           @"status"    :  type_c,
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kWidth(8);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kWidth(8);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivitiesListModel *model = dataArr[indexPath.section];
    if ([model.type isEqualToString:@"1"]) {
      if ([model.status isEqualToString:@"0"]) {
            if ([model.huodong_status integerValue] == 1) {
                return kWidth(177);
            }else{
                NSString *limitNum;
                NSString *signUp;
                limitNum = model.user_upper_limit_num;
                signUp = model.sign_up_num;
                if ([signUp integerValue] >= [limitNum integerValue]) {
                    return kWidth(177);
                }
                return kWidth(222);
            }
        }else if ([model.status isEqualToString:@"1"]) {
             return kWidth(173);
        }else if ([model.status isEqualToString:@"2"]) {
             return kWidth(173);
        }
    }
    if ([model.order_status integerValue] == 0) {
        return kWidth(184) + kWidth(44);
    }else {
        return kWidth(184);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivitiesListModel *model = dataArr[indexPath.section];
    if ([model.type isEqualToString:@"1"]) {
       if ([model.status isEqualToString:@"0"]) {
            OnGoingTableCell *cell = [[OnGoingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OnGoingTableCellId];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           [cell setActivitiesListModel:dataArr[indexPath.section]];
           cell.otherPeopleblock = ^{
               [self lookforPeopleCrowdFund:indexPath];
           };
           cell.supportBlock = ^{
               [self selfSupportCrowdFundIndex:indexPath];
           };
           return cell;
        }else if ([model.status isEqualToString:@"1"]) {
            SucceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SuccessTableCellId];
            if (!cell) {
                cell = [[SucceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SuccessTableCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setActivitiesListModel:dataArr[indexPath.section]];
            return cell;
        }else if ([model.status isEqualToString:@"2"]) {
            FailureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FailureTableCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (!cell) {
                cell = [[FailureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FailureTableCellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setActivitiesListModel:dataArr[indexPath.section]];
            return cell;
        }
    }
    MyActivityOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:MyActivityOrderCellID forIndexPath:indexPath];
    [cell setActivitiesListModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cancelOrder = ^{
        [self cancelActivitiesAction:model indel:indexPath];
    };
    cell.playOrder = ^{
        NSLog(@"立即支付");
        [self GoSelectPlayAction:model indel:indexPath];
    };
    return cell;
}
#pragma mark - 取消报名
- (void) cancelActivitiesAction:(ActivitiesListModel *)model indel:(NSIndexPath *)indexPath {
    [network cancleActivtiesOrder:model.a_order_id success:^(NSDictionary *obj) {
        ActivitiesListModel *mod = [self->dataArr objectAtIndex:indexPath.section];
        mod.order_status = @"3";
        NSArray *indexArray=[NSArray arrayWithObject:indexPath];
        [self->_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    }];
}
//切换活动类型
- (void)activtyType:(UIButton *)button {
    button.selected = YES;
    for (int i = 0; i<4; i++) {
        UIButton *btn = [_topView viewWithTag:i+10];
        if (btn.tag != button.tag) {
            btn.selected= NO;
        }
    }
    if (_EPView) {
        [_EPView removeFromSuperview];
    }
    _lineVew.centerX = button.center.x;
    
    NSString *str;
    if ([button.titleLabel.text isEqualToString:@"全部"]) {
        type_c = @"";
        str = @"您还没订单信息哦~";
    }else if ([button.titleLabel.text isEqualToString:@"进行中"]){
        type_c = @"0";
        str = @"暂无要处理的订单哦~";
    }
    else if ([button.titleLabel.text isEqualToString:@"已成功"]){
        type_c = @"1";
        str = @"您还没有订单哦~";
    } else if ([button.titleLabel.text isEqualToString:@"已失败"]){
        type_c = @"2";
        str = @"您还没有订单哦~";
    }
    
    _EPView = [[EmptyPromptView alloc] initWithFrame:_tableView.frame context:str];
    _EPView.hidden = YES;
    [_tableView addSubview:_EPView];
    [_tableView.mj_header beginRefreshing];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ActiviOrderDetailController *orderVc = [[ActiviOrderDetailController alloc] init];
    ActivitiesListModel *model = dataArr[indexPath.section];
    if ([model.type isEqualToString:@"1"]) {
        MyCrowdListDetailController *DetailVc = [[MyCrowdListDetailController alloc] init];
        if ([model.status intValue] == 0 ) {
            DetailVc.crowType = CrowdFundOn;
        }else if ([model.status intValue] == 1 ) {
            DetailVc.crowType = CrowdFundSucces;
        }else if ([model.status intValue] == 2 ) {
            DetailVc.crowType = CrowdFundFail;
        }
        DetailVc.model = model;
        [self pushViewController:DetailVc];
    }else {
        orderVc.model = model;
        [self pushViewController:orderVc];
    }
}

- (void) GoSelectPlayAction:(ActivitiesListModel *)model indel:(NSIndexPath *)indexPath {
    ApliayView *alipayView = [[ApliayView alloc] initWithFrame:self.view.window.bounds];
    alipayView.top = kScreenHeight;
    APayShow=YES;
    alipayView.selectBlock = ^(NSInteger index){
        if (index == ENT_top) {
            //锁定众筹
            self->type = @"1";
            //            [self lockCrowd];
            self.payType = [NSString stringWithFormat:@"%d",WEICHAT_TYPE];
            [self referAlipayAction:model indel:indexPath];
        }else if (index == ENT_midden){
            //锁定众筹
            self->type = @"1";
            //            [self lockCrowd];
            self.payType = [NSString stringWithFormat:@"%d",AlIPAY_TYPE];
             [self referAlipayAction:model indel:indexPath];
        }
    };
    
    [self.view.window addSubview:alipayView];
    
    [UIView animateWithDuration:.5 animations:^{
        alipayView.top = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            alipayView.backgroundColor = RGBA(0, 0, 0, 0.3);
            self->APayShow=NO;
        }];
    }];
}
- (void)referAlipayAction:(ActivitiesListModel *)model indel:(NSIndexPath *)indexPath
{
    [[PayMentMangers manager] payment:model.order_no orderPrice:model.payment_amount type:self.payType subject:model.activities_titile  activitieID:model.activities_id parentVC:self resultBlock:^(BOOL isPaySuccess, NSString *msg) {
        if (isPaySuccess) {
            [self addSucessView:@"支付成功" type:1];
            [self->_tableView reloadData];
        }
    }];
    
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
