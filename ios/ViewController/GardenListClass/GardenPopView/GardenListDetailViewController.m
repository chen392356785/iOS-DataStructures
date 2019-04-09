//
//  GardenListDetailViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/2.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "GardenListDetailViewController.h"
#import "HeadBannerView.h"
#import "GardenListDetailViewCell.h"
//#import "GardenCommentCell.h"
#import "MessageViewCell.h"
#import "inputView.h"
@interface GardenListDetailViewController () <UITableViewDelegate,UITableViewDataSource,inputViewDelegate>{
    UITableView *_tableView;
    HeadBannerView *_scrollView;
    NSMutableArray *dataArr;
    NSArray *secTitleArr;
    NSString *sendText;     //1 评论  2 回复  3举报 4 回复被人的评论
    GardenCommentListModel *CellModel;
    gardenReplyCommentModel *Gardenmodel;
    NSIndexPath *inputIndex;
}
@property (nonatomic, strong) inputView *input;
//@property (nonatomic,strong) HeadBannerView *scrollView;
@end

static NSString *GardenListDetailInfoCellId = @"GardenListDetailInfoCell";
static NSString *GardenListDetailSkrCellId = @"GardenListDetailSkrCell";
static NSString *GardenListcompanydescribeCellid = @"GardenListcompanydescribeCell";
static NSString *MessageViewCellId  = @"MessageViewCell";
@implementation GardenListDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.shouldResignOnTouchOutside = NO;
    keyboardManager.keyboardDistanceFromTextField = kWidth(30);
    
    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    leftbutton.frame=CGRectMake(0, 0, 20, 44);
    leftbutton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    UIImage *bgImage1 = [UIImage imageWithColor:kColor(@"#05c1b0") size:CGSizeMake(iPhoneWidth, KtopHeitht)];
    UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.shouldResignOnTouchOutside = YES;
    
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
}


- (void) setNavigation {
    UIImage *shareImg=Image(@"Garden-bj-fx");
    moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(0, 0, 20, 40);
    [moreBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:shareImg forState:UIControlStateNormal];
    moreBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -10);
    UIBarButtonItem *barMoreBtn = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    moreBtn.backgroundColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = @[barMoreBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.model.gardenCompany andTitleColor:kColor(@"#ffffff")];
    dataArr = [[NSMutableArray alloc] init];
    secTitleArr = @[@"基本信息",@"",@"企业简介",@"业内评价"];
    [self setNavigation];
    [self createTableView];
    [self getDataModel];
}

-(void)getDataModel{
    NSString *userId = @"";
    if (USERMODEL.userID != nil) {
        userId = USERMODEL.userID;
    }
    
    [self addWaitingView];
    NSDictionary *dic = @{
                          @"gardenId"      : self.model.gardenId,
                          };
    [network httpRequestWithParameter:dic method:GardenListDetailUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        NSDictionary *dict = dic[@"content"];
        NSArray *arr = dict[@"detailPicList"];
        if (arr.count > 0) {
            self->_scrollView.data = arr;
        }
        [self->dataArr removeAllObjects];
        for (NSDictionary *obj in dict[@"commentList"]) {
            GardenCommentListModel *model = [[GardenCommentListModel alloc] initWithDictionary:obj error:nil];
            [self->dataArr addObject:model];
        }
        [self->_tableView reloadData];
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
}

- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(49)) style: UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(178))];
    _tableView.tableHeaderView = headView;
    
    _scrollView = [HeadBannerView initWithFrame:CGRectMake(0, kWidth(10), iPhoneWidth, kWidth(142)) imageSpacing:10 imageWidth:kWidth(305)];
    _scrollView.autoScroll = NO;
    _scrollView.initAlpha = 0.5;    // 设置两边卡片的透明度
    _scrollView.imageRadius = kWidth(6);   // 设置卡片圆角
    _scrollView.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
    _scrollView.placeHolderImage = kImage(@"defaulLogo");
    // 设置要加载的图片
