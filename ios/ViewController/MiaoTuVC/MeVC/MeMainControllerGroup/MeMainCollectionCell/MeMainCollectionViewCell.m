//
//  MeMainCollectionViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MeMainCollectionViewCell.h"

#import "MTCollectionLayout.h"

@implementation MeMainCollectionViewCell

@end

@interface MeMainHeadCollectionViewCell () {
    UIImageView *huiyuImage;
    UIView *BgSubView;

}

@end
@implementation MeMainHeadCollectionViewCell 
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
        [self configuration];
    }
    return self;
}
- (void) createSubViews {
    _headerImageView = [[UIAsyncImageView alloc] init];
    _headerImageView.frame = CGRectMake(kWidth(15), kWidth(23), kWidth(58), kWidth(58));
    [self addSubview:_headerImageView];
    _headerImageView.layer.cornerRadius = _headerImageView.height/2.;
    
    UILabel *EditInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, _headerImageView.height - kWidth(22), _headerImageView.width, kWidth(22))];
    EditInfo.text = @"编辑资料";
    EditInfo.backgroundColor = kColor(@"#000000");
    EditInfo.alpha = 0.33;
    EditInfo.font = boldFont(font(10));
    EditInfo.textColor = kColor(@"#FFFFFF");
    EditInfo.textAlignment = NSTextAlignmentCenter;
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(EditInfoTag:)];
    // 允许用户交互
    _headerImageView.userInteractionEnabled = YES;
    EditInfo.userInteractionEnabled = YES;
//    [EditInfo addGestureRecognizer:tapGes];
//    [_headerImageView addSubview:EditInfo];
    
    _nickNameLbl = [[SMLabel alloc] init];
    _nickNameLbl.frame = CGRectMake(_headerImageView.right + kWidth(14), _headerImageView.top + kWidth(5), iPhoneWidth - _headerImageView.right - kWidth(60), kWidth(17));
    _nickNameLbl.font = sysFont(font(17));
    [self addSubview:_nickNameLbl];
    
    _settingBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [_settingBut setTitle:@"设置" forState:UIControlStateNormal];
    [_settingBut setTitleColor:kColor(@"#333333") forState:UIControlStateNormal];
    _settingBut.titleLabel.font = sysFont(font(16));
    _settingBut.frame = CGRectMake(iPhoneWidth - kWidth(12) - kWidth(35), _headerImageView.top + kWidth(5), kWidth(35), kWidth(17));
    [_settingBut addTarget:self action:@selector(SettingAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingBut];
    
    huiyuImage = [[UIImageView alloc] initWithFrame:CGRectMake(_nickNameLbl.left, _nickNameLbl.bottom + kWidth(9), kWidth(15), kWidth(15))];
    [self addSubview:huiyuImage];
    huiyuImage.hidden = YES;
    huiyuImage.image = kImage(@"User_Vip");
    
    _isVipLbl = [[SMLabel alloc] init];
    _isVipLbl.frame = CGRectMake(huiyuImage.right + kWidth(8), huiyuImage.top, kWidth(90), kWidth(13));
    
    [self addSubview:_isVipLbl];
    
    _VipTypeLbl = [[SMLabel alloc] init];
    _VipTypeLbl.frame = CGRectMake(_isVipLbl.right + kWidth(18), _nickNameLbl.bottom + kWidth(7), kWidth(51), kWidth(20));
    [self addSubview:_VipTypeLbl];
    UITapGestureRecognizer *vipGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(VipTypeTag:)];
    // 允许用户交互
    _VipTypeLbl.userInteractionEnabled = YES;
    [_VipTypeLbl addGestureRecognizer:vipGes];
    
    
    BgSubView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerImageView.bottom + kWidth(25), iPhoneWidth, kWidth(40))];
    [self addSubview:BgSubView];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, BgSubView.bottom + kWidth(17), iPhoneWidth, 1)];
    lineLab.backgroundColor = cLineColor;
    [self addSubview:lineLab];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(15), lineLab.bottom + kWidth(17), kWidth(100), kWidth(15))];
    lab.textColor = kColor(@"#080808");
    lab.text = @"我的兑换码";
    lab.font = boldFont(font(14));
    [self addSubview:lab];
    
    UILabel *duihLab = [UILabel new];
    duihLab.frame = CGRectMake(iPhoneWidth - kWidth(100) - kWidth(10) , 0, kWidth(100), kWidth(15));
    duihLab.text = @"点击兑换 >";
    duihLab.textColor = kColor(@"#4C4C4C");
    duihLab.font = boldFont(font(13));
    duihLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:duihLab];
    duihLab.centerY = lab.centerY;
    UITapGestureRecognizer *duihtapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(duihuanAction)];
    // 允许用户交互
    duihLab.userInteractionEnabled = YES;
    [duihLab addGestureRecognizer:duihtapGes];
}
//兑换会员
- (void) duihuanAction {
    if (self.duihuanBlock) {
        self.duihuanBlock();
    }
}
- (void) configuration {
    _isVipLbl.font = sysFont(font(13));
    _isVipLbl.textColor = kColor(@"#727272");
    
    _VipTypeLbl.layer.cornerRadius = _VipTypeLbl.height/2.;
    _VipTypeLbl.backgroundColor = kColor(@"#FFD736");
    _VipTypeLbl.font = darkFont(font(13));
    _VipTypeLbl.textColor = kColor(@"#FFFFFF");
    _VipTypeLbl.clipsToBounds = YES;
    _VipTypeLbl.textAlignment = NSTextAlignmentCenter;
  
}

