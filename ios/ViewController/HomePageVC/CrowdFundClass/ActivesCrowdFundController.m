//
//  ActivesCrowdFundController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//
#import "MTActionHeadImageCell.h"
#import "MTActivesBottomView.h"
#import "MTActionCollectionViewCell.h"

#import "ActivesCrowdFundController.h"
#import "ULBCollectionViewFlowLayout.h"     //分区背景色
#import "MTZCPersonHeadReusableView.h"      //众筹、支持人数
#import "TeamCollectionReusableView.h"      //战队，代言、众筹中，已筹满
#import "TeamCollectionViewCell.h"          //战队模式cell

#import "MTActivesGridViewCell.h"           //格子视图
#import "MTActivesListViewCell.h"           //列表视图
#import "SubmitOrderController.h"           //确认订单

//#import "CrowdFundingViewController.h"      //发起的众筹界面
//#import "PayMentMangers.h"
//#import "THNotificationCenter+C.h"

#import "MyCrowdFundController.h"           //我的众筹
#import "XHFriendlyLoadingView.h"

#import "NoContentViewCell.h"       //没有内容时

typedef NS_ENUM(NSInteger , ActionSection) {
    MTActionHeadImage,   //头视图图片
    MTActionContionTitle,    //活动说明
    MTActionSignUpPerson,    //人数说明
    MTActionDetailDescribe,  //详情描述
    MTActionZCPersonNum,     //众筹支持人数
    MTActionSectionCount,    //分区个数
};

static NSString *MTActionHeadImageCellID  = @"MTActionHeadImage";
static NSString *MTActionContionTitleID   = @"MTActionContionTitle";
static NSString *MTActionSignUpPersonID   = @"MTActionSignUpPerson";
static NSString *MTActionDetailDescribeID = @"MTActionDetailDescribe";
//static NSString *MTActionZCPersonNumID    = @"MTActionZCPersonNum";
static NSString *MTZCPersonHeadReusableID   = @"MTZCPersonHeadReusableView";
static NSString *MTZCDetailHeadReusableID = @"MTZCDetailHeadReusableID";
static NSString *MTActivesGridViewCellID   = @"MTActivesGridViewCell";
static NSString *MTActivesListViewCellID   = @"MTActivesListViewCell";
static NSString *TeamCollectionReusableID  = @"TeamCollectionReusableView";

static NSString *TeamCollectionCellID  = @"TeamCollectionCell";
static NSString *NoContentCellID  = @"NoContentViewCellID";


@interface ActivesCrowdFundController () <UICollectionViewDataSource, UICollectionViewDelegate>{
    
    NSString *crowdId;//众筹ID
//    UIView *_topView;
//    UITableView *_tableView;
    BOOL _isGrid;       //0：格子视图， 1：列表视图
    int whether;//是否众筹过  1为发起过众筹
    BOOL _isShowDetail;       //是否显示详情描述
    
    MTActivesBottomView *footView;  //底部按钮
    NSString *TeamHearReusaType;    //0 - 代言人 1--众筹 2--已筹满
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ActivesCrowdFundController

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    //进入详情判断是否已众筹 如果已众筹获取众筹ID 点击报名按钮进入众筹也是带过去
    [network getWhetherCrowdWithUserID:userID activities_id:self.model.activities_id success:^(NSDictionary *obj) {
        
		self->whether = [obj[@"content"][@"crowdStatus"] intValue];
		if (self->whether == 1) {
			self->crowdId = [NSString stringWithFormat:@"%@",obj[@"content"][@"crowd_id"]];
			self->footView.isDidCrowdFund = YES;
        }
    }];
}

