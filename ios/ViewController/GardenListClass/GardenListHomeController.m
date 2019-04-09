//
//  GardenListHomeController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/17.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenListHomeController.h"
#import "MTHomeSearchView.h"    //搜索
#import "GardenModel.h"


#import "GardenListController.h"            //排行榜
#import "JoinGardenListController.h"        //加入榜单
#import "YLWebViewController.h"             //跳转链接
#import "GardenViews.h"

#import "GardenTableViewCell.h"              //榜单list
#import "GardenSearchController.h"           //搜索
#import "GardenListDetailViewController.h"
#import "GardenNewViewController.h"         //最新榜单
#import "GardenMoreListController.h"        //更多榜单

#import "ActivtiesVoteViewController.h"     //活动
#import "ActivesCrowdFundController.h"
#import "NewsImageDetailViewController.h"   //资讯
#import "NewsDetailViewController.h"

#import "GarehomePopCategoryView.h"

@interface GardenListHomeController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate> {
     MTHomeSearchView *searchTextfiled;
    
    NSMutableArray *_redsStoryArray;        //园榜红人故事
    NSMutableArray *_yuanbangArr;
    NSMutableArray *_OfflineModelArr;       //线下活动
    NSMutableArray *secTitleArr;                   //分区标题
    NSMutableArray *_NewGardenModelArr;     //最新入榜
    
    
    NSMutableArray *topItemArr;
    CGFloat _topSpaceH;
    
    NSString *okUrl;
    
    UITableView *_tableView;
    GardenTabHeadViews *_headView;
    
    NSTimer *timer; //定时器
    
    NSInteger ScroHeight;       //横向滚动榜单高度
    
    NSString *bgMoreImg;        //更多背景图片
    
}

@end

static NSString *GardenScrlistViewCellId = @"GardenScrlistViewCell";        //横向滚动榜单
static NSString *GardenActivitiesTabCellId = @"GardenActivitiesTabCell";    //线下活动
static NSString *GardenMarqueeTabCellId  = @"GardenMarqueeTabCell";           //轮播
static NSString *GardenRedsStoryTabCellId  = @"GardenRedsStoryTabCell";     //红人故事


@implementation GardenListHomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    leftbutton.frame=CGRectMake(0, 0, 20, 44);
    leftbutton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    UIImage *bgImage1 = [UIImage imageWithColor:kColor(@"#05c1b0") size:CGSizeMake(iPhoneWidth, KtopHeitht)];
    UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    //开启定时器
    [timer setFireDate:[NSDate distantPast]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
    
    //关闭定时器
    [timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    bgMoreImg = @"";
    self.view.backgroundColor = kColor(@"#fafafa");
    _redsStoryArray = [[NSMutableArray alloc] init];
    _NewGardenModelArr = [[NSMutableArray alloc] init];
    secTitleArr = [[NSMutableArray alloc] init];
//    secTitleArr = @[@"",@"最新入榜企业",@"园榜线下活动",@"园榜红人故事"];
    _yuanbangArr = [[NSMutableArray alloc] init];           //第0分区横向滚动标签园榜
    _OfflineModelArr = [[NSMutableArray alloc] init];
    topItemArr = [[NSMutableArray alloc] init];
    _topSpaceH = 0;
    [self createTableView];
    [self reloadData];
    ScroHeight = kWidth(260);
}
- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    GardenTabHeadViews *headView = [[GardenTabHeadViews alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(142))];
    _tableView.backgroundColor = kColor(@"#FFFFFF");
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableHeaderView = headView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _headView = headView;
    [self.view addSubview:_tableView];
    WS(weakSelf);
    headView.seleckBack = ^(NSInteger index) {
        [weakSelf selectTopItem:index];
    };
    NSDictionary *Dic=[IHUtility getUserDefalutDic:KGardenHomeDataDic];
    if (Dic != nil) {
        GardenModel *model = [[GardenModel alloc] initWithDictionary:Dic error:nil];
        NSDictionary *dict = model.indexModel;
        [secTitleArr removeAllObjects];
        [secTitleArr addObject:@""];
        if (dict[@"newCompany"]) {
            [secTitleArr addObject:dict[@"newCompany"]];
        }else {
            [secTitleArr addObject:@""];
        }
        if (dict[@"newInfo"]) {
            [secTitleArr addObject:dict[@"newInfo"]];
        }else {
            [secTitleArr addObject:@""];
        }
        if (dict[@"newActivity"]) {
            [secTitleArr addObject:dict[@"newActivity"]];
        }else {
            [secTitleArr addObject:@""];
        }
        for (menuListModel *menModel in model.gardenMenus) {
            [topItemArr addObject:menModel];
        }
        [_yuanbangArr addObject:model.gardenCategoryPojos];
        [_OfflineModelArr addObject:model.launchActivities];
        
        for (informationsModel *SModel in model.informations) {
            [_redsStoryArray addObject:SModel];
        }
        for (yuanbangModel *SModel in model.theNewGardenBangList) {
            [_NewGardenModelArr addObject:SModel];
        }
        bgMoreImg = model.moreImg;
        okUrl = model.okUrl;
        [_headView updataCreateSubViews:topItemArr];
        [_tableView reloadData];
    }
}


