//
//  ActivityTypeController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/1.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ActivityTypeController.h"
#import "ActivityTypeModel.h"
#import "ActivityTypeCell.h"
#import "RoadInsturController.h"
#import "ActivityListViewController.h"
@interface ActivityTypeController () <UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *dataArr;    
    int page;
    EmptyPromptView *_EPView;//没有活动的时候默认的提示
}

@end

static NSString *ActivityTypeCellID = @"ActivityTypeCellId";

@implementation ActivityTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cBgColor;
    self.title = @"活动分类";
    [self createTableView];
}
- (void) createTableView {
    dataArr = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0.;
    [self.view addSubview:_tableView];
    __weak ActivityTypeController *weakSelf = self;
    [self addBaseTableViewRefesh:_tableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [_tableView.mj_header beginRefreshing];
    NSString *context = @"暂无相关信息哦~";
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:_tableView.frame context:context];
    EPView.hidden = YES;
    _EPView = EPView;
    [_tableView addSubview:EPView];
    page = 1;
//    type_c = 4;
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView == _tableView.mj_header) {
        page=0;
    }
    
   
    [network httpRequestTagWithParameter:nil method:ActivityTypeUrl tag:IH_init success:^(NSDictionary *obj) {
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
        for (NSDictionary *dict in arr) {
            ActivityTypeModel *model = [[ActivityTypeModel alloc] initWithDictionary:dict error:nil];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    return kWidth(123);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityTypeCellID];
    if (cell == nil) {
        cell = [[ActivityTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActivityTypeCellID];
    }
    ActivityTypeModel *model = dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setActivityTypeCellDate:model];
    
    cell.selectActivityBlock = ^{
        ActivityListViewController *actvitVC  = [[ActivityListViewController alloc] init];
        actvitVC.type = @"1";
        actvitVC.typeId = model.typeId;
        [self pushViewController:actvitVC];
    };
    cell.luxianContenBlock = ^{
        RoadInsturController *RoadVc = [[RoadInsturController alloc] init];
        RoadVc.model = model;
        [self pushViewController:RoadVc];
    };
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
