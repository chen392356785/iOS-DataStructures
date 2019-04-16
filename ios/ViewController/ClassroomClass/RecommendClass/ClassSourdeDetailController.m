//
//  ClassSourdeDetailController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/17.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ClassSourdeDetailController.h"

//#import "SignUpSuccessViewController.h"

//#import "LXAVPlayer.h"
#import "MiaoBiInfoViewController.h"


@interface ClassImageModel : JSONModel
@property (nonatomic) NSString <Optional>* imgUrl;
@end
@implementation ClassImageModel
@end


@interface ClassListDetailViewCell : UITableViewCell {
    UILabel *_numLab;
    UILabel *_titleLab;
    UILabel *_timteLab;
    UILabel *_lastLab;
}

- (void) setsubjectVoListModel:(subjectVoLisModel *)model andSelect:(NSString *)select OrNumber:(NSString *)number;

@end


@implementation ClassListDetailViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubView];
    }
    return self;
}
- (void) createSubView {
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(14), 0, 21, 21)];
    lab.font = HBoldFont(12);
    lab.centerY = kWidth(75)/2;
    [self.contentView addSubview:lab];
    _numLab = lab;
    _numLab.textAlignment = NSTextAlignmentCenter;
    _numLab.textColor = kColor(@"#FFFFFF");
    _numLab.layer.cornerRadius = _numLab.height/2.;
    _numLab.clipsToBounds = YES;
    
    lab = [[UILabel alloc] initWithFrame:CGRectMake(_numLab.right + kWidth(15), kWidth(15), iPhoneWidth - _numLab.right - kWidth(42), kWidth(18))];
    lab.font = darkFont(font(14));
    [self.contentView addSubview:lab];
    _titleLab = lab;
    
    lab = [[UILabel alloc] initWithFrame:CGRectMake(_titleLab.left, _titleLab .bottom + kWidth(10), _titleLab.width/2, kWidth(15))];
    lab.font = darkFont(font(13));
    [self.contentView addSubview:lab];
    _timteLab = lab;
    
    lab = [[UILabel alloc] initWithFrame:CGRectMake(_timteLab.right , _timteLab.top, _titleLab.width/2, kWidth(15))];
    lab.font = darkFont(font(13));
    [self.contentView addSubview:lab];
    _lastLab = lab;
    _lastLab.hidden = YES;
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - kWidth(326),  kWidth(74), kWidth(326) , 1)];
    lineLab.backgroundColor = kColor(@"#EEEEEE");
    [self.contentView addSubview:lineLab];
    
}
- (void) setsubjectVoListModel:(subjectVoLisModel *)model andSelect:(NSString *)select OrNumber:(NSString *)number {
    _titleLab.text = model.subName;

    NSString *TimeStr =  [IHUtility retureTimeDate:[model.subTime intValue]];
    
    
    _timteLab.text = [NSString stringWithFormat:@"%@",TimeStr];
    _lastLab.text = [NSString stringWithFormat:@"上次学%@",model.lastHmsTime];
    _numLab.text = number;
    if ([select isEqualToString:@"1"]) {  //选中
        _titleLab.textColor = kColor(@"#05C1B0");
        _timteLab.textColor = kColor(@"#05C1B0");
        _lastLab.textColor = kColor(@"#05C1B0");
        _numLab.backgroundColor = kColor(@"#05C1B0");
    }else {
        _titleLab.textColor = kColor(@"#434343");
        _timteLab.textColor = kColor(@"#707070");
        _lastLab.textColor = kColor(@"#707070");
        _numLab.backgroundColor = kColor(@"#BDBDBD");
        
    }
}
@end




@interface ClassSourceDetailViewCell : UITableViewCell {
    UIImageView *_imageView;
}

@property (nonatomic,assign) CGFloat leftSpaceWidth;
//- (void) setimagUrl:(NSString *)imgUrl;
@property (nonatomic,strong)  ClassImageModel *model;

@end


@implementation ClassSourceDetailViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
    }
    return self;
}
- (void) layoutSubviews {
    _imageView.frame = CGRectMake(0, 0, self.width, self.height);
}
- (void) setimagUrl:(NSString *)imgUrl {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:DefaultImage_logo];
    [self setupAutoHeightWithBottomView:_imageView bottomMargin:kWidth(0.0)];
}

- (void)setModel:(ClassImageModel *)model {
     [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:DefaultImage_logo];
//    [self setupAutoHeightWithBottomView:_imageView bottomMargin:kWidth(0.0)];
}

@end


