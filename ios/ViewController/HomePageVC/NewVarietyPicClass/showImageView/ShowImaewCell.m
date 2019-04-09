//
//  ShowImaewCell.m
//  ImageFileScanning
//
//  Created by MacYin on 17/2/26.
//  Copyright © 2017年 huizhi01. All rights reserved.
//

#import "ShowImaewCell.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface ShowImaewCell () <UIGestureRecognizerDelegate,UIScrollViewDelegate> {
    UIScrollView  *_scrollView;
    UITapGestureRecognizer *tap2;
    NSMutableArray *imageArr;
}
@property (nonatomic, strong) UIAsyncImageView *imageView;
@end

@implementation ShowImaewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - 64)];
        _scrollView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_scrollView];
        self.imageView = [[UIAsyncImageView alloc] init];
        self.showImageView = [[UIImageView alloc] init];
        self.userInteractionEnabled = YES;
        [_scrollView addSubview:self.showImageView];
        [self CreatlayoutSubviews];
       
    }
    return self;
}
- (void) CreatlayoutSubviews {
    _scrollView.multipleTouchEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delaysContentTouches = NO;
    _scrollView.canCancelContentTouches = YES;
    _scrollView.alwaysBounceVertical = NO;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap1:)];
    [_scrollView addGestureRecognizer:tap1];
    
    tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap1:)];
    tap2.numberOfTapsRequired = 2;
    [tap1 requireGestureRecognizerToFail:tap2];
    [self addGestureRecognizer:tap2];
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture1:)];
    [self addGestureRecognizer:longGesture];
}
- (void) resizeSubviews {
    UIImage *image = self.imageView.image;
    CGFloat propor = iPhoneWidth / image.size.width;
    CGFloat Height = image.size.height * propor;
    _scrollView.contentSize = CGSizeMake(0, Height);
    self.showImageView.frame = CGRectMake(0, 0, iPhoneWidth, Height);
    if (Height < height(_scrollView)) {
        self.showImageView.center = _scrollView.center;
    }
    self.showImageView.image = image;

}


- (void)setImageModel:(nurseryNewDetailListModel *)model {
    
    //设置最大伸缩比例
    _scrollView.maximumZoomScale = 4;   //设置缩放比例
    _scrollView.minimumZoomScale = 1;
    [_scrollView setZoomScale:1.0 animated:NO];
    NSString *imageUrl;
    if (![model.showPic hasPrefix:@"http"]) {
        imageUrl = [NSString stringWithFormat:@"%@/%@",ConfigManager.ImageUrl,model.showPic];
    }else {
        imageUrl = model.showPic;
    }
    [self.imageView setImageAsyncWithURL:imageUrl placeholderImage:DefaultImage_logo];
    [self resizeSubviews];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:DefaultImage_logo options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            [self resizeSubviews];
        }
    }];
   
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _showImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (width(scrollView) > scrollView.contentSize.width) ? (width(scrollView) - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (height(scrollView) > scrollView.contentSize.height) ? (height(scrollView) - scrollView.contentSize.height) * 0.5 : 0.0;
    self.showImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - UITapGestureRecognizer Event
- (void)doubleTap1:(UITapGestureRecognizer *)tap {
    if (_scrollView.zoomScale > 1.0) {
        [_scrollView setZoomScale:1.0 animated:YES];
    } else {
        CGPoint touchPoint = [tap locationInView:self.showImageView];
        CGFloat newZoomScale = 3;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [_scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)singleTap1:(UITapGestureRecognizer *)tap {
    if (self.singleTapGestureBlock) {
        self.singleTapGestureBlock();
    }
}

- (void)handlelongGesture1:(UILongPressGestureRecognizer *)gesture{
    ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied) {
        //无权限
    }else {
        if (self.longGestureBlock) {
            self.longGestureBlock();
        }
    }
    
    
}


@end
