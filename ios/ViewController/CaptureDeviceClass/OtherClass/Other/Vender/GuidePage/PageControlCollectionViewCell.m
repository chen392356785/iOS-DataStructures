//
//  PageControlCollectionViewCell.m
//  CCPageControl
//
//  Copyright © 2017年 cccc. All rights reserved.
//

#import "PageControlCollectionViewCell.h"

@interface PageControlCollectionViewCell ()

/**图片*/
@property (nonatomic,weak) UIImageView *cellImageView;

@end

@implementation PageControlCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        [self setSubView];

    }
    return self;
}
#pragma mark --设置数据--
- (void)setImageStr:(NSString *)imageStr {

    _imageStr = imageStr;
    [self.cellImageView setImage:[UIImage imageNamed:imageStr]];
}
#pragma mark --创建ui--
- (void)setSubView {
    
    //商品图片
    UIImageView *cellImageView = [[UIImageView alloc] init];
    self.cellImageView = cellImageView;
    cellImageView.backgroundColor = [UIColor whiteColor];
    cellImageView.contentMode = UIViewContentModeScaleAspectFit;
    cellImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:cellImageView];
    //添加约束
    [cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        
    }];

}
@end
