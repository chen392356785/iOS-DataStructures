//
//  AdScrollView.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdScrollView.h"
//#import "IHTapGesureRecornizer.h"
#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度

#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标

static CGFloat const chageImageTime = 3.0;
static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1

@interface AdScrollView ()

{
    //广告的label
//    UILabel * _adLabel;
    //循环滚动的三个视图
    UIAsyncImageView * _leftImageView;
    UIAsyncImageView * _centerImageView;
    UIAsyncImageView * _rightImageView;
    //循环滚动的周期时间
    
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    //为每一个图片添加一个广告语(可选)
//    UILabel * _leftAdLabel;
//    UILabel * _centerAdLabel;
//    UILabel * _rightAdLabel;
}
@property (assign,nonatomic,readonly) NSTimer *moveTimer;
//@property (strong,nonatomic,readonly) UIAsyncImageView * leftImageView;
//@property (strong,nonatomic,readonly) UIAsyncImageView * centerImageView;
//@property (strong,nonatomic,readonly) UIAsyncImageView * rightImageView;

@end

@implementation AdScrollView
@synthesize moveTimer;
#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, frame.size.height);
        self.delegate = self;
        
        _leftImageView = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, frame.size.height)];
        _leftImageView.userInteractionEnabled=YES;
        [self addSubview:_leftImageView];
        _centerImageView = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, frame.size.height)];
        _centerImageView.userInteractionEnabled=YES;
        [self addSubview:_centerImageView];
        _rightImageView = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, frame.size.height)];
        _rightImageView.userInteractionEnabled=YES;
        [self addSubview:_rightImageView];
     
        IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        
        [_leftImageView addGestureRecognizer:tap];
        IHTapGesureRecornizer *tap1=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [_centerImageView addGestureRecognizer:tap1];
        
        IHTapGesureRecornizer *tap2=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [_rightImageView addGestureRecognizer:tap2];
        
    }
    return self;
}

#pragma mark - 设置广告所使用的图片(名字)
- (void)setImageNameArray:(NSArray *)imageNameArray
{
    NSDictionary *dic1=[imageNameArray objectAtIndex:0];
    NSDictionary *dic2=[imageNameArray objectAtIndex:1];
    NSDictionary *dic3=[imageNameArray objectAtIndex:2];
    
    _imageNameArray = imageNameArray;
    
    NSString *imgStr1=CAMPUS_IMAGE_URL([dic1 objectForKey:@"thumbnail"]);
    NSString *imgStr2=CAMPUS_IMAGE_URL([dic2 objectForKey:@"thumbnail"]);
    NSString *imgStr3=CAMPUS_IMAGE_URL([dic3 objectForKey:@"thumbnail"]);
    [_leftImageView setImageAsyncWithURL:imgStr1 placeholderImage:DefaultImage_logo];
    _leftImageView.mDic=dic1;
    _centerImageView.mDic=dic2;
    _rightImageView.mDic=dic3;
    
    
    [_centerImageView setImageAsyncWithURL:imgStr2 placeholderImage:DefaultImage_logo];
    [_rightImageView setImageAsyncWithURL:imgStr3 placeholderImage:DefaultImage_logo];
  

}

-(void)tapClick:(IHTapGesureRecornizer*)tap{
    UIAsyncImageView *view2=(UIAsyncImageView*)tap.view;
    
    self.selectImageView(view2.mDic);
}

#pragma mark - 创建pageControl,指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
{
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _imageNameArray.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft)
    {
        _pageControl.frame = CGRectMake(10, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    else if (PageControlShowStyle == UIPageControlShowStyleCenter)
    {
        _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTH/2.0, HIGHT+UISCREENHEIGHT - 10);
    }
    else
    {
        _pageControl.frame = CGRectMake( UISCREENWIDTH - 22*_pageControl.numberOfPages,self.frame.size.height - 20, 20*_pageControl.numberOfPages, 20);
    }
    _pageControl.currentPage = 0;
    
    _pageControl.enabled = NO;
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}
//由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
- (void)addPageControl
{
    [[self superview] addSubview:_pageControl];
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_leftImageView setImageAsyncWithURL:nil placeholderImage:nil];
    [_centerImageView setImageAsyncWithURL:nil placeholderImage:nil];
    [_rightImageView setImageAsyncWithURL:nil placeholderImage:nil];
    if (self.contentOffset.x == 0)
    {
        currentImage = (currentImage-1)%_imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage - 1)%_imageNameArray.count;
    }
    else if(self.contentOffset.x == UISCREENWIDTH * 2)
    {
        
       currentImage = (currentImage+1)%_imageNameArray.count;
       _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
    }
    else
    {
        return;
    }
   
    NSDictionary *dic1=[_imageNameArray objectAtIndex:(currentImage-1)%_imageNameArray.count];
    NSDictionary *dic2=[_imageNameArray objectAtIndex:currentImage%_imageNameArray.count];
    NSDictionary *dic3=[_imageNameArray objectAtIndex:(currentImage+1)%_imageNameArray.count];
    NSString *imgStr1=CAMPUS_IMAGE_URL([dic1 objectForKey:@"thumbnail"]);
    NSString *imgStr2=CAMPUS_IMAGE_URL([dic2 objectForKey:@"thumbnail"]);
    NSString *imgStr3=CAMPUS_IMAGE_URL([dic3 objectForKey:@"thumbnail"]);
    _leftImageView.mDic=dic1;
    _centerImageView.mDic=dic2;
    _rightImageView.mDic=dic3;
    [_leftImageView setImageAsyncWithURL:imgStr1 placeholderImage:DefaultImage_logo];
    [_centerImageView setImageAsyncWithURL:imgStr2 placeholderImage:DefaultImage_logo];
    [_rightImageView setImageAsyncWithURL:imgStr3 placeholderImage:DefaultImage_logo];
 
    
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [moveTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    _isTimeUp = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [moveTimer invalidate];
    moveTimer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setUpTime];
}

- (void)setUpTime
{
        moveTimer = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
   
}

//这个方法会在子视图添加到父视图或者离开父视图时调用
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
    if (!newSuperview)
    {
        [self.moveTimer invalidate];
        moveTimer = nil;
    }
    else
    {
        [self setUpTime];
    }
}


@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