@interface ClassSourdeDetailController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
//	UITableView *_tableView;
//	studyBannerListModel *DetailModel;
//	UIView *_headView;
	ClassDetailModel *_DetailModel;
	UIScrollView *_scrollView;
	
	UIButton *_listBut;     //选集But
	UIButton *_DetailBut;   //详情But
	
	NSString *_currentUrl;  //VedioUrl
	
	UILabel *_InfoLab;   //VIP免费观看
	UIButton *_PayVip;   //去开通VIP
	UIView *_VideoView;
	NSMutableArray *imagArr;    //详情图片
	
	CAGradientLayer* ListGl;
	CAGradientLayer* DetailG1;
	CAGradientLayer* VipButGl;
	UIView *ListView;
	UIView *DetailView;
	CGFloat imgHeight;
}

@property(nonatomic,strong)LXAVPlayView *playerview;
@property(nonatomic,strong)UIView *playFatherView;


@end
static NSIndexPath *_currentIndex;
static NSString *ClassSourceHeadCellId = @"ClassSourceDetailHeadViewCell";
static NSString *ClassSourceDetailCellId = @"ClassListDetailViewCell";

@implementation ClassSourdeDetailController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //禁用侧滑手势方法
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
//    [leftbutton setImage:kImage(@"icon_fh_b-1") forState:UIControlStateNormal];
    [self.navigationController.navigationBar setTranslucent:false];
    
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    if (self.playerview.superview == _VideoView) {
        [self.playerview destroyPlayer];
    }
}