- (void) setTitle {
	CGSize size = [IHUtility GetSizeByText:@"活动详情" sizeOfFont:15 width:200];
	SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, size.width, size.height) textColor:cBlackColor textFont:sysFont(15)];
	lbl.text = @"活动详情";
	self.navigationItem.titleView = lbl;
	agreeArr = [[NSMutableArray alloc]init];
	backTopbutton.top = backTopbutton.top - 50;
	_barlineView.alpha = 0;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *flowlayout = [[ULBCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kHeight(50)) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor] ;
        _collectionView.alwaysBounceVertical = YES;
        //注册Cell，必须要有
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];

        [_collectionView registerClass:[MTActionHeadImageCell class] forCellWithReuseIdentifier:MTActionHeadImageCellID];
        [_collectionView registerClass:[MTActionContionTitleCell class] forCellWithReuseIdentifier:MTActionContionTitleID];     //活动价格说明
        [_collectionView registerClass:[MTActionSignUpPersonCell class] forCellWithReuseIdentifier:MTActionSignUpPersonID];     //活动人数说明
        [_collectionView registerClass:[MTActionDetailDescribeCell class] forCellWithReuseIdentifier:MTActionDetailDescribeID]; //活动详情描述
         [_collectionView registerClass:[MTActivesGridViewCell class] forCellWithReuseIdentifier:MTActivesGridViewCellID]; //活动详情描述
         [_collectionView registerClass:[MTActivesListViewCell class] forCellWithReuseIdentifier:MTActivesListViewCellID]; //活动详情描述
        [_collectionView registerClass:[TeamCollectionViewCell class] forCellWithReuseIdentifier:TeamCollectionCellID]; //战队模式
        [_collectionView registerClass:[NoContentViewCell class] forCellWithReuseIdentifier:NoContentCellID]; //没有内容时
        
        
        
        [_collectionView registerClass:[MTZCDetailReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTZCDetailHeadReusableID];
        [_collectionView registerClass:[TeamCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TeamCollectionReusableID];
        //战队模式众筹
         [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"placeholderFoot"];
         [_collectionView registerClass:[MTZCPersonHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTZCPersonHeadReusableID];       //支持、众筹头视图

    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TeamHearReusaType = @"0";
    self.view.backgroundColor = RGB(238, 238, 238);
    [self setTitle];        //设置导航Title
    //活动列表进入直接获取从列表带过来的详情数据  我的活动进入需根据活动ID请求详情信息
    _isGrid = YES;
    _isShowDetail = YES;
 
    if ([self.type isEqualToString:@"1"]) {
//        [self creatCollectionView];
        [self reloadWaitingView];
    }
}

#pragma mark网络断开 从新链接
-(void)reloadWaitingView{
    [self addPushViewWaitingView];
    [network getActivitiesDetail:self.model.activities_id type:self.model.model success:^(NSDictionary *obj) {
        [self removePushViewWaitingView];
        self.model = obj[@"content"];
        [self creatCollectionView];
        [self setNavigationBar];

    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}

- (void) setNavigationBar {
    UIImage *shareImg=Image(@"shareGreen.png");
    moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(0, 0, 40, 40);
    [moreBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:shareImg forState:UIControlStateNormal];
    moreBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);
    UIBarButtonItem *barMoreBtn=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    NSArray *rightBtns=[NSArray arrayWithObjects:barMoreBtn, nil];
    self.navigationItem.rightBarButtonItems=rightBtns;
}
- (void) shareAction {
//    if (!USERMODEL.isLogin) {
//        [self prsentToLoginViewController];
//        return ;
//    }
  
    NSString *CrowPath = [NSString stringWithFormat:@"pages/activity/detail/detail?%@&%@",self.model.activities_id,self.model.model
                          ];
    NSDictionary *dict = @{
                           @"appid"     :WXXCXappId,
                           @"appsecret" :WXXCXappSecret,
                           @"type"      :self.model.model,
                           @"id"        :self.model.activities_id,
                           @"path"      :CrowPath,
                           };
    [self shareSmallProgramCodeOject:dict httpMethod:1 methoe:ActivityShareUrl Vc:self completion:^(id data, NSError *error) {
        
    }];
}
-(void)creatCollectionView
{
    [self.view addSubview:self.collectionView];
    footView = [[MTActivesBottomView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - KtopHeitht- kHeight(50), iPhoneWidth, kHeight(50))];
    //0-活动报名未开始  1-众筹未开始  2-活动立即支付 3-我要众筹 4-众筹已结束 5-活动已结束 6-报名人数已满
    if ([IHUtility overtime:self.model.curtime inputDate:self.model.activities_expiretime]) {
//        [self addSucessView:@"该活动已过期" type:2];
        if ([self.model.model intValue] == 8) {
            footView.BottomType = @"4";
        }
        if ([self.model.model intValue] == 4) {
            footView.BottomType = @"5";
        }
    }else if ([IHUtility overtime:self.model.activities_ExpireStarttime inputDate:self.model.curtime]) {
        //活动未开始
        
        if ([self.model.model intValue] == 8) {
            footView.BottomType = @"1";
        }
        if ([self.model.model intValue] == 4) {
            footView.BottomType = @"0";
        }
    }
    if ([IHUtility overtime:self.model.curtime inputDate:self.model.activities_ExpireStarttime] && [IHUtility overtime:self.model.activities_expiretime inputDate:self.model.curtime]) {
        //活动进行
        
        if ([self.model.crowd_method isEqualToString:@"0"]) {
             footView.BottomType = @"7";
        }else if ([self.model.crowd_method isEqualToString:@"1"]) {
            footView.BottomType = @"3";
        }else {
            footView.BottomType = @"2";
        }
//        if ([self.model.model intValue] == 8) {
//            if ([self.model.crowd_method integerValue] == 0) {
//                _collectionView.frame = CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kHeight(50));
//                footView.frame = CGRectMake(0, maxY(_collectionView), iPhoneWidth, kWidth(60));
//                footView.BottomType = @"7";
//            }else {
//                footView.BottomType = @"3";
//            }
//
//        }
//        if ([self.model.model intValue] == 4) {
//            footView.BottomType = @"2";
//        }
    }

    NSString *limitNum;
    NSString *signUp;
    limitNum = self.model.user_upper_limit_num;
    signUp = self.model.sign_up_num;
    if ([signUp integerValue] >= [limitNum integerValue]) {
         footView.BottomType = @"6";
    }
    
    [footView layoutupSubviews];
    if (whether == 1) {
        footView.isDidCrowdFund = YES;
    }
    [self.view addSubview:footView];
    
    __weak ActivesCrowdFundController *weakSelf=self;
    footView.goCrowdFund = ^{
        if (!USERMODEL.isLogin) {
            //登录
            [weakSelf  prsentToLoginViewController];
            return;
        }
		if (self->whether == 0) {
            //未发起过众筹
            SubmitOrderController *subOrderVc = [[SubmitOrderController alloc] init];
            subOrderVc.model = weakSelf.model;
            subOrderVc.indexPath = weakSelf.indexPath;
            subOrderVc.type = MTSubmitCrowdFundOrder;
            [weakSelf.navigationController pushViewController:subOrderVc animated:YES];
        }else {
            //已经发起过众筹
            [weakSelf didCrowdFundingVC];
        }
    };
    footView.CrowdFundPlay = ^{
        NSLog(@"我要支付");
        [weakSelf goPlayOrder]; //去支付
    };
    footView.ActivityPlay = ^{
        NSLog(@"活动立即支付");
        [weakSelf ActivityGoPlay];
    };
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return MTActionSectionCount;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == MTActionHeadImage) {
        return 1;
    }if (section == MTActionContionTitle) {
        return 1;
    }if (section == MTActionSignUpPerson) {
        return self.model.keyList.count;
    }if (section == MTActionDetailDescribe) {
        if (_isShowDetail == YES) {
            return self.model.imgList2.count;
        }else {
            return 0;
        }
        
    }
//*/
    if (section == MTActionZCPersonNum) {
        if ([self.model.is_xmxs isEqualToString:@"0"]) {
            //不显示
            return 0;
        }
        //战队
        if ([self.model.is_team isEqualToString:@"1"]) {
            if ([TeamHearReusaType isEqualToString:@"0"]) {
                if (self.model.daiyanren.count == 0) {
                    return 1;
                }
                 return self.model.daiyanren.count;
            }else if ([TeamHearReusaType isEqualToString:@"1"]) {
                if (self.model.zhong.count == 0) {
                    return 1;
                }
                 return self.model.zhong.count;
            }else {
                if (self.model.wancheng.count == 0) {
                    return 1;
                }
                return self.model.wancheng.count;
            }
            
        }else {
            if ([self.model.model isEqualToString:@"4"]) {
                return 0;
            }
            if (_isGrid) {
                if (self.model.zcouList.count == 0) {
                    return 1;
                }
                return self.model.zcouList.count;
            }else{
                if (self.model.zclist.count == 0) {
                    return 1;
                }
                return self.model.zclist.count;
            }
        }
    }
//*/
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MTActionHeadImage) {
        MTActionHeadImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActionHeadImageCellID forIndexPath:indexPath];
        [cell setActivitiesListModel:self.model];
        return cell;
    }if (indexPath.section == MTActionContionTitle) {
        MTActionContionTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActionContionTitleID forIndexPath:indexPath];
        [cell setTitle:self.model.activities_titile andPic:self.model.payment_amount];
        return cell;
    }if (indexPath.section == MTActionDetailDescribe) {
        MTActionDetailDescribeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActionDetailDescribeID forIndexPath:indexPath];
        imageListModel *model = self.model.imgList2[indexPath.row];
        [cell setConternImag:model.key];
        return cell;
    }
