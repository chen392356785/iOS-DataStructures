//
//  MyClassSourceController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/29.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyClassSourceController.h"
#import "ClassroomModel.h"
#import "ClassSourceTableViewCell.h"

//#import "ClassSourdeDetailController.h" //课程详情


@interface MyClassSourceController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *_HeadImageV;
    UILabel  *_StudyTimeLabel;      //坚持学习
    UILabel *_completeClassLabel;   //完成课程
    UILabel *_totalLabel;    //总时长
    
    NSMutableArray *HistoryArray;
    NSMutableArray *buyClassArray;
     int page;
    UIView *_topView;
    UIView *_lineVew;
    UITableView *_tableView;
    
}
@property (nonatomic, strong) UIScrollView * bgScroll;
@property (nonatomic, strong) UIImageView *HeadBgView;

@end

static NSString *buyClassSourceCellId    = @"buyClassSourceCellID";
static NSString *historyClassScoreCellId = @"historyClassScoreCellID";

@implementation MyClassSourceController

- (void) backBtnItmAction {
    if (self.presentingViewController) {
        //判断1
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        //判断2
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *backImg=Image(@"icon_fh_b");
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 34, 40);
    [backBtn addTarget:self action:@selector(backBtnItmAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    leftbutton = backBtn;
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    UIBarButtonItem *backBtnItm = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBtnItm;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self reloadData]; //刷新列表

}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:false];
}

- (void)viewDidLoad {
   
   buyClassArray = [[NSMutableArray alloc]init];
   HistoryArray = [[NSMutableArray alloc]init];
   [self setHeadSubView];
   
    [self createTableView];
//   [self reloadData];
}
- (void) reloadData {
    [self addWaitingView];
    NSDictionary *dic = @{
                            @"userId" :  USERMODEL.userID,
                          };
    [network httpRequestWithParameter:dic method:mySubjectOrderUrl success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSDictionary *dict = obj[@"content"];
        self->_StudyTimeLabel.text = [NSString stringWithFormat:@"%@天",dict[@"dayCount"]];
        self->_completeClassLabel.text = [NSString stringWithFormat:@"%@个",dict[@"okClass"]];
        self->_totalLabel.text = [NSString stringWithFormat:@"%@",dict[@"timeSum"]];
        
        NSString *headImage = USERMODEL.userHeadImge;
        [self->_HeadImageV sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:kImage(@"defaulthead")];
        NSArray *arr = dict[@"listenSubjectHistoryList"];
        NSArray *BuyArra = dict[@"myClassOrder"];
        [self->HistoryArray removeAllObjects];
        for (NSDictionary *hDic in arr) {
            MyClassSourceListModel *model = [[MyClassSourceListModel alloc] initWithDictionary:hDic error:nil];
            [self->HistoryArray addObject:model];
            UITableView *tableV = [self.view viewWithTag:101];
            [tableV reloadData];
        }
        [self->buyClassArray removeAllObjects];
        for (NSDictionary *hDic in BuyArra) {
            MyClassSourceListModel *model = [[MyClassSourceListModel alloc] initWithDictionary:hDic error:nil];
            [self->buyClassArray addObject:model];
            UITableView *tableV = [self.view viewWithTag:100];
            [tableV reloadData];
        }
        
    } failure:^(NSDictionary *obj2) {
        [self removeWaitingView];
    }];
}