- (void)dealloc {
    [self.playerview destroyPlayer];
    NSLog(@"====Class === 销毁======");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(@"#FFFFFF");
    _currentIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    imagArr = [[NSMutableArray alloc]init];
    [self reloadData];
}
- (void) createView {
    UIView *VideoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(253))];
    VideoView.backgroundColor = kColor(@"#000000");
    [self.view addSubview:VideoView];
    _VideoView = VideoView;
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 15)];
    infoLab.text = @"VIP会员可免费观看";
    [VideoView addSubview:infoLab];
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.textColor = kColor(@"#FFFFFF");
    infoLab.font = HBoldFont(13);
    infoLab.centerY = VideoView.height/2 - 10;
    UIButton *payBut = [UIButton buttonWithType:UIButtonTypeSystem];
    payBut.frame = CGRectMake(0, infoLab.bottom + kWidth(15), kWidth(145), kWidth(35));
    
    VipButGl = [self retureCagradColor:kColor(@"#05C1B0") andColor:kColor(@"#22ECDA") andBounds:payBut.bounds];
    VipButGl.cornerRadius = payBut.height/2;
    [payBut.layer addSublayer:VipButGl];
    payBut.layer.cornerRadius = payBut.height/2;
    
    [self.view addSubview:payBut];
    payBut.centerX = VideoView.width/2;
    [payBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    [payBut setTitle:@"开通VIP会员" forState:UIControlStateNormal];
    payBut.backgroundColor = kColor(@"#22ECDA");
    [payBut addTarget:self action:@selector(GoPayVipAction) forControlEvents:UIControlEventTouchUpInside];
    _InfoLab = infoLab;
    _PayVip = payBut;
    
    CGRect rect = CGRectMake(0, 0 , iPhoneWidth, kWidth(253));
    self.playFatherView =[[UIView alloc]initWithFrame:rect];
    if (_currentUrl == nil || _currentUrl.length <= 0) {
        _InfoLab.hidden = NO;
        _PayVip.hidden = NO;
        [self.playFatherView removeFromSuperview];
        
    }else {
        _InfoLab.hidden = YES;
        _PayVip.hidden = YES;
        [VideoView addSubview:self.playFatherView];
    }
    
    LXPlayModel *model =[[LXPlayModel alloc]init];
    model.playUrl = _currentUrl;
    model.fatherView = self.playFatherView;
    self.playerview =[[LXAVPlayView alloc]init];
    //不支持横屏
    self.playerview.isLandScape = NO;
    self.playerview.isAutoReplay = NO;
    self.playerview.currentModel = model;
    
    WS(weakSelf);
    self.playerview.backBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    
    UILabel *TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), VideoView.bottom + kWidth(20), iPhoneWidth - kWidth(24), kWidth(20))];
    TitleLab.textColor = kColor(@"#191919");
    TitleLab.font = boldFont(font(15));
    [self.view addSubview:TitleLab];
    TitleLab.text = _DetailModel.className;
    
    UILabel *InfoLab = [[UILabel alloc] initWithFrame:CGRectMake(TitleLab.left, TitleLab.bottom + kWidth(15), TitleLab.width, kWidth(14))];
    InfoLab.textColor = kColor(@"#888888");
    InfoLab.font = darkFont(font(13));
    [self.view addSubview:InfoLab];
    InfoLab.text = _DetailModel.intro;
    [InfoLab sizeToFit];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, InfoLab.bottom + kWidth(21), iPhoneWidth, 1)];
    lineLab.backgroundColor = kColor(@"#F8F8FA");
    [self.view addSubview:lineLab];
    
    ListView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(11), lineLab.bottom + kWidth(30), kWidth(75), kWidth(27))];
    ListGl = [self retureCagradColor:kColor(@"#05C1B0") andColor:kColor(@"#22ECDA") andBounds:ListView.bounds];
    ListGl.cornerRadius = ListView.height/2;
    ListView.layer.cornerRadius = ListView.height/2;
    [ListView.layer addSublayer:ListGl];
    [self.view addSubview:ListView];
    
    
    UIButton *ListBut = [UIButton buttonWithType:UIButtonTypeSystem];
    ListBut.frame = ListView.frame;
    ListBut.layer.cornerRadius = ListBut.height/2;
    [self.view addSubview:ListBut];

    [ListBut setTitle:@"选集" forState:UIControlStateNormal];
    ListBut.titleLabel.font = darkFont(font(16));
    [ListBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    [ListBut addTarget:self action:@selector(SelectClassAction) forControlEvents:UIControlEventTouchUpInside];
    _listBut = ListBut;
    
    
    DetailView = [[UIView alloc] initWithFrame:CGRectMake(ListBut.right + kWidth(10), lineLab.bottom + kWidth(30), kWidth(88), kWidth(27))];
    DetailView.layer.cornerRadius = DetailView.height/2;
    DetailG1 = [self retureCagradColor:kColor(@"#05C1B0") andColor:kColor(@"#22ECDA") andBounds:DetailView.bounds];
    DetailG1.cornerRadius = DetailView.height/2;
    [self.view addSubview:DetailView];
    
    UIButton *detailBut = [UIButton buttonWithType:UIButtonTypeSystem];
    detailBut.frame = DetailView.frame;
    detailBut.layer.cornerRadius = ListBut.height/2;
    [self.view addSubview:detailBut];
//    [detailBut.layer addSublayer:DetailG1];
    
    [detailBut setTitle:@"课程说明" forState:UIControlStateNormal];
    detailBut.titleLabel.font = darkFont(font(14));
    [detailBut setTitleColor:kColor(@"#484848") forState:UIControlStateNormal];
    [detailBut addTarget:self action:@selector(ClassIntroAction) forControlEvents:UIControlEventTouchUpInside];
    _DetailBut = detailBut;
    
    
    UILabel *ClassNumLab = [[UILabel alloc] initWithFrame:CGRectMake( detailBut.right + kWidth(20), detailBut.top, iPhoneWidth - detailBut.right - kWidth(34), detailBut.height)];
    ClassNumLab.textColor = kColor(@"#888888");
    ClassNumLab.font = darkFont(13);
    ClassNumLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:ClassNumLab];
    ClassNumLab.text = [NSString stringWithFormat:@"更新至%@集（共%@）集",_DetailModel.updateNum,_DetailModel.classNum];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 , ListBut.bottom + kWidth(10), iPhoneWidth, iPhoneHeight - ListBut.bottom - kWidth(10))];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    for (int i = 0; i < 2; i ++) {
       UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * iPhoneWidth, 0, iPhoneWidth, scrollView.height) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 100 + i;
        [scrollView addSubview:tableView];
    }
    _scrollView.contentSize = CGSizeMake(iPhoneWidth * 2, scrollView.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
}
//选集
- (void) SelectClassAction {
    [UIView animateWithDuration:0.3 animations:^{
        self->_scrollView.contentOffset = CGPointMake(0, 0);
        [self->ListView.layer addSublayer:self->ListGl];
        self->_listBut.titleLabel.font = darkFont(font(16));
        [self->_listBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
        
        self->_DetailBut.titleLabel.font = darkFont(font(14));
        [self->DetailG1 removeFromSuperlayer];
        [self->_DetailBut setTitleColor:kColor(@"#484848") forState:UIControlStateNormal];
    }];
}
//课程详情
- (void) ClassIntroAction {
    [UIView animateWithDuration:0.3 animations:^{
        self->_scrollView.contentOffset = CGPointMake(iPhoneWidth, 0);
        self->_DetailBut.titleLabel.font = darkFont(font(16));
        [self->DetailView.layer addSublayer:self->DetailG1];
        [self->_DetailBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
        
        self->_listBut.titleLabel.font = darkFont(font(14));
        [self->ListGl removeFromSuperlayer];
        [self->_listBut setTitleColor:kColor(@"#484848") forState:UIControlStateNormal];
       
    }];
    
}
- (void) reloadData {
//    [self addPushViewWaitingView];
    [self addWaitingView];
    NSString *DetailUrl = [NSString stringWithFormat:@"%@/%@",selectClassDetailUrl,self.model.classUuid];
    [network httpGETRequestTagWithParameter:nil method:DetailUrl tag:IH_init success:^(NSDictionary *dic) {
        [self removeWaitingView];
//        [self removePushViewWaitingView];
         NSDictionary *tDic = dic[@"content"];
        ClassDetailModel *model = [[ClassDetailModel alloc] initWithDictionary:tDic error:nil];
        if (model.subjectVoLis.count > 0) {
            subjectVoLisModel *subModel = model.subjectVoLis[0];
            self->_currentUrl = subModel.subUrl;
        }
        for (NSString *str in model.contentImgList) {
             ClassImageModel *model = [[ClassImageModel alloc] init];
             model.imgUrl = str;
             [self->imagArr addObject:model];
        }
        if (self->imagArr.count > 0) {
            ClassImageModel *tmodel = self->imagArr[0];
            UIImage *imag= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tmodel.imgUrl]]];
             self->imgHeight = imag.size.height*iPhoneWidth/imag.size.width;
        }
        
        self->_DetailModel = model;
        [self createView];
    } failure:^(NSDictionary *obj2) {
//        [self removePushViewWaitingView];
        [self removeWaitingView];
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        return _DetailModel.subjectVoLis.count;
    }else {
        return imagArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        return kWidth(75);
    }else {
        ClassImageModel *model = imagArr[indexPath.row];
        if (imgHeight > 0 && indexPath.row < imagArr.count - 1) {
            return imgHeight;
        }else {
            UIImage *imag= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgUrl]]];
            return imag.size.height*iPhoneWidth/imag.size.width;
        }
