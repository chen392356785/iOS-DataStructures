//
//  GardenViews.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenViews.h"

@implementation GardenViews

@end



@implementation GardenTabHeadViews
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.layer.cornerRadius = kWidth(7);
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
    }
    return self;
}
- (void) createView {
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(120))];
    bgView.image = [kImage(@"gardensy_top") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bgView];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 0.5)];
    line.backgroundColor = kColor(@"#000000");
    line.alpha = 0.15;
    [bgView addSubview:line];
    
    _topScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(35), iPhoneWidth - kWidth(10) * 2, kWidth(97))];
    _topScrollview.backgroundColor = kColor(@"#FFFFFF");
    _topScrollview.layer.cornerRadius = kWidth(6);
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://www.miaoto.net/zmh/img/1.png"]];
    UIImage *image = [UIImage imageWithData:data];
    _topScrollview.layer.contents = (id) image.CGImage;    // 如果需要背景透明加上下面这句
    _topScrollview.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    UIView *scrollBGview = [[UIView alloc] initWithFrame:_topScrollview.frame];
    scrollBGview.centerY = _topScrollview.centerY;
    scrollBGview.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollBGview];
    scrollBGview.layer.cornerRadius = kWidth(6);
    [self addSubview:_topScrollview];
//    scrollBGview.layer.cornerRadius = kWidth(6);
//    scrollBGview.layer.shadowColor = kColor(@"#000000").CGColor;
//    scrollBGview.layer.shadowOffset = CGSizeMake(0, .5);
//    scrollBGview.layer.shadowOpacity = 0.16;
//    scrollBGview.layer.shadowRadius = 1;
    
    
}
- (void) updataCreateSubViews:(NSMutableArray *) marr {
    
    [_topScrollview removeAllSubviews];
    if (marr.count > 4) {
        _topScrollview.contentSize = CGSizeMake(_topScrollview.width/4 * marr.count, _topScrollview.height);
    }
    _topScrollview.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < marr.count; i ++ ) {
        menuListModel *model = marr[i];
        UIView *view;
        if (marr.count <= 4) {
            view = [[UIView alloc] initWithFrame:CGRectMake(_topScrollview.width/marr.count * i, 0, _topScrollview.width/marr.count, _topScrollview.height)];
        }else {
            view = [[UIView alloc] initWithFrame:CGRectMake(_topScrollview.width/4 * i, 0, _topScrollview.width/4, _topScrollview.height)];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(15), kWidth(44), kWidth(44))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.menuPic] placeholderImage:defalutHeadImage];
        imageView.centerX = view.width/2;
        [view addSubview:imageView];
        [_topScrollview addSubview:view];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + kWidth(10), view.width, kWidth(20))];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = RegularFont(font(14));
        titleLab.text = model.menuName;
        titleLab.textColor = kColor(@"#4A4A4A");
        [view addSubview:titleLab];
        
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg:)];
        // 允许用户交互
        view.tag = 10 + i;
        imageView.userInteractionEnabled = YES;
        [view addGestureRecognizer:tapGes];
    }
}
-(void)tapImg:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *views = (UIView*)tap.view;
    NSInteger tag = views.tag - 10;
    if (self.seleckBack) {
        self.seleckBack(tag);
    }
}
@end