//*
    if (indexPath.section == MTActionZCPersonNum) {
        if ([self.model.is_team isEqualToString:@"1"]) {
            
            TeamCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TeamCollectionCellID forIndexPath:indexPath];
            zcouListModelModel *model;
            if ([TeamHearReusaType isEqualToString:@"0"]) {
                
                if (self.model.daiyanren.count == 0) {
                    NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                    [Nocell setShowContenTitle:@"还没有代言人哦"];
                    return Nocell;
                }
                
                model = self.model.daiyanren[indexPath.row];
            }else if ([TeamHearReusaType isEqualToString:@"1"]) {
                
                if (self.model.zhong.count == 0) {
                    NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                    [Nocell setShowContenTitle:@"还没有众筹哦"];
                    return Nocell;
                }
                
                model = self.model.zhong[indexPath.row];
            }else if ([TeamHearReusaType isEqualToString:@"2"]) {
                
                if (self.model.wancheng.count == 0) {
                    NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                    [Nocell setShowContenTitle:@"还没有已完成的众筹哦"];
                    return Nocell;
                }
                
                
                model = self.model.wancheng[indexPath.row];
            }
            [cell setTeamDaiyanRenActioviesModel:model];
            
            return cell;
        }
        
        if (_isGrid) {
            if (self.model.zcouList.count == 0) {
                NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                [Nocell setShowContenTitle:@"还没有人众筹哦"];
                return Nocell;
            }
            MTActivesGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActivesGridViewCellID forIndexPath:indexPath];
            zcouListModelModel *model = self.model.zcouList[indexPath.row];
            [cell setIconImagUrl:model.head_image andProgress:model.bili];
