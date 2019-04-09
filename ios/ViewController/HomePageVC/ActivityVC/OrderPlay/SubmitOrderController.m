//
//  SubmitOrderController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SubmitOrderController.h"
#import "OrderInfoViewCell.h"
#import "OrderHeadView.h"
//#import "CrowdFundingViewController.h"      //发起的众筹界面
//#import "THNotificationCenter+C.h"
//#import "ActivityPaySuccessfulViewController.h"
#import "MyCrowdFundController.h"

#import "ActivesCrowdFundController.h"

#import "PayTypeConstants.h"

#import "ValuePickerView.h"
#import "PlayPopView.h"
#import "NewVarietyPicModel.h"

@interface SubmitOrderController () <UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
    NSString *nameStr;      //姓名
    NSString *PhoneStr;     //电话号码
    NSString *companyname;  //公司
    NSString *JobStr;       //职位
    NSString *remarkStr;    //备注
    UIButton *CommitBut;        //提交订单
    NSMutableArray *dataArr;
    PlaceholderTextView *textView;  //备注
    NSString *TeamStr;          //战队
    TeamListModel *teamModel;   //战队Model
    NSString *xuanYanStr;       //宣言
    BOOL APayShow;      //是否要显示支付
    NSIndexPath * PhoneIndeX;     //联系方式
    UITableView    *myTableView;
    NSMutableArray *phoneArray;
}
@property (nonatomic, strong) ValuePickerView *TeampickerView;      //战队选择器对象
@end

static NSString *OrderInfoCell = @"OrderInfoViewCell";

@implementation SubmitOrderController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    // 点击视图隐藏键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}


