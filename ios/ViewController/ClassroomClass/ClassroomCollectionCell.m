//
//  ClassroomCollectionCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

//#import "AdView.h"
#import "UIImage+GIF.h"
#import "ClassroomModel.h"
#import "ClassroomCollectionCell.h"

@implementation ClassroomCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createItemSubView];
    }
    return self;
}
- (void) createItemSubView {
    self.layer.cornerRadius = 4;
    self.layer.shadowColor = kColor(@"#999999").CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 5);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 5;

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, kWidth(111))];
    _imageView.layer.cornerRadius = 4;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), maxY(_imageView) +kWidth(12), self.width - kWidth(24), kWidth(15))];
    [self addSubview:_titleLabel];
    _titleLabel.font = sysFont(font(14));
    _titleLabel.textColor = kColor(@"#282828");
    
    _conLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(_titleLabel), maxY(_titleLabel) +kWidth(5), _titleLabel.width, kWidth(25))];
    [self addSubview:_conLabel];
    _conLabel.numberOfLines = 2;
    _conLabel.font = sysFont(11);
    _conLabel.textColor = kColor(@"#757575");
}
- (void)layoutSubviews {
    _conLabel.size = CGSizeMake(_titleLabel.width, _conLabel.height);
}
- (void)setDataClassListModel:(studyBannerListModel *)model {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSData  *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.headPic]];
        UIImage *image = [UIImage sd_imageWithGIFData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_imageView.image = image;
            if (!image) {
                self->_imageView.image = kImage(@"defaulLogo.png");
            }
        });
    });
    
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.headPic] placeholderImage:[UIImage imageNamed:@"defaulLogo.png"]];
    _titleLabel.text = model.className;
    NSString *ifnoStr = model.classIntro;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:ifnoStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:0];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [ifnoStr length])];
    [_conLabel setAttributedText:attributedString1];
    [_conLabel sizeToFit];
    
//    _conLabel.text = model.classIntro;

}

@end




@interface ClassroomHeadViewCell () <UIGestureRecognizerDelegate> {
//    UILabel *titleLabel;
}
@end

@implementation ClassroomHeadViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubViewInit];
        [self createBannerView];
    }
    return self;
}
- (void) createSubViewInit {
    _bgimageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, KtopHeitht)];
    [self addSubview:_bgimageView2];
    UIImage *bgImage = [[UIImage imageNamed:@"img_dh_sy"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    _bgimageView2.image = bgImage;
    
    _bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KtopHeitht, iPhoneWidth, kWidth(154))];
    [self addSubview:_bgimageView];
    _bgimageView.image = kImage(@"img_dh_sx");
    
    
    leftbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftbutton.frame = CGRectMake(18, KStatusBarHeight + 10, 24, 24);
    [leftbutton setImage:[kImage(@"icon_fh_b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 12);
//    [self addSubview:leftbutton];

    
//    searchTextfiled = [[MTHomeSearchView alloc] initWithFrame:CGRectMake(leftbutton.right + kWidth(10), 0,iPhoneWidth - leftbutton.right - kWidth(52),34)];
     searchTextfiled = [[MTHomeSearchView alloc] initWithFrame:CGRectMake( kWidth(20), 0,iPhoneWidth - kWidth(40),34)];
    searchTextfiled.centerY = leftbutton.centerY;
    searchTextfiled.layer.borderWidth = 0.0;
    searchTextfiled.layer.cornerRadius = 7.1;
    searchTextfiled.clipsToBounds = YES;
    searchTextfiled.backgroundColor = kColor(@"#ffffff");
    searchTextfiled.searchTextField.backgroundColor =  kColor(@"#ffffff");
//    searchTextfiled.searchTextField.alpha = 0.75;
    [ searchTextfiled.searchTextField setValue:kColor(@"#b3c1bc") forKeyPath:@"_placeholderLabel.textColor"];
    searchTextfiled.searchTextField.placeholder = @"搜索你感兴趣的课程或导师";
    searchTextfiled.searchTextField.userInteractionEnabled = NO;
    [self addSubview:searchTextfiled];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SearchAction)];
    [searchTextfiled addGestureRecognizer:tap];
 
}
#pragma -mark back


- (void)leftBackAction {
    if (self.backBlock) {
        self.backBlock();
    }
}
#pragma -mark Search
- (void)SearchAction {
    if (self.searchBlock) {
        self.searchBlock();
    }
}


- (void) createBannerView{
    //获取缓存
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [path stringByAppendingPathComponent:@"ClassRoomList.data"];
    NSArray *resultArr = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    BgAdview = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(17.5), kWidth(52) + kWidth(8) + KtopHeitht, iPhoneWidth - kWidth(35), kWidth(186))];
    
    BgAdview.backgroundColor = [UIColor colorWithPatternImage:kImage(@"banner.png")];
    BgAdview.layer.cornerRadius = kWidth(6);
//    BgAdview.clipsToBounds = YES;
    [self addSubview:BgAdview];
    
    
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (studyBannerListModel *mode in resultArr) {
        [mArray addObject:mode.bannerPic];
    }
    SDCycleScrollView *DicView = [SDCycleScrollView cycleScrollViewWithFrame:BgAdview.frame shouldInfiniteLoop:YES imageNamesGroup:mArray];
    DicView.placeholderImage = [UIImage imageNamed:@"defaulLogo.png"];
    DicView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    DicView.layer.cornerRadius = kWidth(6);
    DicView.clipsToBounds = YES;
    self.DicView = DicView;
    [self addSubview:DicView];
    
    BgAdview.layer.cornerRadius = 4;
    BgAdview.layer.shadowColor = kColor(@"#999999").CGColor;
    BgAdview.layer.shadowOffset = CGSizeMake(2, 5);
    BgAdview.layer.shadowOpacity = 0.7;
    BgAdview.layer.shadowRadius = 5;
}
- (void) setUpSubViewSourde {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [path stringByAppendingPathComponent:@"ClassRoomList.data"];
    NSArray *resultArr = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (studyBannerListModel *mode in resultArr) {
        [mArray addObject:mode.bannerPic];
    }
    self.DicView.imageURLStringsGroup = mArray;
}
@end


@implementation ClassroomClassTitleViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createItem];
    }
    return self;
}
- (void) createItem {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
    _imageView.centerX = self.width/2.;
    [self addSubview:_imageView];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(_imageView) + 5, self.width, self.height - maxY(_imageView) - 5)];
    _titleLabel.textColor = kColor(@"#4d4c4c");
    _titleLabel.font = sysFont(12);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
}
- (void) setImageName:(NSString *)imagStr andTitleStr:(NSString *)title{
    NSString *IconUrl = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,imagStr];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:IconUrl] placeholderImage:DefaultImage_logo];
    _titleLabel.text = title;
}
@end
