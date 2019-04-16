//
//  GardenTableViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenTableViewCell.h"


#import "ELCVFlowLayout.h"



@implementation GardenTableViewCell

@end



@interface GardenScrlistViewCell () <UIScrollViewDelegate> {
    UIScrollView *_bgScrView;
    GardenCollectionView *_collectView;
    UILabel *currentLab;
    UIButton *moreBut;

    NSArray *modeArr;
}

@end

static NSInteger currentTag;

static CGFloat lastMaxX;

@implementation GardenScrlistViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    _bgScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(37))];
    _bgScrView.backgroundColor = kColor(@"#05C1B0");
    _bgScrView.showsHorizontalScrollIndicator = NO;

    [self addSubview:_bgScrView];
    ELCVFlowLayout *horizontalLayout = [[ELCVFlowLayout alloc] init];
    horizontalLayout.itemSize = CGSizeMake(iPhoneWidth/2, kWidth(110));
    
    GardenCollectionView *collectView = [[GardenCollectionView alloc]initWithFrame:CGRectMake(0, _bgScrView.bottom, iPhoneWidth, kWidth(240)) collectionViewLayout:horizontalLayout];
    collectView.backgroundColor  = [UIColor clearColor];
    _collectView = collectView;
    collectView.type = @"1";
    collectView.showsVerticalScrollIndicator = NO;
    collectView.showsHorizontalScrollIndicator = NO;
    collectView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:collectView];
    
    WS(weakSelf);
    collectView.seleckBack = ^(NSInteger index) {
        [weakSelf scrollviewcontentOffsetY:index];
    };
    collectView.seleckMoreBack = ^{
        [weakSelf moreAction];
    };
    currentTag = 0;
    moreBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreBut addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    [moreBut setImage:[kImage(@"garden_img_more") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [self addSubview:moreBut];
    collectView.cellSelkBack = ^(gardenListsModel *model) {
        if (self.cellSelkBack) {
            self.cellSelkBack(model);
        }
    };
}
- (void)layoutSubviews {
     moreBut.frame = CGRectMake(_collectView.right - kWidth(15) - kWidth(25), self.height - kWidth(16) - kWidth(8), kWidth(25) , kWidth(16));
}
#pragma -mark 更多
- (void) moreAction {
    if (self.moreBlock) {
        NSInteger index = currentLab.tag - 100;
        self.moreBlock(index);
    }
}
- (void) updataSlideSegmentArray:(NSMutableArray *)arr {
    [_bgScrView removeAllSubviews];
    _collectView.bgMoreImg = self.bgMoreImg;
    modeArr = arr[0];
    if (modeArr.count <= 0) {
        return;}
    lastMaxX = 0.0;
    for (int i = 0; i <modeArr.count; i ++) {
        biaoqianModel *model = modeArr[i];
        NSString *str = model.cateName;
        UILabel *titleLab = [[UILabel alloc] init];
        UILabel *tempLab = [UILabel new];
        titleLab.text = str;
        titleLab.font = RegularFont(font(12));
        tempLab.font = darkFont(font(16));
        tempLab.text = str;
        [tempLab sizeToFit];
        titleLab.frame = CGRectMake(lastMaxX + (kWidth(18)), 0, tempLab.width + kWidth(15) , kWidth(25));
//        titleLab.centerY = _bgScrView.height/2.;
        titleLab.backgroundColor = kColor(@"#08D7C4");
        titleLab.textColor = kColor(@"#FFFFFF");
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.tag = i + 100;
        if (i == currentTag) {
            titleLab.font = darkFont(font(16));
            titleLab.textColor = kColor(@"#FFFFFF");
            currentLab = titleLab;
        }else {
            titleLab.height = kWidth(20);
        }
        titleLab.layer.cornerRadius = titleLab.height/2;
        titleLab.centerY = _bgScrView.height/2.;
        titleLab.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SlideAction:)];
        // 允许用户交互
        titleLab.userInteractionEnabled = YES;
        [titleLab addGestureRecognizer:tap];
        lastMaxX = titleLab.right;
        [_bgScrView addSubview:titleLab];
    }
    _bgScrView.contentSize = CGSizeMake(lastMaxX + kWidth(12), _bgScrView.height);
    [_collectView updataCollection:modeArr];
    
    [self setupAutoHeightWithBottomView:_collectView bottomMargin:kWidth(10)];
}


