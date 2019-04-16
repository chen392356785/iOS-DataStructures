//
//  ClassroomHomeController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/10.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ClassroomHomeController.h"
#import "ULBCollectionViewFlowLayout.h"
#import "ClassroomCollectionCell.h"
//#import "ClassroomModel.h"
//#import "MTHomeSearchView.h"
#import "ClassSourceReusableView.h"
//#import "SDCycleScrollView.h"             //滚动视图
#import "RecommendTeacherController.h"    //推荐讲师
#import "ClassroomSearchController.h"     //搜索
#import "ClassSourdeDetailController.h"   //课堂详情
#import "ClassSourceListController.h"     //更多分类列表
#import "ActivityListViewController.h"    //线下活动
#import "MyClassSourceController.h"       //我的课程
// offsetY > -64 的时候导航栏开始偏移
#define NAVBAR_TRANSLATION_POINT 0
#define NavBarHeight 44

@interface ClassroomHomeController () <UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>{
    NSMutableArray *dataArr;
    NSMutableArray *classTitlesArr;
    NSMutableArray *BannerArr;
    MTHomeSearchView *searchTextfiled;
//    UIBarButtonItem *negativeSpacer;
    UILabel *Titlelabel;
//    NSString *RefresType;   //下拉 0 上拉1
    ClassroomModel *ClassMode;
    
