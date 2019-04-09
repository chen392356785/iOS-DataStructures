//
//  SlideNavTabBarController.h
//  TaSayProject
//
//  Created by Mac on 15/6/11.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideBtnView.h"

@protocol SlideNavTabBarDelegate <NSObject>
@optional
-(void)itemSelectedIndex:(NSInteger)index;
-(void)itemSlideScroll:(CGFloat)f;
@end

@interface SlideNavTabBarController : UIViewController<SegmentedBtnDelegate,UIScrollViewDelegate>
{
    SlideBtnView *_navTabBar;
    UIScrollView *_mainView;
    NSInteger       _currentIndex;              // current page index
}
@property(nonatomic)int navH;
@property(nonatomic)BOOL isShowline;
@property(nonatomic)BOOL isShowNavSlide;  //是否展示 顶部 滑动
@property (nonatomic, strong)   NSMutableArray     *subViewControllers;// An array of children view controllers
@property(nonatomic,strong) NSArray *imgArray;
@property(nonatomic,strong)NSArray *selectImgArray;
@property(nonatomic,assign)id<SlideNavTabBarDelegate> navBarDelegate;
@property(nonatomic,strong)   NSArray       *titleArray;
-(void)SegmentedDelegateViewclickedWithIndex:(NSInteger)index;
- (id)initWithSubViewControllers:(NSArray *)subViewControllers;
@end