-(void)SlideAction:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UILabel *titleLab = (UILabel*)tap.view;
    NSInteger tag = titleLab.tag - 100;
    if (currentLab.tag == (titleLab.tag)) {
        return;
    }
    currentLab.height = kWidth(20);
    currentLab.font = RegularFont(font(12));
    currentLab.centerY = _bgScrView.height/2;
    currentLab.layer.cornerRadius = currentLab.height/2;
    
    titleLab.font = darkFont(font(16));
    titleLab.height = kWidth(25);
    titleLab.centerY = _bgScrView.height/2;
    titleLab.layer.cornerRadius = titleLab.height/2;
    currentLab = titleLab;
    currentTag = tag;
    
    biaoqianModel *Bmodel = modeArr[tag];
    if (Bmodel.gardenLists.count < 3) {
        if (self.isShowBlock) {
            self.isShowBlock(1);
        }
        moreBut.hidden = NO;
    }else {
        if (self.isShowBlock) {
            self.isShowBlock(2);
        }
        moreBut.hidden = YES;
    }
    
    _collectView.contentOffset = CGPointMake(iPhoneWidth * tag, 0);
    currentLab.adjustsFontSizeToFitWidth = YES;
    
    if (currentLab.right > iPhoneWidth) {
//        int i = currentLab.right/iPhoneWidth;
        CGFloat contentOffsetW = (currentLab.right - iPhoneWidth);
        _bgScrView.contentOffset = CGPointMake(contentOffsetW , 0);
    }else if (currentLab.left < iPhoneWidth) {
        _bgScrView.contentOffset = CGPointMake(0 , 0);
    }else {
        
    }
}


-(void)scrollviewcontentOffsetY:(NSInteger )index{
    if (index == (currentLab.tag - 100)) {
        return;
    }
    UILabel *titleLab = (UILabel *)[_bgScrView viewWithTag:index + 100];;
    currentLab.font = RegularFont(font(12));
    currentLab.height = kWidth(20);
    currentLab.centerY = _bgScrView.height/2;
    currentLab.layer.cornerRadius = currentLab.height/2;
    
    titleLab.font = darkFont(font(16));
    titleLab.height = kWidth(25);
    titleLab.centerY = _bgScrView.height/2;
    titleLab.layer.cornerRadius = titleLab.height/2;
    currentLab = titleLab;
    currentLab.adjustsFontSizeToFitWidth = YES;
    currentTag = index;
    
    biaoqianModel *Bmodel = modeArr[currentLab.tag - 100];
    if (Bmodel.gardenLists.count < 3) {
        if (self.isShowBlock) {
            self.isShowBlock(1);
        }
        moreBut.hidden = NO;
    }else {
        if (self.isShowBlock) {
            self.isShowBlock(2);
        }
        moreBut.hidden = YES;
    }
    if (currentLab.right > iPhoneWidth) {
        int i = currentLab.right/iPhoneWidth;
        NSLog(@"------ %d",i);
        CGFloat contentOffsetW = (currentLab.right - iPhoneWidth);
        _bgScrView.contentOffset = CGPointMake(contentOffsetW , 0);
    }else if (currentLab.left < iPhoneWidth) {
        _bgScrView.contentOffset = CGPointMake(0 , 0);
    }else {
        
    }
/*
    if (currentLab.right < iPhoneWidth) {
        _bgScrView.contentOffset = CGPointMake(0 , 0);
    }else if (_bgScrView.contentSize.width - currentLab.right < iPhoneWidth/2 && currentLab.left > iPhoneWidth) {
        _bgScrView.contentOffset = CGPointMake(currentLab.left - (iPhoneWidth - (_bgScrView.contentSize.width - currentLab.left)) , 0);
    }else{
        _bgScrView.contentOffset = CGPointMake(currentLab.centerX - iPhoneWidth/2 , 0);
    }
//*/
    
}
/*
- (void) updatacollectionContentoffX:(NSInteger )tag {
    
    UILabel *titleLab = (UILabel *)[_bgScrView viewWithTag:tag + 100];;
    
    currentLab.height = kWidth(20);
    currentLab.font = RegularFont(font(12));
    currentLab.centerY = _bgScrView.height/2;
    currentLab.layer.cornerRadius = currentLab.height/2;
    
    titleLab.font = darkFont(font(16));
    titleLab.height = kWidth(25);
    titleLab.centerY = _bgScrView.height/2;
    titleLab.layer.cornerRadius = titleLab.height/2;
    currentLab = titleLab;
    currentTag = tag;
    
    biaoqianModel *Bmodel = modeArr[tag];
    if (Bmodel.gardenLists.count < 3) {
        if (self.isShowBlock) {
            self.isShowBlock(1);
        }
        moreBut.hidden = NO;
    }else {
        if (self.isShowBlock) {
            self.isShowBlock(2);
        }
        moreBut.hidden = YES;
    }
    
    _collectView.contentOffset = CGPointMake(iPhoneWidth * tag, 0);
    currentLab.adjustsFontSizeToFitWidth = YES;
    
    if (currentLab.right > iPhoneWidth) {
        int i = currentLab.right/iPhoneWidth;
        CGFloat contentOffsetW = (currentLab.right - iPhoneWidth);
        _bgScrView.contentOffset = CGPointMake(contentOffsetW , 0);
    }else if (currentLab.left < iPhoneWidth) {
        _bgScrView.contentOffset = CGPointMake(0 , 0);
    }else {
        
    }
}
*/
@end