//        CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ClassSourceHeadCellId class] contentViewWidth:iPhoneWidth];
//        return height;
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 101) {
        return kWidth(110);
    }else {
        return kWidth(75);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        ClassListDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ClassSourceDetailCellId];
        if (cell == nil) {
            cell =  [[ClassListDetailViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ClassSourceDetailCellId];
        }
        cell.selectionStyle = UITableViewCellStyleDefault;
        subjectVoLisModel *model = _DetailModel.subjectVoLis[indexPath.row];
        if (indexPath == _currentIndex && _currentUrl.length > 0) {
            [cell setsubjectVoListModel:model andSelect:@"1" OrNumber:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
        }else {
            [cell setsubjectVoListModel:model andSelect:@"0" OrNumber:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
        }
        
        return cell;
    }else {
        ClassSourceDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ClassSourceHeadCellId];
        if (cell == nil) {
            cell =  [[ClassSourceDetailViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ClassSourceHeadCellId];
        }
        cell.selectionStyle = UITableViewCellStyleDefault;
//        [cell setimagUrl:_DetailModel.contentImgList[indexPath.row]];

        ClassImageModel *model = imagArr[indexPath.row];
        cell.model = model;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        WS(weakSelf);
        if (indexPath != _currentIndex) {
            subjectVoLisModel *subModel = _DetailModel.subjectVoLis[indexPath.row];
            _currentUrl = subModel.subUrl;
            LXPlayModel *model =[[LXPlayModel alloc]init];
            model.playUrl = _currentUrl;
            model.fatherView = weakSelf.playFatherView;
            weakSelf.playerview.currentModel = model;
            _currentIndex = indexPath;
            [tableView reloadData];
        }else {
            
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_scrollView.contentOffset.x >= iPhoneWidth) {
        [self ClassIntroAction];
    }else {
        [self SelectClassAction];
    }
}
#pragma - mark  课堂分享
//- (void) DetailshareAction {
//    NSString *ClassPath = [NSString stringWithFormat:@"pages/classDetail/main?%@&%@",DetailModel.jid,@"2"
//                          ];
//    NSDictionary *dict = @{
//                           @"appid"     :WXKTXappId,
//                           @"appsecret" :WXKTXappSecret,
//                           @"type"      :@"2",
//                           @"path"      :ClassPath,
//                           @"id"        :DetailModel.jid,
//                           };
//    [self shareSmallProgramCodeOject:dict httpMethod:0 methoe:ClassSourceShareUrl Vc:self completion:nil];
////    NSLog(@"分享");
//}

//- (void) signUpSuccessVc {
//    SignUpSuccessViewController * SuccVc = [[SignUpSuccessViewController alloc] init];
//    SuccVc.DetailModel = DetailModel;
//    [self pushViewController:SuccVc];
//    
//}

- (void) GoPayVipAction {
    MiaoBiInfoViewController *VipVc = [[MiaoBiInfoViewController alloc] init];
    //            VipVc.NameTitle = @"加入VIP";
    [VipVc setTitle:@"加入VIP" andTitleColor:kColor(@"#393838")];
    VipVc.type = 1;
    //            VipVc.navBg = @"img_joinVip_img";
    
    VipVc.mUrl=[NSURL URLWithString:_DetailModel.vipUrl];
    [self pushViewController:VipVc];
//    WS(weakSelf);
    VipVc.lianxiKefuBlock = ^{
        
    };
    NSLog(@"加入vip");
}
@end
