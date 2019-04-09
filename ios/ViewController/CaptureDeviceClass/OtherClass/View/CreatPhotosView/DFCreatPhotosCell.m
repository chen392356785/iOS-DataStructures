//
//  DFCreatPhotosCell.m
//  DF
//
//  Created by Tata on 2017/11/29.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFCreatPhotosCell.h"

@interface DFCreatPhotosCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DFCreatPhotosCell

- (void)addSubviews {
    [self creatViews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.imageView];
}

- (void)defineLayout {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)creatViews {
    self.imageView = [[UIImageView alloc]init];
    self.imageView.cas_styleClass = @"creatPhotos_imageView";
}

- (void)setSelectStatus:(BOOL)selectStatus {
    self.imageView.layer.borderColor = THBaseColor.CGColor;
    if (selectStatus) {
        self.imageView.layer.borderWidth = 3;
    }else {
        self.imageView.layer.borderWidth = 0;
    }
}

@end
