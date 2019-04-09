//
//  DFCreatPhotosViewController.m
//  DF
//
//  Created by Tata on 2017/11/29.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFConstant.h"
#import "DFCustomShareView.h"
#import "DFCreatPhotosViewController.h"
#import "DFCreatPhotosView.h"
#import "DFCreatPhotosCell.h"
#import "DFPhotosModel.h"
#import "DFIdentifierConstant.h"
#import <Photos/PHPhotoLibrary.h>

@interface DFCreatPhotosViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIActionSheetDelegate, DFShareViewDelegate, TFShowEmptyViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) DFCreatPhotosView *creatPhotosView;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) DFShareView *shareView;
@property (nonatomic, strong) DFCustomShareView *customShareView;
@property (nonatomic, strong) DFNavigationView *navigationView;

@property (nonatomic,strong) UIActivityIndicatorView * myActivityIndicatorView;

@end

@implementation DFCreatPhotosViewController

- (NSMutableArray *)listArray {
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
    
    [self getPhotosData];
}

- (DFCreatPhotosView *)creatPhotosView {
    return (DFCreatPhotosView *)self.view;
}

#pragma mark - 配置页面
- (void)configureView {
    DFCreatPhotosView *creatPhotosView = [[DFCreatPhotosView alloc]init];
    self.creatPhotosView = creatPhotosView;
    self.view = creatPhotosView;
    
    DFNavigationView *navigationView = creatPhotosView.navigationView;
    self.navigationView = navigationView;
    [navigationView.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView.forwardButton addTarget:self action:@selector(downloadPhotos) forControlEvents:UIControlEventTouchUpInside];
    navigationView.forwardButton.hidden = YES;
    
    creatPhotosView.webView.opaque = NO;
    [creatPhotosView.webView setScalesPageToFit:NO];
    creatPhotosView.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    creatPhotosView.webView.delegate = self;
    UIActivityIndicatorView *myActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((iPhoneWidth - 50 * TTUIScale()) / 2, (iPhoneHeight - 170 * TTUIScale()) / 2, 50 * TTUIScale(), 50 * TTUIScale())];
    self.myActivityIndicatorView = myActivityIndicatorView;
    [myActivityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [creatPhotosView.webView addSubview:myActivityIndicatorView];
    
    creatPhotosView.collectionView.delegate = self;
    creatPhotosView.collectionView.dataSource = self;
    [creatPhotosView.collectionView registerClass:[DFCreatPhotosCell class] forCellWithReuseIdentifier:DFCreatPhotosCellIdentifier];
    
    self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [creatPhotosView.collectionView reloadData];
    
    [creatPhotosView.shareButton addTarget:self action:@selector(sharePhotos) forControlEvents:UIControlEventTouchUpInside];
    creatPhotosView.shareButton.hidden = YES;
    creatPhotosView.collectionView.hidden = YES;
}

#pragma mark - 获取美图信息
- (void)getPhotosData {
    
    [DFTool addWaitingView:self.view];
    [HttpRequest getPhotosWith:self.imageId success:^(NSDictionary *result) {
        [DFTool removeWaitingView:self.view];
        
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            NSArray *array = result[DFData];
            if (TTValidateArray(array)) {
                for (NSDictionary *dictionary in array) {
                    DFPhotosModel *model = [DFPhotosModel mj_objectWithKeyValues:dictionary];
                    [self.listArray addObject:model];
                }
            }
            self.creatPhotosView.shareButton.hidden = NO;
            self.creatPhotosView.collectionView.hidden = NO;
            self.navigationView.forwardButton.hidden = NO;
            [self.creatPhotosView.collectionView reloadData];
            
            DFPhotosModel *model = self.listArray[self.currentIndexPath.item];
            [self.creatPhotosView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.linkUrl]]];
        }
    } failure:^(NSError *error) {
        [DFTool removeWaitingView:self.view];
        
        if (error.code == NSURLErrorCannotConnectToHost||error.code == NSURLErrorNotConnectedToInternet)
        {
            self.emptyDataView.delegate = self;
            [self.view addSubview:self.emptyDataView];
        }
        else if(error.code == 3840) {    //服务器返回格式问题
            
            self.emptyTimeOutDataView.delegate = self;
            [self.view addSubview:self.emptyTimeOutDataView];
            
        }
        else if(error.code == NSURLErrorTimedOut)
        {
            self.emptyTimeOutDataView.delegate = self;
            [self.view addSubview:self.emptyTimeOutDataView];
        }
    }];
}