#pragma mark - 编辑资料
-(void)EditInfoTag:(UITapGestureRecognizer *)sender{
    if (self.UserEditBlock) {
        self.UserEditBlock();
    }
}
#pragma mark - 加入vip Or 续费
-(void)VipTypeTag:(UITapGestureRecognizer *)sender{
    if (self.JoinVipBlock) {
        self.JoinVipBlock();
    }
}
-(void)ItemTag:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *views = (UIView*)tap.view;
    NSInteger tag = views.tag;
    if (self.UserItemBlock) {
        self.UserItemBlock(tag);
    }
    
}
- (void) SettingAction {
    if (self.SettingBlock) {
        self.SettingBlock();
    }
}

- (void)setUmodel:(UserInfoDataModel *)Umodel {
    
    NSDictionary *dic = [IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    UIImage *sexImg;
    if ([dic[@"sexy"] integerValue] == 2) {
        sexImg=Image(@"girl.png");
    }else{
        sexImg=Image(@"boy.png");
    }
    [_headerImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",Umodel.userInfo.heed_image_url] placeholderImage:defalutHeadImage];
    [_headerImageView canClickItWithDuration:0.3 ThumbUrl:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]]];
    
    _nickNameLbl.text=dic[@"nickname"];
    userInfoModel *usermodel = Umodel.userInfo;
    if ([usermodel.isDue isEqualToString:@"1"]) {
        huiyuImage.hidden = NO;
        huiyuImage.size =  CGSizeMake(kWidth(15), kWidth(15));
        _isVipLbl.text = [NSString stringWithFormat:@"%@到期",usermodel.due_time];
        _isVipLbl.origin = CGPointMake(huiyuImage.right + kWidth(8), huiyuImage.top);
        _VipTypeLbl.text = @"去续费";
        _nickNameLbl.textColor = kColor(@"#F25900");
    }else {
        _nickNameLbl.textColor = kColor(@"#333333");
        huiyuImage.hidden = YES;
        huiyuImage.size =  CGSizeMake(0, 0);
        _isVipLbl.frame =  CGRectMake(huiyuImage.left, huiyuImage.top, kWidth(90), kWidth(13));
        _isVipLbl.text = @"您还不是VIP会员";
        _VipTypeLbl.text = @"去加入";
    }
    [_isVipLbl sizeToFit];
    _VipTypeLbl.origin = CGPointMake(_isVipLbl.right + kWidth(18), _VipTypeLbl.top);

    [BgSubView removeAllSubviews];
    if (Umodel.topHELPMenu.count <= 0 ) {
        BgSubView.height = 0;
        return;
    }else {
        BgSubView.height = kWidth(40);
    }
    CGFloat spacWidth = iPhoneWidth/Umodel.topHELPMenu.count;
    for (int i = 0; i < Umodel.topHELPMenu.count; i ++) {
        itemListModel *model = Umodel.topHELPMenu[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*spacWidth, kWidth(2), spacWidth, kWidth(37))];
        view.centerY = BgSubView.height/2;
        view.tag = [model.menuCode intValue];
        [BgSubView addSubview:view];
        
        SMLabel * lab = [[SMLabel alloc] initWithFrame:CGRectMake(0, 0, view.width, kWidth(14))];
        [view addSubview:lab];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = sysFont(font(18));
        lab.textColor = kColor(@"#000000");
        lab.tag = 10;
        lab.text = model.numStr;
        SMLabel * lab2 = [[SMLabel alloc] initWithFrame:CGRectMake(0, lab.bottom + kWidth(8), view.width, kWidth(14))];
        lab2.text = model.menuName;
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.font = sysFont(font(12));
        lab2.textColor = kColor(@"#525252");
        [view addSubview:lab2];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ItemTag:)];
        // 允许用户交互
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tapGes];
        
    }
}