//            [cell setIconImagUrl:@"" andProgress:@"40"];
            return cell;
        }else {
            if (self.model.zclist.count == 0) {
                 NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                [Nocell setShowContenTitle:@"还没有人支持哦"];
                return Nocell;
            }
            
            MTActivesListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActivesListViewCellID forIndexPath:indexPath];
            zcouListModelModel *model = self.model.zclist[indexPath.row];
            [cell setIctonImgUrl:model.head_image andName:model.nickname andTime:model.create_time andPic:model.pay_amount];
//            [cell setIctonImgUrl:@"" andName:@"花花" andTime:@"6月20日" andPic:@"500"];
            return cell;
        }
        
    }
//*/
    else {
        MTActionSignUpPersonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActionSignUpPersonID forIndexPath:indexPath];
        KeyListModel *model =  self.model.keyList[indexPath.row];
        [cell setLimitTitle:model.key andNumber:model.value];
        return cell;
    }
    
}
//设置每个分区背景色
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section {
//*
//    if (section == MTActionZCPersonNum) {
//        return cLineColor;
//    }
 //*/
    return [UIColor whiteColor];
}
//头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
       if (indexPath.section == 3) {
           MTZCDetailReusableView *DetailHeadView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTZCDetailHeadReusableID forIndexPath:indexPath];

           DetailHeadView.backgroundColor = [UIColor whiteColor];
           [DetailHeadView setisShowDetail:_isShowDetail];
           DetailHeadView.isShowDetailblock = ^(BOOL isShow){
			   self->_isShowDetail = isShow;
               [collectionView reloadData];
           };
           return DetailHeadView;
//*
        }

       else if (indexPath.section == MTActionZCPersonNum) {
            if ([self.model.is_team isEqualToString:@"1"]) {
                TeamCollectionReusableView *TeamView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TeamCollectionReusableID forIndexPath:indexPath];
                [TeamView setTeamActioviesModel:self.model];
                TeamView.SpokesmanAction = ^{
					self->TeamHearReusaType = @"0";
                    [collectionView reloadData];
//                    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
                };
                TeamView.CowdFundAction = ^{
					self->TeamHearReusaType = @"1";
                    [collectionView reloadData];
//                    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
                };
                TeamView.SuperAction = ^{
					self->TeamHearReusaType = @"2";
                    [collectionView reloadData];
//                    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
                };
                return TeamView;
            }
           MTZCPersonHeadReusableView *ZCHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTZCPersonHeadReusableID forIndexPath:indexPath];
           [ZCHeadView setCrowdFundCount:self.model.zcou andSupportCount:self.model.zccount];
           ZCHeadView.CrowdfundAction = ^{
			   self->_isGrid = YES;
//               [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
              [collectionView reloadData];
               NSLog(@"众筹人数");
           };
           ZCHeadView.SupportAction = ^{
			   self->_isGrid = NO;
//               [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
               [collectionView reloadData];
               NSLog(@"支持人数");
           };
           return ZCHeadView;
 //*/
        }else {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader" forIndexPath:indexPath];
            view.backgroundColor = [UIColor redColor];
            return view;
        }
   }else {
       return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"placeholderFoot" forIndexPath:indexPath];
   }
    
}
//- (void) isShowDetailTap {
//    _isShowDetail = !_isShowDetail;
//     [_collectionView reloadData];
//}