#pragma mark --点击重试处理(TFShowEmptyViewDelegate)--
- (void)showEmptyViewFinished {
    
    if (self.emptyDataView) {
        
        [self.emptyDataView removeFromSuperview];
    }
    
    if (self.emptyTimeOutDataView) {
        [self.emptyTimeOutDataView removeFromSuperview];
    }
    
    __weak typeof(self)weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        [weakSelf getPhotosData];
    });
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.myActivityIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.myActivityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.myActivityIndicatorView stopAnimating];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFCreatPhotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DFCreatPhotosCellIdentifier forIndexPath:indexPath];
    DFPhotosModel *model = self.listArray[indexPath.item];
    cell.selectStatus = (self.currentIndexPath.item == indexPath.item);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.TemplateUrl]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndexPath.item == indexPath.item) {
        return;
    }
    
    DFPhotosModel *model = self.listArray[indexPath.item];
    [self.creatPhotosView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.linkUrl]]];
    
    NSIndexPath *lastIndexPath = self.currentIndexPath;
    self.currentIndexPath = indexPath;
    [self.creatPhotosView.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.creatPhotosView.collectionView reloadItemsAtIndexPaths:@[lastIndexPath, indexPath]];
    
}

- (UIImage *)cutOutImageWithWebView {
    UIImage* image = nil;
    //保存现在的位置和尺寸
    CGPoint savedContentOffset = self.creatPhotosView.webView.scrollView.contentOffset;
    CGRect savedFrame = self.creatPhotosView.webView.frame;
    CGSize saveContentSize = self.creatPhotosView.webView.scrollView.contentSize;
    //设置尺寸和内容一样大
    self.creatPhotosView.webView.scrollView.contentOffset = CGPointZero;
    self.creatPhotosView.webView.frame = CGRectMake(0, 0, saveContentSize.width, saveContentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(self.creatPhotosView.webView.size, NO, [UIScreen mainScreen].scale);
    [self.creatPhotosView.webView.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //恢复原来的位置和尺寸
    self.creatPhotosView.webView.scrollView.contentOffset = savedContentOffset;
    self.creatPhotosView.webView.frame = savedFrame;
    
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - 下载图片
- (void)downloadPhotos {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            TTDispatchMainAsync(^{
                [self loadImageFinished:[self cutOutImageWithWebView]];
            });
        }else{
            TTDispatchMainAsync(^{
                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"点击设置，允许花眼访问你的相册" message:@"没有访问相册的权限" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                    UIApplication *app = [UIApplication sharedApplication];
//                    NSString *itunesurl = @"App-Prefs:root=com.discernflower.tinghua";
                    
//                    NSURL *url = [NSURL URLWithString:itunesurl];
//                    if ([app canOpenURL:url]) {
//                        [app openURL:url];
//                    }
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        //如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
                        [[UIApplication sharedApplication] openURL:url];
                    }
                    
                }];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
    }];
}

- (void)loadImageFinished:(UIImage *)image {
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error != NULL){
        msg = DFSaveFailureString();
    }else{
        msg = DFSaveSuccessString();
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:DFLetterString() message:msg delegate:self cancelButtonTitle:DFSureString() otherButtonTitles:nil];
    [alert show];
}

#pragma mark - 分享识花结果
- (void)sharePhotos {
    DFPhotosModel *model = self.listArray[self.currentIndexPath.item];
    if (model.linkUrl.length != 0) {
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
    
    [IHUtility ShareImage:[self cutOutImageWithWebView] PlatformType:index controller:self];
    
//     NSString *shareType = TTSelectShareType(index - 1);
/*/==HYFX
    [DFTool shareImageWith:[self cutOutImageWithWebView] andPresentedController:self withType:shareType result:^(UMSocialResponseEntity *shareResponse) {
        [self.customShareView hideCustomShareView];
    }];
//*/
}

#pragma mark - 返回
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
