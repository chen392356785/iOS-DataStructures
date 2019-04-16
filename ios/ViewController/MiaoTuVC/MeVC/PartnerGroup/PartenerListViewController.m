//
//  PartenerListViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/24.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "PartenerListViewController.h"
#import "partenerModel.h"
#import "MessageChatViewController.h"   //聊天
//#import "ULBCollectionViewFlowLayout.h"     //分区背景色


@interface  PartenerListCollectionViewCell : UICollectionViewCell {
    UIImageView *_iconImageView;
    SMLabel *_nameLab;
    SMLabel *_addLab;
    SMLabel *_lineLab;
    partnerList *_partModel;
    UIView *_addBgView;
    UIAsyncImageView *_addImgView;
    
    SMLabel *_CompanyLab;
    
    UIView *liuyanBgView;
    UIView *PhoneBgView;
}
@property (nonatomic, strong) partnerList *model;
@property (nonatomic, strong) userPartner *UserPartenModel;

@property(nonatomic,copy) DidSelectBlock pinlunBlock;
@end

@implementation PartenerListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
//        [self configuration];
    }
    return self;
}
- (void) createSubViews {
    
    UIImageView *HeadimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(kWidth(166)), kWidth(24))];
    HeadimageView.image = kImage(@"img_kpbj");
    _addBgView = HeadimageView;
    HeadimageView.hidden = YES;
    [self addSubview:HeadimageView];
    
    _iconImageView = [[UIAsyncImageView alloc] init];
    _iconImageView.frame = CGRectMake(0, 0, kWidth(43), kWidth(43));
    _iconImageView.layer.cornerRadius = _iconImageView.height/2;
    [self addSubview:_iconImageView];
    
    _nameLab = [[SMLabel alloc] init];
    _nameLab.font = darkFont(font(16));
    _nameLab.textColor = kColor(@"#030303");
    _nameLab.frame = CGRectMake(0, _iconImageView.bottom + kWidth(5), self.width, kWidth(16));
    [self addSubview:_nameLab];
    
    UIAsyncImageView *addImgView = [[UIAsyncImageView alloc] init];
    addImgView.frame = CGRectMake(0, 0 , kWidth(18), kWidth(18));
    [self addSubview:addImgView];
    
    _addImgView = addImgView;
    
    
    _addLab = [[SMLabel alloc] init];
    _addLab.font = sysFont(font(14));
    _addLab.textColor = kColor(@"#575757");
    _addLab.frame = CGRectMake(addImgView.right + kWidth(6), addImgView.top, iPhoneWidth/2 - addImgView.left - kWidth(6), addImgView.height);
    [self addSubview:_addLab];
    _addLab.adjustsFontSizeToFitWidth = YES;
    
    _CompanyLab = [[SMLabel alloc] init];
    _CompanyLab.font = sysFont(font(14));
    _CompanyLab.textColor = kColor(@"#575757");
    _CompanyLab.numberOfLines = 0;
    [self addSubview:_CompanyLab];
    
    
    
    
    liuyanBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kWidth(174) - kWidth(50), kWidth(45), kWidth(50))];
    [self addSubview:liuyanBgView];
    UIImageView *liuyanImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(15), kWidth(15))];
    liuyanImg.centerX = liuyanBgView.width/2;
    liuyanImg.centerY = liuyanBgView.height/4;
    liuyanImg.image = kImage(@"garden_liuyan");
    [liuyanBgView addSubview:liuyanImg];
    
    UILabel *liuyanLab = [[UILabel alloc] initWithFrame:CGRectMake(0, liuyanBgView.height/2, liuyanBgView.width, kWidth(25))];
    liuyanLab.font = darkFont(13);
    liuyanLab.textAlignment = NSTextAlignmentCenter;
    liuyanLab.textColor = kColor(@"#787878");
    liuyanLab.text = @"聊天";
    [liuyanBgView addSubview:liuyanLab];
    
    UITapGestureRecognizer *liuyanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liuyanAction)];
    // 允许用户交互
    PhoneBgView.userInteractionEnabled = YES;
    [liuyanBgView addGestureRecognizer:liuyanTap];
    
    
    PhoneBgView = [[UIView alloc] initWithFrame:CGRectMake(liuyanBgView.right, kWidth(174) - kWidth(50), liuyanBgView.width, kWidth(50))];
    [self addSubview:PhoneBgView];
    UIImageView *PhoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(15), kWidth(15))];
    PhoneImg.centerX = liuyanBgView.width/2;
    PhoneImg.centerY = liuyanBgView.height/4;
    PhoneImg.image = kImage(@"phone_img");
    [PhoneBgView addSubview:PhoneImg];
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(0, PhoneBgView.height/2, PhoneBgView.width, kWidth(25))];
    phoneLab.font = darkFont(13);
    phoneLab.textAlignment = NSTextAlignmentCenter;
    phoneLab.text = @"电话";
    phoneLab.textColor = kColor(@"#787878");
    [PhoneBgView addSubview:phoneLab];
    
    UITapGestureRecognizer *Phonetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CallPhoneAction)];
    // 允许用户交互
    PhoneBgView.userInteractionEnabled = YES;
    [PhoneBgView addGestureRecognizer:Phonetap];
    
    _lineLab = [[SMLabel alloc] initWithFrame:CGRectMake(0, kWidth(174) - kWidth(52) , _addBgView.width, 1)];
    _lineLab.backgroundColor = cLineColor;
