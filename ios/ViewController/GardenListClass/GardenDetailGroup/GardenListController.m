//
//  GardenListController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenListController.h"
#import "GardenListViewCell.h"

#import "GardenDetailView.h"
#import "GardenListDetailViewController.h"

#import "inputView.h"       //评论输入框

@interface GardenListHeadView () {
    
}
@end

@implementation GardenListHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
- (void) createView {
    UILabel *line =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 0.5)];
    line.backgroundColor = kColor(@"#000000");
    line.alpha = 0.15;
    UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(183))];
    bgImgV.image = kImage(@"Garden_list_top");
    [self addSubview:bgImgV];
    [self addSubview:line];
    CGFloat topSpaceH;
    for (int i = 0; i < 3; i ++) {
        if (i == 1) {
            topSpaceH = kWidth(32);
        }else {
            topSpaceH = kWidth(60);
        }
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(18) + i * kWidth(118), topSpaceH, kWidth(100), kWidth(179))];
        
        UITapGestureRecognizer *bgViewtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewAction:)];
        // 允许用户交互
        bgView.userInteractionEnabled = YES;
        [bgView addGestureRecognizer:bgViewtap];
        
        bgView.backgroundColor = kColor(@"#FFFFFF");
        bgView.layer.cornerRadius = kWidth(6);
        bgView.tag = i + 100;
        [self addSubview:bgView];
        bgView.layer.shadowColor = kColor(@"#05C1B0").CGColor;
        bgView.layer.shadowOffset = CGSizeMake(0, 2);
        bgView.layer.shadowOpacity = 0.2;
        bgView.layer.shadowRadius = 10;
        NSString *imgStr;
        if (i == 0) {       //第二名
            imgStr = @"garden_list_two";
        }else if (i == 1) { //第一名
            imgStr = @"garden_list_one";
        }else {             //第三名
            imgStr = @"garden_list_three";
        }
        [self bgViewAddSubviews:bgView andImgStr:imgStr andindex:i];
    }
}
- (void) bgViewAddSubviews:(UIView *)view andImgStr:(NSString *)imgStr andindex:(NSInteger )tag{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(4), kWidth(60), kWidth(60))];
    imageV.image = kImage(imgStr);
    [view addSubview:imageV];
    imageV.centerX = view.width/2.;
    
    UILabel *Namelabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(4), imageV.bottom, view.width - kWidth(8), kWidth(48))];
    Namelabel.numberOfLines = 0;
    [view addSubview:Namelabel];
    Namelabel.font =  RegularFont(font(12));
    Namelabel.textColor = kColor(@"#000000");
    Namelabel.text = @"";
    Namelabel.textAlignment = NSTextAlignmentCenter;
    Namelabel.alpha = 1.0;
    Namelabel.tag = 1000;            //公司名称 100
    
    UIView *PhonView = [[UIView alloc] initWithFrame:CGRectMake(0, Namelabel.bottom + kWidth(2), view.width, kWidth(16))];
    [view addSubview:PhonView];
    UITapGestureRecognizer *Phonetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CallPhoneAction:)];
    // 允许用户交互
    PhonView.tag = 2000 + tag;
    PhonView.userInteractionEnabled = YES;
    [PhonView addGestureRecognizer:Phonetap];
    
    UIImageView *PhonImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(5), PhonView.top, kWidth(16), kWidth(16))];
    [view addSubview:PhonImgV];
    PhonImgV.image = kImage(@"phone_img");
    
    UILabel *phonLab = [[UILabel alloc] initWithFrame:CGRectMake(PhonImgV.right + kWidth(3), PhonImgV.top, view.width - PhonImgV.right - kWidth(6), PhonImgV.height)];
    [view addSubview:phonLab];
    phonLab.font =  LightFont(font(11));
    phonLab.textColor = kColor(@"#575757");
    phonLab.text = @"";
    phonLab.tag = 1101;              //联系方式
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, PhonView.bottom + kWidth(5), kWidth(90), 1)];
    lineView.backgroundColor = kColor(@"#05C1B0");
    [view addSubview:lineView];
    lineView.centerX = Namelabel.centerX;
    
    
    UIView *SkrView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.bottom + kWidth(7), view.width/2., view.height - lineView.bottom - kWidth(4))];
    [view addSubview:SkrView];
    
    UITapGestureRecognizer *skrtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skrtapAction:)];
    // 允许用户交互
    SkrView.tag = 2100 + tag;
    SkrView.userInteractionEnabled = YES;
    [SkrView addGestureRecognizer:skrtap];
    
    
    UIImageView *likeImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, SkrView.top, kWidth(16), kWidth(16))];
    likeImg.image = kImage(@"garden-wdz");
    [view addSubview:likeImg];
    likeImg.centerX = SkrView.centerX;
    likeImg.tag = 1201;              //点赞图片
    
    UILabel *skrLab = [[UILabel alloc] initWithFrame:CGRectMake(0, likeImg.bottom + kWidth(2), SkrView.width, SkrView.height - likeImg.height - kWidth(5))];
    [view addSubview:skrLab];
    skrLab.textAlignment = NSTextAlignmentCenter;
    skrLab.font =  LightFont(font(12));
    skrLab.textColor = kColor(@"#575757");
    skrLab.text = @"00";
    skrLab.tag = 1301;               //点赞数量
    
    
    UIView *messView = [[UIView alloc] initWithFrame:CGRectMake(SkrView.right, SkrView.top, SkrView.width, SkrView.height)];
    [view addSubview:messView];
    UITapGestureRecognizer *messtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(messageTapAction:)];
    // 允许用户交互
    messView.tag = 2200 + tag;
    messView.userInteractionEnabled = YES;
    [messView addGestureRecognizer:messtap];
    
    
    UIImageView *liuyanImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, messView.top, kWidth(16), kWidth(16))];
    liuyanImg.image = kImage(@"garden_liuyan");
    [view addSubview:liuyanImg];
    liuyanImg.centerX = messView.centerX;
    
    UILabel *liuyanLab = [[UILabel alloc] initWithFrame:CGRectMake(messView.left, liuyanImg.bottom + kWidth(2), messView.width, messView.height - liuyanImg.height - kWidth(5))];
    [view addSubview:liuyanLab];
    liuyanLab.textAlignment = NSTextAlignmentCenter;
    liuyanLab.font =  LightFont(font(12));
    liuyanLab.textColor = kColor(@"#575757");
    liuyanLab.text = @"00";
    liuyanLab.tag = 1401;
}
- (void) upSubviewData:(NSArray *)arr {
    if (arr.count <= 0) {
        self.userInteractionEnabled = NO;
        return;
    }
    for(int i = 0; i < arr.count; i ++ ) {
        yuanbangModel *model;
        if (i == 0) {
           model = arr[1];
        }else if (i == 1) {
           model = arr[0];
        }else {
           model = arr[i];
        }
        UIView *view = [self viewWithTag:i + 100];
        UILabel *nameLab = (UILabel *)[view viewWithTag:1000];
        nameLab.text = model.gardenCompany;
        
        UILabel *phoLab = [view viewWithTag:1101];
        phoLab.text = model.mobile;
        
        UIImageView *skrImgV = [view viewWithTag:1201];
        UILabel *skrLab = [view viewWithTag:1301];
        skrLab.text = model.gardenSignString;
        if ([model.isClick isEqualToString:@"1"]) {
            skrImgV.image = kImage(@"garden-dz");
            skrLab.textColor = kColor(@"#FF1745");
        }else {
            skrImgV.image = kImage(@"garden-wdz");
            skrLab.textColor = kColor(@"#575757");
        }
        UILabel *liuyanLab = [view viewWithTag:1401];
        liuyanLab.text = model.commentCountString;
    }
}