//    _scrollView.data = @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",@"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg"];
//    _scrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
    [headView addSubview:_scrollView];
    _scrollView.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调

    };
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, _tableView.bottom, iPhoneWidth, kWidth(49))];
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [UIColor colorWithRed:124/255.0 green:174/255.0 blue:66/255.0 alpha:0.2].CGColor;
    textView.font = sysFont(12);
    textView.text = @"  我也来评论一句...";
    textView.textColor = kColor(@"#9B9B9B");
    [self.view addSubview:textView];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(textView.width - kWidth(49), 0, kWidth(24), kWidth(24))];
    imageV.image = kImage(@"send_img");
    [textView addSubview:imageV];
    imageV.centerY = textView.height/2;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pinglunAction)];
    textView.userInteractionEnabled = YES;
    [textView addGestureRecognizer:tap];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return dataArr.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GardenListDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenListDetailInfoCellId];
        if (!cell) {
            cell = [[GardenListDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GardenListDetailInfoCellId];
        }
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        GardenListDetailSkrCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenListDetailSkrCellId];
        if (!cell) {
            cell = [[GardenListDetailSkrCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GardenListDetailSkrCellId];
        }
        cell.model = self.model;
        WS(weakSelf);
        cell.skrBlock = ^{
            [weakSelf skrAction:indexPath];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2) {
        GardenListcompanydescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenListcompanydescribeCellid];
        if (!cell) {
            cell = [[GardenListcompanydescribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GardenListcompanydescribeCellid];
        }
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageViewCellId];
        if (!cell) {
            cell = [[MessageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MessageViewCellId];
        }
        GardenCommentListModel *CellModel = dataArr[indexPath.row];
        cell.model = CellModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == dataArr.count-1) {
            cell.lineLab.hidden = YES;
        }else {
            cell.lineLab.hidden = NO;
        }

        WS(weakSelf);
        cell.huifuBlock = ^{
            self->inputIndex = indexPath;
            [weakSelf pingOthterIndex:indexPath.row];
        };
        cell.deleBlock = ^{
            [weakSelf delePinglunIndex:indexPath.row];
        };
        cell.jubaoBlock = ^{
            [weakSelf jubaoPinglunIndex:indexPath.row];
        };
        cell.huifuOhterBlock = ^(NSInteger index) {
            self->inputIndex = indexPath;
            [weakSelf huifuOtherhuifuIndex:indexPath.row andTag:index];
        };
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[GardenListDetailInfoCell class] contentViewWidth:iPhoneWidth];
        return height;
    }else if (indexPath.section == 1){
        CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[GardenListDetailSkrCell class] contentViewWidth:iPhoneWidth];
        return height;
    }else if (indexPath.section == 2){
        CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[GardenListcompanydescribeCell class] contentViewWidth:iPhoneWidth];
        return height;
    }else {
        GardenCommentListModel *CellModel = dataArr[indexPath.row];
        CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:CellModel keyPath:@"model" cellClass:[MessageViewCell class] contentViewWidth:iPhoneWidth];
        return height;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 0;
    }
    return kWidth(49);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    if (section == 1) {
        
    }else {
        headView.size = CGSizeMake(iPhoneWidth, kWidth(49));
        [headView removeAllSubviews];
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(15), 0, kWidth(2), kWidth(16))];
        linView.backgroundColor = kColor(@"#05C1B0");
        [headView addSubview:linView];
        linView.centerY = headView.height/2.;
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = secTitleArr[section];
        titleLab.frame = CGRectMake(linView.right + kWidth(10), 0, headView.width - kWidth(20), kWidth(22));
        titleLab.textColor = kColor(@"#030303");
        titleLab.centerY = headView.height/2.;
        titleLab.font = sysFont(font(16));
        [headView addSubview:titleLab];
    }
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 0;
    }
    return kWidth(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor colorWithRed:5/255.0 green:193/255.0 blue:176/255.0 alpha:0.2];
    return footView;
}
#pragma - mark 分享
- (void) shareAction {
    NSLog(@"分享~~~");
    NSString *Path = [NSString stringWithFormat:@"pages/gardenRank/companyDetail/companyDetail?gardenId=%@",self.model.gardenId];
    NSDictionary *dict = @{
                           @"appid"         : WXXCXappId,
                           @"appsecret"     : WXXCXappSecret,
                           @"path"          : Path,
                           @"gardenId"      : self.model.gardenId
                           };
    [self shareSmallProgramCodeOject:dict httpMethod:0 methoe:GardenDetailSharelUrl Vc:self completion:nil];
}