//分区头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == MTActionDetailDescribe) {
        return CGSizeMake(iPhoneWidth, 35);
    }
//*
    if (section == MTActionZCPersonNum) {
        if ([self.model.model isEqualToString:@"4"]) {
            return  CGSizeMake(0, 0);
        }
        if ([self.model.is_xmxs isEqualToString:@"0"]) {
            //不显示
            return  CGSizeMake(0, 0);
        }
        return CGSizeMake(iPhoneWidth, 50);
    }else {
 //*/
         return CGSizeMake(iPhoneWidth, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == MTActionSignUpPerson) {
        return CGSizeMake(iPhoneWidth, 12);
    }
    if (section == MTActionDetailDescribe) {
        return CGSizeMake(iPhoneWidth, 13);
    }
    return CGSizeMake(0, 0);
}
//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MTActionHeadImage) {
        return CGSizeMake(iPhoneWidth, WindowWith*0.453);
    }if (indexPath.section == MTActionContionTitle) {
        return CGSizeMake(iPhoneWidth, 67);
    }if (indexPath.section == MTActionSignUpPerson) {
        if (self.model.keyList.count == 2) {
             return CGSizeMake(((iPhoneWidth-48)/2.), kHeight(48));
        }
        return CGSizeMake(kWidth(100), kHeight(48));
    }if (indexPath.section == MTActionDetailDescribe) {
        if (indexPath.row == self.model.imgList2.count-1) {
            return CGSizeMake(iPhoneWidth, iPhoneWidth/[self.model.picwidth floatValue]*[self.model.pichigth floatValue]);
        }
        return CGSizeMake(iPhoneWidth, iPhoneWidth/[self.model.picwidth floatValue]*220);
    }
//*
    if (indexPath.section == MTActionZCPersonNum) {
        if ([self.model.is_team isEqualToString:@"1"]) {
            //战队
            return CGSizeMake(iPhoneWidth, kWidth(200));
        }
        
        if (_isGrid) {
            if (self.model.zcouList.count == 0) {
                return CGSizeMake(iPhoneWidth, kWidth(200));
            }

            return CGSizeMake(50, 50);
        }else {
            if (self.model.zclist.count == 0) {
                return CGSizeMake(iPhoneWidth, kWidth(200));
            }
             return CGSizeMake(iPhoneWidth, 69);
        }
    }else {
 //*/
        return CGSizeMake(0, 0);
    }
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section== MTActionSignUpPerson) {
        return 0;
    }
//*
    if (section== MTActionZCPersonNum) {
        if ([self.model.is_team isEqualToString:@"1"]) {
            return 0;
        }
        if (_isGrid) {
            return 10;
        }else {
            return 0;
        }
    }
//*/
    return 0.00f;
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section== MTActionSignUpPerson) {
        return 18;
    }
//*
    if (section== MTActionZCPersonNum) {
        if ([self.model.is_team isEqualToString:@"1"]) {
            return 10;
        }
        if (_isGrid) {
            return 10;
        }else {
            return 0;
        }
    }
//*/
    return 0.000f;
}
//四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section== MTActionSignUpPerson) {
        return UIEdgeInsetsMake(18, 15, 18, 15);
    }
