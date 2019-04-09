//
//  MyCrowdFundController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/2.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyCrowdFundController.h"
#import "XHFriendlyLoadingView.h"
#import "ULBCollectionViewFlowLayout.h"     //分区背景色
#import "MyCrowdFundHeadCell.h"
#import "CrowdFundInfoViewCell.h"
#import "ActiviesDescripCell.h"
#import "CrowdFundBottomView.h"
#import "MTZCPersonHeadReusableView.h"
#import "MTActivesGridViewCell.h"
#import "MTActivesListViewCell.h"

#import "MTActionCollectionViewCell.h"
#import "PlayAmountViewController.h"
#import "CrowdFundECloutController.h"
#import "SubmitOrderController.h"

#import "NoContentViewCell.h"       //没有内容时
#import "TeamCrowdReusableView.h"   //

#import "TheTeamNumCollectionViewCell.h"        //战队数量
#import "TeamPeopleCollectionViewCell.h"        //本队人数
#import "TeamSupperCollectionViewCell.h"        //队伍支持

#import "PTCommentInputView.h"  //回复

typedef NS_ENUM(NSInteger , ActionSection) {
    MTActionHeadImage,       //头视图图片
    MTActionContionTitle,    //活动说明
    MTActionDetailDescribe,  //活动信息
    MTActioninformation,     //详情描述
    MTActionZCPersonNum,     //众筹支持人数
    MTActionSectionCount,    //分区个数
};

@interface MyCrowdFundController () <UICollectionViewDelegate,UICollectionViewDataSource,CommentDelegate> {
    BOOL _isGrid;
    UIButton *backTopBut;
    BOOL _isTop;        //返回顶部
     NSString *TeamHearReusaType;    //0 - 参赛队伍 1--本队人数 2--支持人数
    
    PTCommentInputView *_inputView;
    CGFloat OldPintY;
    
    NSInteger supportIndex;
     BOOL _isShowDetail;       //是否显示详情描述
   
}

@property (nonatomic, strong) UICollectionView *collectionView;

//@property (nonatomic, strong) PlaceholderTextView *inputView;;

@end

static CGFloat contentOfSetY;
static NSInteger huifuTag;

static NSString *MTmyCrowdFundHeadCellID   =  @"MyCrowdFundHeadCell";
static NSString *MTCrowdFundInfoViewCellID  = @"CrowdFundInfoViewCell";
static NSString *MTActiviesDescripCellID  =   @"ActiviesDescripCell";
static NSString *MTActivesGridViewCellID   = @"MTActivesGridViewCell";
static NSString *MTActivesListViewCellID   = @"MTActivesListViewCell";
static NSString *MTActionDetailDescribeID   = @"MTActionDetailDescribeID";

static NSString *MTZCPersonHeadReusableID   = @"MTZCPersonHeadReusableView";
static NSString *TeamCrowdReusableViewID  =  @"TeamCrowdReusableView";

static NSString *NoContentCellID  = @"NoContentViewCellID";

static NSString *TheTeamNumCollectionViewCellID  = @"TheTeamNumCollectionViewCell";
static NSString *TeamPeopleCollectionViewCellID  = @"TeamPeopleCollectionViewCell";
static NSString *TeamSupperCollectionViewCellID  = @"TeamSupperCollectionViewCell";

static NSString *MTZCDetailHeadReusableID = @"MTZCDetailHeadReusableID";    //活动详情


@implementation MyCrowdFundController

