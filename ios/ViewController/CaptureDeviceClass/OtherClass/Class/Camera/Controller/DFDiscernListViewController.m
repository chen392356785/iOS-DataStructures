//
//  DFUsersDiscernViewController.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFConstant.h"
#import "DFIconConstant.h"
#import "DFCommentModel.h"
#import "DFAddCommentView.h"
#import "TFWaterflowLayout.h"
#import "DFUsersDiscernView.h"
#import "DFDiscernListModel.h"
#import "DFIdentifierConstant.h"
#import "DFDiscernTypeListView.h"
#import "DFUsersDiscernListCell.h"
#import "DFCommentViewController.h"
#import "DFDiscernListViewController.h"


@interface DFDiscernListViewController ()<TFWaterflowLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource, DFDiscernTypeListViewDelegate, DFAddCommentViewDelegate, DFDiscernListCellDelegate, TFShowEmptyViewDelegate>

@property (nonatomic, strong) DFUsersDiscernView *usersDiscernView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) DFDiscernTypeListView *discernTypeListView;

@property (nonatomic, strong) DFAddCommentView *addCommentView;
@property (nonatomic, strong) UIView *addCommentBackgroundView;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger currentSource;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

@implementation DFDiscernListViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    
}

- (DFUsersDiscernView *)usersDiscernView {
    return (DFUsersDiscernView *)self.view;
}

#pragma mark - 配置页面
- (void)configureView {
    DFUsersDiscernView *usersDiscernView = [[DFUsersDiscernView alloc]init];
    self.usersDiscernView = usersDiscernView;
    self.view = usersDiscernView;
    
    DFNavigationView *navigationView = usersDiscernView.navigationView;
    navigationView.titleLabel.text = DFDiscernString();
    [navigationView.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [usersDiscernView.selectDiscernType addTarget:self action:@selector(changeDiscernType) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectionView = usersDiscernView.collectionView;
    TFWaterflowLayout *layout = (TFWaterflowLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[DFUsersDiscernListCell class] forCellWithReuseIdentifier:DiscernListIdentifier];
    
    if (self.isMyDiscern == YES) {
        self.currentSource = 1;
        [self.usersDiscernView.selectDiscernType setTitle:DFMyPublishString() forState:UIControlStateNormal];
    }else {
        self.currentSource = 0;
    }
    
    self.collectionView.mj_header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDiscernListData)];
    self.collectionView.mj_footer = [MJRefreshAutoBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreDiscernListData)];
//    self.collectionView.mj_footer.automaticallyHidden = YES;
	
	
    [self.collectionView.mj_header beginRefreshing];
    [self setUpCommentView];
}

- (void)setUpCommentView {
    self.addCommentBackgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.addCommentBackgroundView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAddCommentView)];
    [self.addCommentBackgroundView addGestureRecognizer:tap];
    [self.view addSubview:self.addCommentBackgroundView];
    
    self.addCommentView = [[DFAddCommentView alloc]initWithFrame:CGRectMake(0, iPhoneHeight - 170 * TTUIScale() - DFXHomeHeight, iPhoneWidth, 170 * TTUIScale())];
    self.addCommentView.delegate = self;
    [self.addCommentBackgroundView addSubview:self.addCommentView];
    self.addCommentBackgroundView.hidden = YES;
}

