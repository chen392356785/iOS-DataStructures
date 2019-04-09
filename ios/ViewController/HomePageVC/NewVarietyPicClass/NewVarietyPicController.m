//
//  NewVarietyPicController.m
//  MiaoTuProjectTests
//
//  Created by Tomorrow on 2018/7/30.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "NewVarietyPicController.h"
#import "ULBCollectionViewFlowLayout.h"     //分区背景色
#import "XHFriendlyLoadingView.h"   
#import "MTSearchView.h"
#import "NewVarietyPicViewCell.h"
//#import "NewVarietyPicModel.h"
#import "newVarietypicHeadView.h"
#import "NewVarietyMoreController.h"

#import "showImageController.h"
#import "ReleaseNewVarietyController.h"     //发布新品种

@interface NewVarietyPicController () <UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource> {
    NSMutableArray *dataArr;
    BOOL isSearStatu;
    EmptyPromptView *_EPView;//没有搜索内容时候默认的提示
    UIButton *_createXPZBtn;     //发布新品种事件
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MTSearchView *searchBar;
@end

static NSString *NewVarietyPicCellID  = @"NewVarietyPicViewCell";
static NSString *NoNewVarietyPicCellID  = @"NONewVarietyPicViewCell";
static NSString *newVarietypicHeadID  = @"newVarietypicHeadViewId";


@implementation NewVarietyPicController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *bgImage = [[UIImage imageNamed:@"biejing"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *flowlayout = [[ULBCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor] ;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //注册Cell，必须要有
         [_collectionView registerClass:[NewVarietyPicViewCell class] forCellWithReuseIdentifier:NewVarietyPicCellID];
        [_collectionView registerClass:[NewVarietyPicViewCell class] forCellWithReuseIdentifier:NoNewVarietyPicCellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader"];
        [_collectionView registerClass:[newVarietypicHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:newVarietypicHeadID];
        
    }
    return _collectionView;
}
- (void) updataNewVarietyPic{
    
    if (isSearStatu == YES) {
        [self endcollectionViewRefresh];
        return;
    }
    
    _EPView.hidden = YES;
    [dataArr removeAllObjects];
    [_collectionView reloadData];
    [network httpRequestWithParameter:nil method:NewVarietyPicUrl success:^(NSDictionary *dic) {
        [self endcollectionViewRefresh];
        NewVarietyPicConModel *ContentModel = [[NewVarietyPicConModel alloc] initWithDictionary:dic error:nil];
        for (NewVarietyPicConModel *model in ContentModel.content) {
            [self->dataArr addObject:model];
        }
        [self->_collectionView reloadData];
    } failure:^(NSDictionary *dic) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isSearStatu = NO;
    [self setNavigationBar];
    dataArr = [[NSMutableArray alloc] init];
     [self createCollectionView];
     [self addPushViewWaitingView];
    [self createfabuBut];
    [network httpRequestWithParameter:nil method:NewVarietyPicUrl success:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
        NewVarietyPicConModel *ContentModel = [[NewVarietyPicConModel alloc] initWithDictionary:dic error:nil];
        for (NewVarietyPicConModel *model in ContentModel.content) {
            [self->dataArr addObject:model];
        }
        [self->_collectionView reloadData];
    } failure:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v = (XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
    
}

#pragma mark - 添加发布新品种购事件
- (void) createfabuBut {
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createBtn.frame=CGRectMake(WindowWith-kWidth(70), iPhoneHeight - KtopHeitht - 100, kWidth(54), kWidth(54)) ;
    [createBtn setTitle:@"发布\n新品种" forState:UIControlStateNormal];
    createBtn.titleLabel.numberOfLines = 0;
    createBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createBtn addTarget:self action:@selector(releaseXinPinZAction:) forControlEvents:UIControlEventTouchUpInside];
    _createXPZBtn=createBtn;
    [createBtn setLayerMasksCornerRadius:createBtn.height/2. BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(14);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:createBtn];

}
- (void) releaseXinPinZAction:(UIButton *) but {
//    self setTabBarHidden
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    ReleaseNewVarietyController *vc = [[ReleaseNewVarietyController alloc] init];
    [self presentViewController:vc];
}
- (void) setNavigationBar {
    self.navigationItem.rightBarButtonItem = nil;
    leftbutton.frame=CGRectMake(0, 0, 24, 44);
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _searchBar = [[MTSearchView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - 50, 44)];
    _searchBar.searBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    __weak NewVarietyPicController* weakSelf=self;
    if (isSearStatu == NO) {
        [weakSelf.searchBar.searBut setTitle:@"搜索" forState:UIControlStateNormal];
    }else {
        [weakSelf.searchBar.searBut setTitle:@"取消" forState:UIControlStateNormal];
    }
    self.searchBar.searchBlock = ^{
		__strong typeof(weakSelf)strongSelf = weakSelf;
        NSLog(@"搜索");
        if ([strongSelf.searchBar.searBut.titleLabel.text isEqualToString:@"取消"]) {
            strongSelf->isSearStatu = NO;
            [strongSelf updataNewVarietyPic];
            [strongSelf.searchBar.searBar resignFirstResponder];
            strongSelf.searchBar.searBar.text = @"";
            [strongSelf.searchBar.searBut setTitle:@"搜索" forState:UIControlStateNormal];
        }else {
            strongSelf->isSearStatu = YES;
            [strongSelf.searchBar.searBar becomeFirstResponder];
            [strongSelf.searchBar.searBut setTitle:@"取消" forState:UIControlStateNormal];
        }
    };
    
}
- (void) createCollectionView{
	__weak typeof(self)weakSelf = self;
    [self CreateCollectionViewRefesh:self.collectionView type:(ENT_RefreshHeader) successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf updataNewVarietyPic];
    }];
   
    [self.view addSubview:self.collectionView];
    _EPView = [[EmptyPromptView alloc] initWithFrame:_collectionView.frame context:@"还没有人发布该品种哦"];
    _EPView.hidden = YES;
    [_collectionView addSubview:_EPView];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (isSearStatu == YES) {
        return 1;
    }
    return dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (isSearStatu == YES) {
        return dataArr.count;
    }
    if (isSearStatu == NO) {
         NewVarietyPicModel *model = dataArr[section];
        if (model.nurseryNewDetailList.count == 0) {
           return  1;
        }
    }
    NewVarietyPicModel *model = dataArr[section];
    return model.nurseryNewDetailList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewVarietyPicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NewVarietyPicCellID forIndexPath:indexPath];
    
    if (isSearStatu == YES) {
        nurseryNewDetailListModel *model = dataArr[indexPath.row];
        [cell setConternImag:model];
    }else {
        NewVarietyPicModel *mocel = dataArr[indexPath.section];
        if (mocel.nurseryNewDetailList.count == 0) {
            NewVarietyPicViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:NoNewVarietyPicCellID forIndexPath:indexPath];
            [cell2 setBackgNoContent];
            return cell2;
        }else {
            [cell setConternImag:mocel.nurseryNewDetailList[indexPath.row]];
        }
        
    }
    return cell;
}
//分区头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (isSearStatu == YES) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(0, 44);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            newVarietypicHeadView *DetailHeadView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:newVarietypicHeadID forIndexPath:indexPath];
            NewVarietyPicModel *model = dataArr[indexPath.section];
            [DetailHeadView setHeadViewNewVarietyPicModel:model];
        DetailHeadView.moreBlock = ^{
            NSLog(@"更多");
            NewVarietyMoreController *moreVc = [[NewVarietyMoreController alloc] init];
            moreVc.model = model;
            if (model.nurseryNewDetailList.count != 0) {
                [self pushViewController:moreVc];
            }
        };
            return DetailHeadView;
    }else {
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader" forIndexPath:indexPath];
    }
    
}

