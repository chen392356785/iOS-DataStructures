//
//  SlideNavTabBarController.m
//  TaSayProject
//
//  Created by Mac on 15/6/11.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "SlideNavTabBarController.h"
#define topHeigh  40
#define DOT_COORDINATE 0.0f

@interface SlideNavTabBarController ()
- (void)viewConfig;
@end

@implementation SlideNavTabBarController


- (id)initWithSubViewControllers:(NSArray *)subViewControllers
{
    self = [super init];
    if (self)
    {
     //   _subViewControllers=[[NSArray alloc]initWithArray:subViewControllers];
        _subViewControllers = [subViewControllers mutableCopy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
    // Do any additional setup after loading the view.
    
}


- (void)viewInit
{
    int Y=0;

    // Load NavTabBar and content view to show on window
    if (self.isShowNavSlide) {
        _navTabBar = [[SlideBtnView alloc] initWithFrame:CGRectMake(0, _navH , _deviceSize.width, topHeigh)  setTitleArr:_titleArray isShowLINE:self.isShowline setImgArr:_imgArray seletImgArray:_selectImgArray];
        _navTabBar.Segmenteddelegate = self;
        Y=_navTabBar.bottom;
        [self.view addSubview:_navTabBar];
    }
    
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE,Y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-Y)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.bounces = NO;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _subViewControllers.count, 0);
    //
    [self.view addSubview:_mainView];
    
}

- (void)viewConfig
{
    [self viewInit];
    
    // Load children view controllers and add to content view
    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        UIViewController *viewController = (UIViewController *)self->_subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * [UIScreen mainScreen].bounds.size.width, DOT_COORDINATE, [UIScreen mainScreen].bounds.size.width, self->_mainView.frame.size.height);
        [self->_mainView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}



#pragma mark - Scroll View Delegate Methods
#pragma mark -


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    _currentIndex = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    //    _navTabBar.currentItemIndex = _currentIndex;
    CGFloat x=scrollView.contentOffset.x;
    if ([self.navBarDelegate respondsToSelector:@selector(itemSlideScroll:)]) {
        [self.navBarDelegate itemSlideScroll:x];
    }
    if (self.isShowNavSlide) {
        [_navTabBar scrollPage:x/_titleArray.count];
    }
     //
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //    _currentIndex = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    //    _navTabBar.currentItemIndex = _currentIndex;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentIndex = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    _navTabBar.currentItemIndex = _currentIndex;
    if ([self.navBarDelegate respondsToSelector:@selector(itemSelectedIndex:)]) {
        [self.navBarDelegate itemSelectedIndex:_currentIndex];
    }
}


#pragma mark - SCNavTabBarDelegate Methods
#pragma mark -
-(void)SegmentedDelegateViewclickedWithIndex:(NSInteger)index
{
    [_mainView setContentOffset:CGPointMake(index * [UIScreen mainScreen].bounds.size.width, DOT_COORDINATE) animated:NO];
  //  _navTabBar.currentItemIndex = index;
    
    if ([self.navBarDelegate respondsToSelector:@selector(itemSelectedIndex:)]) {
        [self.navBarDelegate itemSelectedIndex:index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