@end











@implementation MeMainVipCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor(@"#F3F6F9");
        _bgScrollView = [[UIScrollView alloc] init];
        [self addSubview:_bgScrollView];
    }
    return self;
}
- (void)setModel:(pointParamsModel *)model {
    [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    [_bgScrollView layoutIfNeeded];
    [_bgScrollView removeAllSubviews];
    if (model.pointsAdvList.count > 1) {
        for (int i = 0; i < model.pointsAdvList.count; i ++) {
            pointsAdvListModel *pModel = model.pointsAdvList[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(170), kWidth(76))];
            [_bgScrollView addSubview:imageView];
            imageView.centerX = (kWidth(12) + imageView.width) * i + kWidth(12) + imageView.width/2;
            imageView.centerY = _bgScrollView.height/2.;
            imageView.layer.cornerRadius = kWidth(5);
            imageView.clipsToBounds = YES;
            imageView.tag = 100 + i;
            [imageView sd_setImageWithURL:[NSURL URLWithString:pModel.menuPic] placeholderImage:kImage(@"")];
            _bgScrollView.contentSize = CGSizeMake(imageView.right + kWidth(12), _bgScrollView.height);
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(VipItemTag:)];
            // 允许用户交互
            imageView.userInteractionEnabled = YES;
            _bgScrollView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tapGes];
        }
        
    }else {
        if (model.pointsAdvList.count == 1) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _bgScrollView.width, _bgScrollView.height - kWidth(7))];
            [_bgScrollView addSubview:imageView];
            pointsAdvListModel *pModel = model.pointsAdvList[0];
            imageView.tag = 100;
            [imageView sd_setImageWithURL:[NSURL URLWithString:pModel.menuPic] placeholderImage:kImage(@"")];
            _bgScrollView.contentSize = CGSizeMake(imageView.width, _bgScrollView.height);
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(VipItemTag:)];
            // 允许用户交互
            imageView.userInteractionEnabled = YES;
            _bgScrollView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tapGes];
        }
    }
    if (model.pointsAdvList.count >= 3) {
        _bgScrollView.contentOffset = CGPointMake(kWidth(12), 0);
    }
}
#pragma mark - vip服务item
-(void)VipItemTag:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *views = (UIView*)tap.view;
    NSInteger tag = views.tag - 100;
    if (self.VipItemBlock) {
        self.VipItemBlock(tag);
    }
}

@end


@implementation MeMainToolCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _iconImageView = [[UIAsyncImageView alloc] init];
        _iconImageView.frame = CGRectMake(kWidth(15), 0, kWidth(37), kWidth(37));
        [self addSubview:_iconImageView];
        
        _titleLbl = [[SMLabel alloc] initWithFrame:CGRectMake(0, _iconImageView.bottom + kWidth(12), kWidth(67), kWidth(13))];
        _titleLbl.textColor = kColor(@"#474646");
        _titleLbl.font = boldFont(font(13));
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLbl];
        
        self.BadgeView = [[CornerView alloc] initWithFrame:CGRectMake(kWidth(67) - 22 , 0, 15, 15) count:0];
        [self addSubview:self.BadgeView];
    }
    return self;
}