    CGFloat showNaHeight;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end

static NSString *ClassroomCollectionCellID      =  @"ClassroomCollectionCell";
static NSString *ClassroomHeadViewCellID        =  @"ClassroomHeadViewCell";
static NSString *ClassroomClassTitleViewCellID  =  @"ClassroomClassTitleViewCell";
static NSString *ClassSourceReusableViewID      =  @"ClassSourceReusableView";

@implementation ClassroomHomeController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
     self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.navigationController.navigationBar.hidden = YES;
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    if (_collectionView.contentOffset.y > KtopHeitht ) {
        self.navigationController.navigationBar.hidden = NO;
        leftbutton.hidden = YES;
        [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.alpha =  _collectionView.contentOffset.y / (showNaHeight);
        if (_collectionView.contentOffset.y >= showNaHeight) {
            self.navigationController.navigationBar.alpha = 1;
        }
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
    
     self.navigationController.navigationBar.hidden = NO;
     self.navigationController.navigationBar.alpha = 1.0;
     [self.navigationController.navigationBar setTranslucent:false];
     [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
//    self.automaticallyAdjustsScrollViewInsets = YES;
    if (_collectionView.contentOffset.y > KtopHeitht ) {
        _collectionView.origin = CGPointMake(0, -KtopHeitht);
        if (@available(iOS 11.0, *)) {
            _collectionView.height =  iPhoneHeight - KTabBarHeight + KStatusBarHeight + KNavBarHeight ;
        } else {
            _collectionView.height =  iPhoneHeight - KTabBarHeight + KNavBarHeight;
        }
        
    }else {
        if (@available(iOS 11.0, *)) {
            _collectionView.origin = CGPointMake(0, -KStatusBarHeight);
            _collectionView.height = iPhoneHeight - KTabBarHeight + KStatusBarHeight;
        } else {
            _collectionView.origin = CGPointMake(0, 0);
            _collectionView.height = iPhoneHeight - KTabBarHeight;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    leftbutton.hidden = YES;
    showNaHeight = kWidth(287) + 44;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImageView *imagView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imagView.backgroundColor = [UIColor colorWithPatternImage:[kImage(@"img_sx_bj") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    imagView.contentMode = UIViewContentModeScaleAspectFill | UIViewContentModeTop;
    [self.view addSubview:imagView];
    classTitlesArr = [[NSMutableArray alloc] init];
    [self createCollectionView];
    
    UIImage *shareImg=Image(@"icon_fx");
    moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(0, 0, 40, 40);
    [moreBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:shareImg forState:UIControlStateNormal];
    moreBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);

    Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 44)];
    Titlelabel.textAlignment = NSTextAlignmentCenter;
    Titlelabel.text = @"青蛙园艺学院";
    Titlelabel.font = sysFont(16);
}

- (void) createCollectionView {
    
    dataArr = [[NSMutableArray alloc] init];
    BannerArr = [[NSMutableArray alloc] init];
    
    
    
/*
    NSArray *mArray;
    if (dataArr.count == 0) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *file = [path stringByAppendingPathComponent:@"ClassRoomList.data"];
        //解档
        mArray = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    }
    BannerArr = [[NSMutableArray alloc] initWithArray:mArray];
//*/
    __weak ClassroomHomeController *weakSelf=self;
    [self CreateCollectionViewRefesh:self.collectionView type:(ENT_RefreshHeader) successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadData];
    }];
    [self.view addSubview:self.collectionView];

    if (KStatusBarHeight > 20) {
        self.collectionView.mj_header.frame = CGRectMake(0, 0, iPhoneWidth, KtopHeitht - 10);
        self.collectionView.mj_header.ignoredScrollViewContentInsetTop = KIsiPhoneX ?  -20 : 0;
    }
    
    [self loadData];
}

-(void)loadData {
  
    [network httpGETRequestTagWithParameter:nil method:ClassroomStudyUrl tag:IH_init success:^(NSDictionary *dic) {
        ClassroomModel *model = [[ClassroomModel alloc] initWithDictionary:dic[@"content"] error:nil];
        self->ClassMode = model;
        [self->BannerArr removeAllObjects];
        [self->dataArr removeAllObjects];
        [self->classTitlesArr removeAllObjects];
        self->searchTextfiled.searchTextField.placeholder = model.keyWord;
        for (studyBannerListModel *Banmodel in model.studyBannerList) {
            [self->BannerArr addObject:Banmodel];
        }
        for (configClientItemListModel *Cmodel in model.configClientItemList) {
            [self->classTitlesArr addObject:Cmodel];
        }
        //
        if (model != nil) {
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *file = [path stringByAppendingPathComponent:@"ClassHomeList.data"];
            [NSKeyedArchiver archiveRootObject:dic[@"content"] toFile:file];
        }
        
        //缓存banner轮播数据
        if (model.studyBannerList != nil) {
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *file = [path stringByAppendingPathComponent:@"ClassRoomList.data"];
            [NSKeyedArchiver archiveRootObject:self->BannerArr toFile:file];
        }
        for (studyLableListModel *Smodel in model.studyLableList) {
            [self->dataArr addObject:Smodel];
        }
        [self->_collectionView reloadData];
        [self endcollectionViewRefresh];
    } failure:^(NSDictionary *obj2) {
        [self endcollectionViewRefresh];
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *file = [path stringByAppendingPathComponent:@"ClassHomeList.data"];
        //解档
        NSDictionary *mdict  = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
        if (mdict != nil) {
            [self->BannerArr removeAllObjects];
            [self->dataArr removeAllObjects];
            [self->classTitlesArr removeAllObjects];
            ClassroomModel *model = [[ClassroomModel alloc] initWithDictionary:mdict error:nil];
            self->ClassMode = model;
            for (studyBannerListModel *Banmodel in model.studyBannerList) {
                [self->BannerArr addObject:Banmodel];
            }
            for (configClientItemListModel *Cmodel in model.configClientItemList) {
                [self->classTitlesArr addObject:Cmodel];
            }
            
            for (studyLableListModel *Smodel in model.studyLableList) {
                [self->dataArr addObject:Smodel];
            }
            [self->_collectionView reloadData];
        }
    }];
    
}


-(void)loadRefesh:(MJRefreshComponent *)refreshView {

	[network httpGETRequestTagWithParameter:nil method:ClassroomStudyUrl tag:IH_init success:^(NSDictionary *dic) {
        ClassroomModel *model = [[ClassroomModel alloc] initWithDictionary:dic[@"content"] error:nil];
		self->ClassMode = model;
        if (refreshView == self->_collectionView.mj_header) {
            [self->BannerArr removeAllObjects];
            [self->dataArr removeAllObjects];
            [self->classTitlesArr removeAllObjects];
            self->searchTextfiled.searchTextField.placeholder = model.keyWord;
            for (studyBannerListModel *Banmodel in model.studyBannerList) {
                [self->BannerArr addObject:Banmodel];
            }
            for (configClientItemListModel *Cmodel in model.configClientItemList) {
                [self->classTitlesArr addObject:Cmodel];
            }
            
            NSInteger num = self->classTitlesArr.count / [self->ClassMode.lineItemSum integerValue];
            if (num > 1) {
                 self->showNaHeight = kWidth(287) + 60 * num + (num - 1) * 10;
            }else {
                 self->showNaHeight = kWidth(287) + 60;
            }
//
            if (dic[@"content"] != nil) {
                NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *file = [path stringByAppendingPathComponent:@"ClassHomeList.data"];
                [NSKeyedArchiver archiveRootObject:dic[@"content"] toFile:file];
            }
            
            //缓存banner轮播数据
            if (model.studyBannerList != nil) {
                NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *file = [path stringByAppendingPathComponent:@"ClassRoomList.data"];
                [NSKeyedArchiver archiveRootObject:self->BannerArr toFile:file];
            }
            [self endcollectionViewRefresh];
            [self->_collectionView.mj_footer resetNoMoreData];
        }else {
            [self->_collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        for (studyLableListModel *Smodel in model.studyLableList) {
            [self->dataArr addObject:Smodel];
        }
        [self->_collectionView reloadData];
        
    } failure:^(NSDictionary *obj2) {
        [self endcollectionViewRefresh];
       
    }];
    
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *flowlayout = [[ULBCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];        
        if (@available(iOS 11.0, *)) {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -KStatusBarHeight, iPhoneWidth, iPhoneHeight - KTabBarHeight + KStatusBarHeight) collectionViewLayout:flowlayout];
        } else {
             _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KTabBarHeight) collectionViewLayout:flowlayout];
        }
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor] ;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //注册Cell，必须要有
        [_collectionView registerClass:[ClassroomHeadViewCell class] forCellWithReuseIdentifier:ClassroomHeadViewCellID];
        [_collectionView registerClass:[ClassroomCollectionCell class] forCellWithReuseIdentifier:ClassroomCollectionCellID];
        [_collectionView registerClass:[ClassroomClassTitleViewCell class] forCellWithReuseIdentifier:ClassroomClassTitleViewCellID];
        [_collectionView registerClass:[ClassSourceReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ClassSourceReusableViewID];
    }
    return _collectionView;
}
#pragma mark - CollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return dataArr.count + 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return classTitlesArr.count;
    }else {
        studyLableListModel *model = dataArr[section - 2];
        return model.classList.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ClassroomHeadViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassroomHeadViewCellID forIndexPath:indexPath];
        [cell setUpSubViewSourde];
        cell.DicView.delegate = self;
        cell.backBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
        cell.searchBlock = ^{
            [self SerachAction];
        };
        return cell;
    }else if (indexPath.section == 1) {
        ClassroomClassTitleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassroomClassTitleViewCellID forIndexPath:indexPath];
        configClientItemListModel *model = classTitlesArr[indexPath.row];
        
        [cell setImageName:model.itemIcon andTitleStr:model.itemName];
        return cell;
    }else {
        ClassroomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassroomCollectionCellID forIndexPath:indexPath];
        studyLableListModel *model = dataArr[indexPath.section - 2];
        [cell setDataClassListModel:model.classList[indexPath.row]];
        return cell;
    }
}
//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(iPhoneWidth , kWidth(257) + KtopHeitht);
    }
    if (indexPath.section == 1) {
       return CGSizeMake(60, 60);
    }
    return CGSizeMake(kWidth(167), kWidth(186));
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0.f;
    }
    if (section == 1) {
       return (iPhoneWidth - kWidth(62) - ([ClassMode.lineItemSum intValue] *65))/([ClassMode.lineItemSum intValue] -1);
    }
    return kWidth(8);
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 10.f;
    }
    return kWidth(25);
}
//四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if (section == 1) {
        return UIEdgeInsetsMake(kWidth(15), kWidth(30), kWidth(15), kWidth(30));
    }
    return UIEdgeInsetsMake(kWidth(12), kWidth(13), kWidth(12), kWidth(13));
}
//分区头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section >= 2) {
        return CGSizeMake(0, 40);
    }
    return CGSizeMake(0, 0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ClassSourceReusableView *ClassView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ClassSourceReusableViewID forIndexPath:indexPath];
        if (indexPath.section >= 2) {
            studyLableListModel *model = dataArr[indexPath.section - 2];
            [ClassView setClassListModel:model];
            ClassView.moreClackBlock = ^{
                [self toMoreClassSource:indexPath.section];
            };
        }
        return ClassView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        configClientItemListModel *model = classTitlesArr[indexPath.row];
        if ([model.itemCode isEqualToString:@"1026"]) {
            NSLog(@"推荐讲师");
            RecommendTeacherController *TearcherVc = [[RecommendTeacherController alloc] init];
            [self pushViewController:TearcherVc];
        }else if ([model.itemCode isEqualToString:@"1028"]) {
            NSLog(@"线下活动");
            ActivityListViewController *actvitVC  = [[ActivityListViewController alloc] init];
            actvitVC.type =@"1";
            [self pushViewController:actvitVC];
        }else if ([model.itemCode isEqualToString:@"1029"]) {
            NSLog(@"讲师申请");
        }else if ([model.itemCode isEqualToString:@"1030"]) {
            if (!USERMODEL.isLogin) {
                [self prsentToLoginViewController];
                return ;
            }
            MyClassSourceController *myClassVc = [[MyClassSourceController alloc] init];
            [self pushViewController:myClassVc];
            NSLog(@"我的订购");
        }
    }
    if (indexPath.section > 1) {
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        studyLableListModel *model = dataArr[indexPath.section - 2];
        studyBannerListModel *Dmodel = model.classList[indexPath.row];
        ClassSourdeDetailController *DetailVc = [[ClassSourdeDetailController alloc] init];
        DetailVc.model = Dmodel;
        [self pushViewController:DetailVc];
    }
}

