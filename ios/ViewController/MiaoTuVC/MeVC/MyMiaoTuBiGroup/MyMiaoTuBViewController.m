//
//  MyMiaoTuBViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/15.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyMiaoTuBViewController.h"
#import "MyMiaoBiModel.h"
#import "UIViewMBHeadView.h"

#import "FBMCombox.h"
#import "MyMiaoBiTableViewCell.h"
//#import "YLWebViewController.h"
#import "MiaoBiInfoViewController.h"


@interface MyMiaoTuBViewController () <FBMComboxDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIView *headView;
    UILabel *miaotuNumlab;      //苗途币数量
    NSMutableArray *CurrentArr; //本月获取
    NSMutableArray *MBListArr;  //苗币记录
    UITableView *_tableView;
    UIViewMBHeadView *_topView;
    FBMCombox *_combox;
    NSString *type;             //0 获取 1消耗 2 全部
}

@end

static NSString * MyMiaoBiTableViewCellID = @"MyMiaoBiTableViewCell";

@implementation MyMiaoTuBViewController
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UIImage *backImg=Image(@"icon_fh_b");
    leftbutton.frame=CGRectMake(0, 0, 34, 40);
    [leftbutton setImage:backImg forState:UIControlStateNormal];
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:false];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(@"#F8F5F5");
    type = @"2";
    CurrentArr = [[NSMutableArray alloc] init];
    MBListArr = [[NSMutableArray alloc] init];
    
    [self setTitle:@"我的苗途币" andTitleColor:kColor(@"#FEFEFE")];
    titleLabel.font = sysFont(font(16));
    [self getUserMioatuBiInfoData];
    [self addHeadView];
    [self createTableView];
}
- (void) addHeadView {
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(219))];
    headView.backgroundColor = kColor(@"#05C1B0");
    [self.view addSubview:headView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(94), iPhoneWidth, kWidth(12))];
    label.text = @"可用苗途币";
    [headView addSubview:label];
    label.textColor = kColor(@"#FFFFFF");
    label.textAlignment = NSTextAlignmentCenter;
    label.font = sysFont(font(12));
    
    miaotuNumlab = [[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom + kWidth(20), iPhoneWidth, kWidth(25))];
    miaotuNumlab.text = @"0";
    [headView addSubview:miaotuNumlab];
    miaotuNumlab.textColor = kColor(@"#FFFFFF");
    miaotuNumlab.textAlignment = NSTextAlignmentCenter;
    miaotuNumlab.font = darkFont(font(33));
    
    UIView *headBotView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.height - kWidth(50), iPhoneWidth, kWidth(50))];
    headBotView.backgroundColor = kColor(@"#000000");
    headBotView.alpha = 0.04;
    [headView addSubview:headBotView];
    
    UILabel *getMBLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth/2 - 10, headBotView.height)];
    getMBLab.centerX = headBotView.width/4;
    getMBLab.centerY = headBotView.centerY;
    getMBLab.font = sysFont(font(13));
    getMBLab.textColor = kColor(@"#FFFFFF");
    getMBLab.textAlignment = NSTextAlignmentCenter;
    getMBLab.text = @"如何获取苗币";
    [headView addSubview:getMBLab];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getMiaoBiTag:)];
    // 允许用户交互
    getMBLab.userInteractionEnabled = YES;
    [getMBLab addGestureRecognizer:tapGes];
    
    UILabel *yaoqLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth/2 - 10, headBotView.height)];
    yaoqLab.centerX = iPhoneWidth/2 + headBotView.width/4;
    yaoqLab.font = sysFont(font(13));
    yaoqLab.textColor = kColor(@"#FFFFFF");
    yaoqLab.textAlignment = NSTextAlignmentCenter;
    yaoqLab.text = @"邀请好友得苗币";
    yaoqLab.centerY = getMBLab.centerY;
    [headView addSubview:yaoqLab];
    UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yaoqingTag:)];
    // 允许用户交互
    yaoqLab.userInteractionEnabled = YES;
    yaoqLab.tag = 100;
    [yaoqLab addGestureRecognizer:tapGes1];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth/2 - 1, 0, 2, kWidth(23))];
    lineLab.centerY = getMBLab.centerY;
    lineLab.alpha = 0.47;
    lineLab.backgroundColor = kColor(@"#FFFFFF");
    [headView addSubview:lineLab];
    
}

