//
//  NoContentViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "NoContentViewCell.h"

@interface NoContentViewCell () {
    UIImageView * imageView;
    UILabel *showLable;
}
@end

@implementation NoContentViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImage *img=Image(@"kuku.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        imageView.image=img;
        imageView.centerX=self.centerX;
//        imageView.centerY=self.centerY;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(-15);
        }];
        
        showLable=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+20, WindowWith, 17) textColor:cGrayLightColor textFont:sysFont(17)];
        showLable.textAlignment=NSTextAlignmentCenter;
        showLable.text = @"还没有东东哦";
        [self addSubview:showLable];
        [showLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->imageView.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self->imageView);
        }];
    }
    return self;
}
- (void)setShowContenTitle:(NSString *)titleStr {
    showLable.text =titleStr;
}
@end