#pragma - mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return secTitleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _yuanbangArr.count;
    }
    if (section == 2) {
        return _OfflineModelArr.count;
    }
    if (section == 3) {
         return _redsStoryArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GardenScrlistViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenScrlistViewCellId];
        if (!cell) {
            cell = [[GardenScrlistViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GardenScrlistViewCellId];
        }
        cell.bgMoreImg = bgMoreImg;
        cell.selectionStyle = UITableViewCellStyleDefault;
        [cell updataSlideSegmentArray:_yuanbangArr];
        WS(weakSelf);
        cell.moreBlock = ^(NSInteger index) {
            [weakSelf moreActionIndex:index];
        };
        cell.cellSelkBack = ^(gardenListsModel *model) {
            [weakSelf jumpGardenList:model];
        };
/*
        cell.isShowBlock = ^(NSInteger index) {
            if (index == 1) {       //改变横向滚动分区的高度
                ScroHeight = kWidth(150);
            }else {
                ScroHeight = kWidth(260);
            }
            [tableView reloadData];
        };
//*/
        return cell;
    }else if (indexPath.section == 2){
        GardenOfflineTabCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenActivitiesTabCellId];
        if (!cell) {
            cell = [[GardenOfflineTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GardenActivitiesTabCellId];
        }
        [cell updataSlideSegmentArray:_OfflineModelArr];
        WS(weakSelf);
        cell.ActivitySelkBack = ^(ActivitiesModel *model) {
            [weakSelf offLineActivityModel:model];
        };
        cell.selectionStyle = UITableViewCellStyleDefault;
        return cell;
    }else if (indexPath.section == 3){
        GardenRedsStoryTabCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenRedsStoryTabCellId];
        if (!cell) {
            cell = [[GardenRedsStoryTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GardenRedsStoryTabCellId];
        }
        informationsModel *model = _redsStoryArray[indexPath.row];
        cell.model  = model;
        cell.selectionStyle = UITableViewCellStyleDefault;
        return cell;
    }else {
        GardenMarqueeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenMarqueeTabCellId];
        if (!cell) {
            cell = [[GardenMarqueeTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GardenMarqueeTabCellId];
        }
        [cell updataTableDataArray:_NewGardenModelArr];
        cell.selectionStyle = UITableViewCellStyleDefault;
        timer = cell.timer;
        WS(weakSelf);
        cell.marqueSelectBlock = ^(NSInteger index) {
            [weakSelf selectMaqueindex:index];
        };
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return ScroHeight;
//        return kWidth(260);
    }else if (indexPath.section == 2){
        if (_OfflineModelArr.count <= 0) {
            return 0;
        }
        return kWidth(170);
    }else if (indexPath.section == 3){
        informationsModel *CellModel = _redsStoryArray[indexPath.row];
        CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:CellModel keyPath:@"model" cellClass:[GardenRedsStoryTabCell class] contentViewWidth:iPhoneWidth];
        return height;
    }else if (indexPath.section == 1){
//        gardenReplyCommentModel *model = dataArray[indexPath.row];
//        CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GardenCommentCell class] contentViewWidth:iPhoneWidth];
        
        return kWidth(172);
    } else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else if (section == 2) {
//        if (_OfflineModelArr.count <= 0) {
//            return 0;
//        }
        return kWidth(41);
    }else if (section == 3) {
        if (_redsStoryArray.count <= 0) {
            return 0;
        }
        return kWidth(41);
    }else {
        return kWidth(41);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    if (section == 0) {
        
    }else {
        view.size = CGSizeMake(iPhoneWidth, kWidth(41));
        [view removeAllSubviews];
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = secTitleArr[section];
        titleLab.frame = CGRectMake(kWidth(10), 0, view.width - kWidth(20), kWidth(22));
        titleLab.textColor = kColor(@"#05C1B0");
        titleLab.centerY = view.height/2.;
        titleLab.font = sysFont(font(16));
        [view addSubview:titleLab];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return kWidth(30);
    }else {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        [self selectNewGardenBang:indexPath.row];
    }
}