//*
    if (section== MTActionZCPersonNum) {
        if ([self.model.is_team isEqualToString:@"1"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
        if (_isGrid) {
            return UIEdgeInsetsMake(27, 12, 27, 12);
        }else {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
 //*/
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//*
    if (indexPath.section== MTActionZCPersonNum) {
        if (!USERMODEL.isLogin) {
            //登录
            [self prsentToLoginViewController];
            return;
        }
        if ([self.model.is_team isEqualToString:@"1"]) {
            return;
        }
        zcouListModelModel *model;
        if (_isGrid == YES) {
            
            if (self.model.zcouList.count == 0) {
                return;
            }
            
           model =  self.model.zcouList[indexPath.row];
            
            if (![model.user_id isEqualToString:USERMODEL.userID]) {
                MyCrowdFundController *vc = [[MyCrowdFundController alloc] init];
                vc.Type = @"2";
                vc.crowdID = model.crowd_id;
                vc.cruUserID = model.user_id;
                vc.CFType = OtherPeoPleCrowdFundType;
                [self pushViewController:vc];
            }else {
                if (whether == 0) {
                    //未发起过众筹
                    SubmitOrderController *subOrderVc = [[SubmitOrderController alloc] init];
                    subOrderVc.model = self.model;
                    subOrderVc.indexPath = self.indexPath;
                    subOrderVc.type = MTSubmitCrowdFundOrder;
                    [self.navigationController pushViewController:subOrderVc animated:YES];
                }else {
                    //已经发起过众筹
                    [self didCrowdFundingVC];
                }
            }
        }else {
            if (self.model.zclist.count == 0) {
                return;
            }
          //支持人数列表无点击效果
          model = self.model.zclist[indexPath.row];
        }
    }
//*/
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark - 我要支付
- (void)goPlayOrder {
    if (!USERMODEL.isLogin) {
        //登录
        [self prsentToLoginViewController];
        return;
    }
    
    SubmitOrderController *subOrderVc = [[SubmitOrderController alloc] init];
    subOrderVc.model = self.model;
    subOrderVc.indexPath = self.indexPath;
    subOrderVc.type = MTSubmitCrowdFundOrderOrPlay;
    [self.navigationController pushViewController:subOrderVc animated:YES];
}

#pragma mark - 已经发起过众筹
- (void) didCrowdFundingVC {
    MyCrowdFundController *vc = [[MyCrowdFundController alloc] init];
    vc.Type = @"2";
    vc.crowdID = crowdId;
    vc.CFType = MyCrowdFundType;
    [self pushViewController:vc];
    
//    CrowdFundingViewController *vc = [[CrowdFundingViewController alloc] init];
//    vc.Type = @"2";
//    vc.crowdID = crowdId;
//    PayMentMangers *paymentManager = [[PayMentMangers alloc]init];
//    vc.payBlock = ^(NSString *price, NSString *orderNo, NSString *type, NSString *subject,NSString *crowId,SMBaseViewController *vc) {
//        [paymentManager payment:orderNo orderPrice:price type:type subject:subject crowID:crowId parentVC:vc resultBlock:^(BOOL isPaySuccess, NSString *msg) {
//            if (isPaySuccess) {
//                [[THNotificationCenter singleton]notifiyCrowdSuccess:self.indexPath];
//            }else{
//                //支付取消或者支付失败
//            }
//        }];
//    };
//    [self pushViewController:vc];
}
#pragma mark - 活动立即支付
- (void) ActivityGoPlay {
    if (!USERMODEL.isLogin) {
        //登录
        [self prsentToLoginViewController];
        return;
    }
    SubmitOrderController *subOrderVc = [[SubmitOrderController alloc] init];
    subOrderVc.model = self.model;
    subOrderVc.indexPath = self.indexPath;
    subOrderVc.type = MTSubmitActiviesPlay;
    [self.navigationController pushViewController:subOrderVc animated:YES];
}

@end



/*
 for (UIView *view in HeadView.subviews) {
 [view removeFromSuperview];
 }
 UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, iPhoneWidth - 24, 16)];
 titleLabel.font = sysFont(16);
 titleLabel.textColor = kColor(@"333333");
 titleLabel.text = @"详情描述";
 titleLabel.centerY = height(HeadView)/2.0;
 [HeadView addSubview:titleLabel];
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth - 30, 9, 12, 16)];
 if (_isShowDetail == NO) {
 imageView.frame = CGRectMake(iPhoneWidth - 30, 9, 12, 16);
 imageView.image = Image(@"icon_shouqi.png");
 }else {
 imageView.frame = CGRectMake(iPhoneWidth - 30, 13, 16, 12);
 imageView.image = Image(@"icon_zhankai.png");
 }
 [HeadView addSubview:imageView];
 
 UIButton * tapBut = [UIButton buttonWithType:UIButtonTypeSystem];
 tapBut.frame = CGRectMake(0, 0, iPhoneWidth, 35);
 [HeadView addSubview:tapBut];
 [tapBut addTarget:self action:@selector(isShowDetailTap) forControlEvents:UIControlEventTouchUpInside];
 
 UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(isShowDetailTap)];
 [HeadView addGestureRecognizer:tap];
 */
