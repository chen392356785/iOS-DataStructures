//
//  ActivtiesVoteViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 21/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivtiesVoteViewController.h"
#import "VotoChartsListViewController.h"
#import "HeardCollectionReusableView.h"
#import "ActivtiesVoteDetailViewController.h"
#import "VotoDetailsViewController.h"
#import "XHFriendlyLoadingView.h"
#import "CustomView+CustomCategory2.h"
#import "BuyVoteViewController.h"   //购买选票

@interface ActivtiesVoteViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,VoteSuccessDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *dataArr;
    UIView *_topView;
    UITextField *_textfiled;
    UIView *_bottomView;
    VotoView *_votoView;
    NSIndexPath *_indexPath;
    NSString *_totleNum;
    NSString *_total_piao;      //总共可用票数
    NSString *_surplus;
    NSString *_currentDate;
    NSString *_project_code;
    BOOL netSuccess;
    
    BuyVotoNumView *_buyVotoView;
}
@end

@implementation ActivtiesVoteViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [rightbutton setImage:[UIImage imageNamed:@"shareGreen.png"] forState:UIControlStateNormal];
//    rightbutton.hidden = NO;
    rightbutton.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"投票活动"];
    [self CreateCollectionView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NotificationVoteActionBuy:) name:NotificationVoteAction object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NotificationVoteActionBuy:) name:@"NotificationVoteSucces" object:nil];
}
//更新界面
-(void)NotificationVoteActionBuy:(NSNotification *)notificaiton{  //发布成功，马上更新列表
    [self loadRefesh];
}
- (void)CreateCollectionView
{
    dataArr =[NSMutableArray array];
    _project_code = @"";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake((WindowWith - 40)/2.0, kWidth(300));
    layout.itemSize = CGSizeMake((WindowWith - 40)/2.0, kWidth(187) + (WindowWith - 40)/2.0);
    layout.sectionInset = UIEdgeInsetsMake(8, 12, 17 , 12);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 17;
//    layout.headerReferenceSize = CGSizeMake(WindowWith, WindowWith/375.0 * 234 + 59);
    layout.headerReferenceSize = CGSizeMake(WindowWith, WindowWith*0.453 + 59);
    
    CGFloat hh = kBottomNoSapce;
    CGFloat nav_h = kNavigationHeight;
    CGFloat origin_H = SCREEN_HEIGHT-hh-nav_h-49;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, origin_H) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = kColor(@"#F5F5F5");
    [_collectionView registerClass:[ActivityVoteCollectionViewCell class] forCellWithReuseIdentifier: @"ActivityVoteCollectionViewCell"];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[HeardCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeardCollectionReusableView"];
    
    [self loadRefesh];
    
    
    
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, origin_H, WindowWith, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView = bottomView;
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(12, 0, WindowWith- 24, 1)];
    lineView2.backgroundColor = cLineColor;
    [bottomView addSubview:lineView2];
    
    
    UIButton *SharBut=[UIButton buttonWithType:UIButtonTypeCustom];
    SharBut.frame =CGRectMake(kWidth(25), 0, kWidth(21), kWidth(21));
    SharBut.centerY = bottomView.height/2.0;
    UIImage *sharmg = Image(@"icon_fx");
    [SharBut setImage:[sharmg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    SharBut.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    [SharBut addTarget:self action:@selector(shareSmallProgram) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:SharBut];
    
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(SharBut.right + kWidth(19), 0, kWidth(136) , kWidth(30))];
    searchView.backgroundColor =RGB(235, 239, 242);
    searchView.centerY = bottomView.height/2.0;
    searchView.layer.cornerRadius = searchView.height/2;
    [bottomView addSubview:searchView];
    
    UIImage *img = Image(@"Search Icon.png");
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(6, 0, img.size.width, img.size.height)];
    imageView.image = img;
    imageView.centerY = searchView.height/2.0;
    [searchView addSubview:imageView];
    
    UITextField *textfiled = [[UITextField alloc] initWithFrame:CGRectMake(imageView.right + 8, 0, searchView.width - imageView.right -15, kWidth(30))];
    textfiled.font = sysFont(13);
    textfiled.placeholder = @"输入参选编号";
    textfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfiled.delegate = self;
    _textfiled = textfiled;
    textfiled.centerY = searchView.height/2.0;
    textfiled.returnKeyType = UIReturnKeySearch;
    [searchView addSubview:textfiled];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(searchView.right + kWidth(12), searchView.top, kWidth(135), kWidth(30));
    button.right = WindowWith - 15;
    [button setTitle:@"排行榜" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = kColor(@"#00B7AA");
    button.layer.cornerRadius = button.height/2;
    UIImage *Img=Image(@"ActivVote_Rank.png");
    [button setImage:[Img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    button.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    [button addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font=sysFont(13);
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
        //****IQKeyboard
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardWillShowNotification object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
    
    //投票弹框
    VotoView *votoView=[[VotoView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
    
    _votoView = votoView;
    
    
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    [widow addSubview:votoView];
    
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:_collectionView];
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VoteListModel *model = dataArr[indexPath.row];
    ActivityVoteCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActivityVoteCollectionViewCell" forIndexPath:indexPath];
    [cell setCollectionViewData:model];
    __weak ActivtiesVoteViewController *weakSelf = self;
    cell.selectBtnBlock = ^(NSInteger index){
        NSLog(@"+++%ld",(long)indexPath.row);
        if ([weakSelf.model.is_zc_goumai isEqualToString:@"1"]) {
            [weakSelf BuyVotoMode:model Andindex:indexPath];
        }else {
            [weakSelf voto];
            [weakSelf VoteViewWith:model indexPath:indexPath];
        }
    };
    return cell;
}

- (void) BuyVotoMode:(VoteListModel *)model Andindex:(NSIndexPath *) indexPath {
    _buyVotoView = [[BuyVotoNumView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    [_buyVotoView setContent:model lmitNum:_total_piao surplus:_surplus];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:_buyVotoView];
    __weak ActivtiesVoteViewController *weakSelf = self;
    _buyVotoView.selectBtnBlock=^(NSString *NumStr){
        [weakSelf addVote:model indexPath:indexPath andVoteNum:NumStr];
    };
    model.times = self.model.times;
    _buyVotoView.buyVotoBtnBlock = ^{
        BuyVoteViewController *buyVc = [[BuyVoteViewController alloc] init];
        buyVc.model = model;
        buyVc.votoTitle = weakSelf.model.activities_titile;
        buyVc.ActiviModel = weakSelf.model;
        [weakSelf pushViewController:buyVc];
    };
    _buyVotoView.hideBtnBlock = ^{
        [weakSelf dismissPopupController];
    };
}

- (void)VoteViewWith:(VoteListModel *)model indexPath:(NSIndexPath *)indexPath
{
    [_votoView setContent:model lmitNum:_total_piao surplus:_surplus];
    __weak ActivtiesVoteViewController *weakSelf = self;
    _votoView.selectBtnBlock=^(NSInteger index){
        [weakSelf addVote:model indexPath:indexPath andVoteNum:@"1"];
    };
}

#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView {
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupViewController presentPopupControllerAnimated:YES];
}
- (void)dismissPopupController {
    [self.popupViewController dismissPopupControllerAnimated:YES];
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_textfiled resignFirstResponder];
    
    VoteListModel *model = dataArr[indexPath.row];
    
    VotoDetailsViewController *vc = [[VotoDetailsViewController alloc] init];
    vc.model = model;
    vc.activModel = self.model;
    //    vc.surplus = _surplus;
    vc.delegate = self;
    vc.indexPath = indexPath;
    [self pushViewController:vc];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        HeardCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeardCollectionReusableView" forIndexPath:indexPath];
        __weak ActivtiesVoteViewController *weakSelf = self;
        headerView.selectBtnBlock = ^(NSInteger index){
            [weakSelf activtDetail:nil];
        };
        
        if (netSuccess) {
            NSString *time = [IHUtility CalLastTime:self.model.activities_endtime curDate:_currentDate];
            [headerView setTopData:self.model.activities_titile time:time totlNum:_totleNum imgUrl:self.model.activities_pic];
            netSuccess = NO;
        }
        reusableview = headerView;
    }
    return reusableview;
}

- (void)activtDetail:(UIButton *)btn
{
    [_textfiled resignFirstResponder];
    
    ActivtiesVoteDetailViewController *vc = [[ActivtiesVoteDetailViewController alloc] init];
    vc.content = self.model.html_content;
    self.model.user_upper_limit_num = _total_piao;
    vc.model = self.model;
    [self pushViewController:vc];
}
- (void)btnTap:(UIButton *)button
{
    [_textfiled resignFirstResponder];
    VotoChartsListViewController *vc = [[VotoChartsListViewController alloc]init];
    vc.model = self.model;
    [self pushViewController:vc];
    WS(weakSelf);
    vc.updataViewBlock = ^{
        [weakSelf loadRefesh];
    };
    
}
-(void)voto{
    [_votoView show];
}

- (void)addVote:(VoteListModel *)model indexPath:(NSIndexPath *)indexPath andVoteNum:(NSString *)vote_num
{
    NSString *userID;
    if (!USERMODEL.isLogin) {
//        userID = @"0";
        //登录
        [self prsentToLoginViewController];
        return;
    }else
    {
        userID = USERMODEL.userID;
    }
    
    [self addWaitingView];
    [network getVoteForUser:self.model.activities_id project_id:stringFormatInt(model.project_id) user_id:userID vote_num:vote_num success:^(NSDictionary *obj) {
		if ([self->_surplus intValue] < [vote_num intValue]) {
			self->_surplus = @"0";
        }else {
            self->_surplus = stringFormatInt([self->_surplus intValue] - [vote_num intValue]);
        }
        model.vote_num += [vote_num integerValue];
        NSArray *indexArray=[NSArray arrayWithObject:indexPath];
        [self->_collectionView reloadItemsAtIndexPaths:indexArray];
        
        [self->_votoView setContent:model lmitNum:self->_total_piao surplus:self->_surplus];      //刷新弹框票数
        [self removeWaitingView];
        
//        [self addSucessView:@"投票成功，感谢您的参与!" type:1];
    } failure:^(NSDictionary *obj2) {
        [self removeWaitingView];
    }];
}

- (void)VoteSuccessDelagate:(VoteListModel *)model indexPath:(NSIndexPath *)indexPath
{
    _surplus = stringFormatInt([_surplus intValue] -1);
    model.vote_num++;
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [_collectionView reloadItemsAtIndexPaths:indexArray];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _project_code = textField.text;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textfiled resignFirstResponder];
    [dataArr removeAllObjects];
    [self loadRefesh];
    return YES;
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    _bottomView.bottom = WindowHeight - kbSize.height ;
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    _bottomView.bottom = WindowHeight;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textfiled resignFirstResponder];
}

