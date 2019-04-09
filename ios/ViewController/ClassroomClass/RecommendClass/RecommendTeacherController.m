//
//  RecommendTeacherController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/15.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "RecommendTeacherController.h"
#import "TeachertableViewCell.h"
//#import "ClassroomModel.h"
#import "ClassSourceListController.h"
#import "JoinTeacherController.h"    //加入讲师

@interface RecommendTeacherController () <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArr;
    UITableView *_tableView;
    UIButton *_createTeachBtn;
}

@end

@implementation RecommendTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐讲师";
    self.view.backgroundColor = [UIColor colorWithPatternImage:kImage(@"tearchVc_bj")];
    dataArr = [[NSMutableArray alloc] init];
    [self reloadData];
}
- (void) reloadData {
    [self addWaitingView];
    [network httpRequestWithParameter:nil method:ClassroomTeacherUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        NSArray *array = dic[@"content"];
        for (NSDictionary *tDic in array) {
            TearchListModel *model = [[TearchListModel alloc] initWithDictionary:tDic error:nil];
			[self->dataArr addObject:model];
        }
        [self createTableview];
    } failure:^(NSDictionary *obj2) {
         [self removeWaitingView];
    }];
}
- (void) createTableview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(100))];
    UIImage *image = [kImage(@"tearch_text") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(235), kWidth(43))];
    imageView.image = image;
    imageView.center = bgView.center;
    [bgView addSubview:imageView];
    _tableView.tableHeaderView = bgView;
    [self.view addSubview:_tableView];
    
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createBtn.frame=CGRectMake(WindowWith - kWidth(68), iPhoneHeight - KtopHeitht - kWidth(95), kWidth(54),  kWidth(54)) ;
    [createBtn setTitle:@"加入\n讲师" forState:UIControlStateNormal];
    createBtn.titleLabel.numberOfLines = 0;
    createBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createBtn addTarget:self action:@selector(releaseTeacherAction:) forControlEvents:UIControlEventTouchUpInside];
    _createTeachBtn=createBtn;
    [createBtn setLayerMasksCornerRadius:createBtn.width/2 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:kColor(@"#29daa2")];
    createBtn.titleLabel.font = boldFont(14);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:createBtn];
    
    _createTeachBtn.layer.shadowColor = kColor(@"#999999").CGColor;
    _createTeachBtn.layer.shadowOffset = CGSizeMake(2, 5);
    _createTeachBtn.layer.shadowOpacity = 0.9;
    _createTeachBtn.layer.shadowRadius = 5;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = dataArr[indexPath.row];
    CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[TeachertableViewCell class] contentViewWidth:iPhoneWidth];
    
    return height;
//    return kWidth(211) + kWidth(66);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeachertableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell =  [[TeachertableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    TearchListModel *model = dataArr[indexPath.row];
    [cell setModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TearchListModel *model = dataArr[indexPath.row];
    ClassSourceListController *ClassVc = [[ClassSourceListController alloc] init];
    ClassVc.tearchModel = model;
    [self pushViewController:ClassVc];
}
#pragma - mark 加入讲师
- (void)releaseTeacherAction:(UIButton *)but {
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    JoinTeacherController * TecherVc = [[JoinTeacherController alloc] init];
    [self presentViewController:TecherVc];
}



@end
