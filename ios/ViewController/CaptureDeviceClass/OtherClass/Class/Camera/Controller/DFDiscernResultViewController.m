//
//  DFDiscernResultViewController.m
//  DF
//
//  Created by Tata on 2017/11/23.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFConstant.h"
#import "DFIconConstant.h"
#import "DFCustomShareView.h"
#import "DFDiscernResultViewController.h"
#import "DFDiscernWaitingView.h"
#import "DFDiscernFailureView.h"
#import "DFDiscernSuccessView.h"
#import "DFDiscernResultView.h"
#import "DFSuccessCollectionViewCell.h"
#import "DFDiscernFlowerModel.h"
#import "DFCreatPhotosViewController.h"
#import "DFFlowerDetailViewController.h"
#import "DFDiscernListViewController.h"
//#import "MRLineLayout.h"
#import "DFIdentifierConstant.h"
#import "MTLoginViewController.h"
#import "THModalNavigationController.h"

@interface DFDiscernResultViewController () <DFDiscernFailureDelegate, DFDiscernSuccessDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DFShareViewDelegate, DFSuccessCollectionViewDelegate>

@property (nonatomic, strong) DFNavigationView *navigationView;
@property (nonatomic, strong) DFDiscernResultView *resultView;
@property (nonatomic, strong) DFDiscernWaitingView *waitingView;
@property (nonatomic, strong) DFDiscernSuccessView *successView;
@property (nonatomic, strong) DFDiscernFailureView *failureView;

@property (nonatomic, strong) DFShareView *shareView;
@property (nonatomic, strong) DFCustomShareView *customShareView;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, assign) CGFloat dragStartX;
@property (nonatomic, assign) CGFloat dragEndX;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation DFDiscernResultViewController

- (NSMutableArray *)listArray {
    
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(indexPathOfCurrentLayoutAttributeAtCenter:) name:DiscernSuccessListScrollIdentifier object:nil];
    
    [self configureView];
    
    [self discernImage];
    
}

- (DFDiscernResultView *)resultView {
    return (DFDiscernResultView *)self.view;
}

#pragma mark - 配置页面
- (void)configureView {
    
    DFDiscernResultView *resultView = [[DFDiscernResultView alloc]init];
    self.view = resultView;
    
    DFNavigationView *navigationView = self.resultView.navigationView;
    self.navigationView = navigationView;
    [navigationView.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView.forwardButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    navigationView.forwardButton.hidden = YES;
    
    resultView.imageView.image = self.bigImage;
    
    self.waitingView = resultView.waitingView;
    self.successView = resultView.successView;
    self.failureView = resultView.failureView;
    
    self.failureView.delegate = self;
    self.failureView.hidden = YES;
    
    self.successView.delegate = self;
    self.successView.hidden = YES;
    self.successView.collectionView.delegate = self;
    self.successView.collectionView.dataSource = self;
    self.successView.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.successView.collectionView registerClass:[DFSuccessCollectionViewCell class] forCellWithReuseIdentifier:DFDiscernSuccessCellIdentifier];
    [UIView animateWithDuration:2.0 animations:^{
        self.resultView.maskView.frame = CGRectMake(iPhoneWidth - 3 * TTUIScale(), 0, 3 * TTUIScale(), kWidth(249));
    }];
    TTDispatchAsync(^{
        for (int i = 0; i < 100; i ++) {
            [NSThread sleepForTimeInterval:0.01];
            TTDispatchMainSync(^{
                self.waitingView.precent = [NSString stringWithFormat:@"努力鉴定中%d%%",i];
            });
        }
    });
}

#pragma mark - 获取识花结果
- (void)discernImage {
    NSData *data = [UIImage compressImage:self.bigImage toMaxLength:1000*150 maxWidth:iPhoneWidth];
    UIImage *miniImage = [UIImage imageWithData:data];
    NSString *base64String = [miniImage base64String];
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)base64String,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    
    [HttpRequest getDiscernPhotoInfoWith:encodedString cameraType:self.cameraType success:^(NSDictionary *result) {
        
        self.waitingView.hidden = YES;
        self.resultView.maskView.hidden = YES;
        self.navigationView.forwardButton.hidden = NO;
        
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            
            NSArray *array = result[DFData];
            if (TTValidateArray(array) && array.count != 0) {
                for (NSDictionary *dictionary in array) {
                    DFDiscernFlowerModel *model = [DFDiscernFlowerModel mj_objectWithKeyValues:dictionary];
                    [self.listArray addObject:model];
                }
                DFDiscernFlowerModel *model = [self.listArray firstObject];
                
                self.successView.flowerNameLabel.text = model.Name;
                self.successView.flowerDiscribeLabel.text = model.LatinName;
//                NSDictionary *dict = model.iOSLocation;

                self.successView.hidden = NO;
                self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                [self.successView.collectionView reloadData];
            }else {
                 self.failureView.hidden = NO;
            }
            
        }else {
            self.failureView.hidden = NO;
        }
    } failure:^(NSError *error) {
        self.waitingView.hidden = YES;
        self.resultView.maskView.hidden = YES;
        self.navigationView.forwardButton.hidden = NO;
        self.failureView.hidden = NO;
    }];
}

