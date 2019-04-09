//
//  ClassSourceListController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/16.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ClassSourceListController.h"
#import "TeachertableViewCell.h"
#import "ClassSourdeDetailController.h"

@interface ClassSourceListController () <UITableViewDelegate,UITableViewDataSource>{
    EmptyPromptView *_EPView;//没有活动的时候默认的提示
    UITableView *_tableView;
    NSMutableArray *dataArr;
    
}

@end

@implementation ClassSourceListController

- (void)back:(id)sender {
    if (self.IsSearchVcJump == YES) {
        [self popViewController:1];
    } else  {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = cBgColor;
    if (self.IsSearchVcJump == YES) {
        self.title = self.titleStr;
         [self CreateSearchTableview];
    }else {
         self.title = [NSString stringWithFormat:@"%@的课程",self.tearchModel.name];
         [self createTableview];
    }
    if (self.HomoemoreModel != nil) {
        self.title = self.HomoemoreModel.lableName;
    }
}
- (void) CreateSearchTableview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    dataArr = self.SearchArr;
    [_tableView reloadData];
}
- (void) createTableview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    __weak ClassSourceListController *weakSelf = self;
    [self addBaseTableViewRefesh:_tableView type:ENT_RefreshHeader successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [_tableView.mj_header beginRefreshing];
    NSString *context = @"暂无课程哦~";
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:_tableView.frame context:context];
    EPView.hidden = YES;
    _EPView = EPView;
    [_tableView addSubview:EPView];
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    NSDictionary *dict;
    if (self.HomoemoreModel != nil) {
        dict = @{
                               @"lable_code" : self.HomoemoreModel.lableCode,
                               @"type"      : @"3",
                               };
    }else {
        dict = @{
                               @"teacherId" : self.tearchModel.teacherId,
                               @"type"      : @"1",
                               };
    }
    [network httpRequestTagWithParameter:dict method:selectClassLisUrl tag:IH_init success:^(NSDictionary *obj) {
        NSDictionary *dict = obj[@"content"];
        NSArray *arr = dict[@"studyClassList"];
        if (refreshView == self->_tableView.mj_header) {
            [self->_tableView.mj_header endRefreshing];
            [self->dataArr removeAllObjects];
            if (arr.count == 0) {
                [self->_tableView reloadData];
            }
        }
        for (NSDictionary *dict in arr) {
            studyBannerListModel *model = [[studyBannerListModel alloc] initWithDictionary:dict error:nil];
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
    return kWidth(142);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherClasstListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell =  [[TeacherClasstListViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    studyBannerListModel *model = dataArr[indexPath.row];
    [cell setTearchClassListModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    studyBannerListModel *Dmodel = dataArr[indexPath.row];
    ClassSourdeDetailController *DetailVc = [[ClassSourdeDetailController alloc] init];
    DetailVc.model = Dmodel;
    [self pushViewController:DetailVc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
