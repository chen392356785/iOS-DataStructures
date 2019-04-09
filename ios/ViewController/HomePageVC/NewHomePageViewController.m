//
//  NewHomePageViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/6/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NewHomePageViewController.h"
#import "AdView.h"
#import "YLWebViewController.h"
//#import "GongQiuMainViewController.h"
#import "MTTopicDetailsViewController.h"
#import "GongQiuDetailsViewController.h"
#import "NewsTableListViewController.h"
#import "ActivityListViewController.h"      //活动列表
//#import "ActivityTypeController.h"          //活动分类
#import "NewsBanner.h"
#import "MTOtherInfomationMainViewController.h"
//#import "LogisticsIdentViewController.h"
//#import "LogisticsFindCarListViewController.h"
//#import "LogisticsFindGoodsListViewController.h"
#import "ChatListViewController.h"
//#import "ActivityDetailViewController.h"
//#import "InvitedViewController.h"
#import "MTTopicListViewController.h"
//#import "MapAnnotationViewController.h"
//#import "MYTaskViewController.h"
#import "NewSlideHeadingViewController.h"
#import "NewsDetailViewController.h"
#import "NewsImageDetailViewController.h"
#import "EPCloudListViewController.h"
//#import "EPCloudCumlativeViewController.h"
//#import "GardenCloudViewController.h"
//#import "MTNewSupplyAndBuyViewController.h"
//#import "VotoChartsListViewController.h"
#import "ActivtiesVoteViewController.h"
//#import "MTThemeListViewController.h"
#import "MiaoTuMainViewController.h"
//#import "EditPersonInformationViewController.h"
//#import "CrowdFundingViewController.h"
//#import "IdentAuthViewController.h"
//#import "JionEPCloudViewController.h"
#import "JobIdentViewController.h"
#import "GiuZhiViewController.h"
#import "ZhaoPingViewController.h"
#import "NewECloudHomePageViewController.h"
#import "GuangChangMainViewController.h"
#import "AskProblemDetailViewController.h"
#import "NurseryCloudViewController.h"
#import "HomePageWeatherViewController.h"
//#import "CreatNerseryViewController.h"
//#import "CityTableViewController.h"
//#import "CityChooseViewController.h"
#import "JLAddressPickView.h"
//#import "ScoreConvertViewController.h"
//#import "PersonScoreViewController.h"
//#import "NewsTableListViewController.h"
#import "EPCloudDetailViewController.h"
//#import "ChatroomListViewController.h"
#import "MTShoppingViewController.h"
#import "FindCarViewController.h"
//#import "LogisticsFindCarListViewController.h"
//#import "MTTopicDetailsViewController.h"

#import "MTHomeSectionTitleView.h"
#import "ChooseHTTPServiceViewController.h"
//#import "UIBarButtonItem+Extents.h"
#import "THModalNavigationController.h"

#import "ActivesCrowdFundController.h"

#import "NewVarietyPicController.h"         //新品种图库
#import "MTHomeSearchView.h"        //搜索
#import "HomeSearchViewController.h"
#import "showImageController.h" //新品种图片大图

#import "DFDiscernListViewController.h"     //鉴定
//#import "ClassroomHomeController.h"         //课堂首页
#import "GardenListHomeController.h"        //园榜
#import "MTHomePopView.h"                   //弹框
//#import "MTHomePopModel.h"                  //弹框Model
#import "MyClassSourceController.h"         //我的课程
#import "RecommendTeacherController.h"      //推荐讲师
#import "MyMessageListViewController.h"   //我的消息
#import "MiaoBiInfoViewController.h"      //H5界面

#define NAVBAR_CHANGE_POINT 50
#define  navHeigh  64
#define  itemWidth  WindowWith/4

//#import "NSString+AES.h"


@interface NewHomePageViewController ()<UITableViewDelegate,NewsDataSourceDelegate,JLAddressActionSheetDelegate,BCBaseTableViewCellDelegate,UITableViewDataSource,MTTopicAgreeDelegate,TFFlowerSearchViewDelegate>
{
    MTBaseTableView * commTableView;
    NSMutableArray * dataArray;
    int page;
    NSMutableArray * tittleArr;
    NewsBanner *tittleScroll;
    UIView *_topView;
    AdView *_v;
    CGFloat _offsetY;
    float lastContentOffset;
    CornerView *_cornerview;
    UIView *_bkView;
    NSInteger _question;
    CGFloat width;
    CGFloat hight;
    UIImageView *_redImageView;
    NSString *_city;
    UIView *_view;
    SMLabel *_cityLbl;
    UIImageView *_imageView;
    JLAddressPickView *_adressPickView;
    WeatherView *_weatherView;
    NSDictionary *_dic;
    NSString *_cityId;
    BOOL pick;
    
    
    NSArray *categoryList;
    UITableView *_table;
    HomePageTopView *topView;           //banner
    MTHomeSearchView *searchTextfiled;
    UIButton *LeftCityBtn;      //城市选择
    
    BOOL isShowPopView;
    UIButton *_cityBtn;     //当前城市
    NSNumber *messageNum;   //消息未读数
    UILabel *_messLab;
}

/**行业资讯资讯*/
@property (nonatomic,strong) NSMutableArray *hotZixunArray;
/**热门品种*/
@property (nonatomic,strong) NSMutableArray *hotPinZhongArray;
/**企业*/
@property (nonatomic,strong) NSMutableArray *hotqiyeArray;
/**人脉*/
@property (nonatomic,strong) NSMutableArray *hotRenmaiArray;

/**战略合作单位*/
@property (nonatomic,strong) NSMutableArray *zhanluehezuoUnitArray;
/**新品种*/
@property (nonatomic,strong) NSMutableArray *XinPinzhongArray;

@end


@implementation NewHomePageViewController

