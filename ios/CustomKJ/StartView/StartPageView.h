//
//  StartView.h
//  QiDongYe
//
//  Created by Zmh on 29/4/16.
//  Copyright © 2016年 Zmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstView.h"

@interface StartPageView : UIView<UIScrollViewDelegate>
{
        UIImageView *_imageView;
        UIScrollView* _scrollView;
        NSArray *_titleArr;
        UIPageControl *_pageCtr;
        CGFloat _size;
    
}
@property (nonatomic,strong) FirstView *firstView;
//  top为上方大图离顶端的距离  size表示相对缩放的比例 filename为plist文件中存放图片的类的名字
- (id)initWithFrame:(CGRect)frame top:(CGFloat)imageTop plistFileName:(NSString *)fileName sizeHeight:(CGFloat)size;
@end
