//
//  MyReleasePicViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/28.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyReleasePicViewController.h"
#import "ULBCollectionViewFlowLayout.h"     //分区背景色
#import "XHFriendlyLoadingView.h"
//#import "MTSearchView.h"
#import "NewVarietyPicViewCell.h"
//#import "NewVarietyPicModel.h"
//#import "newVarietypicHeadView.h"

#import "showImageController.h"


@interface MyReleasePicViewController () <UICollectionViewDelegate,UICollectionViewDataSource> {
    NSMutableArray *dataArr;
    NSInteger page;
    EmptyPromptView *_EPView;//没有搜索内容时候默认的提示
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *NewVarietyPicCellID  = @"NewVarietyPicViewCell";


@implementation MyReleasePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [[NSMutableArray alloc] init];
    __weak MyReleasePicViewController *weakSelf=self;
    [self CreateCollectionViewRefesh:self.collectionView type:(ENT_RefreshAll) successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:self.collectionView];
    [self begincollectionViewRefesh:ENT_RefreshHeader];
//    [self beginRefesh:ENT_RefreshHeader];
    _EPView  = [[EmptyPromptView alloc] initWithFrame:self.collectionView.frame context:@"您还没有发布过新品种哦~"];
    
    _EPView.hidden = NO;
    [self.collectionView addSubview:_EPView];
   
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView == _collectionView.mj_header) {
        page=0;
    }
    NSDictionary *dict = @{
                           @"page"    :stringFormatInt(page),
                           @"num"     :@"10",
                           @"user_id" :USERMODEL.userID,
                           };
    [network httpRequestWithParameter:dict method:MyNurseryUrl success:^(NSDictionary *dic) {
        NSArray* testArr = [dic objectForKey:@"content"];
        NSMutableArray * arr= [[NSMutableArray alloc] init];
        for (NSDictionary *dict in testArr) {
            nurseryNewDetailListModel *model = [[nurseryNewDetailListModel alloc] initWithDictionary:dict error:nil];
            [arr addObject:model];
        }
       
        if (refreshView==self->_collectionView.mj_header) {
            
            [self->dataArr removeAllObjects];
            self->page=0;
            if (arr.count==0) {
                [self->_collectionView reloadData];
            }
            [self->_collectionView.mj_footer resetNoMoreData];
        }
        
        if (arr.count>0) {
            self->page++;
            if (arr.count<pageNum) {
                [self->_collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self->_collectionView.mj_footer endRefreshingWithNoMoreData];
             [self endcollectionViewRefresh];
            if (self->dataArr.count == 0) {
                
                self->_EPView.hidden = NO;
            }else{
                self->_EPView.hidden = YES;
            }
            
            return;
        }
        
        [self->dataArr addObjectsFromArray:arr];
        [self->_collectionView reloadData];
        if (self->dataArr.count == 0) {
            self->_EPView.hidden = NO;
        }else{
            self->_EPView.hidden = YES;
        }
        [self endcollectionViewRefresh];
    } failure:^(NSDictionary *obj2) {
        [self endcollectionViewRefresh];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *flowlayout = [[ULBCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, iPhoneWidth, iPhoneHeight - KtopHeitht - 50) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor] ;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //注册Cell，必须要有
        [_collectionView registerClass:[NewVarietyPicViewCell class] forCellWithReuseIdentifier:NewVarietyPicCellID];
    }
    return _collectionView;
}


- (void) createCollectionView{
    [self.view addSubview:self.collectionView];
    
    _EPView = [[EmptyPromptView alloc] initWithFrame:_collectionView.frame context:@"还没有人发布该品种哦"];
    _EPView.hidden = YES;
    [_collectionView addSubview:_EPView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewVarietyPicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NewVarietyPicCellID forIndexPath:indexPath];
    nurseryNewDetailListModel *mocel = dataArr[indexPath.row];
    [cell setConternImag:mocel];
    return cell;
}
//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((iPhoneWidth - kWidth(35))/2, 240);
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 14;
}
//四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(21, 12, 0, 12);
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    showImageController *showImagVc = [[showImageController alloc] initWithSourceArr:dataArr index:indexPath.row];
    showImagVc.CompressImage = dataArr;
    [self.inviteParentController pushViewController:showImagVc];
}

@end