- (void) dataInit {
    nameStr = @"";
    PhoneStr = @"";
    companyname = @"";
    JobStr = @"";
    remarkStr = @"";
    TeamStr = @"请选择队伍";
    xuanYanStr = @"";
    dataArr = [[NSMutableArray alloc] init];
    NSDictionary *dic = self.model.userinfoDic;
    self.TeampickerView = [[ValuePickerView alloc]init];
    
    if ([dic[@"name"] integerValue] == 1) {
        [dataArr addObject:@"*姓      名"];
    }else if ([dic[@"name"] integerValue] == 0){
        //        [dataArr addObject:@"姓    名"];
    }
    if ([dic[@"mobile"] integerValue] == 1) {
        [dataArr addObject:@"*联系方式"];
    }else if ([dic[@"mobile"] integerValue] == 0){
        //        [dataArr addObject:@"联系方式"];
    }
    if ([dic[@"company"] integerValue] == 1) {
        [dataArr addObject:@"*公司名称"];
    }else if ([dic[@"company"] integerValue] == 0){
        //         [dataArr addObject:@"公司名称"];
    }
    if ([dic[@"job"] integerValue] == 1) {
        [dataArr addObject:@"*职      位"];
    }else if ([dic[@"job"] integerValue] == 0){
//        [dataArr addObject:@"职    位"];
    }
    [self getPhoneNum];
}
- (void) getPhoneNum {
    phoneArray = [[NSMutableArray alloc] init];
    NSDictionary *dic = @{
                          @"user_id":USERMODEL.userID,
                          };
    [network httpRequestWithParameter:dic method:GetPhoneNumUrl success:^(NSDictionary *dic) {
        NSArray *tempArr = dic[@"content"];
        for (NSDictionary *objDic in tempArr) {
            NewMobileListModel *phoneModel = [[NewMobileListModel alloc]initWithDictionary:objDic error:nil];
			[self->phoneArray addObject:phoneModel];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = cBgColor;
    [self dataInit];
    [self createTableView];
}
- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - kHeight(50) - KtopHeitht) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.estimatedSectionHeaderHeight = 0.01;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    OrderHeadView *tabHeadView = [[OrderHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(113))];
    [tabHeadView setActivitiesListModel:self.model];
    _tableView.tableHeaderView = tabHeadView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(100))];
    _tableView.tableFooterView = footView;
    footView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"备注:";
    titleLabel.font = sysFont(font(14));
    titleLabel.textColor = kColor(@"#333333");
    [footView addSubview:titleLabel];
    titleLabel.frame = CGRectMake(kWidth(12), kWidth(5), kWidth(80), kWidth(12));
    
    textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(kWidth(12), maxY(titleLabel) + 5, iPhoneWidth - kWidth(24), height(footView) - maxY(titleLabel) - 10)];
    textView.layer.cornerRadius = 4;
    textView.layer.borderColor = cLineColor.CGColor;
    textView.layer.borderWidth = 1;
    textView.font = sysFont(13);
    textView.placeholder = @"备注信息";
    textView.delegate = self;
    textView.placeholderFont = sysFont(13);
    [footView addSubview:textView];
    [self addBottomUI];
}
- (void) addBottomUI {
    UIView *BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - KtopHeitht - kHeight(50), iPhoneWidth, kHeight(50))];
    [self.view addSubview:BottomView];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneHeight, 0.8)];
    lineLabel.backgroundColor = cLineColor;
    [BottomView addSubview:lineLabel];
    
    UILabel * PicLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLevelSpace(12), 0, iPhoneWidth/2 - 12, kHeight(17))];
    PicLabel.centerY = height(BottomView)/2.0;
    [BottomView addSubview:PicLabel];
    
    NSString *picLabStr = [NSString stringWithFormat:@"合计: ￥%@",self.model.payment_amount];
    PicLabel.textColor = kColor(@"#333333");
    PicLabel.textAlignment = NSTextAlignmentLeft;
    PicLabel.font = sysFont(font(17));
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picLabStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(4, self.model.payment_amount.length + 1)];
    PicLabel.attributedText = attributedStr;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(iPhoneWidth - kWidth(105), 0, kWidth(105), height(BottomView));
    [button setTintColor:kColor(@"#ffffff")];
    button.backgroundColor = kColor(@"#05c1b0");
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(SubmitValidation) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = sysFont(font(17));
    [BottomView addSubview:button];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 100) {
        return 1;
    }
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        return phoneArray.count;
    }
    if (section == 0) {
        if (![self.model.is_team isEqualToString:@"1"]) {
            return 0;
        }else {
            return 2;
        }
    }else {
        return dataArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tfcellid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Tfcellid"];
        }
        NewMobileListModel *model = phoneArray[indexPath.row];
        cell.backgroundColor = cLineColor;
        cell.textLabel.text = model.mobile;
        cell.textLabel.font = sysFont(font(15));
        return cell;
    }
    if (indexPath.section == 1) {
        OrderInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoCell];
        if (!cell) {
            cell = [[OrderInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderInfoCell];
        }
        cell.textFied.delegate = self;
        NSString *TitleStr = dataArr[indexPath.row];
        [cell setTitleContent:TitleStr];
        if ([TitleStr isEqualToString:@"联系方式"]||[TitleStr isEqualToString:@"*联系方式"]) {
            cell.textFied.tag = 1011;
            PhoneIndeX = indexPath;
            cell.textFied.keyboardType = UIKeyboardTypeNumberPad;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableviewcellID"];
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(14), kWidth(16), kWidth(85), kWidth(17))];
                titleLabel.tag = 101;
                [cell.contentView addSubview:titleLabel];
            }
            UILabel *TitleL = (UILabel *)[cell.contentView viewWithTag:101];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"*选择战队"];
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
            TitleL.attributedText = attriStr;
            TitleL.font = sysFont(font(17));
            cell.detailTextLabel.text = TeamStr;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            OrderInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoCell];
            if (!cell) {
                cell = [[OrderInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderInfoCell];
            }
            cell.textFied.delegate = self;
            if (self.model.talkList.count > 0) {
                if (self.model.talkList.count > 1) {
                    NSInteger arc =  arc4random() % (self.model.talkList.count - 1);
                    talkListModel *model = self.model.talkList[arc];
                    cell.textFied.text = model.activity_talk;
                }else {
                    talkListModel *model = self.model.talkList[0];
                    cell.textFied.text = model.activity_talk;
                }
                
//                cell.textFied.placeholder = @"请填写宣言";
            }
            [cell setTitleContent:@"*宣      言"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        return kWidth(37);
    }
    
    return kWidth(49);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        return 0;
    }
    if (section == 0) {
        return kWidth(8);
    }else {
        if (![self.model.is_team isEqualToString:@"1"]) {
            return 0;
        }else {
             return 4;
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        OrderInfoViewCell *cell = [_tableView cellForRowAtIndexPath:PhoneIndeX];
        NewMobileListModel *model = phoneArray[indexPath.row];
        cell.textFied.text = model.mobile;
        [cell.textFied resignFirstResponder];
    }else {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                NSMutableArray *teamArr = [[NSMutableArray alloc] init];
                for (TeamListModel *model in _model.teamList) {
                    [teamArr addObject:model.team_name];
                }
                if (teamArr.count <= 0) {
                    [self addSucessView:@"还没有战队！" type:2];
                    return;
                }
                __block SubmitOrderController *blockSelf = self;
                _TeampickerView.dataSource = teamArr;
                _TeampickerView.pickerTitle = @"选择队伍";
                _TeampickerView.valueDidSelect = ^(NSString *value){
                    NSArray * stateArr = [value componentsSeparatedByString:@"/"];
					self->TeamStr = stateArr[0];
                    NSInteger index = [stateArr[1] integerValue];
					self->teamModel = blockSelf.model.teamList[index - 1];
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                };
                [_TeampickerView show];
            }
            
            //        SelecTeamViewController *seleTeamVc = [[SelecTeamViewController alloc] init];
            //        [self pushViewController:seleTeamVc];
            
            NSLog(@"选择战队");
        }
    }
}
- (void) SubmitValidation {
    
    if (!USERMODEL.isLogin) {
        //        userID = @"0";
        //登录
        [self prsentToLoginViewController];
        return;
    }
    
    int i = 0;
    NSDictionary *dic = self.model.userinfoDic;
    for (NSString *obj in dataArr) {
        OrderInfoViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
        if ([obj isEqualToString:@"*公司名称"] || [obj isEqualToString:@"公司名称"]) {
            companyname =  [cell.textFied.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([dic[@"company"] integerValue] == 1 && companyname.length <= 0) {
                 [self addSucessView:[NSString stringWithFormat:@"请填写公司名称"] type:2];
                return;
            }
        }
        if ([obj isEqualToString:@"*职      位"] || [obj isEqualToString:@"职      位"]) {
            JobStr = [cell.textFied.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([dic[@"job"] integerValue] == 1 && JobStr.length <= 0) {
                [self addSucessView:[NSString stringWithFormat:@"请填写职位"] type:2];
                return;
            }
        }
        if ([obj isEqualToString:@"*联系方式"] || [obj isEqualToString:@"联系方式"]) {
            PhoneStr = [cell.textFied.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([dic[@"mobile"] integerValue] == 1 && PhoneStr.length <= 0) {
                [self addSucessView:[NSString stringWithFormat:@"请填写联系方式"] type:2];
                return;
            }
        }
        if ([obj isEqualToString:@"*姓      名"] || [obj isEqualToString:@"姓      名"]) {
            nameStr = [cell.textFied.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([dic[@"name"] integerValue] == 1 && nameStr.length <= 0) {
                [self addSucessView:[NSString stringWithFormat:@"请填写姓名"] type:2];
                return;
            }
        }
        i ++;
    }
    if ([self.model.is_team isEqualToString:@"1"]) {
        OrderInfoViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        xuanYanStr =  [cell.textFied.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (xuanYanStr.length <= 0) {
            [self addSucessView:[NSString stringWithFormat:@"请填写宣言内容"] type:2];
            return;
        }
    }
    if (![IHUtility isValidateMobile:PhoneStr] && PhoneStr.length > 0) {
        [self addSucessView:[NSString stringWithFormat:@"手机号格式错误"] type:2];
        return;
    }
    remarkStr = textView.text;
    [self subOrderAction];
    
}
#pragma mark - 提交订单
- (void) subOrderAction {
//     NSLog(@"提交订单 --- %@ -- %@ --- %@ -- %@ --- 备注=%@",companyname,JobStr,PhoneStr,nameStr,remarkStr);
//    [self addWaitingView];
    
    if ([self.model.is_team isEqualToString:@"1"]) {
        //我要众筹提交订单
        if ([TeamStr isEqualToString:@"请选择队伍"]) {
            [self addSucessView:[NSString stringWithFormat:@"请选择战队"] type:2];
            return;
        }
        if (self.type == MTSubmitCrowdFundOrder) {
            if ([self.model.is_pop isEqualToString:@"1"]) {
                [self popPlayView];
            }else {
                [self TeamsubmitCrowdFundOrder];
            }
        }
        if (self.type == MTSubmitCrowdFundOrderOrPlay || self.type == MTSubmitActiviesPlay) {
            [self TeamsubmitActivityGoPlay];
        }


    }else {
        if (self.type == MTSubmitCrowdFundOrder) {
            if ([self.model.is_pop isEqualToString:@"1"]) {
                [self popPlayView];
            }else {
                //我要众筹提交订单
                [self submitCrowdFundOrder];
            }
           
        }
        if (self.type == MTSubmitCrowdFundOrderOrPlay) {
            //提交众筹我要支付订单并支付
            [self submitCrowdFundOrderPlay];
        }
        if (self.type == MTSubmitActiviesPlay) {
            [self submitActivityGoPlay];
        }
    }
    
}

#pragma mark - 队伍众筹提交订单
- (void) TeamsubmitCrowdFundOrder {
    NSDictionary *dic2;
    if (teamModel.team_id == nil) {
            dic2 = @{
                               @"user_id"       :  USERMODEL.userID,
                               @"activities_id" :  [NSString stringWithFormat:@"%@",self.model.activities_id],
                               @"order_num"     :  @"1",
                               @"contacts_people":  nameStr,
                               @"contacts_phone":  PhoneStr,
                               @"job"           :  JobStr,
                               @"company_name"  :  companyname,
                               @"email"         :  @"",
                               @"remark"        :  remarkStr,
                               };
    }else {
            dic2 = @{
                               @"user_id"       :  USERMODEL.userID,
                               @"activities_id" :  [NSString stringWithFormat:@"%@",self.model.activities_id],
                               @"order_num"     :  @"1",
                               @"contacts_people":  nameStr,
                               @"contacts_phone":  PhoneStr,
                               @"job"           :  JobStr,
                               @"company_name"  :  companyname,
                               @"email"         :  @"",
                               @"remark"        :  remarkStr,
                               @"team_id"       :  teamModel.team_id,
                               @"talk"          :  xuanYanStr,
                               };
    }
    NSLog(@"%@ --------xuanyan---- %@",dic2,xuanYanStr);
    [network httpRequestTagWithParameter:dic2 method:@"CrowdActivity/addCrowOrderActivities" tag:IH_AddCrowdActivties success:^(NSDictionary *dic) {
        
        MyCrowdFundController *vc = [[MyCrowdFundController alloc] init];
        vc.Type = @"2";
        CrowdOrderModel *model = dic[@"content"];
        vc.crowdID = [NSString stringWithFormat:@"%ld",model.infoModel.crowd_id];;
        vc.CFType = MyCrowdFundType;
        vc.isPopVc = @"1";
        if ([self.model.is_pop isEqualToString:@"1"]) {
            [self goPlayOrder:model];
        }else {
            [self removeWaitingView];
            [self pushViewController:vc];
        }
    } failure:^(NSDictionary *dic) {
        
    }];
}
#pragma mark 提交订单并支付
- (void) TeamsubmitActivityGoPlay {
    NSDictionary *dict2 = @{
                            @"user_id"       :  USERMODEL.userID,
                            @"activities_id" :  [NSString stringWithFormat:@"%@",self.model.activities_id],
                            @"order_num"     :  @"1",
                            @"contacts_people":  nameStr,
                            @"contacts_phone":  PhoneStr,
                            @"job"           :  JobStr,
                            @"company_name"  :  companyname,
                            @"email"         :  @"",
                            @"team_id"       :  teamModel.team_id,
                            };
    
    [network httpRequestTagWithParameter:dict2 method:@"Activities/addOrderActivities" tag:IH_AddActivties success:^(NSDictionary *dic) {
        
        [self removeWaitingView];
        ActivitiesListModel *model = dic[@"content"];
        //如果活动为免费活动 则直接报名成功 否则就跳转支付界面
        if (self.model.payment_amount == nil ||[self.model.payment_amount isEqualToString:@""]||[self.model.payment_amount isEqualToString:@"0"]) {
            [self addSucessView:@"报名成功！" type:1];
            ActivesCrowdFundController *ActivesVc = [[ActivesCrowdFundController alloc] init];
            NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                                self.model.activities_id,@"activities_id",
                                USERMODEL.userID,@"user_id",
                                nil];
            
            [network httpRequestTagWithParameter:dic2 method:@"Activities/selectActivities" tag:IH_UserActivityDetail success:^(NSDictionary *dic) {
                ActivitiesListModel *cModel = dic[@"content"];
                ActivesVc.model = cModel;
                ActivesVc.type = @"1";
                [self pushViewController:ActivesVc];
            } failure:^(NSDictionary *dic) {
                
            }];
        }else {
            self.model = model;
            [self selectPlayType:model];
        }
    } failure:^(NSDictionary *dic) {
        
    }];
    
}
#pragma mark - 提交活动订单并支付
- (void) submitActivityGoPlay {
    
    [network getAddActivtiesOrder:1 activities_id:[NSString stringWithFormat:@"%@",self.model.activities_id] contacts_people:nameStr contacts_phone:PhoneStr job:JobStr company_name:companyname email:@"" success:^(NSDictionary *obj) {
        [self removeWaitingView];
        ActivitiesListModel *model = obj[@"content"];
        //如果活动为免费活动 则直接报名成功 否则就跳转支付界面
        if (self.model.payment_amount == nil ||[self.model.payment_amount isEqualToString:@""]||[self.model.payment_amount isEqualToString:@"0"]) {
            [self addSucessView:@"报名成功！" type:1];
            ActivesCrowdFundController *ActivesVc = [[ActivesCrowdFundController alloc] init];
            NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                                self.model.activities_id,@"activities_id",
                                USERMODEL.userID,@"user_id",
                                nil];
            
            [network httpRequestTagWithParameter:dic2 method:@"Activities/selectActivities" tag:IH_UserActivityDetail success:^(NSDictionary *dic) {
                ActivitiesListModel *cModel = dic[@"content"];
                ActivesVc.model = cModel;
                ActivesVc.type = @"1";
                [self pushViewController:ActivesVc];
            } failure:^(NSDictionary *dic) {
                
            }];
        }else {
            self.model = model;
            [self selectPlayType:model];
        }
    } failure:^(NSDictionary *obj2) {
        
    }];
}

#pragma mark - 提交我要众筹订单
- (void) submitCrowdFundOrder {
    [network getActivtyCrowdOrder:USERMODEL.userID activities_id:self.model.activities_id order_num:@"1" contacts_people:nameStr contacts_phone:PhoneStr job:JobStr company_name:companyname email:@"" remark:remarkStr success:^(NSDictionary *obj) {
        [self removeWaitingView];
        
        MyCrowdFundController *vc = [[MyCrowdFundController alloc] init];
        vc.Type = @"2";
        CrowdOrderModel *model = obj[@"content"];
        vc.crowdID = [NSString stringWithFormat:@"%ld",model.infoModel.crowd_id];;
        vc.CFType = MyCrowdFundType;
        vc.isPopVc = @"1";
        [self pushViewController:vc];
    } failure:^(NSDictionary *obj2) {
        
    }];
}
#pragma mark - 提交众筹我要支付订单并支付
- (void) submitCrowdFundOrderPlay {
    //*
    [network getAddActivtiesOrder:1 activities_id:[NSString stringWithFormat:@"%@",self.model.activities_id] contacts_people:nameStr contacts_phone:PhoneStr job:JobStr company_name:companyname email:@""  success:^(NSDictionary *obj) {
        [self removeWaitingView];
        ActivitiesListModel *model = obj[@"content"];
        self.model = model;
        [self selectPlayType:model];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
    //*/
}
#pragma mark - 支付方式支付
- (void) selectPlayType:(ActivitiesListModel *)model {
    
    ApliayView *alipayView = [[ApliayView alloc] initWithFrame:self.view.window.bounds];
    alipayView.top = kScreenHeight;
    APayShow=YES;
    alipayView.selectBlock = ^(NSInteger index){
        if (index == ENT_top) {
            self.payType = [NSString stringWithFormat:@"%d",WEICHAT_TYPE];
            [[PayMentMangers manager] payment:model.order_no orderPrice:model.payment_amount type:self.payType subject:model.activities_titile activitieID:model.activities_id parentVC:self resultBlock:^(BOOL isPaySuccess, NSString *msg) {
                if (isPaySuccess) {
                    [self pushToPaySuccessfulVC];
                }
            }];
        }else if (index == ENT_midden){
            self.payType = [NSString stringWithFormat:@"%d",AlIPAY_TYPE];
            [[PayMentMangers manager] payment:model.order_no orderPrice:model.payment_amount type:self.payType subject:model.activities_titile activitieID:model.activities_id parentVC:self resultBlock:^(BOOL isPaySuccess, NSString *msg) {
                if (isPaySuccess) {
                    [self pushToPaySuccessfulVC];
                }
            }];
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

#pragma mark - 众筹先支付一笔订单
- (void) popPlayView {
    PlayPopView *popView = [[PlayPopView alloc] init];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:popView];
    [popView setPopViewZouclistModel:self.model];
    popView.cancelPopView = ^{
        [self dismissPopupController];
    };
    popView.goPlayOrder = ^{
        [self TeamsubmitCrowdFundOrder];    //发起众筹
        [self dismissPopupController];
    };
}
//支付完成
- (void)pushToPaySuccessfulVC {
    [self addSucessView:@"支付成功！" type:1];
    ActivesCrowdFundController *ActivesVc = [[ActivesCrowdFundController alloc] init];
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        self.model.activities_id,@"activities_id",
                        USERMODEL.userID,@"user_id",
                        nil];
    
    [network httpRequestTagWithParameter:dic2 method:@"Activities/selectActivities" tag:IH_UserActivityDetail success:^(NSDictionary *dic) {
        ActivitiesListModel *cModel = dic[@"content"];
        ActivesVc.model = cModel;
        ActivesVc.type = @"1";
        [self pushViewController:ActivesVc];
    } failure:^(NSDictionary *dic) {
        
    }];
   
        
//    ActivityPaySuccessfulViewController *vc=[[ActivityPaySuccessfulViewController alloc]init];
//    vc.indexPath = self.indexPath;
//    vc.model = self.model;
//    [self pushViewController:vc];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:self.indexPath];
}

#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView{
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromBottom;
    [self.popupViewController presentPopupControllerAnimated:YES];
    
}
- (void)dismissPopupController{
    [self.popupViewController dismissPopupControllerAnimated:YES];
}
- (void)goPlayOrder:(CrowdOrderModel *)model {
    NSDictionary *dict = @{
             @"c"         : [NSString stringWithFormat:@"%ld",model.infoModel.crowd_id],
             @"headimgurl": USERMODEL.userHeadImge,
             @"nickname"  : USERMODEL.nickName,
             @"openid"    : USERMODEL.userID,
             @"pay_money" :self.model.pop_money,
             @"is_refund" :@"1",
             };
    [network httpRequestTagWithParameter:dict method:@"CrowdActivity/getPrepay" tag:IH_init success:^(NSDictionary * dic) {
        [self removeWaitingView];
        NSDictionary *OrdDic = dic[@"content"];
        self.model.order_no = OrdDic[@"order_no"];
        self.model.uploadtime = OrdDic[@"create_time"];
        CGFloat Npic = [self.model.pop_money floatValue] *100;
        NSString *picStr = [NSString stringWithFormat:@"%.0f",Npic];
        self.model.payment_amount = picStr;
        [self selectPlayType:self.model];
    } failure:^(NSDictionary * dic) {
        [self removeWaitingView];
    }];
}


#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1011 && textField.text.length < 1) {
        [self showListV:textField];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"1");//输入文字时 一直监听
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 1011) {
        if (text.length < 1) {
            [_tableView addSubview:myTableView];
        }else {
            [myTableView removeFromSuperview];
        }
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"3");//文本彻底结束编辑时调用
    if (textField.tag == 1011) {
        [myTableView removeFromSuperview];
    }
}
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"5");// 点击‘x’清除按钮时 调用
    if (textField.tag == 1011) {
        [_tableView addSubview:myTableView];
    }
    return YES;
}
- (void) showListV:(UITextField *)Tf {
    CGRect rectInTableView = [_tableView rectForRowAtIndexPath:PhoneIndeX];
    CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
    CGFloat conentY = _tableView.contentOffset.y;
    CGFloat cellHeight;
    if (phoneArray.count >= 4) {
        cellHeight = 4 * kWidth(37.0);
    }else {
        cellHeight = phoneArray.count * 37;
    }
    if (myTableView == nil) {
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(Tf.frame.origin.x, rect.origin.y - cellHeight + conentY, Tf.frame.size.width, cellHeight) style:UITableViewStylePlain];
    }
    myTableView.tag = 100;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = cBgColor;
    [_tableView addSubview:myTableView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self.view endEditing:NO];;
}
@end