- (void)back:(id)sender {
    NSArray *ViewControllers= self.navigationController.viewControllers;
    if ([self.isPopVc isEqualToString:@"1"]) {
       [self popViewController:(int)(ViewControllers.count - 3)];
    }else if ([self.isPopVc isEqualToString:@"2"]){
        [self popViewController:1];
    }else if (ViewControllers.count >= 5)  {
         [self popViewController:1];
    }else {
         [self.navigationController popViewControllerAnimated:NO];
    }
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *flowlayout = [[ULBCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(60)) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor] ;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //注册Cell，必须要有
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
        
        [_collectionView registerClass:[MyCrowdFundHeadCell class] forCellWithReuseIdentifier:MTmyCrowdFundHeadCellID];         //0
        [_collectionView registerClass:[CrowdFundInfoViewCell class] forCellWithReuseIdentifier:MTCrowdFundInfoViewCellID];    //我的众筹
        [_collectionView registerClass:[ActiviesDescripCell class] forCellWithReuseIdentifier:MTActiviesDescripCellID];       //活动信息
        [_collectionView registerClass:[MTActionDetailDescribeCell class] forCellWithReuseIdentifier:MTActionDetailDescribeID]; //活动详情描述
        [_collectionView registerClass:[MTActivesGridViewCell class] forCellWithReuseIdentifier:MTActivesGridViewCellID]; //活动详情描述
        [_collectionView registerClass:[MTActivesListViewCell class] forCellWithReuseIdentifier:MTActivesListViewCellID]; //活动详情描述
        
        [_collectionView registerClass:[TheTeamNumCollectionViewCell class] forCellWithReuseIdentifier:TheTeamNumCollectionViewCellID]; //队伍数量
        [_collectionView registerClass:[TeamPeopleCollectionViewCell class] forCellWithReuseIdentifier:TeamPeopleCollectionViewCellID]; //本队人数
        [_collectionView registerClass:[TeamSupperCollectionViewCell class] forCellWithReuseIdentifier:TeamSupperCollectionViewCellID]; //支持人数
        
        [_collectionView registerClass:[NoContentViewCell class] forCellWithReuseIdentifier:NoContentCellID]; //没有内容时
        
        
//
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ActionHeadId"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"placeholderFoot"];
        [_collectionView registerClass:[MTZCPersonHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTZCPersonHeadReusableID];       //支持、众筹头视图
         [_collectionView registerClass:[TeamCrowdReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TeamCrowdReusableViewID];
        [_collectionView registerClass:[MTZCDetailReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTZCDetailHeadReusableID];
        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TeamHearReusaType = @"1";
    _isShowDetail = NO;
    self.view.backgroundColor = RGB(238, 238, 238);
    
    if ([self.Type isEqualToString:@"2"]) {
        [self getOrderData];
    } else {
        [self creatCollectionView];
        self.crowdID = [NSString stringWithFormat:@"%ld",self.model.infoModel.crowd_id];
    }
}
- (void)getOrderData
{
    [self addPushViewWaitingView];
    [network selectCrowdDetailByCrowdId:[self.crowdID intValue] openid:@"" success:^(NSDictionary *obj) {
        [self removePushViewWaitingView];
        self.model= obj[@"content"];
        self.ActiModel = self.model.selectActivitiesListInfo;
        [self creatCollectionView];
        
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
        
    }];
}

-(void)creatCollectionView
{
    [self.view addSubview:self.collectionView];
    self.title = self.model.infoModel.activities_titile;
    //返回顶部
    
    
    _isGrid = YES;
    CrowdFundBottomView *footView = [[CrowdFundBottomView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - KtopHeitht- kWidth(60) , iPhoneWidth, kWidth(60))];
    float worsePic = (self.model.infoModel.total_money - self.model.infoModel.obtain_money);
    if (worsePic <= 0) {
        footView.SuceeOrFail = SuccesType;
    }else if (self.model.infoModel.status == 2) {
        footView.SuceeOrFail = EndCrowdFund;
    }else{
        
        if (MyCrowdFundType == self.CFType) {
            footView.BootomType = MyCrowdFundSignUp;
//            [footView setActivies:self.ActiModel];        //是否可以自己支持
        }
        if (OtherPeoPleCrowdFundType == self.CFType) {
            footView.BootomType = OtherPeoPleCrowdFund;
        }
        
        footView.selfSupport = ^(){     //自己支持
            [self selfSupport];
        };
        footView.OtherPeoPleZCBlock = ^(){      //找人帮我众筹
            [self OtherPeoPleZCBlock];
        };
        footView.myCrowdFundBlock = ^(){       //我的众筹
            [self myCrowdFundBlock];
        };
        footView.giveTasupportlock = ^{        //给ta支持
            [self giveTasupportlock];
        };
        footView.IPlayToolock = ^{             //我也要玩
            [self IPlayToolock];
        };
        
    }
     [self.view addSubview:footView];
    
    backTopBut = [UIButton buttonWithType:UIButtonTypeSystem];
    backTopBut.frame = CGRectMake(iPhoneWidth - kWidth(54), iPhoneHeight - kWidth(120) - KTabSpace - KtopHeitht, kWidth(40), kWidth(40));
    [self.view addSubview:backTopBut];
    [backTopBut addTarget:self action:@selector(BackTopAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self createTextView];//添加回复输入框
}
- (void) createTextView{
    _inputView = [[PTCommentInputView alloc]initWithFrame:CGRectMake(0, iPhoneHeight, WindowWith, 35)];
    _inputView.delegate=self;
    _inputView.hidden = YES;
    [self.view addSubview:_inputView];
    
    [_inputView.inputTextView becomeFirstResponder];
    [_inputView.inputTextView resignFirstResponder];
    _inputView.inputTextView.placeholder = @"回复信息：";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InputkeyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
//设置每个分区背景色
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section {
    if (section == MTActionZCPersonNum) {
        return cLineColor;
    }else {
        return [UIColor whiteColor];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return MTActionSectionCount;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == MTActionHeadImage) {
        return 1;
    }
    if (section == MTActionContionTitle) {
        return 1;
    }
    if (section == MTActionDetailDescribe) {
        return 1;
    }
    if (section == MTActioninformation) {
        if (_isShowDetail == YES) {
            return self.ActiModel.imgList2.count;
        }else {
            return 0;
        }
    }
    if (section == MTActionZCPersonNum) {
        //战队
        if ([self.ActiModel.is_team isEqualToString:@"1"]) {
            if ([TeamHearReusaType isEqualToString:@"0"]) {
                if (self.ActiModel.teamList.count == 0) {
                    return 1;
                }
                return self.ActiModel.teamList.count;
            }else if ([TeamHearReusaType isEqualToString:@"1"]) {
                if (self.ActiModel.zcouList.count == 0) {
                    return 1;
                }
                return self.ActiModel.zcouList.count;
            }else {
                if (self.ActiModel.zclist.count == 0) {
                    return 1;
                }
                return self.ActiModel.zclist.count;
            }

        }
        
        if (_isGrid) {
            if (self.ActiModel.zcouList.count == 0) {
                return 1;
            }
           return self.ActiModel.zcouList.count;
        }else{
            if (self.ActiModel.zclist.count == 0) {
                return 1;
            }
            return self.ActiModel.zclist.count;
        }
        
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MTActionHeadImage) {
        MyCrowdFundHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTmyCrowdFundHeadCellID forIndexPath:indexPath];
        [cell setImageURl:self.model.infoModel.activities_pic];
        return cell;
    }
    if (indexPath.section == MTActionContionTitle) {
        CrowdFundInfoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTCrowdFundInfoViewCellID forIndexPath:indexPath];
        [cell setUIData:self.model.infoModel];
        return cell;
    }
    if (indexPath.section == MTActionDetailDescribe) {
        ActiviesDescripCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActiviesDescripCellID forIndexPath:indexPath];
        [cell setImageUrl:self.model.infoModel.activities_pic andTitle:self.model.infoModel.activities_titile andContTitle:self.model.infoModel.total_money];
        return cell;
    }
    if (indexPath.section == MTActioninformation) {
        MTActionDetailDescribeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActionDetailDescribeID forIndexPath:indexPath];
        imageListModel *model = self.ActiModel.imgList2[indexPath.row];
        [cell setConternImag:model.key];
        return cell;
    }
    if (indexPath.section == MTActionZCPersonNum) {
        if ([self.ActiModel.is_team isEqualToString:@"1"]) {
            if ([TeamHearReusaType isEqualToString:@"0"]) {
                if (self.ActiModel.teamList.count == 0) {
                    NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                    [Nocell setShowContenTitle:@"还没有战队哦"];
                    return Nocell;
                }
                TheTeamNumCollectionViewCell *Teamcell = [collectionView dequeueReusableCellWithReuseIdentifier:TheTeamNumCollectionViewCellID forIndexPath:indexPath];
                return Teamcell;
            }else if ([TeamHearReusaType isEqualToString:@"1"]) {
                if (self.ActiModel.zcouList.count == 0) {
                    NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                    [Nocell setShowContenTitle:@"还没有战队哦"];
                    return Nocell;
                }
                
                TeamPeopleCollectionViewCell *Teamcell = [collectionView dequeueReusableCellWithReuseIdentifier:TeamPeopleCollectionViewCellID forIndexPath:indexPath];
                zcouListModelModel *model = self.ActiModel.zcouList[indexPath.row];
                [Teamcell setTeamPeopleActioviesModel:model];
                return Teamcell;
            }else {
                if (self.ActiModel.zclist.count == 0) {
                    NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                    [Nocell setShowContenTitle:@"还没有支持人数哦"];
                    return Nocell;
                }
                TeamSupperCollectionViewCell *Teamcell = [collectionView dequeueReusableCellWithReuseIdentifier:TeamSupperCollectionViewCellID forIndexPath:indexPath];
                Teamcell.tag = indexPath.row;
                zcouListModelModel *model = self.ActiModel.zclist[indexPath.row];
                [Teamcell setTeamSupperActioviesModel:model];
                Teamcell.huifuAction = ^(NSInteger index) {
                    [self SupperHuifu:index];
                };
                return Teamcell;
            }
        }
        if (_isGrid) {
            if (self.ActiModel.zcouList.count == 0) {
                NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                [Nocell setShowContenTitle:@"还没有人众筹哦"];
                return Nocell;
            }
            MTActivesGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActivesGridViewCellID forIndexPath:indexPath];
            zcouListModelModel *model = self.ActiModel.zcouList[indexPath.row];
            [cell setIconImagUrl:model.head_image andProgress:model.bili];
            //            [cell setIconImagUrl:@"" andProgress:@"40"];
            return cell;
        }else {
            if (self.ActiModel.zclist.count == 0) {
                NoContentViewCell *Nocell = [collectionView dequeueReusableCellWithReuseIdentifier:NoContentCellID forIndexPath:indexPath];
                [Nocell setShowContenTitle:@"还没有人支持哦"];
                return Nocell;
            }
            MTActivesListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTActivesListViewCellID forIndexPath:indexPath];
            zcouListModelModel *model = self.ActiModel.zclist[indexPath.row];
            [cell setIctonImgUrl:model.head_image andName:model.nickname andTime:model.create_time andPic:model.pay_amount];
            //            [cell setIctonImgUrl:@"" andName:@"花花" andTime:@"6月20日" andPic:@"500"];
            return cell;
        }
        
    }
    return nil;
}
//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MTActionHeadImage) {
        return CGSizeMake(iPhoneWidth, WindowWith*0.453);
    }if (indexPath.section == MTActionContionTitle) {
        return CGSizeMake(iPhoneWidth, kWidth(124));
    }if (indexPath.section == MTActionDetailDescribe) {
        return CGSizeMake(iPhoneWidth, kWidth(112));
    }if (indexPath.section == MTActioninformation) {
        if (indexPath.row == self.ActiModel.imgList2.count-1) {
            return CGSizeMake(iPhoneWidth, iPhoneWidth/[self.ActiModel.picwidth floatValue]*[self.ActiModel.pichigth floatValue]);
        }
        return CGSizeMake(iPhoneWidth, iPhoneWidth/[self.ActiModel.picwidth floatValue]*220);
    }if (indexPath.section == MTActionZCPersonNum) {
        if ([self.ActiModel.is_team isEqualToString:@"1"]) {
            //战队
            
            if ([TeamHearReusaType isEqualToString:@"0"]) {
                if (self.ActiModel.teamList.count == 0) {
                    return CGSizeMake(iPhoneWidth, kWidth(160));
                }
                return CGSizeMake(iPhoneWidth, kWidth(100));
            }else if ([TeamHearReusaType isEqualToString:@"1"]) {
                if (self.ActiModel.zcouList.count == 0) {
                    return CGSizeMake(iPhoneWidth, kWidth(160));
                }
                return CGSizeMake(iPhoneWidth, kWidth(90));
            } else {
                if (self.ActiModel.zclist.count == 0) {
                    return CGSizeMake(iPhoneWidth, kWidth(160));
                }
                zcouListModelModel *model = self.ActiModel.zclist[indexPath.row];
                return CGSizeMake(iPhoneWidth, [self cellHeightZoulistModel:model]);
            }
        }
        if (_isGrid) {
            if (self.ActiModel.zcouList.count == 0) {
                return CGSizeMake(iPhoneWidth, kWidth(160));
            }
            
            return CGSizeMake(50, 50);
        }else {
            if (self.ActiModel.zclist.count == 0) {
                return CGSizeMake(iPhoneWidth, kWidth(160));
            }
            return CGSizeMake(iPhoneWidth, 69);
        }
        
    }else {
        return CGSizeMake(0, 0);
    }
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section== MTActionZCPersonNum) {
        if ([self.ActiModel.is_team isEqualToString:@"1"]) {
            return 0;
        }
        if (_isGrid) {
            return 10;
        }else {
            return 0;
        }
    }
    return 0.01f;
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section== MTActionZCPersonNum) {
        if ([self.ActiModel.is_team isEqualToString:@"1"]) {
            return 0;
        }
        if (_isGrid) {
            return 10;
        }else {
            return 0;
        }
    }
    return 0.01f;
}
//四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section== MTActionZCPersonNum) {
        if ([self.ActiModel.is_team isEqualToString:@"1"]) {
            return  UIEdgeInsetsMake(0, 0, 0, 0);
        }
        if (_isGrid) {
            return UIEdgeInsetsMake(27, 12, 27, 12);
        }else {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == MTActionDetailDescribe) {
            UICollectionReusableView *HeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ActionHeadId" forIndexPath:indexPath];
            HeadView.backgroundColor = [UIColor whiteColor];
            for (UIView *view in HeadView.subviews) {
                [view removeFromSuperview];
            }
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 120, 16)];
            titleLabel.font = sysFont(16);
            titleLabel.textColor = kColor(@"333333");
            titleLabel.text = @"活动信息";
            titleLabel.centerY = height(HeadView)/2.0;
            [HeadView addSubview:titleLabel];
            
            UILabel *ritLabel = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 120, 5,  100, 16)];
            ritLabel.font = sysFont(16);
            ritLabel.textColor = kColor(@"333333");
            ritLabel.centerY = height(HeadView)/2.0;
            ritLabel.textAlignment = NSTextAlignmentRight;
            [HeadView addSubview:ritLabel];
            NSString *TextStr = [NSString stringWithFormat:@"剩余%@天",self.model.diffDay];
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:TextStr];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(2, TextStr.length - 3)];
            ritLabel.attributedText = attributedStr;
            UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height(HeadView)-1, iPhoneWidth, 1)];
            lineLabel.backgroundColor = cLineColor;
            [HeadView addSubview:lineLabel];
            return HeadView;
        }
        if (indexPath.section == MTActioninformation) {
            MTZCDetailReusableView *DetailHeadView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTZCDetailHeadReusableID forIndexPath:indexPath];
            
            DetailHeadView.backgroundColor = [UIColor whiteColor];
            [DetailHeadView setisShowDetail:_isShowDetail];
            DetailHeadView.isShowDetailblock = ^(BOOL isShow){
                self->_isShowDetail = isShow;
                [collectionView reloadData];
            };
            return DetailHeadView;
        }
        if (indexPath.section == MTActionZCPersonNum) {
           
            if ([self.ActiModel.is_team isEqualToString:@"1"]) {
                TeamCrowdReusableView *TeamView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TeamCrowdReusableViewID forIndexPath:indexPath];
                TeamView.selectIndex = TeamHearReusaType;
                TeamView.TheTeamAction = ^{
                    self->TeamHearReusaType = @"0";
                    [self->_inputView.inputTextView resignFirstResponder];
                    [collectionView reloadData];
                };
                TeamView.TeamPeopleAction = ^{
                    self->TeamHearReusaType = @"1";
                    [self->_inputView.inputTextView resignFirstResponder];
                    [collectionView reloadData];
                };
                TeamView.SuperAction = ^{
                    self->TeamHearReusaType = @"2";
                    [collectionView reloadData];
                };
                [TeamView setTeamActioviesModel:self.ActiModel];
                return TeamView;
            }
            
            MTZCPersonHeadReusableView *ZCHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MTZCPersonHeadReusableID forIndexPath:indexPath];
            [ZCHeadView setCrowdFundCount:self.ActiModel.zcou andSupportCount:self.ActiModel.zccount];
            ZCHeadView.CrowdfundAction = ^{
                self->_isGrid = YES;
                //               [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
                [self->_collectionView reloadData];
                NSLog(@"众筹人数");
            };
            ZCHeadView.SupportAction = ^{
                self->_isGrid = NO;
                //               [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
                [self->_collectionView reloadData];
                NSLog(@"支持人数");
            };
            return ZCHeadView;
        }else {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader" forIndexPath:indexPath];
            view.backgroundColor = [UIColor redColor];
            return view;
        }
    }else {
         return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"placeholderFoot" forIndexPath:indexPath];
    }
}