//线下活动

@interface GardenOfflineTabCell () <UIScrollViewDelegate> {
    GardenCollectionView *_collectView;
//    UILabel *titleLab;
//    UILabel *timeLab;
}

@end
@implementation GardenOfflineTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    UICollectionViewFlowLayout *horizontalLayout = [[UICollectionViewFlowLayout alloc] init];
    horizontalLayout.itemSize = CGSizeMake(kWidth(180) , kWidth(170));
    horizontalLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    GardenCollectionView *collectView = [[GardenCollectionView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(170)) collectionViewLayout:horizontalLayout];
    
    collectView.type = @"2";
    collectView.backgroundColor = [UIColor whiteColor];
    _collectView = collectView;
    collectView.showsVerticalScrollIndicator = NO;
    collectView.showsHorizontalScrollIndicator = NO;
    collectView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:collectView];
    WS(weakSelf);
    collectView.ActivitySelkBack = ^(ActivitiesModel *model) {
        if (self.ActivitySelkBack) {
            weakSelf.ActivitySelkBack(model);
        }
    };
}
- (void) updataSlideSegmentArray:(NSMutableArray *)arr {
     NSArray *modeArr = arr[0];
    [_collectView updataActionCollection:modeArr];
}
@end



//园榜红人故事
@implementation GardenRedsStoryTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(10), iPhoneWidth - kWidth(20), kWidth(120))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    bgView =  backView;
    
    backView.layer.cornerRadius = kWidth(6);
    backView.layer.shadowColor = kColor(@"#05C1B0").CGColor;
    backView.layer.shadowOffset = CGSizeMake(0, 2);
    backView.layer.shadowOpacity = 0.2;
    backView.layer.shadowRadius = 10;
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(10) , kWidth(10),backView.width - kWidth(20), kWidth(16))];
    [backView addSubview:titleLab];
    
    leftImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(titleLab.left, titleLab.bottom + kWidth(6), kWidth(100), kWidth(100))];
    [backView addSubview:leftImg];
    
    
    
    conLab = [[SMLabel alloc] initWithFrame:CGRectMake(leftImg.right + kWidth(5) , leftImg.top, titleLab.width - leftImg.width - kWidth(3), leftImg.height - kWidth(14))];
    conLab.verticalAlignment = VerticalAlignmentTop;
    conLab.numberOfLines = 0;
    [backView addSubview:conLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(conLab.left , conLab.bottom + kWidth(2), conLab.width, kWidth(12))];
    [backView addSubview:timeLab];
    
    
}
- (void)setModel:(informationsModel *)model {
    NSArray *arr=[network getJsonForString:model.infoUrl];
    NSString *ImgUrlStr;
    if ([arr.firstObject[@"t_url"] hasPrefix:@"http"]) {
        ImgUrlStr = arr.firstObject[@"t_url"];
    }else {
        ImgUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,arr.firstObject[@"t_url"]];
    }
    [leftImg setImageAsyncWithURL:ImgUrlStr placeholderImage:DefaultImage_logo];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.infoTitle attributes: @{NSFontAttributeName: darkFont(font(14)),NSForegroundColorAttributeName: kColor(@"#4A4A4A")}];
    
    UILabel *tempLab = [[UILabel alloc] init];
    tempLab.size = CGSizeMake(titleLab.width, 16);
    tempLab.numberOfLines = 2;
    tempLab.attributedText = string;
    [tempLab sizeToFit];
    
    titleLab.numberOfLines = 2;
    titleLab.attributedText = string;
    titleLab.height = tempLab.height;
    
    [self layoutIfNeeded];
    
    leftImg.origin = CGPointMake(titleLab.left, titleLab.bottom + kWidth(10));
    
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:model.infoContent attributes: @{NSFontAttributeName: darkFont(font(12)),NSForegroundColorAttributeName:kColor(@"#9B9B9B")}];
    conLab.attributedText = string1;
    
    conLab.origin = CGPointMake(conLab.left, leftImg.top - kWidth(2));
    
    NSString *timeStr = [NSString stringWithFormat:@"发布时间：%@",model.uploadtime];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:timeStr attributes: @{NSFontAttributeName: darkFont(font(10)),NSForegroundColorAttributeName: kColor(@"#4A4A4A")}];
    timeLab.attributedText = string2;
    timeLab.origin = CGPointMake(timeLab.left, leftImg.bottom - kWidth(12));
    
    bgView.size = CGSizeMake(iPhoneWidth - kWidth(20), leftImg.bottom + kWidth(10));
    
    [self setupAutoHeightWithBottomView:bgView bottomMargin:kWidth(0.1)];
}