#pragma - mark ScrollviewDelegate
//*
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    if (scrollView.contentOffset.y >= showNaHeight) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationController.navigationBar.alpha = 1.;
    }else {
        if (scrollView.contentOffset.y > KtopHeitht) {
            [self setNavigationRithtSharItem];
            self.navigationController.navigationBar.hidden = NO;
//            leftbutton.hidden = NO;
            self.navigationController.navigationBar.alpha =  scrollView.contentOffset.y / (showNaHeight);
            
        }else {
            self.navigationController.navigationBar.hidden = YES;
            self.navigationController.navigationBar.alpha = 0;
            leftbutton.hidden = YES;
        }
    }
 
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
 
    
}
//*/
- (void) setNavigationRithtSharItem {
    
    UIImage *shareImg=Image(@"icon_fx");
    moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(0, 0, 40, 40);
    [moreBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:shareImg forState:UIControlStateNormal];
    moreBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);
    
    Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 44)];
    Titlelabel.textAlignment = NSTextAlignmentCenter;
    Titlelabel.text = @"青蛙园艺学院";
    Titlelabel.font = sysFont(16);
    
     [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
     [leftbutton setImage:kImage(@"iconfont-fanhui.png") forState:UIControlStateNormal];
    


    self.navigationItem.titleView = Titlelabel;
    
    UIBarButtonItem *barMoreBtn=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItems= @[barMoreBtn];
}