- (void) createTableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.bottom, iPhoneWidth, iPhoneHeight - headView.bottom) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = kColor(@"#F8F5F5");
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _topView = [[UIViewMBHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneHeight, kWidth(196) + kWidth(44) + kWidth(44))];
    _tableView.tableHeaderView = _topView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(50))];
    _tableView.tableFooterView = footView;
    UILabel *footLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(20), iPhoneWidth, kWidth(15))];
    footLab.text = @"仅展示近1年的记录";
    footLab.font = sysFont(13);
    footLab.textAlignment = NSTextAlignmentCenter;
    footLab.textColor = kColor(@"#818181");
    [footView addSubview:footLab];
    
    _combox = [[FBMCombox alloc] initWithItems:@[@"全部",@"获取",@"使用"] withFrame:CGRectMake(iPhoneWidth - kWidth(40) - kWidth(42) ,_topView.height - kWidth(35),kWidth(70), kWidth(30))];
    _combox.textFont = kWidth(14);
    [_tableView addSubview:_combox];
    _combox.delegate = self;
    
}
- (void) getUserMioatuBiInfoData {
    [self addWaitingView];
    NSDictionary *dict = @{
                           @"user_id" :  USERMODEL.userID,
                           @"type"    :  type
                           };
    [network httpRequestTagWithParameter:dict method:getUserMiaoBiinfoUrl tag:IH_init success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSDictionary *dict = obj[@"content"];
        if (dict[@"totalPoint"] != nil) {
			self->miaotuNumlab.text = dict[@"totalPoint"];
        }
        if (dict[@"head"] != nil) {
			[self->CurrentArr removeAllObjects];
            for (id mDic in dict[@"head"]) {
                if ([mDic isKindOfClass:[NSDictionary class]]) {
                    headModel *model = [[headModel alloc] initWithDictionary:mDic error:nil];
					[self->CurrentArr addObject:model];
                }
            }
			[self->_topView setCurrentGetMiaotubiArr:self->CurrentArr];
        }
        if (dict[@"monthPointList"] != nil) {
			[self->MBListArr removeAllObjects];
            for (id mDic in dict[@"monthPointList"]) {
                if ([mDic isKindOfClass:[NSDictionary class]]) {
                    MyMiaoBiModel *model = [[MyMiaoBiModel alloc] initWithDictionary:mDic error:nil];
					[self->MBListArr addObject:model];
                }
            }
        }
		[self->_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        [self removeWaitingView];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MBListArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MyMiaoBiModel *model = MBListArr[section];
    return model.pointsRecords.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(61);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kWidth(54);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeadView *view = [[SectionHeadView alloc] init];
    MyMiaoBiModel *model = MBListArr[section];
    [view updataMyMiaoBiModel:model];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kWidth(16);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SectionFootView *view = [[SectionFootView alloc] init];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView bringSubviewToFront:_combox];    //将筛选视图调制到最上层，防止被遮住
    
    MyMiaoBiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyMiaoBiTableViewCellID];
    if (cell == nil) {
        cell = [[MyMiaoBiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyMiaoBiTableViewCellID];
    }
    MyMiaoBiModel *model = MBListArr[indexPath.section];
    [cell updatapointsRecordsModel:model.pointsRecords[indexPath.row]];
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
#pragma mark - 苗币记录
- (void)combox:(FBMCombox *)combox didSelectItem:(NSString *)item {
    if ([item isEqualToString:@"获取"]) {
        type = @"0";
    }else if ([item isEqualToString:@"使用"]){
        type = @"1";
    }else {
        type = @"2";
    }
    [self getUserMioatuBiInfoData];
}


#pragma mark - 如何获取苗途币
-(void)getMiaoBiTag:(UITapGestureRecognizer *)sender{
    NSLog(@"如何获取苗途币");
    MiaoBiInfoViewController *controller=[[MiaoBiInfoViewController alloc]init];
    controller.NameTitle = @"苗途币获取使用规则";
    controller.type = 1;
    controller.navBg = @"miaobi_gz_Na";
    controller.mUrl=[NSURL URLWithString:self.Umodel.allUrl.getpointMoney_Url];
    [self pushViewController:controller];
    WS(weakSelf);
    controller.yaoqinghaoyouBlock = ^{
        weakSelf.yaoqinghaoyouBlock();
    };
}
#pragma mark - 邀请好友德苗途币
-(void)yaoqingTag:(UITapGestureRecognizer *)sender {
    NSLog(@"邀请好友得苗途币");
    if (self.yaoqinghaoyouBlock) {
        self.yaoqinghaoyouBlock();
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     [_tableView bringSubviewToFront:_combox];    //将筛选视图调制到最上层，防止被遮住
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
