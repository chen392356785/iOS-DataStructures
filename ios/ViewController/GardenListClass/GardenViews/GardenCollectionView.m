//
//  GardenCollectionView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenCollectionView.h"




@interface ActionCollectionCell : UICollectionViewCell {
    UIImageView *bgImgVew;
    UILabel *titleLab;
    UILabel *timeLab;
}


- (void)updataCollectioncellModel:(ActivitiesModel *)model;
@end

@implementation ActionCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createItemSubView];
    }
    return self;
}
- (void) createItemSubView {
    bgImgVew = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(0), kWidth(5), kWidth(180) , kWidth(100))];
    bgImgVew.layer.cornerRadius = kWidth(6);
    [self addSubview:bgImgVew];
    bgImgVew.clipsToBounds = YES;
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(bgImgVew.left, bgImgVew.bottom + kWidth(10), bgImgVew.width, kWidth(20))];
    titleLab.font = darkFont(font(14));
    titleLab.textColor = kColor(@"#4A4A4A");
    [self addSubview:titleLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.left, titleLab.bottom + kWidth(2), bgImgVew.width, kWidth(14))];
    timeLab.font = sysFont(font(12));
    timeLab.textColor = kColor(@"#4A4A4A");
    [self addSubview:timeLab];
}
- (void)updataCollectioncellModel:(ActivitiesModel *)model{
    NSURL *imgUrl = [NSURL URLWithString:model.activitiesPic];
    [bgImgVew sd_setImageWithURL:imgUrl placeholderImage:DefaultImage_logo];
    titleLab.text = model.activitiesTitile;
    timeLab.text =  [NSString stringWithFormat:@"%@ ~ %@",[IHUtility FormatDatePointByStringStyle:model.activitiesExpirestarttime],[IHUtility FormatDatePointByStringStyle:model.activitiesExpiretime]];
}
@end






@interface GardenCollectionCell : UICollectionViewCell {
    UIImageView *bgImgVew;
    UIView *CompanyBgView;
}
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *moreBut;
- (void)ShowMoreButAndbgImag:(NSString *)bgImag;
@end

static CGFloat lastMaxY;
@implementation GardenCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createItemSubView];
    }
    return self;
}
- (void) createItemSubView {
    bgImgVew = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(5), kWidth(172) , kWidth(100))];
    bgImgVew.centerX = self.width/2.;;
    [self addSubview:bgImgVew];
    bgImgVew.layer.cornerRadius = kWidth(6);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgImgVew.width, bgImgVew.height)];
    [bgImgVew addSubview:bgView];
    bgView.backgroundColor = kColor(@"#FFFFFF");
    bgView.alpha = .55;
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(6), bgImgVew.width - kWidth(6), kWidth(22))];
    self.titleLab.textColor = kColor(@"#575757");
    self.titleLab.font = darkFont(font(14));
    self.titleLab.textAlignment = NSTextAlignmentRight;
    [bgImgVew addSubview:self.titleLab];
    
    CompanyBgView = [[UIView alloc] initWithFrame:CGRectMake(0,_titleLab.bottom + kWidth(6), bgImgVew.width, bgImgVew.height - _titleLab.bottom - kWidth(10))];
    [bgImgVew addSubview:CompanyBgView];
    
    
    UIButton * moreBut = [UIButton buttonWithType:UIButtonTypeSystem];
    moreBut.frame = CGRectMake(0, 0, kWidth(80), kWidth(35));
    moreBut.centerX = bgImgVew.centerX;
    moreBut.centerY = bgImgVew.centerY;