#pragma -  mark  点赞
- (void)skrAction:(NSIndexPath *) index {
    [self addWaitingView];
    NSString *userId = @"";
    if (USERMODEL.userID != nil) {
        userId = USERMODEL.userID;
    }
    NSDictionary *dic = @{
                          @"gardenId"      : self.model.gardenId,
                          @"userId"        : userId,
                          @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                          };
    [network httpRequestWithParameter:dic method:GardenLikeUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        NSLog(@"%@ - %@",dic[@"content"],dic[@"errorContent"]);
        self.model.isClick = @"1";
        
        NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self.model.gardenSignString options:NSMatchingReportProgress range:NSMakeRange(0, self.model.gardenSignString.length)];
        if (tNumMatchCount == self.model.gardenSignString.length) {
             self.model.gardenSignString = [NSString stringWithFormat:@"%d",[self.model.gardenSignString intValue] + 1];
        }
//        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
        [self->_tableView reloadData];
        
        if (self.updataCellBlock) {
            self.updataCellBlock();
        }
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
}

- (void)dealloc {
    NSLog(@"释放");
}

#pragma - mark - 回复别人的回复
- (void) huifuOtherhuifuIndex:(NSInteger) index andTag:(NSInteger ) tag {
    sendText = @"4";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    CellModel = dataArr[index];
    
    NSDictionary *dict = CellModel.tails;
    NSArray *arr = dict[@"gardenReplyComment"];
    NSDictionary *mdict = arr[tag];
    Gardenmodel = [[gardenReplyCommentModel alloc] initWithDictionary:mdict error:nil];
    
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:self.input];
    [self.input.inputTextView becomeFirstResponder];
    WS(weakSelf);
    self.input.tapBgViewBlock = ^{
        [weakSelf dismissPopupController];
    };
    self.input.placeLabel.text = [NSString stringWithFormat:@"回复@%@",Gardenmodel.replyUserName];
}
#pragma - mark - 评论别人的评论
- (void) pingOthterIndex:(NSInteger )index {
    sendText = @"2";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    CellModel = dataArr[index];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:self.input];
    [self.input.inputTextView becomeFirstResponder];
    WS(weakSelf);
    self.input.tapBgViewBlock = ^{
        [weakSelf dismissPopupController];
    };
    self.input.placeLabel.text = [NSString stringWithFormat:@"回复@%@",CellModel.userName];
}
#pragma - mark - 删除评论
- (void) delePinglunIndex:(NSInteger )index {
    GardenCommentListModel *CellModel = dataArr[index];
    [self addWaitingView];
    NSDictionary *dic = @{
                          @"type"      : @"2",
                          @"id"        : CellModel.jid,
                          @"gardenId"  : CellModel.gardenId,
                          @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                          };
    [network httpRequestWithParameter:dic method:GardenDelepingluneUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];

        [self showHomeHint:@"已删除~" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        [self->dataArr removeObject:CellModel];
        
        NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self.model.commentCountString options:NSMatchingReportProgress range:NSMakeRange(0, self.model.commentCountString.length)];
        if (tNumMatchCount == self.model.commentCountString.length) {
            self.model.commentCountString = [NSString stringWithFormat:@"%ld",self->dataArr.count];
            if (self.updataCellBlock) {
                self.updataCellBlock();
            }
        }else {
            
        }
        
        [self->_tableView reloadData];
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
    NSLog(@"删除评论");
}
#pragma - mark - 举报评论
- (void) jubaoPinglunIndex:(NSInteger )index {
    NSLog(@"举报评论");
    sendText = @"3";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    CellModel = dataArr[index];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:self.input];
    [self.input.inputTextView becomeFirstResponder];
    WS(weakSelf);
    self.input.tapBgViewBlock = ^{
        [weakSelf dismissPopupController];
    };
    self.input.inputTextView.text = @"";
    self.input.placeLabel.text = @"请输入举报原因";
}