- (void)setModel:(pointsAdvListModel *)model {
    [self layoutIfNeeded];
    _titleLbl.size = CGSizeMake(self.width, _titleLbl.height);
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.menuPic] placeholderImage:kImage(@"defaulLogo")];
    _titleLbl.text = model.menuName;
}
@end



@interface MeMainLunboCollectionViewCell () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate> {
    UICollectionView *_collectionview;
}

@end

CGFloat groupCount = 100;

@implementation MeMainLunboCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor(@"#FFFFFF");
//        [self creatAddSubviews];
        [self createCollectionView];
    }
    return self;
}
- (void) createCollectionView {
    _imgsArr = [[NSMutableArray alloc] init];
    _modelArr = [[NSMutableArray alloc] init];
    MTCollectionLayout *Layout = [[MTCollectionLayout alloc]init];
    _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(10), iPhoneWidth, kWidth(240)) collectionViewLayout:Layout];
    _collectionview.backgroundColor = kColor(@"#FFFFFF");
    Layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    Layout.minimumLineSpacing = 0;
    _collectionview.showsHorizontalScrollIndicator = NO;
    _collectionview.alwaysBounceHorizontal = YES;
    [self.contentView addSubview:_collectionview];
    [_collectionview registerClass:[ZHCollectionCell class] forCellWithReuseIdentifier:@"CELL"];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
/**
 @return 返回每个组有多少个item
 
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgsArr.count;
}
/**
 @return 返回每个item
 
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL"forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZHCollectionCell alloc]init];
    }
    [cell addDataSourceToCell:_imgsArr[indexPath.row]];
    return cell;
}
///**
// @return 每个item的大小
//
// */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(iPhoneWidth/3.0,kWidth(190));
}

/**
 item的点击事件
 
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    pointsAdvListModel *pModel = _modelArr[indexPath.row];
    if (self.ItemBlock) {
        self.ItemBlock(pModel);
    }
//    NSLog(@"你选中了第 %ld 个item",(long)indexPath.row);
}
/**
 @return 返回item的内边距
 
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/**
 选着第几个item不可以被选中，触发事件
 
 */
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //
    //    if (indexPath.row == 2) {
    //        return NO;
    //    }
    return YES;
}

- (void)setModel:(pointParamsModel *)model {
    [_imgsArr removeAllObjects];
    [_modelArr removeAllObjects];
    if (model.pointsAdvList.count > 0) {
        for (int i = 0; i < groupCount; i ++) {
            for (int i = 0; i < model.pointsAdvList.count; i ++) {
                pointsAdvListModel *pModel = model.pointsAdvList[i];
                [_imgsArr addObject:pModel.menuPic];
                [_modelArr addObject:pModel];
            }
        }
        [_collectionview reloadData];
    }
    [_collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow: _imgsArr.count/2 + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point = _collectionview.center;
    CGPoint pointInView = [self convertPoint:point toView:_collectionview];
    NSIndexPath *indexPathNow = [_collectionview indexPathForItemAtPoint:pointInView];
    NSInteger index = (indexPathNow.row ? indexPathNow.row : 0 ) % _imgsArr.count;
    
    // 动画停止, 重新定位到 第50组(中间那组) 模型
    if (index == _imgsArr.count - 2 || index ==  1) {
        [_collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow: _imgsArr.count/5 + 1  inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    }
//    else if ( index ==  1) {
//        [_collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow: _imgsArr.count/2 - 1  inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
//    }
    
}



@end

@implementation ZHCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self configCell];
    }
    return self;
}
-(void)configCell{
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    [self.contentView addSubview:self.imageView];
    
}
- (void)layoutSubviews {
    self.layer.cornerRadius = 4;
    self.layer.shadowColor = kColor(@"#EEEEEE").CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 5);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 3;
}
-(void)addDataSourceToCell:(NSString*)imageName{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:kImage(@"")];
    self.imageView.layer.cornerRadius = 7;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = 7;
    self.imageView.layer.shadowColor = kColor(@"#999999").CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(2, 5);
    self.imageView.layer.shadowOpacity = 0.7;
    self.imageView.layer.shadowRadius = 5;
//    [self.imageView setImage:[UIImage imageNamed:imageName]];
}



@end


