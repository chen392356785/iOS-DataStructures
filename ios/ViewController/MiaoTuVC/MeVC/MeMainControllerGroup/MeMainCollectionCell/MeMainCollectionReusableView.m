//
//  MeMainCollectionReusableView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MeMainCollectionReusableView.h"

@implementation MeMainCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(14), iPhoneWidth - kWidth(30), kWidth(13))];
        [self addSubview:_titleLabel];
        _titleLabel.font = boldFont(font(14));
        _titleLabel.textColor = kColor(@"#080808");
        
        linLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(40), iPhoneWidth, 1)];
        linLabel.backgroundColor = kColor(@"#F2F6F9");
        [self addSubview:linLabel];
    }
    return self;
}
- (void)setModel:(pointParamsModel *)model {
    _titleLabel.text = model.name;
   
}
@end
