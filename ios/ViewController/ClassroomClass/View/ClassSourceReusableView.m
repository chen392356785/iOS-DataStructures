//
//  ClassSourceReusableView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/12.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ClassSourceReusableView.h"

@implementation ClassSourceReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createlayoutSubviews];
    }
    return self;
}
- (void) createlayoutSubviews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(16), 0, kWidth(230), self.height)];
    [self addSubview:_titleLabel];
    _titleLabel.font = boldFont(14);
    _titleLabel.textColor = kColor(@"#333333");
    
    UILabel *label = [[UILabel alloc] init];
    label.font = sysFont(12);
    label.text = @"查看全部";
    [label sizeToFit];
    _moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - kWidth(16) -  label.width, 0, label.width, 12)];
    _moreLabel.textColor = kColor(@"#8e8e8e");
    _moreLabel.font = sysFont(12);
    
    [self addSubview:_moreLabel];
    _moreLabel.centerY = self.height/2.;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(minX(_moreLabel) - kWidth(12) - 12, minY(_moreLabel), 12, 12)];
    [self addSubview:_imageView];
    UIView *TagView = [[UIView alloc] initWithFrame:CGRectMake(minX(_imageView), 0, self.width - minX(_imageView), self.height)];
    TagView.backgroundColor = [UIColor clearColor];
    [self addSubview:TagView];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreTagAction)];
    [TagView addGestureRecognizer:tap];
}
- (void) moreTagAction {
    self.moreClackBlock();
}
- (void) setClassListModel:(studyLableListModel*)model {
    _titleLabel.text = model.lableName;
    _imageView.image = kImage(@"icon_ckqb");
    _moreLabel.text = @"查看全部";
}
@end