//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (isSearStatu == NO) {
        NewVarietyPicModel *model = dataArr[indexPath.section];
        if (model.nurseryNewDetailList.count == 0) {
            return CGSizeMake(iPhoneWidth, 120);
        }
    }
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
    if (isSearStatu == YES) {
        showImageController *showImagVc = [[showImageController alloc] initWithSourceArr:dataArr index:indexPath.row];
        showImagVc.CompressImage = dataArr;
        [self pushViewController:showImagVc];
    }else {
        NewVarietyPicModel *model = dataArr[indexPath.section];
        if (model.nurseryNewDetailList.count > 0) {
            showImageController *showImagVc = [[showImageController alloc] initWithSourceArr:model.nurseryNewDetailList index:indexPath.row];
            showImagVc.model = model;
            [self pushViewController:showImagVc];
        }
        
    }
}







#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"1");//输入文字时 一直监听
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self searchText:text];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"2");// 准备开始输入  文本字段将成为第一响应者
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"3");//文本彻底结束编辑时调用
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"4");//返回一个BOOL值，指定是否循序文本字段开始编辑
    isSearStatu = YES;
    [dataArr removeAllObjects];
    [_collectionView reloadData];
    [self searchText:textField.text];
    [self.searchBar.searBut setTitle:@"取消" forState:UIControlStateNormal];
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"5");// 点击‘x’清除按钮时 调用
    [self searchText:@""];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"6");//返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出第一响应者
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"7");// 点击键盘的‘换行’会调用
    [self searchText:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (void) searchText:(NSString *)text {
    NSDictionary *dic = @{
                          @"page":@"0",
                          @"num":@"1000",
                          @"plant_title":text,
                          };
    
    [network httpRequestWithParameter:dic method:NewVarietySearUrl success:^(NSDictionary *dic) {
        NSArray* array = [dic objectForKey:@"content"];
        if (self->isSearStatu == YES) {
            [self->dataArr removeAllObjects];
            for (NSDictionary *dict in array) {
                nurseryNewDetailListModel *model = [[nurseryNewDetailListModel alloc] initWithDictionary:dict error:nil];
                [self->dataArr addObject:model];
            }
            [self->_collectionView reloadData];
            if (self->dataArr.count > 0) {
                self->_EPView.hidden = YES;
            }else {
                self->_EPView.hidden = NO;
            }
        }
       
        
    } failure:^(NSDictionary *dic) {
        self->_EPView.hidden = YES;
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}

@end