//分区头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == MTActionDetailDescribe) {
        return CGSizeMake(iPhoneWidth, kWidth(35));
    }else if (section == MTActioninformation) {
        return CGSizeMake(iPhoneWidth, kWidth(35));
    }else if (section == MTActionZCPersonNum) {
        return CGSizeMake(iPhoneWidth, 50);
    }else {
        return CGSizeMake(0, 0);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == MTActionContionTitle) {
        return CGSizeMake(iPhoneWidth, kWidth(8));
    }
    if (section == MTActionDetailDescribe) {
        return CGSizeMake(iPhoneWidth, kWidth(9));
    }
    if (section == MTActioninformation) {
        return CGSizeMake(iPhoneWidth, kWidth(9));
    }
    return CGSizeMake(0, 0);
}
#pragma mark --UICollectionViewDelegate

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//点击Cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section== MTActionZCPersonNum) {
        if ([self.ActiModel.is_team isEqualToString:@"1"]) {
            if ([TeamHearReusaType isEqualToString:@"1"]) {
                if (self.ActiModel.zcouList.count == 0) {
                    return;
                }
               zcouListModelModel* model =  self.ActiModel.zcouList[indexPath.row];
                MyCrowdFundController *vc = [[MyCrowdFundController alloc] init];
                vc.Type = @"2";
                vc.cruUserID = model.user_id;
                vc.crowdID = model.crowd_id;
                if ([model.user_id isEqualToString:USERMODEL.userID]) {
                    vc.CFType = MyCrowdFundType;
                }else {
                    vc.CFType = OtherPeoPleCrowdFundType;
                }
                [self.navigationController pushViewController:vc animated:YES];
            }else if ([TeamHearReusaType isEqualToString:@"2"]) {
                zcouListModelModel *model = self.ActiModel.zclist[indexPath.row];
                if (![model.is_hide isEqualToString:@"1"]) {
                     [self hidCellIndexPath:indexPath];//隐藏cell内容
                }
               
            }
            
        }else {
            zcouListModelModel *model;
            if (_isGrid == YES) {
                if (self.ActiModel.zcouList.count == 0) {
                    return;
                }
                model =  self.ActiModel.zcouList[indexPath.row];
            }else {
                if (self.ActiModel.zclist.count == 0) {
                    return;
                }
                model = self.ActiModel.zclist[indexPath.row];
                return;
            }
            if (![self.cruUserID isEqualToString:model.user_id]) {
                MyCrowdFundController *vc = [[MyCrowdFundController alloc] init];
                vc.Type = @"2";
                vc.cruUserID = model.user_id;
                vc.crowdID = model.crowd_id;
                if ([model.user_id isEqualToString:USERMODEL.userID]) {
                    vc.CFType = MyCrowdFundType;
                }else {
                    vc.CFType = OtherPeoPleCrowdFundType;
                }
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
       
    }
}
#pragma mark - 隐藏支持人
- (void) hidCellIndexPath:(NSIndexPath *)index {
     [IHUtility AlertMessage:@"温馨提示？" message:@"选择隐藏后，此条消息仅本人可见" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" tag:10];
    supportIndex = index.row;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==1){
        zcouListModelModel *model = self.ActiModel.zclist[supportIndex];
        NSDictionary *dict = @{
                               @"record_id" : model.record_id,
                               };
        [network httpRequestTagWithParameter:dict method:SupportHideCrowUrl tag:IH_init success:^(NSDictionary * dic) {
            model.is_hide = @"1";
            [self->_collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self->supportIndex inSection:MTActionZCPersonNum], nil]];
            [self->_inputView.inputTextView resignFirstResponder];
            
        } failure:^(NSDictionary * dic) {
            
        }];
        
    }
}
#pragma mark - 自己支持
- (void) selfSupport {
    NSLog(@"自己支付");
    PlayAmountViewController *selfPlayVc = [[PlayAmountViewController alloc] init];
    selfPlayVc.model = self.model;
    selfPlayVc.indexPath = self.indexPath;
    selfPlayVc.ActiModel = self.ActiModel;
    if ([self.isPopVc isEqualToString:@"1"]) {
        selfPlayVc.blakPopVc = @"2";
    }else {
        selfPlayVc.blakPopVc = @"1";
    }
    [self pushViewController:selfPlayVc];
    
}
#pragma makr - 找人帮我众筹
- (void)OtherPeoPleZCBlock{
    NSLog(@"找人帮我众筹");
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    [self shareView2:ENT_Crowd object:_model vc:self];
};
#pragma mark - 我的众筹
- (void)myCrowdFundBlock{
    CrowdFundECloutController *controller = [[CrowdFundECloutController alloc] init];
    controller.tabedSlideView.selectedIndex = 1;
    [self pushViewController:controller];
    NSLog(@"我的众筹");
};
#pragma mark - 给Ta支持
- (void)giveTasupportlock{
    NSLog(@"给他支持");
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
//    [self shareView2:ENT_Crowd object:_model vc:self];
    PlayAmountViewController *selfPlayVc = [[PlayAmountViewController alloc] init];
    selfPlayVc.model = self.model;
    selfPlayVc.indexPath = self.indexPath;
    selfPlayVc.ActiModel = self.ActiModel;
    selfPlayVc.isSupport = @"1";
    [self pushViewController:selfPlayVc];
};
#pragma mark - 我也要玩
- (void)IPlayToolock{
    NSLog(@"我也要玩");
    NSString *userID;
    if (!USERMODEL.isLogin) {
        //登录
        [self prsentToLoginViewController];
         userID = @"0";
        return;
    }
    userID = USERMODEL.userID;
    __block int whether;//是否众筹过  1为发起过众筹
    //进入详情判断是否已众筹 如果已众筹获取众筹ID 点击报名按钮进入众筹也是带过去
    [network getWhetherCrowdWithUserID:userID activities_id:self.ActiModel.activities_id success:^(NSDictionary *obj) {
        whether = [obj[@"content"][@"crowdStatus"] intValue];
        if (whether == 1) {
            //已经发起过众筹
            NSString * crowdId = [NSString stringWithFormat:@"%@",obj[@"content"][@"crowd_id"]];
            [self didCrowdFundingVC:crowdId];
        }else {
            //未发起过众筹
            SubmitOrderController *subOrderVc = [[SubmitOrderController alloc] init];
            subOrderVc.model = self.ActiModel;
            subOrderVc.indexPath = self.indexPath;
            subOrderVc.type = MTSubmitCrowdFundOrder;
            [self.navigationController pushViewController:subOrderVc animated:YES];
        }
    }];

};
#pragma mark - 已经发起过众筹
- (void) didCrowdFundingVC :(NSString *)crowdId{
    MyCrowdFundController *vc = [[MyCrowdFundController alloc] init];
    vc.Type = @"2";
    vc.crowdID = crowdId;
    vc.CFType = MyCrowdFundType;
    [self pushViewController:vc];
}