#pragma - mark ULBCollectionViewDelegateFlowLayout
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section {
    if (section == 0 || section == 1) {
        return [UIColor whiteColor];
    }
    return [UIColor clearColor];
}

#pragma - mark 点击搜索代理
- (void)SerachAction {
    ClassroomSearchController *searchVc = [[ClassroomSearchController alloc] init];
    searchVc.Model = ClassMode;
    
    [self pushViewController:searchVc];
   
}
#pragma - mark pusVc
- (void) pushViewController:(UIViewController *)Vc {
    [self endcollectionViewRefresh];
    [self performSelector:@selector(pushViewVc:) withObject:Vc afterDelay:0.01];
}
- (void) pushViewVc:(UIViewController *)Vc {
    [self.navigationController pushViewController:Vc animated:YES];
}
#pragma - mark 查看更多
- (void) toMoreClassSource:(NSInteger ) index {
    studyLableListModel *model = dataArr[index-2];
    if (model.classList.count < 4) {
        return;
    }
    ClassSourceListController *moreVc = [[ClassSourceListController alloc] init];
    moreVc.HomoemoreModel = model;
    [self pushViewController:moreVc];
}

#pragma mark - 滚动视图代理SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    studyBannerListModel *mode = BannerArr[index];
    ClassSourdeDetailController *DetailVc = [[ClassSourdeDetailController alloc] init];
    if ([mode.banner_tiao isEqualToString:@"1"]) {
        DetailVc.model = mode;
        [self pushViewController:DetailVc];
    }
   
}

#pragma - mark 分享
- (void) shareAction {
    NSString *ClassHomePath = [NSString stringWithFormat:@"pages/index/main?0&%@",@"1"];
    NSDictionary *dict = @{
                           @"appid"     :WXKTXappId,
                           @"appsecret" :WXKTXappSecret,
                           @"type"      :@"1",
                           @"path"      :ClassHomePath,
                           };
    [self shareSmallProgramCodeOject:dict httpMethod:0 methoe:ClassSourceShareUrl Vc:self completion:^(id data, NSError *error) {
        NSLog(@"完成分享");
    }];
//     NSLog(@"分享 ====== ");
}
@end