@end













//轮播滚动cell
@interface MarqueeTabCell (){

    UILabel *titleLab;
    UILabel *bangLab;
//    UIView *_bgview;
}
- (void)updataSubViewModel:(yuanbangModel *)model;
@end
//轮播滚动
@implementation MarqueeTabCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(10), iPhoneWidth - kWidth(20), kWidth(44))];
    bgview.backgroundColor = kColor(@"#FFFFFF");
    [self.contentView addSubview:bgview];
//    _bgview = bgview;
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(3), bgview.width - kWidth(20), kWidth(20))];
    [bgview addSubview:titleLab];
    
    bangLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.left, titleLab.bottom, titleLab.width, kWidth(15))];
    bangLab.textColor = kColor(@"#4A4A4A");
    bangLab.font = sysFont(font(10));
    [bgview addSubview:bangLab];
    
    bgview.layer.cornerRadius = kWidth(6);
    bgview.layer.shadowColor =  [UIColor colorWithRed:5/255.0 green:193/255.0 blue:176/255.0 alpha:0.2].CGColor;
    bgview.layer.shadowOffset = CGSizeMake(0, 2);
    bgview.layer.shadowOpacity = 1;
    bgview.layer.shadowRadius = 10;
    
}
- (void)updataSubViewModel:(yuanbangModel *)model {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.gardenCompany attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: font(14)],NSForegroundColorAttributeName: [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0]}];
    titleLab.attributedText = string;
    titleLab.textAlignment = NSTextAlignmentLeft;
    bangLab.textAlignment = NSTextAlignmentRight;
    bangLab.text = [NSString stringWithFormat:@"加入榜单：%@",model.gardenListName];
   
    
}
@end



//轮播滚动
@interface GardenMarqueeTabCell () <UITableViewDelegate,UITableViewDataSource>{
//    UITableView *_tableView;
    NSArray *DataArr;
}

@property (nonatomic, strong) UITableView *tableView;
@end
static NSString *MarqueeTabCellId = @"MarqueeTabCell";
//轮播滚动

@implementation GardenMarqueeTabCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(172)) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [self.contentView addSubview:_tableView];
    [self setTimer];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(54);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarqueeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:MarqueeTabCellId];
    if (!cell) {
        cell = [[MarqueeTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MarqueeTabCellId];
    }
    [cell updataSubViewModel:DataArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
- (void)setTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(MarqueechangePos) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
   
}
- (void) MarqueechangePos {
    CGFloat OffSetY = _tableView.contentSize.height - _tableView.contentOffset.y - _tableView.height;
    if (OffSetY <= 0) {
        _tableView.contentOffset = CGPointMake(0, 0);
    }
    WS(weakSelf);
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat offsetY = weakSelf.tableView.contentOffset.y + kWidth(54);
        
        CGFloat num = fmod(offsetY, kWidth(54)) ;
//        NSLog(@"取余取余取余取余取余取余----%.2f --- offsetY === %f",num,offsetY);
        if (num != 0.0) {
			self->_tableView.contentOffset = CGPointMake(0, 0);
        }
        weakSelf.tableView.contentOffset = CGPointMake(0, offsetY);
    }];
}
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)updataTableDataArray:(NSMutableArray *)arr {
    DataArr = arr;
    if (DataArr.count <= 4) {
        [self.timer invalidate];
    }
    _tableView.contentOffset = CGPointMake(0, 0);
    [_tableView reloadData];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.marqueSelectBlock) {
        self.marqueSelectBlock(indexPath.row);
    }
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (! newSuperview && self.timer) {
        // 销毁定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
