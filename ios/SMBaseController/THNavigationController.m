//
//  THNavigationController.m
//  MiaoTuProjectTests
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import "THNavigationController.h"
//#import "UIImage+Extents.h"
//#import <objc/runtime.h>
//#import "THColorMacro.h"
//#import "THOSMacro.h"

@interface THNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) id<UINavigationControllerDelegate> realDelegate;
@property (nonatomic, copy) ShowCompleteBlock completeBlock;
@property (atomic) BOOL animatingPushOrPop;

@end

@implementation THNavigationController

+ (void)initialize
{
    [UINavigationBar appearance].titleTextAttributes = @{
                                                         NSForegroundColorAttributeName : COLOR_MAIN_TEXT,
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:17]
                                                         };
    if (TWOS_IOS7) {
        [[UINavigationBar appearance] setBarTintColor:COLOR_TITLEBAR_WHITE];
    } else {
        UIImage *bgImage =
        [UIImage pureImageFromColor:COLOR_NAV_TITLEBAR withSize:CGSizeMake(1, 1)];
        bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    }
    
}
    
- (void)viewDidLoad
{
        [super viewDidLoad];
    //去掉导航底部线
        [self.navigationBar setShadowImage:[UIImage new]];
        self.navigationBar.translucent = NO;
        self.delegate = self;
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
            self.interactivePopGestureRecognizer.delegate = self;
        }
}
    
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
    
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
    
- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
    {
        [super setDelegate:delegate ? self : nil];
        self.realDelegate = (delegate != self ? delegate : nil);
    }
    
- (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    
- (UIViewController *)childViewControllerForStatusBarStyle
    {
        return self.topViewController;
    }
    
- (UIViewController *)childViewControllerForStatusBarHidden
    {
        return self.topViewController;
    }
    
#ifdef _HANDLE_ANIMATING_BUG_
-(UIViewController *)popViewControllerAnimated:(BOOL)animated
    {
        if (self.animatingPushOrPop)
        return nil;
#warning 不能处理 滑动返回-取消
        //   self.animatingPushOrPop = animated;
        
        UIViewController *vc = [super popViewControllerAnimated:animated];
        //    if (!vc)
        //        self.animatingPushOrPop = NO;
        return vc;
    }
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
    {
        if (self.animatingPushOrPop)
        return nil;
#warning 不能处理 滑动返回-取消
        //    self.animatingPushOrPop = animated;
        
        NSArray *a = [super popToViewController:viewController animated:animated];
        //    if (0 == a.count)
        //        self.animatingPushOrPop = NO;
        return a;
    }
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
    {
        if (self.animatingPushOrPop)
        return nil;
#warning 不能处理 滑动返回-取消
        //    self.animatingPushOrPop = animated;
        
        NSArray *a = [super popToRootViewControllerAnimated:animated];
        //    if (0 == a.count)
        //        self.animatingPushOrPop = NO;
        return a;
    }
-(void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
    {
        if (self.animatingPushOrPop)
        return;
        self.animatingPushOrPop = animated;
        
        [super setViewControllers:viewControllers animated:animated];
    }
#endif
    
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
    {
        //    NSLog(@"%s, %@", __PRETTY_FUNCTION__, viewController);
        void(^block)() = ^(){
#ifdef _HANDLE_ANIMATING_BUG_
            if (self.animatingPushOrPop)
            return;
            self.animatingPushOrPop = animated;
#endif
            if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.interactivePopGestureRecognizer.enabled = NO;
            }
            [super pushViewController:viewController animated:animated];
        };
        
#ifdef _HANDLE_ANIMATING_BUG_
        if (self.animatingPushOrPop)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
            //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            [self pushViewController:viewController animated:animated];
            //        });
        }
        else
#endif
        block();
    }
    
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(ShowCompleteBlock)completion
    {
        void(^block)() = ^(){
#ifdef _HANDLE_ANIMATING_BUG_
            if (self.animatingPushOrPop)
            return;
            self.animatingPushOrPop = animated;
#endif
            
            self.completeBlock = completion;
            [super pushViewController:viewController animated:animated];
            if (!animated) {
                if (self.completeBlock) {
                    self.completeBlock();
                    self.completeBlock = nil;
                }
            }
        };
        
#ifdef _HANDLE_ANIMATING_BUG_
        if (self.animatingPushOrPop)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
        else
#endif
        block();
    }

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
        //    NSLog(@"%s, %@", __PRETTY_FUNCTION__, viewController.title);
//        self.animatingPushOrPop = NO;
//        if (self.completeBlock) {
//            self.completeBlock();
//            self.completeBlock = nil;
//        }
//        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            BOOL supportSwipeBack = YES;
//            if ([viewController respondsToSelector:@selector(supportSwipeBack)]) {
//                supportSwipeBack = [viewController supportSwipeBack];
//            }
//            if ([[navigationController viewControllers] firstObject] == viewController) {
//                supportSwipeBack = NO;
//            }
//            self.interactivePopGestureRecognizer.enabled = supportSwipeBack;
//        }
//
//        if ([self.realDelegate respondsToSelector:_cmd]) {
//            [self.realDelegate navigationController:navigationController
//                              didShowViewController:viewController
//                                           animated:animated];
//        }
}
    
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
//        id <TWZoomTransitionAnimating> sourceTransition = (id<TWZoomTransitionAnimating>)fromVC;
//        id <TWZoomTransitionAnimating> destinationTransition = (id<TWZoomTransitionAnimating>)toVC;
//        if ([sourceTransition conformsToProtocol:@protocol(TWZoomTransitionAnimating)] &&
//            [destinationTransition conformsToProtocol:@protocol(TWZoomTransitionAnimating)]) {
//            TWZoomTransitionAnimator *animator = [[TWZoomTransitionAnimator alloc] init];
//            animator.goingForward = (operation == UINavigationControllerOperationPush);
//            animator.sourceTransition = sourceTransition;
//            animator.destinationTransition = destinationTransition;
//            return animator;
//        }
        return nil;
}
    
    
- (BOOL)statusBarHidden
{
        if (TWOS_IOS7) {
            return [[self childViewControllerForStatusBarHidden] prefersStatusBarHidden];
        }
//            else {
//            if ([self.topViewController respondsToSelector:@selector(statusBarHidden)]) {
//                return [self.visibleViewController statusBarHidden];
//            }
//            return _statusBarHidden;
//        }
        return _statusBarHidden;
}
    
#pragma mark - Delegate Forwarder
- (BOOL)respondsToSelector:(SEL)s
{
    return [super respondsToSelector:s] || [self.realDelegate respondsToSelector:s];
}
    
- (NSMethodSignature *)methodSignatureForSelector:(SEL)s
    {
        return [super methodSignatureForSelector:s]
        ?: [(id)self.realDelegate methodSignatureForSelector:s];
    }
    
- (void)forwardInvocation:(NSInvocation *)invocation
{
        id delegate = self.realDelegate;
        if ([delegate respondsToSelector:invocation.selector]) {
            [invocation invokeWithTarget:delegate];
        }
}


@end
