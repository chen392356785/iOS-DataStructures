//
//  PicReleaseSucces.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/27.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "PicReleaseSucces.h"

@interface PicReleaseSucces () {
    UIView *bgView;
    UIImageView *_imageView;
    UILabel *titleLabel;
    UILabel *conLabel;
    UIButton *but;
    UIButton *canCel;
}
@end

@implementation PicReleaseSucces

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self creareSubView];
        self.backgroundColor = [UIColor clearColor];
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kWidth(30), width(self), height(self) - kWidth(30))];
        bgView.layer.cornerRadius = 3;
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        [self creareSubView];
    }
    return self;
}
- (void) creareSubView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, kWidth(60),  kWidth(60))];
    _imageView.centerX = self.centerX;
    _imageView.image = Image(@"icon_fbcg.png");
    [self addSubview:_imageView];
    
    canCel = [UIButton buttonWithType:UIButtonTypeSystem];
    canCel.frame = CGRectMake(width(bgView) - kWidth(35), kWidth(5), kWidth(27), kWidth(27));
    [canCel setImage:Image(@"icon_gbtc")  forState:UIControlStateNormal];
    [canCel addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.CancelBut = canCel;
    [bgView addSubview:canCel];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height(_imageView)/2 + kWidth(30), width(bgView), kWidth(25))];
    titleLabel.text = @"成功";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = sysFont(font(25));
    [bgView addSubview:titleLabel];
    
    conLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(titleLabel) + kWidth(20), width(bgView), kWidth(50))];
    conLabel.text = @"您已发布新品种成功！\n可到我的发布看看";
    conLabel.numberOfLines = 2;
    conLabel.textAlignment = NSTextAlignmentCenter;
    conLabel.font = sysFont(font(16));
    [bgView addSubview:conLabel];
    
    but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(0, maxY(conLabel) + kWidth(24), kWidth(192), kWidth(36));
    but.centerX = bgView.centerX;
    but.backgroundColor = kColor(@"#4CBE7C");
    [but setTitle:@"再拍一个试试" forState:UIControlStateNormal];
    [but setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
    but.layer.cornerRadius = kWidth(4);
    but.titleLabel.font = sysFont(16);
    [but addTarget:self action:@selector(TryAgainAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.TryBut = but;
    [bgView addSubview:but];
    
}
- (void) CancelAction:(UIButton *)but {
    self.CancelBlock();
}
- (void) TryAgainAction:(UIButton *)but {
    self.TryAgainBlock();
}
@end