#pragma mark - 获取鉴定列表数据
- (void)getDiscernListData {
    [self.collectionView.mj_footer endRefreshing];
    self.currentPage = 1;
    [HttpRequest getDiscernListWithSource:self.currentSource page:self.currentPage success:^(NSDictionary *result) {
        [self.collectionView.mj_header endRefreshing];
        
        if (!TTValidateDictionary(result)) {
            return ;
        }
        [DFTool removeNothingView:self.view];
        [self.listArray removeAllObjects];
        if ([result[DFErrCode]integerValue] == 200) {
            NSArray *array = result[DFData];
            
            if (TTValidateArray(array) && array.count == 0) {
                [self.collectionView reloadData];
                [DFTool addNothingView:self.view frame:self.collectionView.frame];
                return;
            }
            
            if (TTValidateArray(array) && array.count != 0) {
                self.currentPage ++;
                for (NSDictionary *dictionary in array) {					
					DFDiscernListModel *model = [DFDiscernListModel new];
					model.ID = dictionary[@"ID"];
					model.NickName = dictionary[@"NickName"];
					model.NickName = dictionary[@"HeadImage"];
					model.NickName = dictionary[@"Title"];
					model.NickName = dictionary[@"ImagePath"];
					model.NickName = dictionary[@"CreateTime"];
					NSArray *CommentList = dictionary[@"CommentList"];
					NSMutableArray *temp = [NSMutableArray array];
					for (NSDictionary *commDic in CommentList) {
						DFCommentModel *commentModel = [[DFCommentModel alloc] init];
						commentModel.HeadImage = commDic[@"HeadImage"];
						commentModel.NickName = commDic[@"NickName"];
						commentModel.Content = commDic[@"Content"];
						commentModel.TimeStr = commDic[@"TimeStr"];
						[temp addObject:commentModel];
					}
					model.CommentList = [temp mutableCopy];
					
                    [self.listArray addObject:model];
                }
            }
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        
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
            [DFTool showTips:DFNetworkString()];
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
        
        [weakSelf.collectionView.mj_header beginRefreshing];
    });
}

#pragma mark - 获取更多鉴定列表数据
- (void)getMoreDiscernListData {
    [self.collectionView.mj_header endRefreshing];
    
    [HttpRequest getDiscernListWithSource:self.currentSource page:self.currentPage success:^(NSDictionary *result) {
        [self.collectionView.mj_footer endRefreshing];
        
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            NSArray *array = result[DFData];
            if (TTValidateArray(array)) {
                if (array.count > 0) {
                    self.currentPage ++;
                    for (NSDictionary *dictionary in array) {
                        DFDiscernListModel *model = [DFDiscernListModel new];
						model.ID = dictionary[@"ID"];
						model.NickName = dictionary[@"NickName"];
						model.NickName = dictionary[@"HeadImage"];
						model.NickName = dictionary[@"Title"];
						model.NickName = dictionary[@"ImagePath"];
						model.NickName = dictionary[@"CreateTime"];
						NSArray *CommentList = dictionary[@"CommentList"];
						NSMutableArray *temp = [NSMutableArray array];
						for (NSDictionary *commDic in CommentList) {
							DFCommentModel *commentModel = [[DFCommentModel alloc] init];
							commentModel.HeadImage = commDic[@"HeadImage"];
							commentModel.NickName = commDic[@"NickName"];
							commentModel.Content = commDic[@"Content"];
							commentModel.TimeStr = commDic[@"TimeStr"];
							[temp addObject:commentModel];
						}
						model.CommentList = [temp mutableCopy];
                        [self.listArray addObject:model];
                    }
                }else {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFUsersDiscernListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DiscernListIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.listModel = self.listArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DFDiscernListModel *model = self.listArray[indexPath.item];
    DFCommentViewController *commentVC = [[DFCommentViewController alloc]init];
    commentVC.listModel = model;
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - <XMGWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(TFWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    DFDiscernListModel *listModel = self.listArray[index];
    CGFloat totalHeight = 0;
    for (int i = 0; i < listModel.CommentList.count; i ++) {
        DFCommentModel *commentModel = listModel.CommentList[i];
        NSString *contentString = [NSString stringWithFormat:@"%@：%@",commentModel.NickName,commentModel.Content];
        totalHeight = totalHeight + [self heightWithString:contentString];
    }
    return 270 * TTUIScale() + totalHeight + [self titleHeightWithString:listModel.Title];
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(TFWaterflowLayout *)waterflowLayout {
    return UIEdgeInsetsMake(10 * TTUIScale(), 10 * TTUIScale(), 10 * TTUIScale(), 10 * TTUIScale());
}

#pragma mark - 计算评论内容高度
- (CGFloat)heightWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:PingFangRegularFont() size:11 * TTUIScale()];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat height = [string boundingRectWithSize:CGSizeMake((iPhoneWidth - 20 * TTUIScale() - 5)/2 - 10 * TTUIScale(), 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return height + 3;
}

#pragma mark - 计算标题高度
- (CGFloat)titleHeightWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:PingFangRegularFont() size:12 * TTUIScale()];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat height = [string boundingRectWithSize:CGSizeMake((iPhoneWidth - 20 * TTUIScale() - 5)/2 - 10 * TTUIScale(), 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return height + 2;
}

#pragma mark - 切换列表分类
- (void)changeDiscernType {
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDiscernTypeListView)];
        [self.backgroundView addGestureRecognizer:tap];
        [self.view addSubview:self.backgroundView];
        
        self.discernTypeListView = [[DFDiscernTypeListView alloc]initWithFrame:CGRectMake(iPhoneWidth - 130 * TTUIScale(), DFNavigationBar + 5, 120 * TTUIScale(), 150 * TTUIScale())];
        self.discernTypeListView.delegate = self;
        [self.backgroundView addSubview:self.discernTypeListView];
        
        UIImageView *arrowIcon = [[UIImageView alloc]initWithFrame:CGRectMake(iPhoneWidth - 50 * TTUIScale(), DFNavigationBar - 7, 19, 26)];
        arrowIcon.image = kImage(TopArrowIcon);
        [self.backgroundView addSubview:arrowIcon];
    }else {
        self.backgroundView.hidden = NO;
        [self.view bringSubviewToFront:self.backgroundView];
    }
    self.discernTypeListView.currentSource = self.currentSource;
}

#pragma mark - 隐藏分类下拉框
- (void)hideDiscernTypeListView {
    self.backgroundView.hidden = YES;
}

#pragma mark - 选择分类
- (void)selectDiscernTypeWith:(NSInteger)index {
    if (self.currentSource == index) {
        return;
    }
    
    if (index == 0) {
        [self selectAllFlower];
        self.currentSource = index;
    }else {
        if (!USERMODEL.isLogin) {
            DFLoginViewController *loginVC = [[DFLoginViewController alloc]init];
            [self presentViewController:loginVC animated:YES completion:nil];
            return;
        }else {
            [self selectPublishOrDiscernWith:index];
        }

    }
    
    [self hideDiscernTypeListView];
}

- (void)selectPublishOrDiscernWith:(NSInteger)index {
    if (index == 1) {
        [self selectMyPublish];
    }
    if (index == 2) {
        [self selectMyDiscern];
    }
    
    self.currentSource = index;
}

#pragma mark - 选择全部分类
- (void)selectAllFlower {
    [self.usersDiscernView.selectDiscernType setTitle:DFAllString() forState:UIControlStateNormal];
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 选择我的发布
- (void)selectMyPublish {
    [self.usersDiscernView.selectDiscernType setTitle:DFMyPublishString() forState:UIControlStateNormal];
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 选择我的鉴定
- (void)selectMyDiscern {
    [self.usersDiscernView.selectDiscernType setTitle:DFMyDiscernString() forState:UIControlStateNormal];
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 弹出评论框
- (void)addComment:(UIButton *)sender {
    
    if (!USERMODEL.isLogin) {
        DFLoginViewController *loginVC = [[DFLoginViewController alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }else {
        UIView *aview = sender.superview;
        while (![aview isKindOfClass:[DFUsersDiscernListCell class]]) {
            aview = aview.superview;
        }
        
        DFUsersDiscernListCell *cell = (DFUsersDiscernListCell *)aview;
        self.currentIndexPath = [self.collectionView indexPathForCell:cell];
        
        if (self.addCommentBackgroundView.hidden) {
            self.addCommentBackgroundView.hidden = NO;
            [self.addCommentView.textView becomeFirstResponder];
        }
    }
}

#pragma mark - 隐藏评论框
- (void)hideAddCommentView {
    self.addCommentBackgroundView.hidden = YES;
    [self.addCommentView.textView resignFirstResponder];
}

#pragma mark - 提交评论
- (void)confirmComment {
    
    NSString *commentText = self.addCommentView.textView.text;
    if (!commentText || [commentText isEqualToString:@""]) {
        [DFTool showTips:DFSpaceLetterString()];
        return ;
    }
    
    DFDiscernListModel *listModel = self.listArray[self.currentIndexPath.item];
    
//    [DFTool addWaitingView:self.view];
    [HttpRequest postAddCommentInfoWith:listModel.ID content:commentText success:^(NSDictionary *result) {
//        [DFTool removeWaitingView:self.view];
        
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        [DFTool showTips:result[DFErrMsg]];
        
        if ([result[DFErrCode]integerValue] == 200) {
            [self hideAddCommentView];
            
            [self saveCommentContent];
            self.addCommentView.textView.text = @"";
            
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError *error) {
//        [DFTool removeWaitingView:self.view];
    }];
}

- (void)saveCommentContent {
    DFDiscernListModel *currentModel = self.listArray[self.currentIndexPath.item];
    NSMutableArray *commentList = [currentModel.CommentList mutableCopy];
    if (commentList.count >= 5) {
        [commentList removeLastObject];
    }
    DFCommentModel *newModel = [[DFCommentModel alloc]init];
    newModel.NickName = UserModel.Nick;
    newModel.Content = self.addCommentView.textView.text;
    
    [commentList insertObject:newModel atIndex:0];
    
    currentModel.CommentList = commentList;
    self.listArray[self.currentIndexPath.item] = currentModel;
}

#pragma mark - 取消评论
- (void)cancleComment {
    [self hideAddCommentView];
}

#pragma mark - 返回
- (void)backAction {
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
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
