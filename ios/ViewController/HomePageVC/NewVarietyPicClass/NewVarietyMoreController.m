//
//  NewVarietyMoreController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/30.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "NewVarietyMoreController.h"
#import "ULBCollectionViewFlowLayout.h"     //分区背景色
#import "XHFriendlyLoadingView.h"
#import "MTSearchView.h"
#import "NewVarietyPicViewCell.h"
//#import "NewVarietyPicModel.h"
#import "newVarietypicHeadView.h"

#import "showImageController.h"

@interface NewVarietyMoreController () <UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource> {
    NSMutableArray *dataArr;
    BOOL isSearStatu;
    EmptyPromptView *_EPView;//没有搜索内容时候默认的提示
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MTSearchView *searchBar;

@end

static NSString *NewVarietyPicCellID  = @"NewVarietyPicViewCell";
static NSString *newVarietypicHeadID  = @"newVarietypicHeadViewId";

@implementation NewVarietyMoreController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *bgImage = [[UIImage imageNamed:@"biejing"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
  
}

- (void) updataNewVarietyPic{
    _EPView.hidden = YES;
    
    [dataArr removeAllObjects];
    [self addPushViewWaitingView];
    NSDictionary *dic = @{
                          @"page":@"0",
                          @"num":@"1000",
                          @"nursery_type_id":self.model.nursery_type_id,
                          };
    [network httpRequestWithParameter:dic method:NewDetailMoreUrl success:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
        NSArray* array = [dic objectForKey:@"content"];
        for (NSDictionary *dict in array) {
            nurseryNewDetailListModel *model = [[nurseryNewDetailListModel alloc] initWithDictionary:dict error:nil];
            [self->dataArr addObject:model];
        }
        [self->_collectionView reloadData];
    } failure:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
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
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader"];
        [_collectionView registerClass:[newVarietypicHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:newVarietypicHeadID];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader"];
        [_collectionView registerClass:[newVarietypicHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:newVarietypicHeadID];
        
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    isSearStatu = NO;
    dataArr = [[NSMutableArray alloc] init];
    [self addPushViewWaitingView];
    NSDictionary *dic = @{
                          @"page":@"0",
                          @"num":@"1000",
                          @"nursery_type_id":self.model.nursery_type_id,
                          };
    [network httpRequestWithParameter:dic method:NewDetailMoreUrl success:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
         NSArray* array = [dic objectForKey:@"content"];
        for (NSDictionary *dict in array) {
            nurseryNewDetailListModel *model = [[nurseryNewDetailListModel alloc] initWithDictionary:dict error:nil];
            [self->dataArr addObject:model];
        }
        [self createCollectionView];
    } failure:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}
- (void) setNavigationBar {
    
    self.navigationItem.rightBarButtonItem = nil;
    leftbutton.frame=CGRectMake(0, 0, 24, 44);
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _searchBar = [[MTSearchView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - 50, 44)];
    _searchBar.searBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
    __weak NewVarietyMoreController* weakSelf=self;
    if (isSearStatu == NO) {
        [weakSelf.searchBar.searBut setTitle:@"搜索" forState:UIControlStateNormal];
    }else {
        [weakSelf.searchBar.searBut setTitle:@"取消" forState:UIControlStateNormal];
    }
    self.searchBar.searchBlock = ^{
        NSLog(@"搜索");
        if ([weakSelf.searchBar.searBut.titleLabel.text isEqualToString:@"取消"]) {
            [weakSelf updataNewVarietyPic];
            [weakSelf.searchBar.searBar resignFirstResponder];
            weakSelf.searchBar.searBar.text = @"";
            self->isSearStatu = NO;
            [weakSelf.searchBar.searBut setTitle:@"搜索" forState:UIControlStateNormal];
        }else {
            self->isSearStatu = YES;
            [weakSelf.searchBar.searBar becomeFirstResponder];
            [weakSelf.searchBar.searBut setTitle:@"取消" forState:UIControlStateNormal];
        }
    };
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
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        newVarietypicHeadView *DetailHeadView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:newVarietypicHeadID forIndexPath:indexPath];

        [DetailHeadView setHeadViewNewVarietyPicModel:self.model];
        [DetailHeadView setHiddenChickMore];
        return DetailHeadView;
    }else {
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader" forIndexPath:indexPath];
    }
    
}
//分区头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 44);
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
    [self pushViewController:showImagVc];
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
//    [self.searchBar.searBut setTitle:@"取消" forState:UIControlStateNormal];
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
                          @"nursery_type_id":self.model.nursery_type_id,
                          };
    [network httpRequestWithParameter:dic method:NewVarietySearUrl success:^(NSDictionary *dic) {
        [self->dataArr removeAllObjects];
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