#pragma mark - ScrollviewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    backTopBut.hidden = YES;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    backTopBut.hidden = NO;
    CGFloat y=scrollView.contentOffset.y;
    if (y > _boundHeihgt/2.0) {
        _isTop = YES;
        [backTopBut setBackgroundImage:Image(@"icon_dingbui.png") forState:UIControlStateNormal];
    }else {
        _isTop = NO;
        [backTopBut setBackgroundImage:Image(@"icon_dibu.png") forState:UIControlStateNormal];
    }
    
    if (y > 0) {
        [UIView animateWithDuration:0.5f animations:^{
            self->backTopBut.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self->backTopBut.alpha =0.0 ;
        } completion:^(BOOL finished) {
        }];
    }
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if ((int)bottomOffset <= (int)height) {
        //在最底部
        _isTop = YES;
        [backTopBut setBackgroundImage:Image(@"icon_dingbui.png") forState:UIControlStateNormal];
    }
    
}
- (void) BackTopAction {
    if (_isTop == YES) {
        backTopBut.hidden = YES;
        _collectionView.contentOffset = CGPointMake(0, 0);
    }else {
        NSInteger s = [_collectionView numberOfSections];  //有多少组
        if (s<1) return;  //无数据时不执行 要不会crash
        NSInteger r = [_collectionView numberOfItemsInSection:s-1]; //最后一组有多少行
        if (r<1) return;
        NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
        [_collectionView scrollToItemAtIndexPath:ip atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        
        _isTop = YES;
        [backTopBut setBackgroundImage:Image(@"icon_dingbui.png") forState:UIControlStateNormal];
    }
}

#pragma mark - cellHeight
- (CGFloat)cellHeightZoulistModel:(zcouListModelModel *)model {
    // 文字的最大尺寸(设置内容label的最大size，这样才可以计算label的实际高度，需要设置最大宽度，但是最大高度不需要设置，只需要设置为最大浮点值即可)，53为内容label到cell左边的距离
//    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 53, MAXFLOAT);
    CGFloat textHeight = [IHUtility calculateRowHeight:model.huifu Width:(iPhoneWidth - kWidth(67) - kWidth(15) -  kWidth(16)) fontSize:font(12)];
    
    /*
     昵称label和cell的顶部为0
     17为昵称label的高度
     8.5为昵称label和内容label的间距
     textH为内容label的高度
     304为内容image的高度
     */
    CGFloat _cellHeight;
    if ([model.huifu isEqualToString:@""] || model.huifu == nil) {
        _cellHeight = kWidth(80.);
    }else {
        _cellHeight = kWidth(80) +kWidth(textHeight) + kWidth(40);
    }
    return _cellHeight;
}
#pragma mark - 回复
- (void) SupperHuifu:(NSInteger )index {
    
    huifuTag = index;
    NSLog(@"回复：------- %ld",index);
    OldPintY = 0;
    contentOfSetY = 0;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:MTActionZCPersonNum];
    TeamSupperCollectionViewCell *Teamcell = [_collectionView dequeueReusableCellWithReuseIdentifier:TeamSupperCollectionViewCellID forIndexPath:indexPath];
    //获取cell在当前collection的位置
    CGRect cellInCollection = [_collectionView convertRect:Teamcell.frame toView:_collectionView];
    //获取cell在当前屏幕的位置
    OldPintY = _collectionView.contentOffset.y;
    CGRect cellInSuperview = [_collectionView convertRect:cellInCollection toView:self.view];

    contentOfSetY = cellInSuperview.origin.y;
    _inputView.hidden = NO;
    self.view.transform = CGAffineTransformIdentity;
     _inputView.inputTextView.text = @"";
    [_inputView.inputTextView becomeFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_inputView resignFirstResponder];
    _inputView.hidden = YES;
}