#pragma - mark 设置导航栏
- (void) setNavigationBar {
    leftbutton.frame=CGRectMake(0, 0, 20, 44);
    leftbutton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    UIImage *shareImg=Image(@"Garden-bj-fx");
    moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(0, 0, 20, 40);
    [moreBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:shareImg forState:UIControlStateNormal];
    moreBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -10);
    UIBarButtonItem *barMoreBtn = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    moreBtn.backgroundColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = @[barMoreBtn];
    
    searchTextfiled = [[MTHomeSearchView alloc] initWithFrame:CGRectMake(0, 5, iPhoneWidth,34)];
    searchTextfiled.layer.borderWidth = 0.0;
    searchTextfiled.layer.cornerRadius = 10;
    searchTextfiled.clipsToBounds = YES;
    searchTextfiled.backgroundColor = kColor(@"#ffffff");
    searchTextfiled.searchTextField.backgroundColor =  kColor(@"#ffffff");
    //    searchTextfiled.searchTextField.alpha = 0.75;
    [ searchTextfiled.searchTextField setValue:kColor(@"#83847f") forKeyPath:@"_placeholderLabel.textColor"];
    searchTextfiled.searchTextField.placeholder = @"您想知道的企业名称";
    self.navigationItem.titleView = searchTextfiled;
    searchTextfiled.searchTextField.userInteractionEnabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SearchAction)];
    [searchTextfiled addGestureRecognizer:tap];
}

- (void) reloadData {
   [self addWaitingView];
   [network httpRequestWithParameter:nil method:GardenHomeUrl success:^(NSDictionary *dic) {
       [self removeWaitingView];

       GardenModel *model = [[GardenModel alloc] initWithDictionary:dic[@"content"] error:nil];
       if (dic[@"content"] != nil) {
           [IHUtility setUserDefaultDic:dic[@"content"] key:KGardenHomeDataDic];
       }
       NSDictionary *dict = model.indexModel;
       [self->secTitleArr removeAllObjects];
       [self->secTitleArr addObject:@""];
       if (dict[@"newCompany"]) {
           [self->secTitleArr addObject:dict[@"newCompany"]];
       }else {
           [self->secTitleArr addObject:@""];
       }
       if (dict[@"newInfo"]) {
           [self->secTitleArr addObject:dict[@"newInfo"]];
       }else {
           [self->secTitleArr addObject:@""];
       }
       if (dict[@"newActivity"]) {
           [self->secTitleArr addObject:dict[@"newActivity"]];
       }else {
           [self->secTitleArr addObject:@""];
       }
       self->bgMoreImg = model.moreImg;
       [self->_yuanbangArr removeAllObjects];
       [self->_yuanbangArr addObject:model.gardenCategoryPojos];  //滚动标签排行版
       [self->_OfflineModelArr removeAllObjects];
       if (model.launchActivities.count > 0) {
           [self->_OfflineModelArr addObject:model.launchActivities]; //线下活动
       }
       
       [self->_redsStoryArray removeAllObjects];
       for (informationsModel *SModel in model.informations) {
           [self->_redsStoryArray addObject:SModel];
       }
       
       [self->topItemArr removeAllObjects];
       
       for (menuListModel *menModel in model.gardenMenus) {
           [self->topItemArr addObject:menModel];
       }
       [self->_NewGardenModelArr removeAllObjects];
       for (yuanbangModel *SModel in model.theNewGardenBangList) {
            [self->_NewGardenModelArr addObject:SModel];
       }
       self->okUrl = model.okUrl;
	   [self->_headView updataCreateSubViews:self->topItemArr];
       [self->_tableView reloadData];

   } failure:^(NSDictionary * obj) {
         [self removeWaitingView];
    }];
    
}