- (void) setHeadSubView {
    self.HeadBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(214)+KStatusBarHeight)];
    self.HeadBgView.image = kImage(@"MyClass_bj");
    
    [self.view addSubview:self.HeadBgView];
    _HeadImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, KStatusBarHeight +kWidth(24), 70, 70)];
    _HeadImageV.centerX = iPhoneWidth/2.;
    _HeadImageV.clipsToBounds = YES;
    _HeadImageV.image = kImage(@"headtjh");
    _HeadImageV.layer.cornerRadius = _HeadImageV.width/2.;
    _HeadImageV.layer.borderWidth = 1.5;
    _HeadImageV.layer.borderColor = kColor(@"#ffffff").CGColor;
    [self.HeadBgView addSubview:_HeadImageV];
    
    UILabel *studLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _HeadImageV.bottom + kWidth(31.5), iPhoneWidth/3, 15)];
    studLab.text = @"坚持学习";
    studLab.font = sysFont(15);
    studLab.textColor = kColor(@"#ffffff");
    studLab.textAlignment = NSTextAlignmentCenter;
    [self.HeadBgView addSubview:studLab];
    
    UILabel *endClassLab = [[UILabel alloc] initWithFrame:CGRectMake(studLab.right, studLab.top, iPhoneWidth/3, 15)];
    endClassLab.text = @"完成课程";
    endClassLab.font = sysFont(15);
    endClassLab.textColor = kColor(@"#ffffff");
    endClassLab.textAlignment = NSTextAlignmentCenter;
    [self.HeadBgView addSubview:endClassLab];
    
    UILabel *totalLab = [[UILabel alloc] initWithFrame:CGRectMake(endClassLab.right, studLab.top, iPhoneWidth/3, 15)];
    totalLab.text = @"累计时长";
    totalLab.font = sysFont(15);
    totalLab.textColor = kColor(@"#ffffff");
    totalLab.textAlignment = NSTextAlignmentCenter;
    [self.HeadBgView addSubview:totalLab];
    
    _StudyTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, studLab.bottom + 17, iPhoneWidth/3, 15)];
    _StudyTimeLabel.text = @"0天";
    _StudyTimeLabel.font = sysFont(15);
    _StudyTimeLabel.textColor = kColor(@"#ffffff");
    _StudyTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.HeadBgView addSubview:_StudyTimeLabel];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(_StudyTimeLabel.right - 1, 0, 2, 28)];
    line1.backgroundColor = kColor(@"#ffffff");
    line1.centerY = _StudyTimeLabel.top - 8;
    [self.HeadBgView addSubview:line1];
    
    _completeClassLabel = [[UILabel alloc] initWithFrame:CGRectMake(line1.right, _StudyTimeLabel.top, iPhoneWidth/3, 15)];
    _completeClassLabel.text = @"0个";
    _completeClassLabel.font = sysFont(15);
    _completeClassLabel.textColor = kColor(@"#ffffff");
    _completeClassLabel.textAlignment = NSTextAlignmentCenter;
    [self.HeadBgView addSubview:_completeClassLabel];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(_completeClassLabel.right - 1, line1.top, 2, 28)];
    line2.backgroundColor = kColor(@"#ffffff");
    [self.HeadBgView addSubview:line2];
    
    _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(line2.right, _StudyTimeLabel.top, iPhoneWidth/3, 15)];
    _totalLabel.text = @"0分钟";
    _totalLabel.font = sysFont(15);
    _totalLabel.textColor = kColor(@"#ffffff");
    _totalLabel.textAlignment = NSTextAlignmentCenter;
    [self.HeadBgView addSubview:_totalLabel];
    
}
- (void) createTableView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.HeadBgView.bottom, WindowWith, 47)];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    UIView *lineVew = [[UIView alloc] initWithFrame:CGRectMake(0, 46, WindowWith/4., 1)];
    lineVew.backgroundColor = RGB(6, 183, 174);
    _lineVew = lineVew;
    [topView addSubview:lineVew];
    NSArray *arr = @[@"已购课程",@"听课历史"];
    for (int i =0; i<arr.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowWith/arr.count*i, 0, WindowWith/arr.count, 46)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:cBlackColor forState:UIControlStateNormal];
        [button setTitleColor:RGB(6, 193, 174) forState:UIControlStateSelected];
        button.titleLabel.font = sysFont(16);
        [button addTarget:self action:@selector(switchType:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            button.selected = YES;
            _lineVew.centerX = button.center.x;
        }
        button.tag = 10+i;
        [topView addSubview:button];
    }
    [self.view addSubview:topView];
    self.bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topView.bottom, WindowWith, iPhoneHeight -topView.bottom)];
    self.bgScroll.contentSize = CGSizeMake(WindowWith*arr.count, 0);
    
    self.bgScroll.delegate = self;
    self.bgScroll.pagingEnabled = YES;
    self.bgScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bgScroll];
    self.bgScroll.bounces = NO;
    page = 1;
    for (int i= 0 ; i < arr.count ; i ++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * WindowWith, 0, iPhoneWidth, height(self.bgScroll)) style:UITableViewStylePlain];
        tableView.backgroundColor = cLineColor;
        tableView.delegate=self;
        tableView.separatorColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.tag = 100+i;
        [self.bgScroll addSubview:tableView];
        NSString *context = @"暂无课程哦~";
        EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:CGRectMake(0, 0, tableView.size.width, tableView.size.height) context:context];
        EPView.tag = 10 + i;
        EPView.hidden = YES;
        [tableView addSubview:EPView];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        if (buyClassArray.count == 0) {
            EmptyPromptView *EPView  = [tableView viewWithTag:10];
            EPView.hidden = NO;
        }else {
            EmptyPromptView *EPView  = [tableView viewWithTag:10];
            EPView.hidden = YES;
        }
        return buyClassArray.count;
    }else if (tableView.tag == 101) {
        if (HistoryArray.count == 0) {
            EmptyPromptView *EPView  = [tableView viewWithTag:11];
            EPView.hidden = NO;
        }else {
            EmptyPromptView *EPView  = [tableView viewWithTag:11];
            EPView.hidden = YES;
        }
        return HistoryArray.count;
    }else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(122);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        MyClassSourceListModel *model = buyClassArray[indexPath.row];
        ClassSourceTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:buyClassSourceCellId];
        if (cell == nil) {
            cell = [[ClassSourceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buyClassSourceCellId];
        }
        cell.selectionStyle = UITableViewCellStyleDefault;
        [cell setDataWith:model isHistort:NO];
        return cell;
    }else {
        ClassSourceTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:historyClassScoreCellId];
        if (cell == nil) {
            cell = [[ClassSourceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historyClassScoreCellId];
        }
        cell.selectionStyle = UITableViewCellStyleDefault;
        MyClassSourceListModel *model = HistoryArray[indexPath.row];
        [cell setDataWith:model isHistort:YES];
        return cell;
    }
}
//切换活动类型
- (void)switchType:(UIButton *)button
{
    if (button.selected == YES) {
        return;
    }
    button.selected = YES;
    for (int i = 0; i<2; i++) {
        UIButton *btn = [_topView viewWithTag:i+10];
        if (btn.tag != button.tag) {
            btn.selected= NO;
        }
    }
    self.bgScroll.contentOffset = CGPointMake((button.tag - 10)*WindowWith, 0);

    _lineVew.centerX = button.center.x;
    
    _tableView = [self.bgScroll viewWithTag:100 + button.tag - 10];
    
}

#pragma mark -- scrollviewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.bgScroll) {
        NSInteger selectedIndx = scrollView.contentOffset.x/WindowWith;
        UIButton *button =  [_topView viewWithTag:selectedIndx+10];
        button.tag = selectedIndx + 10;
        if (button.selected == YES) {
            return;
        }
        button.selected = YES;
        for (int i = 0; i<2; i++) {
            UIButton *btn = [_topView viewWithTag:i+10];
            if (btn.tag != button.tag) {
                btn.selected= NO;
            }
        }
        _lineVew.centerX = button.center.x;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        
        
//        ClassSourdeDetailController *DetailVc = [[ClassSourdeDetailController alloc] init];
//        studyBannerListModel *DModel = [[studyBannerListModel alloc] init];
//        DModel.className = mode.class_name;
//        DModel.classUuid = mode.class_uuid;
//        DetailVc.model = DModel;
//        [self pushViewController:DetailVc];
    }
}
@end
