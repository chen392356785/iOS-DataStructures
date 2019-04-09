//
//  MyCrowdListDetailController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyCrowdListDetailController.h"
//#import "orderHeadView.h"
#import "ActiviOrderCell.h"
#import "CrowFundDetailCell.h"
#import "CrowBottom.h"
#import "PlayAmountViewController.h"    //付款
#import "ActivesCrowdFundController.h"

@interface MyCrowdListDetailController () <UITableViewDelegate,UITableViewDataSource> {
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


static NSString *const ActivityInfoCellID =  @"ActivityInfoSectionCell";
static NSString *const CrowFundDetailCellID =  @"CrowFundDetailCell";
static NSString *const OrderInfoCellID =    @"OrderInfoSectionCell";

@implementation MyCrowdListDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cBgColor;
    self.title = @"众筹详情";
    [self createTableview];
}

- (void) createTableview {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(95)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.estimatedSectionHeaderHeight = 0.1;
//    _tableView.estimatedSectionFooterHeight = 0.1;
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
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(50))];
    UILabel *statuLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, iPhoneWidth, kWidth(30))];
    [headView addSubview:statuLable];
    _tableView.tableHeaderView = headView;
    statuLable.textAlignment = NSTextAlignmentCenter;
    statuLable.font = sysFont(font(17));
    if (self.crowType == CrowdFundSucces) {
        headView.backgroundColor = kColor(@"#FDF4F3");
        statuLable.text = @"众筹成功";
        statuLable.textColor = kColor(@"ff0000");
    }else if (self.crowType == CrowdFundOn) {
        headView.backgroundColor = kColor(@"#FDF4F3");
        statuLable.text = @"众筹中 ...";
        statuLable.textColor = kColor(@"ff0000");
    }else {
        headView.backgroundColor = kColor(@"#eaeaea");
        statuLable.text = @"众筹失败";
        statuLable.textColor = kColor(@"#999999");
    }
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, maxY(_tableView), iPhoneWidth, kWidth(95))];
    [self.view addSubview:bottom];
    
    CrowBottom *crowBottom = [[CrowBottom alloc] initWithFrame:CGRectMake(0,  maxY(_tableView), iPhoneWidth, kWidth(95)) CrowType:self.crowType];
    [self.view addSubview:crowBottom];
    if ([self.model.huodong_status integerValue] == 1 ) {
        _tableView.frame = CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(50));
        crowBottom.frame = CGRectMake(0,  maxY(_tableView), iPhoneWidth, kWidth(50));
        [crowBottom setActivies:self.model];        //活动下架查看详情
    }
    
    NSString *limitNum;
    NSString *signUp;
    limitNum = self.model.user_upper_limit_num;
    signUp = self.model.sign_up_num;
    
    crowBottom.selfCrowBlock = ^{
        NSLog(@"自己支持");
        if ([signUp integerValue] >= [limitNum integerValue]) {
            [IHUtility addSucessView:@"活动名额已满" type:2];
            return ;
        }
        PlayAmountViewController *selfPlayVc = [[PlayAmountViewController alloc] init];
        [network selectCrowdDetailByCrowdId:[self.model.crowd_id intValue] openid:@"" success:^(NSDictionary *obj) {
            selfPlayVc.model = obj[@"content"];
            selfPlayVc.ActiModel = self.model;
            [self pushViewController:selfPlayVc];
        } failure:^(NSDictionary *obj2) {
            
            
        }];
    };
    crowBottom.myCrowDetailBlock = ^{
        NSLog(@"查看众筹详情");
        
        ActivesCrowdFundController *CFVc = [[ActivesCrowdFundController alloc] init];
//        PlayAmountViewController *selfPlayVc = [[PlayAmountViewController alloc] init];
        NSDictionary *dict2 = @{
                                @"crowd_id" : self.model.crowd_id,
                                @"openid"   : @"",
                                @"user_id"  :USERMODEL.userID,
                                };
        [network httpRequestTagWithParameter:dict2 method:selectCrowdByIdUrl tag:IH_selectCrowdDetailByCrowdId success:^(NSDictionary * dic) {
            CrowdOrderModel *cModel = dic[@"content"];
            CFVc.model = cModel.selectActivitiesListInfo;
            CFVc.type = @"1";
            [self pushViewController:CFVc];
        } failure:^(NSDictionary * dic) {
            
        }];
       
//        CFVc.indexPath = indexPath;        
       
    };
    crowBottom.helpMeCrowBlock = ^{
        NSLog(@"找人帮我众筹");
        if ([signUp integerValue] >= [limitNum integerValue]) {
            [IHUtility addSucessView:@"活动名额已满" type:2];
            return ;
        }
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        [self shareView2:ENT_MyCrowdList object:self.model vc:self];
    };
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return OrderCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == ActivityInfoSection) {
        return dataArr.count;
    }
    return 1;
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
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
        CrowFundDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:CrowFundDetailCellID];
        if (!cell) {
            cell = [[CrowFundDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CrowFundDetailCellID];
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