#pragma - mark 呼叫
-(void)CallPhoneAction:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *views = (UIView*)tap.view;
    NSInteger index = views.tag - 2000;
    if (self.CallPhoneItemBlock) {
        self.CallPhoneItemBlock(index);
    }
   
}
#pragma - mark 点赞
-(void)skrtapAction:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *views = (UIView*)tap.view;
    NSInteger index = views.tag - 2100;
    if (self.SkrItemBlock) {
        self.SkrItemBlock(index);
    }
//    NSLog(@"index 点赞 ==== %ld",index);
}
#pragma - mark 评论
-(void)messageTapAction:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *views = (UIView*)tap.view;
    NSInteger index = views.tag - 2200;
//    NSLog(@"index 评论 ==== %ld",index);
    if (self.messagItemBlock) {
        self.messagItemBlock(index);
    }
}
#pragma - mark
-(void)bgViewAction:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *views = (UIView*)tap.view;
    NSInteger index = views.tag - 100;
    NSLog(@"index  ==== %ld",index);
    if (self.bgViewItemBlock) {
        self.bgViewItemBlock(index);
    }
}

@end



@interface GardenListController () <UITableViewDelegate,UITableViewDataSource,inputViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *dataArr;
    NSInteger page;
    GardenDetailView * _gardPopView;
    
    GardenListHeadView *_headView;          //tableview 的HeadView
    NSMutableArray *headDataArr;
    
    yuanbangModel *pinlunmodel;         //评论model
}
@property (nonatomic, strong) inputView *input;
@end