#pragma mark - 拍个植物试试 (DFDiscernFailureDelegate)
- (void)retakePhotos {
    [self backAction];
}

#pragma mark - 生成美图 (DFDiscernSuccessDelegate)
- (void)creatPhoto {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tinghua://"]];
    
    DFDiscernFlowerModel *model = self.listArray[self.currentIndexPath.item];
    DFCreatPhotosViewController *creatPhotosVC = [[DFCreatPhotosViewController alloc]init];
    creatPhotosVC.imageId = model.Id;
    [self.navigationController pushViewController:creatPhotosVC animated:YES];
}



#pragma mark - 分享识花结果
- (void)shareResult {
     DFDiscernFlowerModel *model = self.listArray[self.currentIndexPath.item];
    if (model.HtmlUrl) {
        if (!self.customShareView) {
            self.customShareView = [[DFCustomShareView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            self.customShareView.shareView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:self.customShareView];
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.customShareView.hidden = NO;
            self.customShareView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        }];
    }
}

#pragma mark --分享点击处理--
- (void)shareViewTypeWith:(NSInteger)index {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.customShareView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    }completion:^(BOOL finished) {
        self.customShareView.hidden = YES;
    }];
    
    DFDiscernFlowerModel *model = self.listArray[self.currentIndexPath.item];
    NSString *title = model.ShareTitle;
    NSString *content = model.ShareTitleSub;
    NSString *urlImage = model.ShareImgUrl;
    NSString *contentUrl = model.HtmlUrl;
//    NSString *shareType = TTSelectShareType(index - 1);
    [IHUtility SharePingTai:title url:contentUrl imgUrl:urlImage content:content PlatformType:index controller:self completion:nil];
/*/
    [DFTool shareWXWithTitle:title andContent:content andContentURL:contentUrl andUrlImage:urlImage andPresentedController:self withType:@[shareType] result:^(UMSocialResponseEntity *shareResponse) {
        
        [self.customShareView hideCustomShareView];
        
    }];
//*/
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

//- (void)loginSuccess {
  //  [self loginDiscernFlower];
//}

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
    DFDiscernFlowerModel *model = [self.listArray firstObject];
    NSString *guid = model.Id;
    [DFTool addWaitingView:self.view];
    
    [HttpRequest postMasterDiscernWith:guid  success:^(NSDictionary *result) {
        [DFTool removeWaitingView:self.view];
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            
            if (TTValidateBOOL(result[DFData])) {
                
                DFDiscernListViewController *listVC = [[DFDiscernListViewController alloc]init];
                listVC.isMyDiscern = YES;
                [self.navigationController pushViewController:listVC animated:YES];
            }
        }
        
    } failure:^(NSError *error) {
        [DFTool removeWaitingView:self.view];
    }];


}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DFSuccessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DFDiscernSuccessCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.item < self.listArray.count) {
        DFDiscernFlowerModel *model = self.listArray[indexPath.item];
        [cell.flowerIcon setImageWithURL:[NSURL URLWithString:model.ImageUrl] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        cell.roundIcon.image = kImage(RoundIconBlack);
        cell.checkButton.hidden = NO;
    }else {
        cell.flowerIcon.image = kImage(FalseIcon);
        cell.roundIcon.image = kImage(RoundIcon);
        cell.checkButton.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.listArray.count) {
        return;
    }
    DFDiscernFlowerModel *model = self.listArray[indexPath.item];
    DFFlowerDetailViewController *detailVC = [[DFFlowerDetailViewController alloc]init];
    detailVC.flowerModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)indexPathOfCurrentLayoutAttributeAtCenter:(NSNotification *)notification {
    NSIndexPath *indexPath = (NSIndexPath *)notification.object;
    self.currentIndexPath = indexPath;
    [self setDiscernResultWith:self.currentIndexPath.item];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - 切换花后刷新识花信息
- (void)setDiscernResultWith:(NSInteger)index {
    
    BOOL isLast = (index == self.listArray.count);
    self.successView.creatPhotoButton.hidden = isLast;
    self.successView.shareResultButton.hidden = isLast;
    self.successView.masterDiscernButton.hidden = !isLast;
    
    self.successView.flowerNameLabel.hidden = isLast;
    self.successView.flowerDiscribeLabel.hidden = isLast;
    
    
    if (!isLast) {
        if (index >= self.listArray.count) {
            return;
        }
        DFDiscernFlowerModel *model = self.listArray[index];
        self.successView.flowerNameLabel.text = model.Name;
        self.successView.flowerDiscribeLabel.text = model.LatinName;
    }
}

#pragma mark - 查看详情
- (void)checkDetail {
    DFDiscernFlowerModel *model = self.listArray[self.currentIndexPath.item];
    DFFlowerDetailViewController *detailVC = [[DFFlowerDetailViewController alloc]init];
    detailVC.flowerModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 返回
- (void)backAction {
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
