//
//  MyCrowdFundHeadCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/2.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyCrowdFundHeadCell.h"

@interface MyCrowdFundHeadCell () {
    UIAsyncImageView *headImageView;
}
@end

@implementation MyCrowdFundHeadCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        headImageView = [[UIAsyncImageView alloc] initWithFrame:self.frame];
        [self addSubview:headImageView];
    }
    return self;
}
- (void)setImageURl:(NSString *)imageUrl {
//    NSString *imagUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,imageUrl];
    [headImageView setImageAsyncWithURL:imageUrl placeholderImage:DefaultImage_logo];
}
@end
