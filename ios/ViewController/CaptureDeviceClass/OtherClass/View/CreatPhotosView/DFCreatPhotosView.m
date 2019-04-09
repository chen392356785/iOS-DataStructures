//
//  DFCreatPhotosView.m
//  DF
//
//  Created by Tata on 2017/11/29.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFCreatPhotosView.h"

@interface DFCreatPhotosView ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation DFCreatPhotosView

- (void)addSubviews {
    [super addSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self insertSubview:self.webView atIndex:0];
    [self addSubview:self.collectionView];
    [self addSubview:self.shareButton];
    
}

- (void)defineLayout {
    [super defineLayout];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.collectionView.mas_top);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.shareButton.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.collectionView.cas_sizeHeight));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(self.shareButton.cas_marginBottom / TTUIScale());
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.shareButton.cas_sizeHeight));
    }];
}

- (void)creatViews {
    [super creatViews];
    
    self.navigationView.backButton.cas_styleClass = @"navigation_back";
    [self.navigationView.backButton setImage:kImage(BackArrowGreen) forState:UIControlStateNormal];
    
    self.navigationView.forwardButton.cas_styleClass = @"navigation_forward";
    [self.navigationView.forwardButton setImage:kImage(DownloadIcon) forState:UIControlStateNormal];
    [self.navigationView.forwardButton setImage:kImage(DownloadIcon) forState:UIControlStateHighlighted];
    
    self.navigationView.lineView.cas_styleClass = @"navigation_line_clear";
    
    self.webView = [[UIWebView alloc]init];
    self.webView.cas_styleClass = @"creatPhotos_webView";
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(67 * TTUIScale(), 89 * TTUIScale());
    layout.sectionInset = UIEdgeInsetsMake(10 * TTUIScale(), 10 * TTUIScale(), 16.5 * TTUIScale(), 10 * TTUIScale());
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.cas_styleClass = @"creatPhotos_collectionView";
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setTitle:@"分享美图" forState:UIControlStateNormal];
    self.shareButton.cas_styleClass = (iPhoneHeight == kHeightX) ? @"creatPhotos_shareButton_X" : @"creatPhotos_shareButton";
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