@implementation GardenListController


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

- (void) setNavigation{
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
    self.view.backgroundColor = kColor(@"#fafafa");
    [self setTitle:self.model.name andTitleColor:kColor(@"#ffffff")];
    page = 1;
    
    headDataArr = [[NSMutableArray alloc] init];
    dataArr = [[NSMutableArray alloc] init];
    [self setNavigation];            //分享
    [self createTableView];
    
    [self getDataModel];
}

- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style: UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
    GardenListHeadView *headView = [[GardenListHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(192) + kWidth(55))];
    _headView = headView;
    _tableView.tableHeaderView = headView;
    WS(weakSelf);
    _headView.CallPhoneItemBlock = ^(NSInteger index) {
        [weakSelf CallPhoneItem:index];
    };
    _headView.SkrItemBlock = ^(NSInteger index) {
        [weakSelf SkrItem:index];
    };
    _headView.messagItemBlock = ^(NSInteger index) {
        [weakSelf pinlunAction:index isHeadView:YES];
    };
    _headView.bgViewItemBlock = ^(NSInteger index) {
        [weakSelf selectPushVcItem:index];
    };

}
-(void)getDataModel{
    NSString *userId = @"";
    if (USERMODEL.userID != nil) {
        userId = USERMODEL.userID;
    }
    
    [self addWaitingView];
    NSDictionary *dic = @{
                          @"gardenCompany" : @"",
                          @"gardenListId"  : @"",
                          @"num"           : @"15",
                          @"pageNum"       : stringFormatInt(page),
                          @"userId"        : userId,
                          @"gardenListUuid": self.model.listUuid,
                          @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                          @"myyuan"        : @"",                                  //为1时查我的园榜
                          };
    [network httpRequestWithParameter:dic method:GardenBangdanListUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        NSDictionary *dict = dic[@"content"];
        NSArray *arr = dict[@"gardenBangs"];
        for (int i = 0; i < arr.count; i ++ ) {
            NSDictionary *mDic = arr[i];
            yuanbangModel *model = [[yuanbangModel alloc] initWithDictionary:mDic error:nil];
            if (i < 3) {
                [self->headDataArr addObject:model];
            }else {
                [self->dataArr addObject:model];
            }
        }
        [self->_headView upSubviewData:self->headDataArr];
        [self->_tableView reloadData];

    } failure:^(NSDictionary * obj) {
         [self removeWaitingView];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GardenListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell =  [[GardenListViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    yuanbangModel *model = dataArr[indexPath.row];
    [cell setYuanbangModel:model andBgImage:@""];
    __weak typeof (self) weekSelf = self;
    cell.SkrBlock = ^(NSInteger i){
        if (i == 0) {
            [weekSelf skrAction:indexPath.row isShowView:NO];
        }else {
             [self showHomeHint:@"已给该公司点赞，其他公司还可以点哦" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        }
    };
    cell.pinlunBlock = ^{
        [weekSelf pinlunAction:indexPath.row isHeadView:NO];
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    yuanbangModel *model = dataArr[indexPath.row];
    GardenListDetailViewController *DeailVc = [[GardenListDetailViewController alloc] init];
    DeailVc.updataCellBlock = ^{
         [self->_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    DeailVc.model = model;
    [self pushViewController:DeailVc];
}


#pragma mark - head-pushDetail
- (void) selectPushVcItem:(NSInteger )index {
    WS(weakSelf);
    yuanbangModel *model;
    if (index == 0) {
        model = headDataArr[1];
    }else if (index == 1) {
        model = headDataArr[0];
    }else {
        model = headDataArr[index];
    }
    GardenListDetailViewController *DeailVc = [[GardenListDetailViewController alloc] init];
    DeailVc.updataCellBlock = ^{
         [self->_headView upSubviewData:self->headDataArr];
    };
    DeailVc.model = model;
    [weakSelf pushViewController:DeailVc];
}

#pragma mark - head-CallPhone
- (void) CallPhoneItem:(NSInteger )index {
    yuanbangModel *model;
    if (index == 0) {
        model = headDataArr[1];
    }else if (index == 1) {
        model = headDataArr[0];
    }else {
        model = headDataArr[index];
    }
    //NSString *phoneStr = [NSString stringWithFormat:@"tel:%@",model.mobile];
    WS(weakSelf);
    if (![model.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",model.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [weakSelf.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
}

#pragma mark - head-SkrItem
- (void) SkrItem:(NSInteger ) index {
    yuanbangModel *model;
    if (index == 0) {
        model = headDataArr[1];
    }else if (index == 1) {
        model = headDataArr[0];
    }else {
        model = headDataArr[index];
    }
    NSString *userId = @"";
    if (USERMODEL.userID != nil) {
        userId = USERMODEL.userID;
    }
    if ([model.isClick isEqualToString:@"1"]) {
         [self showHomeHint:@"已给该公司点赞，其他公司还可以点哦" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        return;
    }
    [self addWaitingView];
    NSDictionary *dic = @{
                          @"gardenId"      : model.gardenId,
                          @"userId"        : userId,
                          @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                          };
    [network httpRequestWithParameter:dic method:GardenLikeUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        NSLog(@"%@ - %@",dic[@"content"],dic[@"errorContent"]);
        model.isClick = @"1";
        
        NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:model.gardenSignString options:NSMatchingReportProgress range:NSMakeRange(0, model.gardenSignString.length)];
        if (tNumMatchCount == model.gardenSignString.length) {
            model.gardenSignString = [NSString stringWithFormat:@"%d",[model.gardenSignString intValue] + 1];
        }
//        model.gardenSign = [NSString stringWithFormat:@"%d",[model.gardenSign intValue] + 1];
        [self->_headView upSubviewData:self->headDataArr];
        [self showHomeHint:@"明天还可以继续哦~" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
    
}

#pragma mark - 企业详情分享
//- (void) shareCompanyAction:(NSInteger ) index {
//    yuanbangModel *model = dataArr[index];
//    //NSString *ClassHomePath = [NSString stringWithFormat:@"pages/gardenRank/gardenDetail/gardenDetail?gardenId=%@",model.gardenId];
//    NSDictionary *dict = @{
//                           @"appid"         : WXXCXappId,
//                           @"appsecret"     : WXXCXappSecret,
//                           @"gardenId"      : model.gardenId,
////                           @"path"          : ClassHomePath,
//                           @"path"          : @"pages/activity/detail/detail?1&2",
//                           };
//    [self shareSmallProgramCodeOject:dict httpMethod:0 methoe:GardenDetailSharelUrl Vc:self completion:^(id data, NSError *error) {
//        
//    }];
//}


#pragma -  mark  点赞
- (void)skrAction:(NSInteger ) index isShowView:(BOOL) isShow {
    yuanbangModel *model = dataArr[index];
    [self addWaitingView];
    NSString *userId = @"";
    if (USERMODEL.userID != nil) {
        userId = USERMODEL.userID;
    }
    NSDictionary *dic = @{
                          @"gardenId"      : model.gardenId,
                          @"userId"        : userId,
                          @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                          };
    [network httpRequestWithParameter:dic method:GardenLikeUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        NSLog(@"%@ - %@",dic[@"content"],dic[@"errorContent"]);
        model.isClick = @"1";
        
        NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:model.gardenSignString options:NSMatchingReportProgress range:NSMakeRange(0, model.gardenSignString.length)];
        if (tNumMatchCount == model.gardenSignString.length) {
            model.gardenSignString = [NSString stringWithFormat:@"%d",[model.gardenSignString intValue] + 1];
        }
//        model.gardenSign = [NSString stringWithFormat:@"%d",[model.gardenSign intValue] + 1];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
        [self->_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        if (isShow == YES) {
            [self->_gardPopView upSubViewDataModel:model];    //刷新cell状态
        }else {
            [self showHomeHint:@"明天还可以继续哦~" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        }
        //     [_tableView reloadData];
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
}

#pragma - mark 分享
- (void) shareAction {
    NSLog(@"--分享---");
    NSString *Path = [NSString stringWithFormat:@"pages/gardenRank/yibai/yibai?gardenListId=%@",self.model.jid];
    NSDictionary *dict = @{
                           @"appid"         : WXXCXappId,
                           @"appsecret"     : WXXCXappSecret,
                           @"path"          : Path,
                           @"id"            : self.model.jid,
                           };
    [self shareSmallProgramCodeOject:dict httpMethod:0 methoe:GardenSharelUrl Vc:self completion:nil];
}
#pragma - mark 评论留言
- (void)pinlunAction:(NSInteger ) index isHeadView:(BOOL) isHeadView{
    WS(weekSelf);
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    [weekSelf showPopupWithStyle:CNPPopupStyleCentered popupView:weekSelf.input];
    [weekSelf.input.inputTextView becomeFirstResponder];
    
    self.input.tapBgViewBlock = ^{
        [weekSelf dismissPopupController];
    };
   
    if (isHeadView == YES) {
        if (index == 0) {
            pinlunmodel = headDataArr[1];
        }else if (index == 1) {
            pinlunmodel = headDataArr[0];
        }else {
            pinlunmodel = headDataArr[index];
        }
    }else {
        pinlunmodel = dataArr[index];
    }
    weekSelf.input.placeLabel.text = [NSString stringWithFormat:@"评论@%@",pinlunmodel.gardenName];
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


- (inputView *)input{
    if (_input == nil) {
        _input = [[inputView alloc] initWithFrame:CGRectMake(0, 0,iPhoneWidth, iPhoneHeight)];
        _input.delegate = self;
    }
    return _input;
}
- (void)sendText:(NSString *)text{
    NSLog(@"发送 === %@",text);
    [self.input inputViewHiden];
    self.input.inputTextView.text = @"";
    [self.popupViewController dismissPopupControllerAnimated:YES];
    [self addWaitingView];
    NSDictionary *dic = @{
                          @"comment"       : text,
                          @"userId"        : USERMODEL.userID,
                          @"type"          : @"0",
                          @"gardenId"      : pinlunmodel.gardenId,
                          @"deviceNumber"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                          };
    [network httpRequestWithParameter:dic method:GardenpingluneUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        
         [self showHomeHint:@"评论成功~" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        if ([self->pinlunmodel.commentCountString integerValue] < 1000) {
            self->pinlunmodel.commentCountString = [NSString stringWithFormat:@"%ld",[self->pinlunmodel.commentCountString integerValue] + 1];
        }
        NSInteger index = [self->pinlunmodel.paiming integerValue];
        if (index <= 3) {
             [self->_headView upSubviewData:self->headDataArr];
            return ;
        }
//        NSInteger index = [pinlunmodel.paiming integerValue];
//        if (index > 3) {
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index - 4  inSection:0];
//            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//        }
        [self->_tableView reloadData];
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