#pragma - mark 园榜红人故事
- (void) selectNewGardenBang:(NSInteger ) index {
    informationsModel *model = _redsStoryArray[index];
//    NSLog(@"园榜红人故事 === %@",model);
    [self addWaitingView];
    [network getPushNewsDetail:model.infoId success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NewsListModel *model = obj[@"content"];
        if (model.img_type == 3) {
            NewsListModel *mod = obj[@"content"];
            NewsImageDetailViewController *vc = [[NewsImageDetailViewController alloc] init];
            vc.infoModel = mod;
            [self pushViewController:vc];
        }else {
            //    NewDetailModel *mod = obj[@"detailContent"];
            
            NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
            vc.infoModel = model;
            //  vc.model = mod;
            [self pushViewController:vc];
        }
    } failure:^(NSDictionary *obj2) {
        [self removeWaitingView];
    }];
}
#pragma - mark 顶部分类
-(void)selectTopItem:(NSInteger )index {
    menuListModel *menModel = topItemArr[index];
    if ([menModel.isJump isEqualToString:@"2"]) {           //0不跳转 1跳转功能 2.跳转链接
        YLWebViewController *controller=[[YLWebViewController alloc]init];
        controller.NameTitle = menModel.menuName;
        controller.type = 1;
        controller.mUrl = [NSURL URLWithString:menModel.jumpUrl];
        [self pushViewController:controller];
    }else if ([menModel.isJump isEqualToString:@"1"]) {
        if ([menModel.menuCode isEqualToString:@"2000"]) {           //申请入榜
            JoinGardenListController *joinVc = [[JoinGardenListController alloc] init];
            joinVc.titleStr = menModel.menuName;
            joinVc.successImg = okUrl;
            [self pushViewController:joinVc];
        }else if ([menModel.menuCode isEqualToString:@"2003"]) {
            GardenNewViewController *newView = [[GardenNewViewController alloc] init];
            newView.titleStr = menModel.menuName;
            [self pushViewController:newView];
        }else if ([menModel.menuCode isEqualToString:@"2004"]) {
            [self popGarehomePopCategory];
        }else {
            
        }
    } else {
        
        
    }
}
#pragma mark - 弹出榜单类别
- (void) popGarehomePopCategory {       //榜单分类
    GarehomePopCategoryView * CateView = [[GarehomePopCategoryView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:CateView];
    [CateView setGardenCategoryArr:_yuanbangArr andPointY:_headView.height + KtopHeitht - kWidth(25)];
    WS(weakSelf);
    CateView.cancelBack = ^{
        [weakSelf dismissPopupController];
    };
    //GardenScrlistViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CateView.SelectIndexBack = ^(NSInteger index) {
//        NSLog(@"标签-----%ld",index);
        [weakSelf dismissPopupController];
        [weakSelf moreActionIndex:index];
//        [cell updatacollectionContentoffX:index];
    };
}
#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView {
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupViewController presentPopupControllerAnimated:YES];
}
- (void)dismissPopupController {
    [self.popupViewController dismissPopupControllerAnimated:YES];
}

#pragma - mark 更多
- (void) moreActionIndex:(NSInteger )index {
    NSArray *modeArr = _yuanbangArr[0];
    biaoqianModel *Bmodel = modeArr[index];
    GardenMoreListController *moreVc = [[GardenMoreListController alloc] init];
    moreVc.model = Bmodel;
    moreVc.titleStr = Bmodel.cateName;
    [self pushViewController:moreVc];
}

#pragma - mark 跳转榜单列表
- (void) jumpGardenList:(gardenListsModel *)model {
    NSLog(@"榜单详情 == %@",model);
    if (model == nil) {
        return;
    }
    GardenListController *bangListVc = [[GardenListController alloc] init];
    bangListVc.model = model;
    [self pushViewController:bangListVc];
}

#pragma - mark 线下活动
- (void) offLineActivityModel:(ActivitiesModel *)model {
//    NSLog(@"线下活动 === %@",model);
    [self addWaitingView];
    [network getActivitiesDetail:model.activitiesId type:model.model success:^(NSDictionary *obj) {
        ActivitiesListModel *detailModel = obj[@"content"];
        [self removeWaitingView];
        if ([detailModel.model isEqualToString:@"7"]){
            ActivtiesVoteViewController *vc = [[ActivtiesVoteViewController alloc] init];
            vc.model = detailModel;
            //                vc.indexPath = indexPath;
            [self pushViewController:vc];
        }else{
            ActivesCrowdFundController *vc=[[ActivesCrowdFundController alloc]init];
            vc.model = detailModel;
            vc.type = @"1";
            [self pushViewController:vc];
        }
    } failure:^(NSDictionary *obj2) {
        [self removeWaitingView];
    }];
}

#pragma - mark 最新入榜轮播点击事件
- (void) selectMaqueindex:(NSInteger )index {
    yuanbangModel *model = _NewGardenModelArr[index];
    GardenListDetailViewController *DeailVc = [[GardenListDetailViewController alloc] init];
    DeailVc.model = model;
    [self pushViewController:DeailVc];
}


#pragma - mark 搜索
- (void) SearchAction {
    GardenSearchController *searchVc = [[GardenSearchController alloc] init];
    [self pushViewController:searchVc];
//    NSLog(@"搜索");
}
- (void)dealloc {
    [timer invalidate];
    timer = nil;
    NSLog(@"~~~释放~~~");
}
//*
#pragma mark - 分享
- (void) shareAction {
    [searchTextfiled.searchTextField resignFirstResponder];
    NSString *ClassHomePath = [NSString stringWithFormat:@"pages/gardenRank/gardenRank"];
    NSDictionary *dict = @{
                           @"appid"         : WXXCXappId,
                           @"appsecret"     : WXXCXappSecret,
                           @"path"          : ClassHomePath,
                           };
    [self shareSmallProgramCodeOject:dict httpMethod:0 methoe:@"wechat/getGardenIndexCode" Vc:self completion:nil];
}
//*/



@end