#pragma mark - 发送
-(void)didSendText:(UITextView *)textView text:(NSString *)text{
    
    zcouListModelModel *model = self.ActiModel.zclist[huifuTag];
    
    NSDictionary *dic = @{
                          @"user_id"  : USERMODEL.userID,
                          @"huifu"    : text,
                          @"record_id":model.record_id,
                          };
    [network SpperhuifuParames:dic success:^(NSDictionary *obj) {
        model.huifu = text;
        model.huifu_name = USERMODEL.nickName;
        [self->_collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:huifuTag inSection:MTActionZCPersonNum], nil]];
        [self->_inputView.inputTextView resignFirstResponder];
    }];
    
}

- (void)InputkeyboardNotification:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    CGRect KeyboardFrame = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat KeyboardY = KeyboardFrame.origin.y;
    //获取动画时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGFloat transY = KeyboardY;
    //动画
//    CGFloat OldContentOfY = _collectionView.contentOffset.y;
    if (transY > iPhoneHeight - contentOfSetY) {
        self->_collectionView.contentOffset = CGPointMake(0,  OldPintY + (transY - (iPhoneHeight - contentOfSetY)) + 80);
    }
    [UIView animateWithDuration:duration animations:^{
        self->_inputView.transform =CGAffineTransformMakeTranslation(0, -(transY ));
    }];
}
#pragma mark -      当键盘即将消失

-(void)didKboardDisappear:(NSNotification *)sender{
    _collectionView.contentOffset = CGPointMake(0,  OldPintY);
    _inputView.hidden = YES;
    _inputView.transform = CGAffineTransformIdentity;
    _inputView.inputTextView.text = @"";
    [_inputView.inputTextView resignFirstResponder];
    
}
- (void)dealloc {
    [_inputView.inputTextView removeFromSuperview];
    _inputView.transform = CGAffineTransformIdentity;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