//    _lineLab.hidden = YES;
    [self addSubview:_lineLab];
    
    self.layer.cornerRadius = 4;
    self.layer.shadowColor = kColor(@"#EEEEEE").CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 5);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 3;
    
}
- (void)setModel:(partnerList *)model {
    self.backgroundColor = kColor(@"#FEFDFD");
    self.layer.cornerRadius = kWidth(7);
    _partModel = model;
    _addBgView.hidden = NO;
    _addImgView.frame = CGRectMake(kWidth(7), 0, kWidth(17), kWidth(17));
    _addImgView.centerY = _addBgView.centerY;
    _addImgView.image = kImage(@"icon_dingwei_qt");
    _addLab.frame = CGRectMake(_addImgView.right + kWidth(3), 0, kWidth(160) - _addImgView.right - kWidth(5), _addImgView.height);
    _addLab.centerY = _addImgView.centerY;
    _addLab.text = model.parterAddress;
    _addLab.textColor = kColor(@"#FFFFFF");
    
    _iconImageView.frame = CGRectMake(kWidth(7), _addBgView.bottom + kWidth(21), kWidth(43), kWidth(43));
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.heedImageUrl] placeholderImage:defalutHeadImage];
    _nameLab.frame = CGRectMake(_iconImageView.right + kWidth(8), _iconImageView.top, _addBgView.width - _iconImageView.right - kWidth(8), kWidth(15));
    _nameLab.font = darkFont(13);
    _nameLab.text = [NSString stringWithFormat:@"%@",model.partnerName];
    
    _CompanyLab.frame = CGRectMake(_nameLab.left, _nameLab.bottom + kWidth(9), _nameLab.width - kWidth(8) , kWidth(29));
    _CompanyLab.text = model.parterCompany;
    _CompanyLab.textColor = kColor(@"#868686");
    _CompanyLab.font = darkFont(12);
    [_CompanyLab sizeToFit];
    
    _lineLab.frame = CGRectMake(0, PhoneBgView.top - kWidth(2), _addBgView.width, 1);
    _lineLab.hidden = NO;
    liuyanBgView.centerX = _addBgView.width/4;
    PhoneBgView.centerX = _addBgView.width - _addBgView.width/4;
    
}
- (void)setUserPartenModel:(userPartner *)UserPartenModel {
    _partModel = [[partnerList alloc] initWithDictionary:[UserPartenModel toDictionary] error:nil];
    self.backgroundColor = kColor(@"#FFFFFF");
    self.layer.cornerRadius = kWidth(0);
    _addBgView.hidden = YES;
    _addImgView.image = kImage(@"me_weizhi");
    _addImgView.frame = CGRectMake(kWidth(13), kWidth(22), kWidth(18), kWidth(18));
    _addLab.frame = CGRectMake(_addImgView.right + kWidth(5), 0, 120, _addImgView.height);
    _addLab.centerY = _addImgView.centerY;
    NSString *cityStr;
    if (USERMODEL.city) {
        cityStr = USERMODEL.city;
    }else {
        cityStr = @"杭州";
    }
    _addLab.text = [NSString stringWithFormat:@"%@%@",cityStr,@"(当前城市)"];
    [_addLab sizeToFit];
    
    
    _iconImageView.frame = CGRectMake(0, kWidth(17), kWidth(43), kWidth(43));
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:UserPartenModel.heedImageUrl] placeholderImage:defalutHeadImage];
    _iconImageView.centerX = iPhoneWidth/2;
    
    _nameLab.frame = CGRectMake(0, _iconImageView.bottom + kWidth(5), iPhoneWidth - kWidth(8), kWidth(16));
    _nameLab.font = darkFont(16);
    _nameLab.centerX = _iconImageView.centerX;
    _nameLab.textAlignment = NSTextAlignmentCenter;
    _nameLab.textColor = kColor(@"#1D1D1D");
    _nameLab.text = [NSString stringWithFormat:@"%@",UserPartenModel.partnerName];
    
    _CompanyLab.frame = CGRectMake(0, _nameLab.bottom + kWidth(16), _nameLab.width - kWidth(8) , kWidth(15));
    _CompanyLab.text = UserPartenModel.parterCompany;
