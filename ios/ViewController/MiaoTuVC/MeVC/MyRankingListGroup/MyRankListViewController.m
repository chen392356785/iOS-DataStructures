//
//  MyRankListViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/18.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyRankListViewController.h"




@implementation MyRankListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    UILabel *linLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(15), kWidth(61), iPhoneWidth - kWidth(30) - kWidth(24), 1)];
    linLabel.backgroundColor = kColor(@"#E5E5E5");
    [self.contentView addSubview:linLabel];
    rightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(21), kWidth(19), kWidth(25), kWidth(25))];
    [self.contentView addSubview:rightImgV];
    
    NumLab = [[UILabel alloc] initWithFrame: rightImgV.frame];
    NumLab.textAlignment = NSTextAlignmentCenter;
    NumLab.font = darkFont(font(14));
    [self.contentView addSubview:NumLab];
    
    nameLab = [[UILabel alloc] initWithFrame: CGRectMake(rightImgV.right + kWidth(19), kWidth(13), kWidth(100), kWidth(13))];
    nameLab.font = sysFont(font(14));
    nameLab.text = @"张大大";
    [self.contentView addSubview:nameLab];
    
    fensLab = [[UILabel alloc] initWithFrame: CGRectMake(nameLab.left, nameLab.bottom + kWidth(13), linLabel.right - nameLab.left, kWidth(13))];
    fensLab.font = sysFont(font(12));
    fensLab.text = @"2100个粉丝";
    fensLab.textColor = kColor(@"#757575");
    [self.contentView addSubview:fensLab];
    
    miaoBLab = [[UILabel alloc] initWithFrame: CGRectMake(linLabel.right - kWidth(55), kWidth(25), kWidth(50), kWidth(16))];
    miaoBLab.font = sysFont(font(16));
    miaoBLab.text = @"2100";
    miaoBLab.textColor = kColor(@"#FF3C0A");
    miaoBLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:miaoBLab];
}
- (void)updataRankListModel:(RankListModel *)model {
    nameLab.text = model.nickname;
    fensLab.text = [NSString stringWithFormat:@"%@个粉丝",model.followUserCount];
    miaoBLab.text = model.sumPoint;
    miaoBLab.adjustsFontSizeToFitWidth = YES;
    if ([model.orderNumber isEqualToString:@"1"]) {
        rightImgV.image = kImage(@"icon_one");
        NumLab.hidden = YES;
        rightImgV.hidden = NO;
    }else if ([model.orderNumber isEqualToString:@"2"]) {
        rightImgV.image = kImage(@"icon_two");
        NumLab.hidden = YES;
        rightImgV.hidden = NO;
    }else if ([model.orderNumber isEqualToString:@"3"]) {
        NumLab.hidden = YES;
        rightImgV.hidden = NO;
        rightImgV.image = kImage(@"icon_three");
    }else {
       rightImgV.hidden = YES;
       NumLab.hidden = NO;
       NumLab.text = model.orderNumber;
    }
}
@end





@interface MyRankListViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UIView  * headView;
    UILabel * showPaimLab;

    UITableView *_tableView;
    NSMutableArray *dataArr;
}

@end

static NSString * MyRankListTableViewCellID = @"MyRankListTableViewCell";

@implementation MyRankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.view.backgroundColor = kColor(@"#F8F5F5");
    dataArr = [[NSMutableArray alloc] init];
    [self createUISubViews];
    [self getData];
}
- (void) getData {
     [self addWaitingView];
    NSString *userID = @"";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    userID = USERMODEL.userID;
    NSDictionary *dic = @{
                          @"userId"     : userID,
                          @"type"       : self.typeStr,
                          };
    [network httpRequestWithParameter:dic method:getpointsListUrl success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSDictionary *dic = obj[@"content"];
        NSArray *arr = dic[@"pointList"];
        if (arr.count > 0) {
            for (NSDictionary *mdic in arr) {
                RankListModel *model = [[RankListModel alloc] initWithDictionary:mdic error:nil];
                [self->dataArr addObject:model];
            }
        }
        NSDictionary *myDic = dic[@"myPointList"];
        if (myDic != nil) {
            RankListModel *model = [[RankListModel alloc] initWithDictionary:myDic error:nil];
            self->showPaimLab.text = model.orderNumber;
        }
        [self->_tableView reloadData];
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
}
- (void) createUISubViews {
    headView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(16), iPhoneWidth - kWidth(24), kWidth(106))];
    [self.view addSubview:headView];
    headView.backgroundColor = kColor(@"#FFFFFF");
    headView.layer.cornerRadius = kWidth(8);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(24), headView.width, kWidth(14))];
    [headView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"当前排名";
    label.textColor = kColor(@"#333333");
    label.font = boldFont(font(14));
    
    showPaimLab = [[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom + kWidth(22), headView.width, kWidth(30))];
    [headView addSubview:showPaimLab];
    showPaimLab.textAlignment = NSTextAlignmentCenter;
    showPaimLab.textColor = kColor(@"#05C1B0");
    showPaimLab.font = darkFont(font(30));
    
    UILabel *lisInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(14), headView.bottom + kWidth(15), headView.width, kWidth(13))];
    [self.view addSubview:lisInfoLab];
    lisInfoLab.text = @"榜单信息";
    lisInfoLab.textColor = kColor(@"#333333");
    lisInfoLab.font = boldFont(font(14));
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(headView.left, lisInfoLab.bottom + kWidth(16), headView.width, iPhoneHeight - lisInfoLab.bottom - 40 - kWidth(16) - KtopHeitht - kWidth(27) ) style: UITableViewStylePlain];
    _tableView.backgroundColor = kColor(@"#FFFFFF");
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    _tableView.layer.cornerRadius = kWidth(8);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(62);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyRankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyRankListTableViewCellID];
    if (cell == nil) {
        cell = [[MyRankListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyRankListTableViewCellID];
    }
    RankListModel *model = dataArr[indexPath.row];
    [cell updataRankListModel:model];
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}

@end