- (NSMutableArray *)hotZixunArray {

    if (!_hotZixunArray) {
        _hotZixunArray = [NSMutableArray array];
    }
    return _hotZixunArray;
}
- (NSMutableArray *)XinPinzhongArray {
    
    if (!_XinPinzhongArray) {
        _XinPinzhongArray = [NSMutableArray array];
    }
    return _XinPinzhongArray;
}
- (NSMutableArray *)zhanluehezuoUnitArray {
    
    if (!_zhanluehezuoUnitArray) {
        _zhanluehezuoUnitArray = [NSMutableArray array];
    }
    return _zhanluehezuoUnitArray;
}
- (NSMutableArray *)hotPinZhongArray {

    if (!_hotPinZhongArray) {
     
        _hotPinZhongArray = [NSMutableArray array];
    }
    return _hotPinZhongArray;
}
- (NSMutableArray *)hotqiyeArray {

    if (!_hotqiyeArray) {
        
        _hotqiyeArray = [NSMutableArray array];
    }
    return _hotqiyeArray;

    
}
- (NSMutableArray *)hotRenmaiArray {
    
    if (!_hotRenmaiArray) {
        
        _hotRenmaiArray = [NSMutableArray array];
    }
    return _hotRenmaiArray;
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setHomeTabBarHidden:NO];
}
-(void)badgeChatNum:(NSNotification *)notification {
    
    //  [_cornerview setNum:[[notification object] intValue]];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//   滚动列表tabbar隐藏。
//    if (lastContentOffset < scrollView.contentOffset.y) {
//        [self setHomeTabBarHidden:YES];
//    }else{
//        [self setHomeTabBarHidden:NO];
//    }
}

-(void)cityPick
{
    [self chooseAdress:@"选择城市" tag:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self SetNaviBarItemView];

    //do sth.
    _city = @"正在定位";
    
    if (USERMODEL.city!=nil) {
        _city = USERMODEL.city;
        [self setCity:_city];
    }else{
        _city=@"杭州";
        [self setCity:_city];
    }

    [self setTitle:@"苗  途"];

    _question=0;
    [self createTableView];
    
//    MTOppcenteView *oppcenteView=[[MTOppcenteView alloc]initWithOrgane:CGPointMake(WindowWith/2 - 10, WindowHeight-TFTabBarHeight - 115)  BtnType:ENT_FaBu];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
//        [self.view bringSubviewToFront:oppcenteView];
//        [self.view addSubview:oppcenteView];
        
    }else{
        NSLog(@"已经不是第一次启动了");
    }

    [self setbackTopFrame:backBtnY];
    
//     [leftbutton setImage:[Image(@"ding.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    leftbutton.hidden=YES;
    
//      UIImage *Img= Image(@"ding.png");
//      rightbutton.frame = CGRectMake(0, 0, Img.size.width, Img.size.height);
//       leftbutton.frame = CGRectMake(0, 0, Img.size.width, Img.size.height);
    
    // [rightbutton setImage:[Image(@"ding.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    rightbutton.hidden = YES;
    
    //    CornerView *view=[[CornerView alloc]initWithFrame:CGRectMake(rightbutton.width - 5, -5, 15, 10) count:BadgeMODEL.chatNum];//
    //    _cornerview=view;
    //    [rightbutton addSubview:view];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationPush:) name:NotificationPushVC object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationPush:) name:NotificationTapLanuch object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setRedImageView) name:NotificationQusetion object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideRedImageView) name:NotificationNavViewHide object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityChangeNoti) name:kUserDefalutInitcity object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SheQuNotiBadgeNum) name:KSheQuBadgeSumNum object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HomePopView) name:KPopHomeView object:nil];
    
    
}
#pragma - mark 社区
- (void) SheQuNotiBadgeNum {
    [topView.BadgeView setNum:[BadgeMODEL getSumNum]];
}

#pragma - mark

- (void)SetNaviBarItemView {
//    self.navigationItem.rightBarButtonItems =
    self.title = @"首页";
    self.navigationItem.rightBarButtonItem = nil;
//*
    
    UIButton *SwithBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    SwithBtn.frame=CGRectMake(0, 0, 20, 35);
    SwithBtn.titleLabel.font = sysFont(16);
    [SwithBtn addTarget:self action:@selector(actionToChooseHTTPServiuce:) forControlEvents:UIControlEventTouchUpInside];
//    [SwithBtn setTitle:@"消息" forState:UIControlStateNormal];
    [SwithBtn setImage:[kImage(@"right_message") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [SwithBtn setBackgroundImage:[kImage(@"right_message") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    SwithBtn.titleLabel.font = sysFont(14);
    [SwithBtn setTitleColor:kColor(@"#333333") forState:UIControlStateNormal];
    UIBarButtonItem *SwithBtnItm = [[UIBarButtonItem alloc] initWithCustomView:SwithBtn];
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(SwithBtn.width - 15, 0, 30, 13)];
    numLab.backgroundColor = kColor(@"#FF0000");
    numLab.layer.cornerRadius = 7.5;
    numLab.clipsToBounds = YES;
    numLab.textAlignment = NSTextAlignmentCenter;
    _messLab = numLab;
    [SwithBtn addSubview:numLab];
    _messLab.hidden = YES;
    _messLab.font = darkFont(10);
    _messLab.textColor = kColor(@"#FFFFFF");
    
    self.navigationItem.rightBarButtonItems = @[SwithBtnItm];
#ifdef DEBUG
//    self.navigationItem.rightBarButtonItems = @[barMoreBtn,SwithBtnItm];
//    self.navigationItem.rightBarButtonItems = @[SwithBtnItm];
#else
//    self.navigationItem.rightBarButtonItems = @[barMoreBtn];
#endif
//*/
}


//消息
- (void)actionToChooseHTTPServiuce:(id)sender
{
	
#ifdef DEBUG
	ChooseHTTPServiceViewController *vc = [[ChooseHTTPServiceViewController alloc] init];
	THModalNavigationController *nav = [[THModalNavigationController alloc] initWithRootViewController:vc];
	[self.navigationController presentViewController:nav animated:YES completion:nil];
#else
	if (!USERMODEL.isLogin) {
		[self prsentToLoginViewController];
		return;
	}
	MyMessageListViewController *myMessVc = [[MyMessageListViewController alloc] init];
	[self.navigationController pushViewController:myMessVc animated:YES];
#endif
    
}


-(void)hideRedImageView {
    
    _redImageView.hidden = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationTabBarHiddenRedPoint object:nil];
    _question = 0;
    BadgeMODEL.forumQuestion = 0;
}

#pragma mark --定位城市--
-(void)cityChangeNoti {
    if (USERMODEL.city != nil) {
        [_cityBtn setTitle:@"杭州" forState:UIControlStateNormal];
    }
    [self setCity:USERMODEL.city];
}

-(void)setRedImageView {
    
    [topView.BadgeView setNum:[BadgeMODEL getSumNum]];
    _redImageView.hidden=NO;
    _question=1;
}

-(void)hide {
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self->_bkView.alpha=0;
                     }
                     completion:^(BOOL finished) {
                         self->_bkView.hidden=YES;
                     }];
}

