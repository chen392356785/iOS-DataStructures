//
//  showImageController.m
//  HZOA
//
//  Created by huizhi01 on 17/1/18.
//  Copyright © 2017年 hz_02. All rights reserved.
//

#import "showImageController.h"
#import "ShowImaewCell.h"
//#import "NewVarietyPicModel.h"
#import <Photos/Photos.h>

//#import<AVFoundation/AVCaptureDevice.h>
//#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
//#import<CoreLocation/CoreLocation.h>


#define KBounds         [UIScreen mainScreen].bounds
#define KScreenWidth    [UIScreen mainScreen].bounds.size.width
#define KScreenHeight   [UIScreen mainScreen].bounds.size.height
@interface showImageController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate> {
    NSMutableArray      *ImageArr;
    UICollectionView    *_collectionView;
    NSInteger           _index;
    
    UILabel *titleLabel;
}
@end

static NSString *cellIdentifier = @"ImageBrowserCells";

@implementation showImageController

- (instancetype)initWithSourceArr:(NSMutableArray *)sourceArr index:(NSInteger) index {
    if (self = [super init]) {
        ImageArr = [[NSMutableArray alloc] initWithArray:sourceArr];
        _index   = index;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configCollectionView];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    titleLabel.text = [NSString stringWithFormat:@"%ld",_index+1];
    if (_model != nil) {
        [self addDataSource];
    }
}
- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
}
- (void) viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(KScreenWidth, KScreenHeight - 64);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.backgroundColor = [UIColor blackColor];
    
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(0, 64);
    _collectionView.contentSize = CGSizeMake(KScreenWidth * ImageArr.count, KScreenHeight);
    //注册cell类型及复用标识
    [_collectionView registerClass:[ShowImaewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    [_collectionView setContentOffset:CGPointMake((KScreenWidth) * _index, 0) animated:NO];
    [self.view addSubview:_collectionView];
    
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 40, 40);
    [self.view addSubview:button];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = sysFont(18);
    [button addTarget:self action:@selector(saveImageAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item3  = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *nagativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    nagativeSpacer.width = 15;
    
    self.navigationItem.rightBarButtonItems = @[nagativeSpacer,item3];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ImageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    ShowImaewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    nurseryNewDetailListModel *model = ImageArr[indexPath.row];
    NSString *imageUrl;
    if (![model.showPic hasPrefix:@"http"]) {
         imageUrl = [NSString stringWithFormat:@"%@/%@",ConfigManager.ImageUrl,model.showPic];
    }else {
         imageUrl = model.showPic;
    }
    [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:DefaultImage_logo];
    
    [cell setImageModel:model];
    if (!cell.singleTapGestureBlock) {      //单击回调
        cell.singleTapGestureBlock = ^(){
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    __strong typeof (cell) weakCell = cell;
    if (!cell.longGestureBlock) {
        cell.longGestureBlock = ^(){
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success == YES) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self useThisImageWith:weakCell.showImageView.image];
                    });
                }
            }];
            
            
        };
    }
    return cell;
}

//长按回调
- (void)useThisImageWith:(UIImage *)image {
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];
    if ([activityViewController respondsToSelector:@selector(popoverPresentationController)]) {
        activityViewController.popoverPresentationController.sourceView = self.view;
    }
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint orifinalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    _index = orifinalTargetContentOffset.x/iPhoneWidth;
    if (_index == ImageArr.count - 1) {
        [self showTextHUD:@"已经是最后一张"];
    }else if (_index == 0) {
        [self showTextHUD:@"已经是第一张哦"];
    }
   titleLabel.text = [NSString stringWithFormat:@"(%ld/%ld)",_index+1,ImageArr.count];
//    imageModel *model = ImageArr[index];
//    self.title = model.imageName;
    //计算出想要其停止的位置
}

#pragma mark - 判断软件是否有相册、相机访问权限
- (BOOL)judgeIsHavePhotoAblumAuthority
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}
- (void) saveImageAction:(UIButton *)but {
    //相册权限
    
//    sourceType = UIImagePickerControllerSourceTypePhotoLibrary
//    ShowImaewCell *cell = (ShowImaewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:0]];
//    UIImage *image = cell.showImageView.image;
	
    
    ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied) {
        //无权限
        dispatch_async(dispatch_get_main_queue(), ^{
            [IHUtility AlertMessage:@"提示" message:@"相册权限被禁用，请到设置中开启允许访问相册权限" delegate:self cancelButtonTitle:@"去设置" otherButtonTitles:@"取消" tag:2010];
        });
    }else {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == YES) {
                [self addSucessView:@"保存成功！" type:1];
            }else{
                
            }
        }];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==2010) {
        if (buttonIndex==0){
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
                //无权限 引导去开启
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    //如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
           
        }
    }
}



- (void) addDataSource{
    NSDictionary *dic = @{
                          @"page":@"0",
                          @"num":@"1000",
                          @"nursery_type_id":self.model.nursery_type_id,
                          };
    [network httpRequestWithParameter:dic method:NewDetailMoreUrl success:^(NSDictionary *dic) {
		[self->ImageArr removeAllObjects];
        NSArray* array = [dic objectForKey:@"content"];
        for (NSDictionary *dict in array) {
            nurseryNewDetailListModel *model = [[nurseryNewDetailListModel alloc] initWithDictionary:dict error:nil];
			[self->ImageArr addObject:model];
        }
		[self->_collectionView reloadData];
    } failure:^(NSDictionary *dic) {
       
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