- (void)extracted {
    [network getVoteList:self.model.activities_id project_code:_project_code success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"];
        self->_totleNum = stringFormatString(obj[@"totalNum"]);
        self->_total_piao = stringFormatString(obj[@"total_piao"]);
        NSInteger surplus = [self->_total_piao intValue] - [obj[@"surplus"] intValue];
        if (surplus >= 0) {
            self->_surplus = stringFormatInt(surplus);
        }else {
            self->_surplus = @"0";
        }
        self->_currentDate = obj[@"curDate"];
       self->netSuccess = YES;
        
        [self->dataArr removeAllObjects];
        [self->dataArr addObjectsFromArray:arr];
        [self->_collectionView reloadData];
        
        [self removePushViewWaitingView];
        
    } failure:^(NSDictionary *obj2) {
        
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}

-(void)loadRefesh{
    
    [self addPushViewWaitingView];
    [self extracted];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_textfiled resignFirstResponder];
}



//分享到小程序
- (void) shareSmallProgram {

    NSString *Path = [NSString stringWithFormat:@"pages/activity/voteDetail/voteDetail?activitiesId=%@",self.model.activities_id];
    NSDictionary *dict = @{
                           @"appid"     :WXXCXappId,
                           @"appsecret" :WXXCXappSecret,
                           @"type"      :self.model.model,
                           @"id"        :self.model.activities_id,
                           @"path"      :Path,
                           };
    [self shareSmallProgramCodeOject:dict httpMethod:1 methoe:ActivityShareUrl Vc:self completion:nil];
    
    
}
//分享
- (void)home:(id)sender
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@vote/tphd.html?vote_id=%d",shareURL,[self.model.activities_id intValue]];
    
    [self ShareUrl:self withTittle:@"火爆行业的投票活动！拿出你的选票向我开炮！" content:self.model.activities_titile withUrl:urlStr imgUrl:self.model.activities_pic];
}

@end