-(void)notificationPush:(NSNotification *)notification {
    
    NSDictionary *dic=[notification object];
    [self weakPushWebVC:dic];
}

-(void)home:(id)sender {
    
    FindCarViewController *vc=[[FindCarViewController alloc]init];
    [self pushViewController:vc];
}

-(void)back:(id)sender {
    
    if (pick) {
        HomePageWeatherViewController *vc=[[HomePageWeatherViewController alloc]init];
        vc.dataDic=_dic;
        
        vc.cityId=_cityId;
        
        [self pushViewController:vc];
        
    }else{
        if (USERMODEL.city) {
            HomePageWeatherViewController *vc=[[HomePageWeatherViewController alloc]init];
            vc.dataDic=_dic;
            
            vc.cityId=_cityId;
            
            [self pushViewController:vc];
            
        }else{
            [IHUtility addSucessView:@"无法定位当前城市，请选择城市" type:2];
        }
    }
}

-(void)weakPushWebVC:(NSDictionary *)dic {
    
    isShowPopView = NO;
    
    __weak NewHomePageViewController* weakSelf=self;
    int type=[dic[@"model"]intValue];
    if (type != 0&&type!=5) {
        if ([stringFormatString(dic[@"businessid"]) isEqualToString:@"0"]) {
            return;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    if ( type==5) {    //网页链接
        
        NSString *url=dic[@"activities_content"];
        if (url) {
            YLWebViewController *controller=[[YLWebViewController alloc]init];
            controller.type=1;
            controller.mUrl=[NSURL URLWithString:url];
            [self pushViewController:controller];
        }
    }
    else if (type==6){ //资讯
        [self addWaitingView];
        [network getPushNewsDetail:stringFormatString(dic[@"businessid"]) success:^(NSDictionary *obj) {
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
        }];
    }
    else if (type==1){  // 供应
        [self addWaitingView];
        [network getSupplyDetailID:USERMODEL.userID supply_id:stringFormatString(dic[@"businessid"])  success:^(NSDictionary *obj) {
            NSDictionary *dic=obj[@"content"];
            
            [weakSelf pushVC:dic type:1];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else if (type==2){  // 话题
        [self addWaitingView];
        [network getTopicDetailID:USERMODEL.userID topic_id:stringFormatString(dic[@"businessid"]) success:^(NSDictionary *obj) {
            NSDictionary *dic=obj[@"content"];
            
            [weakSelf pushVC:dic type:3];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else if (type==3){  //求购
        [self addWaitingView];
        [network getBuyDetailID:USERMODEL.userID want_buy_id:stringFormatString(dic[@"businessid"]) success:^(NSDictionary *obj) {
            NSDictionary *dic=obj[@"content"];
            
            [weakSelf pushVC:dic type:2];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else if (type == 4||type == 8||type == 7){ //活动
        [self addWaitingView];
        [network getActivitiesDetail:stringFormatString(dic[@"businessid"]) type:stringFormatInt(type) success:^(NSDictionary *obj) {
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
            
        }];
    }else if (type==10 || type ==11){// 评论我的
        
    }else if (type==12){//发布的问题被回复
        AskProblemDetailViewController *vc=[[AskProblemDetailViewController alloc]init];
        vc.answer_id=[dic[@"answer_id"] stringValue];
        [self pushViewController:vc];
    }
}

-(void)pushVC:(NSDictionary *)dic type:(int)type {
    
    [self removeWaitingView];
    if (type==3) {
        
        MTTopicListModel *mod=[network getTopicModelForDic:dic];
        MTTopicDetailsViewController *vc=[[MTTopicDetailsViewController alloc]init];
        vc.model=mod;
        [self pushViewController:vc];
        
    }else{
        int type2 = 0;
        if (type==1) {
            type2=IH_QuerySupplyList;
        } else if (type==2){
            type2=IH_QueryBuyList;
        }
        
        MTSupplyAndBuyListModel *mod=[network getSupplyAndBuyForDic:dic type:type2];
        GongQiuDetailsViewController *vc=[[GongQiuDetailsViewController alloc]init];
        vc.model=mod;
        if (type == 1) {
            vc.type=ENT_Supply;
        }else if (type==2){
            vc.type=ENT_Buy;
        }
        [self pushViewController:vc];
    }
}

-(void)pushToChatVC {
    
    ChatListViewController *vc=[[ChatListViewController alloc]init];
    [self pushViewController:vc];
}

#pragma mark --创建表格--
- (void)createTableView
{
    __weak NewHomePageViewController *weakSelf=self;
    
    dataArray = [[NSMutableArray alloc]init];
    
    categoryList = [ConfigManager getHomePageCategoryList];
    
    
    topView = [[HomePageTopView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowWith*0.453)];
    _v = topView.v;
    _weatherView = topView.weatherView;
    _redImageView = topView.redImageView;
    topView.callBack=^(NSInteger index,NSDictionary *dic){
        [weakSelf weakPushWebVC:dic];
    };
    topView.selectBlock=^(NSInteger index,NSDictionary *dict){
        if (index==SelectBtnBlock) {
            [weakSelf back:nil];
        }else{
            [weakSelf BtnTap:index andDic:dict];
        }
    };
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = topView;
    table.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, TFTabBarHeight)];
    table.backgroundColor = [UIColor whiteColor];
    table.separatorColor = [UIColor clearColor];
    _table=table;
    table.showsVerticalScrollIndicator=NO;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:table];
    _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //获取缓存
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [path stringByAppendingPathComponent:@"homeList.data"];
    NSDictionary *resulDic = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if ([resulDic isKindOfClass:[NSDictionary class]] && resulDic != nil) {
        
        self.hotZixunArray =[self fetchRowDataArr:resulDic[@"informationList"] rowNum:10 type:ENT_zixun];             //热门资讯
        self.zhanluehezuoUnitArray =[self fetchRowDataArr:resulDic[@"companyInfoSupList"] rowNum:10 type:ENT_HeZuoQiye];  //中苗会战略合作单位
        self.XinPinzhongArray =[self fetchRowDataArr:resulDic[@"nurseryNewDetailList"] rowNum:12 type:ENT_XinPinZhongPic];  //新品种
        self.hotPinZhongArray=[self fetchRowDataArr:resulDic[@"nurseryTypeInfoList"] rowNum:4 type:ENT_pinzhong];    //热门品种
        self.hotqiyeArray=[self fetchRowDataArr:resulDic[@"companyInfoList"] rowNum:2 type:ENT_qiye];                //优秀企业
        
        self.hotRenmaiArray=[self fetchRowDataArr:resulDic[@"userConnectInfosList"] rowNum:5 type:ENT_renmai];
        [_table reloadData];
        
    }
    
    [self CreateTableViewRefesh:_table type:ENT_RefreshHeader successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    page = 1;
    //    [self refreshTableViewLoading:commTableView data:dataArray dateType:kTopicUserDate];
    //  [self beginRefesh:ENT_RefreshHeader];
    
    [self beginTableViewRefesh:ENT_RefreshHeader];
    [self setbackTopFrame:WindowHeight-120-navHeigh];
    
    if (BadgeMODEL.forumQuestion > 0) {
        
        [self setRedImageView];
        
    }
    self.view.backgroundColor = cBgColor;
    
    isShowPopView = YES;
   
}
- (void)HomePopView {
    if (isShowPopView == NO) {
        return;
    }
    isShowPopView = NO;
    NSDictionary *objDic = [IHUtility getUserDefalutsDicKey:kUserDefalutInit];
    MTHomePopView * gardPopView = [[MTHomePopView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - kWidth(98), kWidth(378))];
    MTHomePopModel *Model;
    if ([objDic[@"configAdv"] isKindOfClass:[NSDictionary class]] && objDic != nil) {
        Model = [[MTHomePopModel alloc] initWithDictionary:objDic[@"configAdv"] error:nil];
        [gardPopView setMiaoTuHomePopViewModel:Model];
        [self showPopupWithStyle:CNPPopupStyleCentered popupView:gardPopView];
    }
     __weak typeof (self) weekSelf = self;
    gardPopView.SelettBut = ^(NSInteger tag) {
        self->isShowPopView = NO;
        NSInteger index = tag - 100;
        advButtonModel *advModel = Model.advButtonList[index];
        if ([advModel.isJump isEqualToString:@"2"]) {
            NSString *url = advModel.jumpUrl;
            if (url) {
                YLWebViewController *controller=[[YLWebViewController alloc]init];
                controller.type=1;
                controller.mUrl=[NSURL URLWithString:url];
                [weekSelf pushViewController:controller];
            }
        }
        if ([advModel.isJump isEqualToString:@"1"]) {
            [self BtnTap:[advModel.buttonCode integerValue] andDic:nil];
        }
        [weekSelf dismissPopupController];
    };
    gardPopView.CancelBlock = ^{
        self->isShowPopView = NO;
        [weekSelf dismissPopupController];
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


-(void)backTopClick:(UIButton *)sender {    
    [self scrollTopPoint:_table];
    [self setHomeTabBarHidden:NO];
}
//地址选择
- (void)chooseAdress:(NSString *)title tag:(NSInteger)tag
{
    if(_adressPickView == nil)
    {
        _adressPickView = [[JLAddressPickView alloc] initWithParams:title type:0];
        _adressPickView.tag=tag;
        _adressPickView.ActionSheetDelegate = self;
    }
    [_adressPickView show];
}
- (void)ActionSheetDoneHandle:(JLAddressPickView *)pickViewComponent selectedProData:(NSString *)SelectedStr selectedCityData:(NSString *)SelectedCityStr
{
    [self setCity:SelectedCityStr];
}


-(void)setCity:(NSString *)str {
    
    _city = str;
    NSDictionary *dic = [ConfigManager getCityweatherList];
    NSString *city = _city;
    NSString *cityId = @"";
    
    cityId = [dic objectForKey:_city];
    
    if (!cityId) {
        NSRange range = [_city rangeOfString:@"市"];
        if (range.location==NSNotFound) {
            NSRange range1 = [_city rangeOfString:@"地区"];
            if (range1.location==NSNotFound){
                
                NSRange range2 = [_city rangeOfString:@"回族自治州"];
                
                if (range2.location==NSNotFound){
                    
                    NSRange range3 = [_city rangeOfString:@"朝鲜自治州"];
                    
                    if (range3.location==NSNotFound){
                        
                        NSRange range5 = [_city rangeOfString:@"土家族苗族自治州"];
                        
                        if (range5.location==NSNotFound){
                            NSRange range6 = [_city rangeOfString:@"藏族自治州"];
                            if (range6.location==NSNotFound){
                                NSRange range7 = [_city rangeOfString:@"蒙古自治州"];
                                if (range7.location==NSNotFound){
                                    
                                    NSRange range4 = [_city rangeOfString:@"自治州"];
                                    if (range4.location==NSNotFound){
                                        city=@"北京";
                                        cityId=@"101010100";
                                        
                                    }else{
                                        city=[_city substringToIndex:range4.location];
                                        cityId=dic[city];
                                    }
                                }else{
                                    city=[_city substringToIndex:range7.location];
                                    cityId=dic[city];
                                }
                            }else{
                                city=[_city substringToIndex:range6.location];
                                cityId=dic[city];
                            }
                        }else{
                            
                            city=[_city substringToIndex:range5.location];
                            cityId=dic[city];
                        }
                    }else{
                        city=[_city substringToIndex:range3.location];
                        cityId=dic[city];
                    }
                }else{
                    city=[_city substringToIndex:range2.location];
                    cityId=dic[city];
                }
            }else{
                city=[_city substringToIndex:range1.location];
                cityId=dic[city];
            }
        }else{
            city=[_city substringToIndex:range.location];
            cityId=dic[city];
        }
    }
    
    _city=city;
    CGSize size=[IHUtility GetSizeByText:_city sizeOfFont:16 width:200];
    _cityLbl.text=_city;
    _cityLbl.frame=CGRectMake(5, 0, size.width, size.height);
    _imageView.origin=CGPointMake(_cityLbl.right+5, 10);
    _view.size=CGSizeMake(_cityLbl.width+_imageView.width+15, _cityLbl.height);
    [_view setLayerMasksCornerRadius:10 BorderWidth:0 borderColor:cBlackColor];
    
    if (!cityId) {
        
        city=@"北京";
        cityId=@"101010100";
    }
    _cityId=cityId;
    [LeftCityBtn setTitle:_city forState:UIControlStateNormal];
    [network getWeatherDetail:cityId date:@"" success:^(NSDictionary *obj) {
       self->pick=YES;
        self->_dic=obj;
        [self->_weatherView setweatherDic:obj cityID:self->_cityId cityName:self->_city];
        
    } failure:^(NSDictionary *obj2) {

    }];
}

#pragma mark --加载数据--
-(void)loadRefesh:(MJRefreshComponent *)refreshView {
	
    [network getQueryHomePageTypeListSuccess:^(NSDictionary *obj) {
        NSDictionary *content = obj[@"content"];
        NSDictionary *dict = content[@"keyWord"];
        self->messageNum = content[@"messageCount"];
        if (self->messageNum && [self->messageNum intValue] > 0) {
            self->_messLab.hidden = NO;
            self->_messLab.text = [self->messageNum stringValue];
        }else {
            self->_messLab.hidden = YES;
        }
        
        if (dict[@"key_word"] != nil) {
            self->searchTextfiled.searchTextField.placeholder = dict[@"key_word"];
        }
        //缓存数据
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *file = [path stringByAppendingPathComponent:@"homeList.data"];
        [NSKeyedArchiver archiveRootObject:content toFile:file];

        self.hotZixunArray =[self fetchRowDataArr:content[@"informationList"] rowNum:10 type:ENT_zixun];             //热门资讯
        self.zhanluehezuoUnitArray =[self fetchRowDataArr:content[@"companyInfoSupList"] rowNum:10 type:ENT_HeZuoQiye];  //中苗会战略合作单位
        self.XinPinzhongArray =[self fetchRowDataArr:content[@"nurseryNewDetailList"] rowNum:12 type:ENT_XinPinZhongPic];  //新品种
        self.hotPinZhongArray=[self fetchRowDataArr:content[@"nurseryTypeInfoList"] rowNum:4 type:ENT_pinzhong];    //热门品种
        self.hotqiyeArray=[self fetchRowDataArr:content[@"companyInfoList"] rowNum:2 type:ENT_qiye];                //优秀企业
        
        self.hotRenmaiArray=[self fetchRowDataArr:content[@"userConnectInfosList"] rowNum:5 type:ENT_renmai];       //品质人脉
        [self->_table reloadData];
       
        
        [self endTableViewRefresh];
        
    } failure:^(NSDictionary *obj2) {
        
        [self endTableViewRefresh];
        
    }];
    [self reloadTagView];
//    [self reloadAdView];
}
- (void) reloadTagView {
//    NSLog(@"imgUrl 33 == %@",ConfigManager.ImageUrl);
    [network getInitsuccess:@"0" longitude:116.404 latitude:39.914999999999999 success:^(NSDictionary *obj) {
        [IHUtility saveDicUserDefaluts:obj[@"content"] key:kUserDefalutInit];
        NSString *url=[[[IHUtility getUserDefalutDic:kUserDefalutInit]objectForKey:@"urlInfo"]objectForKey:@"url_read"];
        ConfigManager.ImageUrl=[NSString stringWithFormat:@"%@",url];
        NSString *url2=[[[IHUtility getUserDefalutDic:kUserDefalutInit]objectForKey:@"urlInfo"]objectForKey:@"url_write"];
        ConfigManager.uploadImgUrl=url2;
        
        self->topView = [[HomePageTopView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowWith*0.453)];
        self->_v = self->topView.v;
        self->_weatherView = self->topView.weatherView;
        self->_redImageView = self->topView.redImageView;
         __weak NewHomePageViewController *weakSelf=self;
        self->topView.callBack=^(NSInteger index,NSDictionary *dic){
            [weakSelf weakPushWebVC:dic];
        };
       self->topView.selectBlock=^(NSInteger index,NSDictionary *dict){
            if (index==SelectBtnBlock) {
                [weakSelf back:nil];
            }else{
                [weakSelf BtnTap:index andDic:dict];
            }
        };
        self->_table.tableHeaderView = self->topView;
        
//        NSLog(@"imgUrl == %@",ConfigManager.ImageUrl);
        
        [self->_weatherView setweatherDic:self->_dic cityID:self->_cityId cityName:self->_city];
    }failure:^(NSError *error) {
        
    }];
}

-(void)reloadAdView
{
    [network getActivityList:0 num:10 success:^(NSDictionary *obj) {
        NSArray *arr = obj[@"content"];
        if ([arr isKindOfClass:[NSArray class]] && arr != nil) {
            //缓存数据
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *file = [path stringByAppendingPathComponent:@"myBannerList.data"];
            [NSKeyedArchiver archiveRootObject:arr toFile:file];
        }
         [self->_table reloadData];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

-(void)BtnTap:(NSInteger)integer andDic:(NSDictionary *)dict {
    
    if (integer==1001)
    {
        NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutInit];
        NSMutableArray *arrayTittles = [[NSMutableArray alloc]init];
        NSMutableArray *programIdArray = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"infomationProgramLsit"]) {
            [arrayTittles addObject:obj[@"program_name"]];
            [programIdArray addObject:obj[@"program_id"]];
        }
        if (arrayTittles.count==1) {
            NewsTableListViewController *vc=[[NewsTableListViewController alloc]init];
            vc.program_id=[programIdArray[0] intValue];
            vc.titl=arrayTittles[0];
            vc.i=1;
            vc.type = @"1";
            [self pushViewController:vc];
        }else{
            NewSlideHeadingViewController * newVC=[[NewSlideHeadingViewController alloc]init];
            [self pushViewController:newVC];
        }
    }else if (integer==1002){
#ifdef APP_MiaoTu
        
        BadgeMODEL.forumQuestion=0;
        _redImageView.hidden=YES;
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationTabBarHiddenRedPoint object:nil];
        GuangChangMainViewController *controller=[[GuangChangMainViewController alloc]init];
        controller.i=_question;
        [self pushViewController:controller];
#elif defined APP_YiLiang
        MTThemeListViewController *controller=[[MTThemeListViewController alloc]init];
        //controller.type=ENT_topic;
        controller.inviteParentController=self;
        [self pushViewController:controller];
#endif
    }
    else if (integer==1003)
    {
//        ActivityTypeController *actvitVC  = [[ActivityTypeController alloc] init];
        ActivityListViewController *actvitVC  = [[ActivityListViewController alloc] init];
        actvitVC.type =@"1";
        [self pushViewController:actvitVC];
    }else if (integer==1004)
    {   //苗途地图
        MiaoTuMainViewController *controller=[[MiaoTuMainViewController alloc]init];
        [self pushViewController:controller];
    }else if(integer==1005 ||integer==1013 || integer==1014){   //园林云
        NewECloudHomePageViewController *controller = [[NewECloudHomePageViewController alloc] init];
        controller.currentIndex = [self indexSelect:integer];
        [self pushViewController:controller];
    }else if(integer==1006){ //招聘求职
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        if ( [[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1002)
        {
            ZhaoPingViewController *vc=[[ZhaoPingViewController alloc]init];
            [self pushViewController:vc];
            return;
        }else if ([[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1001){
            GiuZhiViewController *vc=[[GiuZhiViewController alloc]init];
            [self pushViewController:vc];
            return;
        }
        JobIdentViewController *vc=[[JobIdentViewController alloc]init];//招聘求职
        vc.type= ENT_Seek;
        [self pushViewController:vc];
    }
    /*
     else if((NSInteger)tap.view.tag==1007){  //积分任务
     if (!USERMODEL.isLogin) {
     [self prsentToLoginViewController];
     return ;
     }
     
     MYTaskViewController * task=[[MYTaskViewController alloc]init];
     // task.delegate=self;
     [self pushViewController:task];*/
    
    else if(integer==1009){ //推荐
        
        [self ShareUrl:self withTittle:[NSString stringWithFormat:@"%@，加入%@，携手共赢",KAppTitle,KAppName] content:[NSString stringWithFormat:@"我一直在用%@找苗木、搜人脉、找企业。邀你一起来体验，积分还可抵现金用哦",KAppName] withUrl:dwonShareURL imgUrl:@""];
        
    }else if (integer==1010){//积分推荐
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        ScoreConvertViewController *vc=[[ScoreConvertViewController alloc]init];
        [self pushViewController:vc];
    }else if (integer==1011){//商城
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        MTShoppingViewController *vc=[[MTShoppingViewController alloc]init];
        [self pushViewController:vc];
    }else if (integer==1012){//苗木物流
        FindCarViewController *vc=[[FindCarViewController alloc]init];
        [self pushViewController:vc];
    }
    else if (integer==1015){//新品种图库
        NewVarietyPicController *vc=[[NewVarietyPicController alloc]init];
        [self pushViewController:vc];
    }else if (integer==1017){//发布
        NSLog(@"发布----%s----",__func__);
    }else if (integer==1023){//鉴定
        NSLog(@"专家鉴定----%s----",__func__);
        [self masterDiscern];
    }else if (integer==1008){//敬请期待
        [self showHomeHint:@"更多功能正在开发中,敬请期待"];
    }else if (integer==1024){//园榜
        GardenListHomeController *GardenListVc = [[GardenListHomeController alloc] init];
        [self pushViewController:GardenListVc];
//        [self showHomeHint:@"该功能正在开发中,敬请期待"];
    }else if (integer==1025){//课堂
        [self.tabBarController setSelectedIndex:3];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabBarSelectedIndex object:[NSNumber numberWithInt:3]];
//        ClassroomHomeController *classRoomVc = [[ClassroomHomeController alloc] init];
//        [self pushViewController:classRoomVc];
        
    }else if ( integer ==1031){ //社区
        
        ChatListViewController *vc=[[ChatListViewController alloc]init];
        [self pushViewController:vc];
        
    } else if ( integer ==1026){     //推荐讲师
        RecommendTeacherController *TearcherVc = [[RecommendTeacherController alloc] init];
        [self pushViewController:TearcherVc];
        
    } else if ( integer ==1028){     //线下活动
        ActivityListViewController *actvitVC  = [[ActivityListViewController alloc] init];
        actvitVC.type =@"1";
        [self pushViewController:actvitVC];
    }  else if ( integer ==1030){     //我的订购
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        MyClassSourceController *myClassVc = [[MyClassSourceController alloc] init];
        [self pushViewController:myClassVc];
        
    } else if ( integer ==1033){     //VIP福利社
        YLWebViewController *controller=[[YLWebViewController alloc]init];
        controller.type=1;
        NSString *url = dict[@"jumpUrl"];
        if (url && url.length > 0) {
            controller.mUrl=[NSURL URLWithString:url];
            [self pushViewController:controller];
        }
    }else {
        if ([dict[@"isJump"] intValue] == 1) {
            MiaoBiInfoViewController *controller = [[MiaoBiInfoViewController alloc] init];
            controller.type = 1;
            NSString *url = dict[@"jumpUrl"];
            if (url && url.length > 0) {
                controller.mUrl = [NSURL URLWithString:url];
                [self pushViewController:controller];
            }
        }else {
            [self showHomeHint:@"该功能正在开发中,敬请期待"];
        }
    }
}

#pragma mark - 请高手鉴别
- (void)masterDiscern {
    if (!USERMODEL.isLogin) {
        //登录
        MTLoginViewController *vc=[[MTLoginViewController alloc]init];
        THModalNavigationController *nav=[[THModalNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    NSString *DFID = [IHUtility getUserDefalutsKey:@"DFID"];
    if (!DFID) {
        [self loginDiscernFlower];
    }else {
        [self submitMasterDiscern];
    }
}
- (void)loginSuccess {
    [self loginDiscernFlower];
}

- (void)loginDiscernFlower {
    [HttpRequest loginDiscernFlowerSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            [self submitMasterDiscern];
        }else {
            [IHUtility addSucessView:@"用户信息获取失败，请重新操作！" type:2];
        }
    }];
}
//鉴别
- (void)submitMasterDiscern {
    [self setHomeTabBarHidden:YES];
    DFDiscernListViewController *listVC = [[DFDiscernListViewController alloc]init];
    [self.navigationController pushViewController:listVC animated:YES];
}


- (NSInteger)indexSelect:(NSInteger)code {
    if (code == 1005) {
        return 0;
    }else if (code == 1013){
        return 1;
    }else{
        return 2;
    }
}

-(NSMutableArray *)fetchRowDataArr:(NSMutableArray *)tempArr rowNum :(int)rowNum  type:(HomePageType)type {
    
    NSMutableArray * rowDataArray = [[NSMutableArray alloc]init];
    NSInteger rowcount = 0;//计算行数
    if ((![tempArr isKindOfClass:[NSArray class]]) || tempArr == nil) {
        return rowDataArray;
    }
    if (tempArr.count%rowNum==0) {
        rowcount = tempArr.count/rowNum;
    }else{
        rowcount = tempArr.count/rowNum+1;
    }
    for (int j = 0; j < rowcount; j++) {
        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        int startCount = j*rowNum;
        int endCount = (j+1)*rowNum;
        
        for (int i = startCount; i < endCount; i++) {
            if (tempArr.count>i) {
                [arr addObject:[tempArr objectAtIndex:i]];
            }
        }
        if (type==ENT_zixun) {
            HomeInformationModel * rowGV = [[HomeInformationModel alloc] initWithIndex:j DataArr:arr];//一行数据
            [rowDataArray addObject:rowGV];         //多行数据
        }
        else if (type==ENT_HeZuoQiye){
            HomeZhanLueQiYeModel * rowGV = [[HomeZhanLueQiYeModel alloc] initWithIndex:j DataArr:arr];
            [rowDataArray addObject:rowGV];
        }else if (type==ENT_XinPinZhongPic){
            HomeXinPinzhongeModel * rowGV = [[HomeXinPinzhongeModel alloc] initWithIndex:j DataArr:arr];
            [rowDataArray addObject:rowGV];
        }else if (type == ENT_pinzhong){
            HomeVarietiesModel * rowGV = [[HomeVarietiesModel alloc] initWithIndex:j DataArr:arr];
            [rowDataArray addObject:rowGV];
        }else if (type==ENT_qiye){
            HomeCompanyModel * rowGV = [[HomeCompanyModel alloc] initWithIndex:j DataArr:arr];
            [rowDataArray addObject:rowGV];
        }else if (type == ENT_renmai){
            HomeContactsModel * rowGV = [[HomeContactsModel alloc] initWithIndex:j DataArr:arr];
            [rowDataArray addObject:rowGV];
        }
    }
    return rowDataArray;
}

#pragma mark --UITableViewDataSource--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSDictionary *dic = categoryList[section];
    MTHomeSectionTitleView *titleView = [[MTHomeSectionTitleView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 50)];
    titleView.dataDic = dic;
    WS(weakSelf);
    titleView.HomeMoreBlock = ^{
        [weakSelf HomeJumpMoreIndex:section];
    };
    return titleView;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 10)];
    bgView.backgroundColor = cLineColor;
    return bgView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==ENT_zixun) {
        return self.hotZixunArray.count;
    }
    else if (section == ENT_HeZuoQiye){
        return self.zhanluehezuoUnitArray.count;
    }
    else if (section == ENT_XinPinZhongPic){
        return self.XinPinzhongArray.count;
    }
    else if (section==ENT_pinzhong){
        return self.hotPinZhongArray.count;
    }
    else if (section==ENT_qiye){
        return self.hotqiyeArray.count;
    }
    else if(section==ENT_renmai){
        return self.hotRenmaiArray.count;
    } else {
    
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == ENT_zixun) {
        
        static NSString *identify = @"HotInformationTableViewCell";
        HotInformationTableViewCell *cell = (HotInformationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            
            cell=[[HotInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        cell.delegate = self;
        cell.indexPath = indexPath;
        HomeInformationModel *mod = [self.hotZixunArray objectAtIndex:indexPath.row];
        cell.ItemArray = mod.hotArray;
        
        return cell;
    }
    else if (indexPath.section==ENT_HeZuoQiye){
        
        static NSString *identify=@"ZhanLueQiYeTableViewCell";
        ZhanLueQiYeTableViewCell *cell=(ZhanLueQiYeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            
            cell=[[ZhanLueQiYeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        cell.delegate=self;
        cell.indexPath=indexPath;
        HomeZhanLueQiYeModel *mod = [self.zhanluehezuoUnitArray objectAtIndex:indexPath.row];
        cell.ItemArray=mod.hotArray;
        return cell;
    }
    else if (indexPath.section==ENT_XinPinZhongPic){
        
        static NSString *identify=@"HotXinPinZhongTableViewCell";
        HotXinPinZhongTableViewCell *cell=(HotXinPinZhongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            
            cell=[[HotXinPinZhongTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        cell.delegate=self;
        cell.indexPath=indexPath;
        HomeXinPinzhongeModel *mod = [self.XinPinzhongArray objectAtIndex:indexPath.row];
        cell.ItemArray=mod.hotArray;
        return cell;
    }
    else  if (indexPath.section==ENT_pinzhong){
        
        static NSString *identify=@"HotVarietiesTableViewCell";
        HotVarietiesTableViewCell *cell=(HotVarietiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            
            cell=[[HotVarietiesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        cell.delegate=self;
        cell.indexPath=indexPath;
        HomeVarietiesModel *mod = [self.hotPinZhongArray objectAtIndex:indexPath.row];
        cell.ItemArray=mod.hotArray;
        return cell;
    }
    else if (indexPath.section==ENT_qiye){
        
        static NSString *identify = @"HotCompanyTableViewCell";
        HotCompanyTableViewCell *cell = (HotCompanyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            cell=[[HotCompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.delegate = self;
        cell.indexPath = indexPath;
        HomeCompanyModel *mod=[self.hotqiyeArray objectAtIndex:indexPath.row];
        cell.ItemArray=mod.hotArray;
        
        return cell;
    }
    else if(indexPath.section==ENT_renmai){
        
        static NSString *identify=@"HotContactsTableViewCell";
        HotContactsTableViewCell *cell=(HotContactsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            cell=[[HotContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.delegate=self;
        cell.indexPath=indexPath;
        HomeContactsModel *mod=[self.hotRenmaiArray objectAtIndex:indexPath.row];
        cell.ItemArray=mod.hotArray;
        return cell;
    }
    
    else{
        static NSString *identify=@"UITableViewCell";
        UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell == nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==ENT_zixun) {
        
        return kWidth(156);
        
    }else if (indexPath.section==ENT_HeZuoQiye) {
        
         return kWidth(168);
        
    }else  if (indexPath.section==ENT_XinPinZhongPic) {
        
        return kWidth(292);
        
    }else if (indexPath.section==ENT_pinzhong){
        
        return kWidth(115);
        
    }else if (indexPath.section==ENT_qiye){
        
        return kWidth(284);
        return 10+WindowWith*0.456*0.6315+45;
        
    }
    else{
        return 40;
    }
}
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute {
    
    if (action == MYActionHomePageZiXunTableViewAction) {  //资讯
        NSLog(@"11");
        // NSDictionary *dic = attribute;
        NewsListModel *model = [[NewsListModel alloc]initWithDictionary:(NSDictionary *)attribute error:nil];
        
        [self NewsDtailController:model];
        
    }else if (action == MYActionHomePageZhanlueQiyeTableViewAction) {  //战略合作企业
        NSLog(@"11");
        NSDictionary *dic=(NSDictionary*)attribute;
//        NewsListModel *model=[[NewsListModel alloc]initWithDictionary:(NSDictionary *)attribute error:nil];
        [self addWaitingView];
        [network getCompanyHomePage:dic[@"company_id"] success:^(NSDictionary *obj) {
            
            [self removeWaitingView];
            EPCloudListModel *model = obj[@"content"];
            
            EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
            detailVC.model = model;
            
            [self pushViewController:detailVC];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else if (action == MTActionHomePageXinPinZhongTableViewCellAction) {  //新品种
        NSDictionary *dic=(NSDictionary*)attribute;
        NSInteger tempIndex = 0;
        NSInteger ImageIndex;
        NSMutableArray *marray = [[NSMutableArray alloc] init];
        for (HomeXinPinzhongeModel *mod in self.XinPinzhongArray) {
            for (NSDictionary *object in mod.hotArray) {
                nurseryNewDetailListModel *model = [[nurseryNewDetailListModel alloc] init];
                NSString *ImgUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,object[@"showPic"]];
                model.showPic = ImgUrlStr;
                if ([dic[@"showPic"] isEqualToString:object[@"showPic"]]) {
                    ImageIndex = tempIndex;
                }
                tempIndex++;
                [marray addObject:model];
            }
        }
        showImageController *showImagVc = [[showImageController alloc] initWithSourceArr:marray index:ImageIndex];
        [self pushViewController:showImagVc];
        
    }else if (action==MTActionHomePagePinZhongTableViewCellAciont){ //品种
        NSLog(@"22");
        
        NSDictionary *dic=(NSDictionary*)attribute;
        NurseryCloudViewController *vc=[[NurseryCloudViewController alloc]init];
        vc.nursery_type_id=dic[@"nursery_type_id"];
        vc.nursery_type_name=dic[@"nursery_type_name"];
        [self pushViewController:vc];
        
    }else if (action==MTActionHomePageQiYeTableViewCellAction){ //企业
        NSLog(@"33");
        [self addWaitingView];
        NSDictionary *dic=(NSDictionary*)attribute;
        [network getCompanyHomePage:dic[@"company_id"] success:^(NSDictionary *obj) {
            
            [self removeWaitingView];
            EPCloudListModel *model = obj[@"content"];
            
            EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
            detailVC.model = model;
            
            [self pushViewController:detailVC];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else if (action==MTActionHomePageRenMaiTableViewCellAction){ //人脉
        
        NSDictionary *dic=(NSDictionary*)attribute;
        [self addWaitingView];
        [network selectUseerInfoForId:[dic[@"user_id"] intValue]
                              success:^(NSDictionary *obj) {
                                  
                                  MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                                  UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                                  [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[dic[@"user_id"] intValue] success:^(NSDictionary *obj) {
                                      
                                      [self removeWaitingView];
                                      
                                      MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:[dic[@"user_id"] stringValue] :NO dic:obj[@"content"]];
                                      controller.userMod=usermodel;
                                      controller.dic=obj[@"content"];
                                      [self pushViewController:controller];
                                  } failure:^(NSDictionary *obj2) {
                                      
                                  }];
                              } failure:^(NSDictionary *obj2) {
                              }];
    }
}

- (void)NewsDtailController:(NewsListModel *)model
{
    if (model.img_type == 3) {
        [self addWaitingView];
        [network getImageNewsDetail:stringFormatInt(model.info_id) success:^(NSDictionary *obj) {
            [self removeWaitingView];
            
            NewsListModel *mod = obj[@"content"];
            NewsImageDetailViewController *vc = [[NewsImageDetailViewController alloc] init];
            vc.infoModel = mod;
             [self pushViewController:vc];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else {
        
        NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
        vc.infoModel = model;
        [self pushViewController:vc];
        
    }
}
- (void)disPalyNewsCollect:(NewsListModel *)model indexPath:(NSIndexPath *)indexPath
{
    NewsListModel *mod = dataArray[indexPath.section][indexPath.row];
    mod.hasCollection = 1;
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

-(void)pushTozixun {
    
    NewSlideHeadingViewController * newVC=[[NewSlideHeadingViewController alloc]init];
    [self pushViewController:newVC];
    
}
-(void)pushTotopic{
    
    MTTopicListViewController *vc=[[MTTopicListViewController alloc]init];
    vc.type=ENT_topic;
    vc.isHot=0;
    [self pushViewController:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 搜索代理
- (void)flowerSearchViewWithText:(NSString *)searchText textField:(UITextField *)textField {
    [textField resignFirstResponder];
    HomeSearchViewController *homeSeachVc = [[HomeSearchViewController alloc] init];
    homeSeachVc.TfStr = searchText;
    if ([searchText isEqualToString:@""]) {
        homeSeachVc.TfStr = textField.placeholder;
    }
    textField.text = @"";
    [self pushViewController:homeSeachVc];
}

#pragma mark - 首页更多
- (void) HomeJumpMoreIndex:(NSInteger ) index {
//    NSLog(@"更多模块 ==== %ld",index);
    if (index == 0) {           //热门资讯
        NewSlideHeadingViewController * newVC=[[NewSlideHeadingViewController alloc]init];
        [self pushViewController:newVC];
    }else if (index == 1) {     //中苗会战略合作企业
        EPCloudListViewController *vc=[[EPCloudListViewController alloc]init];
        vc.company_label_id = 1;
        [self pushViewController:vc];
    }else if (index == 2) {     //新品种图库
        NewVarietyPicController *vc=[[NewVarietyPicController alloc]init];
        [self pushViewController:vc];
    }else if (index == 3) {     //热门品种
        NewECloudHomePageViewController *controller = [[NewECloudHomePageViewController alloc] init];
        controller.currentIndex = [self indexSelect:1005];
        [self pushViewController:controller];
    }else if (index == 4) {     //推荐企业
        EPCloudListViewController *vc=[[EPCloudListViewController alloc]init];
        vc.company_label_id = 2;
        [self pushViewController:vc];
    }
    
}

@end