#pragma - mark - 评论or回复
- (void) pinglunAction {
    sendText = @"1";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:self.input];
    [self.input.inputTextView becomeFirstResponder];
    WS(weakSelf);
    self.input.tapBgViewBlock = ^{
        [weakSelf dismissPopupController];
    };
    self.input.placeLabel.text = [NSString stringWithFormat:@"评论@%@",self.model.gardenName];
}
//- (void) popBottomePinglunTextView {
//    [self showPopupWithStyle:CNPPopupStyleCentered popupView:self.input];
//    [self.input.inputTextView becomeFirstResponder];
//    WS(weekSelf);
//    self.input.tapBgViewBlock = ^{
//        [weekSelf dismissPopupController];
//    };
//}
#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView {
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromBottom;
    [self.popupViewController presentPopupControllerAnimated:YES];
    
}
- (void)dismissPopupController {
    WS(weekSelf);
    [weekSelf.popupViewController dismissPopupControllerAnimated:YES];
}
- (inputView *)input {
    if (_input == nil) {
        _input = [[inputView alloc] initWithFrame:CGRectMake(0, 0,iPhoneWidth, iPhoneHeight)];
        _input.delegate = self;
    }
    return _input;
}
- (void)sendText:(NSString *)text {
    [self.input inputViewHiden];
    self.input.inputTextView.text = @"";
    [self.popupViewController dismissPopupControllerAnimated:YES];
    [self addWaitingView];
    NSDictionary *dic;
    if ([sendText isEqualToString:@"1"]) {  //评论
        dic = @{
                @"comment"       : text,
                @"userId"        : USERMODEL.userID,
                @"type"          : @"0",
                @"gardenId"      : self.model.gardenId,
                @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                };
    }else if ([sendText isEqualToString:@"2"]) {//回复
        dic = @{
                @"comment"       : text,
                @"userId"        : CellModel.userId,
                @"type"          : @"1",
                @"gardenId"      : self.model.gardenId,
                @"replyUserId"   : USERMODEL.userID,
                @"id"            : CellModel.jid,
                @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                };
    }else if ([sendText isEqualToString:@"4"]) {//回复
        dic = @{
                @"comment"       : text,
                @"userId"        : Gardenmodel.replyUserId,
                @"type"          : @"1",
                @"gardenId"      : self.model.gardenId,
                @"replyUserId"   : USERMODEL.userID,
                @"id"            : CellModel.jid,
                @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                };
    }else if ([sendText isEqualToString:@"3"]) {     //举报
        dic = @{
                @"reportReason"  : text,
                @"reportUserId"  : USERMODEL.userID,
                @"type"          : @"3",
                @"id"            : CellModel.jid,
                @"gardenId"      : self.model.gardenId,
                @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                };
    }else{
        return;
    }
    [network httpRequestWithParameter:dic method:GardenpingluneUrl success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSDictionary *dict = obj[@"content"];
        if ([self->sendText isEqualToString:@"1"]) {  //评论
            GardenCommentListModel *model = [[GardenCommentListModel alloc] initWithDictionary:dict error:nil];
//            [dataArr addObject:model];
            [self->dataArr insertObject:model atIndex:0];
            NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
            NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self.model.commentCountString options:NSMatchingReportProgress range:NSMakeRange(0, self.model.commentCountString.length)];
            if (tNumMatchCount == self.model.commentCountString.length) {
                self.model.commentCountString = [NSString stringWithFormat:@"%ld",self->dataArr.count];
                if (self.updataCellBlock) {
                    self.updataCellBlock();
                }
            }
            [self showHomeHint:@"评论成功~" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
            [self->_tableView reloadData];

        }else if ([self->sendText isEqualToString:@"2"] || [self->sendText isEqualToString:@"4"]) {//回复
            GardenCommentListModel *model = [[GardenCommentListModel alloc] initWithDictionary:dict error:nil];
            self->CellModel.tails = model.tails;
            [self showHomeHint:@"回复成功~" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
            [self->_tableView beginUpdates];
            [self->_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:self->inputIndex,nil] withRowAnimation:UITableViewRowAnimationNone];
            [self->_tableView endUpdates];
        }else if ([self->sendText isEqualToString:@"3"]) {     //举报
            [self showHomeHint:@"已举报~" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        }else{
            return;
        }
        
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
    
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
@end
