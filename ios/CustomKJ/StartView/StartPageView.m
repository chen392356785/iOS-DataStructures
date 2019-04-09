//
//  StartView.m
//  QiDongYe
//
//  Created by Zmh on 29/4/16.
//  Copyright © 2016年 Zmh. All rights reserved.
//

#import "StartPageView.h"
//#import "FirstView.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@implementation StartPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame top:(CGFloat)imageTop plistFileName:(NSString *)fileName sizeHeight:(CGFloat)size
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _size =size;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.top = - Height;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *arr = [NSArray arrayWithArray:[dic objectForKey:fileName]];
        scrollView.contentSize = CGSizeMake(Width*(arr.count-1), screenHeight);
        for (int i=1; i<arr.count; i++) {
            FirstView *imageView = [[FirstView alloc] initWithFrame:CGRectMake((i-1)*Width, 0, Width, screenHeight) images:arr[i] index:(i-1) top:imageTop zoomSize:size];
            
            [scrollView addSubview:imageView];
            
            if (i==3) {
                self.firstView = imageView;
            }
        }
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
        _titleArr = arr[0];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_titleArr[0]]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((Width -image.size.width * size)/2.0 , 0 , image.size.width *size , image.size.height*size)];
        imageView.center = self.center;
        imageView.image = image;
        _imageView = imageView;
        [self addSubview:imageView];
        
        [self performSelector:@selector(changeView) withObject:nil afterDelay:2.0];
        
        _pageCtr = [[UIPageControl alloc] initWithFrame:CGRectMake((Width - (arr.count - 1)*15)/2.0 , 0, (arr.count - 1)*15, 25)];
        _pageCtr.numberOfPages = arr.count - 1;
        _pageCtr.currentPage = 0;
        _pageCtr.currentPageIndicatorTintColor = RGB(191, 235, 232);
        _pageCtr.pageIndicatorTintColor = RGB(237, 242, 243);

    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >=  Width * 2 - _imageView.left) {
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_titleArr[1]]];
    }else {
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_titleArr[0]]];
    }
    
    int page = scrollView.contentOffset.x / Width;
    _pageCtr.currentPage = page;
    NSString *value = [NSString stringWithFormat:@"%f",scrollView.contentOffset.x];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue" object:@{@"value":value}];
}
- (void)changeView
{
    
    [UIView animateWithDuration:.5 animations:^{
        self->_imageView.bottom = Height - 69 * self->_size;
        [UIView animateWithDuration:.3 animations:^{
            self->_scrollView.top= 0;
        }];
    } completion:^(BOOL finished) {
        self->_pageCtr.bottom = self->_imageView.top - 15 * self->_size;
        [self addSubview:self->_pageCtr];
    }];
    
    
}

@end
