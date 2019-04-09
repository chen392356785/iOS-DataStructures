//
//  ActiviOrderDetailController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/10.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ActiviOrderDetailController.h"
#import "orderHeadView.h"
#import "ActiviOrderCell.h"

@interface ActiviOrderDetailController () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
    NSMutableArray *dataArr;
}

@end

typedef NS_ENUM(NSInteger , OrderSection) {
    ActivityInfoSection ,
    OrderDetailSection,
    OrderInfoSection,
    OrderCount,
};

static NSString *const ActivityInfoCellID = @"ActivityInfoSectionCell";
static NSString *const OrderDetailCellID =  @"OrderDetailSectionCell";
static NSString *const OrderInfoCellID =   @"OrderInfoSectionCell";
@implementation ActiviOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cBgColor;
    self.title = @"订单详情";
    [self createTableview];
}

- (void) createTableview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    dataArr = [[NSMutableArray alloc] init];
    if (![self.model.contacts_people isEqualToString:@""]) {
        NSString *str = [NSString stringWithFormat:@"*姓     名: %@",self.model.contacts_people];
        [dataArr addObject:str];
    }
    if (![self.model.contacts_phone isEqualToString:@""]) {
        NSString *str = [NSString stringWithFormat:@"*联系方式: %@",self.model.contacts_phone];
        [dataArr addObject:str];
    }
    if (![self.model.company_name isEqualToString:@""]) {
        NSString *str = [NSString stringWithFormat:@"*公司名称: %@",self.model.company_name];
        [dataArr addObject:str];
    }
    if (![self.model.job isEqualToString:@""]) {
        NSString *str = [NSString stringWithFormat:@"*职     位: %@",self.model.job];
        [dataArr addObject:str];
    }
    
    if (![self.model.team_name isEqualToString:@""]) {
        NSString *str = [NSString stringWithFormat:@"*战队名称: %@",self.model.team_name];
        [dataArr addObject:str];
        if ([self.model.talk isEqualToString:@""] || self.model.talk == nil) {
            NSString *str = [NSString stringWithFormat:@"*宣      言: %@",@"暂无宣言"];
            [dataArr addObject:str];
        }else {
            NSString *str = [NSString stringWithFormat:@"*宣      言: %@",self.model.talk];
            [dataArr addObject:str];
        }
    }
    
    orderHeadView *headView = [[orderHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(150))];
    [headView setHeadView:self.model.order_status];
    _tableView.tableHeaderView = headView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return OrderCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (ActivityInfoSection == section) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 35)];
        bgView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, iPhoneWidth - 20, 14)];
        titleLabel.text = @"报名人信息";
        for (UIView *view in bgView.subviews) {
            [view removeFromSuperview];
        }
        [bgView addSubview:titleLabel];
        titleLabel.font = sysFont(font(14));
        return bgView;
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (ActivityInfoSection == section) {
        return dataArr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ActivityInfoSection) {
        return kWidth(40);
    }else if (indexPath.section == OrderDetailSection) {
        return kWidth(180);
    }else {
        if ([self.model.order_status integerValue] == 1) {
            return kWidth(80);
        }else {
            return kWidth(60);
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (ActivityInfoSection == section) {
        return 30;
    }
    if (section == ActivityInfoSection) {
        return 0;
    }else if (section == OrderDetailSection) {
        return kWidth(13);
    }else {
        return kWidth(8);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (ActivityInfoSection == indexPath.section) {
        ActivityInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:ActivityInfoCellID];
        if (!cell) {
            cell = [[ActivityInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActivityInfoCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setActivitiesListModel:dataArr[indexPath.row]];
        return cell;
    }else if (OrderDetailSection == indexPath.section) {
        OrderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailCellID];
        if (!cell) {
            cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setActivitiesListModel:self.model];
        return cell;
    }else if (OrderInfoSection == indexPath.section) {
        OrderInfCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoCellID];
        if (!cell) {
            cell = [[OrderInfCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderInfoCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setActivitiesListModel:self.model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.copyBlock = ^{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string =[NSString stringWithFormat:@"%@",self.model.order_no];
            [self addSucessView:@"复制成功" type:1];
        };
        return cell;
    }
    return nil;
}


@end