//    [moreBut addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    [moreBut setTitle:@"更多" forState:UIControlStateNormal];
    [moreBut setTitleColor:kColor(@"#575757") forState:UIControlStateNormal];
    moreBut.titleLabel.font = darkFont(font(font(20)));
    [moreBut setImage:[kImage(@"garden_img_more") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [moreBut setTitleEdgeInsets:UIEdgeInsetsMake(0, -moreBut.imageView.size.width, 0, moreBut.imageView.size.width)];
    [moreBut setImageEdgeInsets:UIEdgeInsetsMake(kWidth(5), moreBut.titleLabel.bounds.size.width, kWidth(5), -moreBut.titleLabel.bounds.size.width)];
    
     [bgImgVew addSubview:moreBut];
    self.moreBut = moreBut;
    moreBut.hidden = YES;
}

- (void)ShowMoreButAndbgImag:(NSString *)bgImag {
    [CompanyBgView removeAllSubviews];
    [bgImgVew sd_setImageWithURL:[NSURL URLWithString:bgImag] placeholderImage:kImage(@"garen_list_bg")];
//    bgImgVew.image = kImage(@"garen_list_bg");

    _titleLab.hidden = YES;
    self.moreBut.hidden = NO;
}

- (void)updataCollectioncellModel:(gardenListsModel *)model {
    NSURL *imgUrl = [NSURL URLWithString:model.indexUrl];
    [bgImgVew sd_setImageWithURL:imgUrl placeholderImage:kImage(@"garen_list_bg")];
    _titleLab.hidden = NO;
    _titleLab.text = model.name;
    int i = 0;
    [CompanyBgView removeAllSubviews];
    lastMaxY = 0.0;
    CompanyBgView.clipsToBounds = YES;
    for (yuanbangModel *BangModel in model.gardenBangs) {
        UILabel *tempLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth(165), kWidth(12))];
        tempLab.font = darkFont(font(10));
        tempLab.numberOfLines = 2;
        tempLab.text = [NSString stringWithFormat:@"%d.%@",i+1,BangModel.gardenCompany];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 0.1;// 字体的行间距
        NSDictionary *attributes = @{
                                     NSFontAttributeName:darkFont(font(10)),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        tempLab.attributedText = [[NSAttributedString alloc] initWithString:tempLab.text attributes:attributes];
        
        [tempLab sizeToFit];
        UILabel *gardLab = [[UILabel alloc] initWithFrame:CGRectMake(3, lastMaxY + 2, kWidth(165), tempLab.height)];
        gardLab.numberOfLines = 2;
        gardLab.attributedText = [[NSAttributedString alloc] initWithString:tempLab.text attributes:attributes];
        gardLab.textColor = kColor(@"#575757");
        lastMaxY = gardLab.bottom;
//        gardLab.adjustsFontSizeToFitWidth = YES;
        if (i < 3) {
            [CompanyBgView addSubview:gardLab];
        }
        i ++;
    }
}
@end





@interface GardenCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *sectionNum;

@end

static NSString *GardenCollectionCellId = @"GardenCollectionCell";
static NSString *ActionCollectionCellId = @"ActionCollectionCell";

@implementation GardenCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        
        self.pagingEnabled = YES;
        [self registerClass:[GardenCollectionCell class] forCellWithReuseIdentifier:GardenCollectionCellId];
        
        [self registerClass:[ActionCollectionCell class] forCellWithReuseIdentifier:ActionCollectionCellId];
        //线下活动
        _sectionNum = [[NSMutableArray alloc] init];
        
    }
    return self;
}

#pragma mark - collection view delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.type isEqualToString:@"2"]) {
        return 1;
    }
    return _sectionNum.count;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.type isEqualToString:@"2"]) {
        return _sectionNum.count;
    }else {
        NSArray *tempArr = _sectionNum[section];
        if (tempArr.count >= 3) {
            return 4;
        }else {
            NSArray *tempArr = _sectionNum[section];
            return tempArr.count;
        }
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.type isEqualToString:@"2"]) {
        ActionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ActionCollectionCellId forIndexPath:indexPath];
        ActivitiesModel *Gmodel = _sectionNum[indexPath.row];
        [cell updataCollectioncellModel:Gmodel];
        return cell;
    }
    GardenCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GardenCollectionCellId forIndexPath:indexPath];
    if (indexPath.row <= 2) {
        NSMutableArray *marr = _sectionNum[indexPath.section];
        gardenListsModel *Gmodel = marr[indexPath.row];
        [cell updataCollectioncellModel:Gmodel];
        cell.moreBut.hidden = YES;
    }else {
        [cell ShowMoreButAndbgImag:self.bgMoreImg];
    }
    return cell;
}


#pragma mark - collection view data source
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.type isEqualToString:@"2"]) {
        ActivitiesModel *Amodel = _sectionNum[indexPath.row];
        if (self.ActivitySelkBack) {
            self.ActivitySelkBack(Amodel);
        }
    }else {
        NSArray *tempArr = _sectionNum[indexPath.section];
        if (indexPath.row == 3) {
            if (self.seleckMoreBack) {
                self.seleckMoreBack();
            }
        }else {
            gardenListsModel *Gmodel = tempArr[indexPath.row];
            if (self.cellSelkBack) {
                self.cellSelkBack(Gmodel);
            }
        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.type isEqualToString:@"1"]) {
        NSInteger index = self.contentOffset.x / iPhoneWidth;
        if (self.seleckBack) {
            self.seleckBack(index);
        }
    }
}
- (void)updataCollection:(NSArray *)arr{
    [_sectionNum removeAllObjects];
    for (biaoqianModel *Bmodel in arr) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (gardenListsModel *Gmodel in Bmodel.gardenLists) {
            if (tempArr.count <= 4) {
                [tempArr addObject:Gmodel];
            }
        }
        [_sectionNum addObject:tempArr];
    }
    [self reloadData];
}
//线下活动刷新
- (void)updataActionCollection:(NSArray *)arr {
    self.pagingEnabled = NO;
     [_sectionNum removeAllObjects];
    for (ActivitiesModel *Amodel in arr) {
        [_sectionNum addObject:Amodel];
    }
    [self reloadData];
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([self.type isEqualToString:@"2"]) {
        return UIEdgeInsetsMake(kWidth(0), kWidth(10), kWidth(0), kWidth(10));
    }else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
@end