//    [_contAddLab sizeToFit];
    _CompanyLab.textColor = kColor(@"#4A4A4A");
    _CompanyLab.textAlignment = NSTextAlignmentCenter;
    _CompanyLab.font = darkFont(14);
    
    _lineLab.frame = CGRectMake(0, PhoneBgView.top - kWidth(2), iPhoneWidth - kWidth(28), 1);
    _lineLab.hidden = NO;
    _lineLab.centerX = iPhoneWidth/2;
    if ([UserPartenModel.jid isEqualToString:@""]) {
        _nameLab.text = @"???";
        _CompanyLab.text = @"当前城市暂无城市合伙人哦~";
        liuyanBgView.alpha = 0.7;
        liuyanBgView.userInteractionEnabled = NO;
        PhoneBgView.alpha = 0.7;
        PhoneBgView.userInteractionEnabled = NO;
    }
    
    liuyanBgView.centerX = _iconImageView.left - kWidth(17) - liuyanBgView.width/2;
    PhoneBgView.centerX = _iconImageView.right + kWidth(17) + liuyanBgView.width/2;
    liuyanBgView.centerY = kWidth(192) - liuyanBgView.height/2;
    PhoneBgView.centerY = liuyanBgView.centerY;
}
#pragma - mark 留言
- (void) liuyanAction {
    if (self.pinlunBlock) {
        self.pinlunBlock();
    }
}

#pragma - mark 打电话
- (void) CallPhoneAction {
    if (![_partModel.parterMobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",_partModel.parterMobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.contentView addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
}

@end



@interface PartenerListViewController () <UICollectionViewDelegate,UICollectionViewDataSource> {
    NSMutableArray *dataArr;
    partenerModel *_model;
//    UITableView *_tableView;
    UIAsyncImageView *_headImagView;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *partenerListCellId    = @"PartenerListCollectionViewCell";
static NSString *partenerListOneCellId = @"PartenerListCollectionViewOneCell";

static NSIndexPath *currentIndex;


@implementation PartenerListViewController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(48), iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(48)) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kColor(@"#F7F7F7");
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //注册Cell，必须要有
        [_collectionView registerClass:[PartenerListCollectionViewCell class] forCellWithReuseIdentifier:partenerListCellId];
        [_collectionView registerClass:[PartenerListCollectionViewCell class] forCellWithReuseIdentifier:partenerListOneCellId];
        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市合伙人";
    dataArr = [[NSMutableArray alloc] init];
    
    NSLog(@"%f === %f",USERMODEL.latitude,USERMODEL.longitude);
    
    [self createCollectionView];
    NSDictionary *Parameter = @{
                                @"latitude"  : stringFormatDouble(USERMODEL.latitude),
                                @"longitude" : stringFormatDouble(USERMODEL.longitude),
                                };
    [self getPartenerListData:Parameter];
}


- (void)dealloc {
    NSLog(@"释放====");
}


- (void) getPartenerListData:(NSDictionary *)paramter {
    [self addWaitingView];
    [network httpRequestWithParameter:paramter method:partnerListUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        partenerModel *model = [[partenerModel alloc] initWithDictionary:dic[@"content"] error:nil];
		self->_model = model;
        for (partnerList *ListModel in model.partnerList) {
			[self->dataArr addObject:ListModel];
        }
		[self->_collectionView reloadData];
    } failure:^(NSDictionary *dic) {
        [self removeWaitingView];
    }];
}
- (void) createCollectionView {
    _headImagView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(48))];
    [self.view addSubview:_headImagView];
    _headImagView.image = kImage(@"img_parten_banner");
    [self.view addSubview:self.collectionView];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return dataArr.count;
    }
}
//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(iPhoneWidth, kWidth(192));
    }else {
        return CGSizeMake(kWidth(166), kWidth(174));
    }
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (iPhoneWidth - kWidth(186) * 2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kWidth(18);
}

//四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        return UIEdgeInsetsMake(kWidth(22), kWidth(16), kWidth(22), kWidth(16));
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    partnerList *model = dataArr[indexPath.row];
    MessageChatViewController *chatVc = [[MessageChatViewController alloc] init];
    chatVc.PartModel = model;
    [self pushViewController:chatVc];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    if (indexPath.section == 0) {
        PartenerListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:partenerListOneCellId forIndexPath:indexPath];
        userPartner *mode = _model.userPartner;
        cell.UserPartenModel = mode;
        partnerList *ListModel = [[partnerList alloc] initWithDictionary:[mode toDictionary] error:nil];
        cell.pinlunBlock = ^{
            MessageChatViewController *chatVc = [[MessageChatViewController alloc] init];
            chatVc.PartModel = ListModel;
            [weakSelf pushViewController:chatVc];
        };
        return cell;
    }else {
        PartenerListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:partenerListCellId forIndexPath:indexPath];
        partnerList *ListModel = dataArr[indexPath.row];
        cell.model = ListModel;
        cell.pinlunBlock = ^{
            MessageChatViewController *chatVc = [[MessageChatViewController alloc] init];
            chatVc.PartModel = ListModel;
            [weakSelf pushViewController:chatVc];
        };
        return cell;
    }
}


@end
