//
//  MTTabBarViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTabBarViewController.h"
//#import "GongQiuMainViewController.h"
//#import "GuangChangMainViewController.h"
#import "FaBuMainViewController.h"
#import "MeMainViewController.h"
//#import "MiaoTuMainViewController.h"
#import "MTNewSupplyAndBuyViewController.h"
//#import "BHBPopView.h"
#import "NewHomePageViewController.h"
//#import "ChatListViewController.h"
#import "THNavigationController.h"

//#import <AVFoundation/AVFoundation.h>

//#import "DFCameraViewController.h"        //拍照
#define  stateBarHeigh  [UIApplication sharedApplication].statusBarFrame.size.height

#import "ClassroomHomeController.h"      //课堂


//#import "UIImage+TabbarIcon.h"

@interface MTTabBarViewController ()<MTTabBarDelegate>
{
    int indexFlag;
}
@end

@implementation MTTabBarViewController


- (NSArray *)createTabItemArr
{
    NSArray * _tabConfigList = [ConfigManager getMainConfigList];
    NSMutableArray *item = [NSMutableArray array];
    for (int i = 0; i < _tabConfigList.count; i ++)
    {
        switch (i) {
            case 0:
            {
                NewHomePageViewController *item0 = [[NewHomePageViewController alloc] init];
                THNavigationController *nav = [[THNavigationController alloc] initWithRootViewController:item0];
                [item addObject:nav];
                
            }
                break;
            case 1:
            {
                
                MTNewSupplyAndBuyViewController *item1 = [[MTNewSupplyAndBuyViewController alloc] init];
                THNavigationController *nav = [[THNavigationController alloc] initWithRootViewController:item1];
                [item addObject:nav];
                
            }
                break;
            case 5:
            {
                FaBuMainViewController *item2 = [[FaBuMainViewController alloc] init];
                THNavigationController *nav = [[THNavigationController alloc] initWithRootViewController:item2];
                
                [item addObject:nav];
                
            }
                break;
            case 2:
            {
                
                ClassroomHomeController *classRoomVc = [[ClassroomHomeController alloc] init];
                THNavigationController *nav = [[THNavigationController alloc] initWithRootViewController:classRoomVc];
                [item addObject:nav];
                
                
                //                ChatListViewController *vc=[[ChatListViewController alloc]init];
                //                THNavigationController *nav = [[THNavigationController alloc] initWithRootViewController:vc];
                //                [item addObject:nav];
                
            }
                break;
            case 3:
            {
                MeMainViewController *item4 = [[MeMainViewController alloc] init];
                THNavigationController *nav = [[THNavigationController alloc] initWithRootViewController:item4];
                [item addObject:nav];
                
            }
                break;
            default:
                break;
        }
        
    }
    return item;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    indexFlag=0;
    self.viewControllers = [self createTabItemArr];
    
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = kTabbarHeight;
    tabFrame.origin.y = SCREEN_HEIGHT-kTabbarHeight;//self.view.frame.size.height - tabBarHeigh;
    self.tabBar.frame = tabFrame;
    self.tabBar.hidden=YES;
    
    if (stateBarHeigh==40) {
        ChangeStateNum=20;
    }else if (stateBarHeigh==20){
        ChangeStateNum=0;
    }
    
    CGRect rect = CGRectMake(0, _boundHeihgt-TFTabBarHeight-ChangeStateNum, WindowWith, TFTabBarHeight);//self.tabBar.bounds;
    
    MTTabBar *myView = [[MTTabBar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    _tabBar=myView;
    myView.backgroundColor=[UIColor clearColor];
    myView.delegate = self; //设置代理
    myView.frame = rect;
    [self.view addSubview:myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = CGRectMake(0, 0, WindowWith, TFTabBarHeight);
        [myView addSubview:effectview];
        //   effectview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
        effectview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }else{
        myView.backgroundColor=[UIColor whiteColor];
    }
    
    UIView *lineVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0.5)];
    lineVIew.backgroundColor=RGBA(189, 202, 219, 1);
    [myView addSubview:lineVIew];
    
    //为控制器添加按钮
    NSArray * _tabConfigList = [ConfigManager getMainConfigList];
    for (int i=0; i<_tabConfigList.count; i++) { //根据有多少个子视图控制器来进行添加按钮
        NSDictionary *dic=[_tabConfigList objectAtIndex:i];
        NSString *imageName = [dic objectForKey:@"image"];
        NSString *imageNameSel = [dic objectForKey:@"highlightedImage"];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [myView addButtonWithImage:image selectedImage:imageSel index:i title:dic[@"title"]];
        
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTabBarSelected:) name:NotificationChangeTabBarSelectedIndex object:nil];
    // Do any additional setup after loading the view.
    isHidden=NO;
    
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateBarFrame2:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
}

//-(void)stateBarFrame2:(NSNotification *)notification{
//
//
//    CGRect rect=_tabBar.frame;
//    if (stateBarHeigh==40) {
//        ChangeStateNum=20;
//    }else if (stateBarHeigh==20){
//        ChangeStateNum=0;
//    }
//    rect.origin.y= _boundHeihgt-TFTabBarHeight-ChangeStateNum;
//
//    _tabBar.frame=rect;
//
//
//}

/**永远别忘记设置代理*/
- (void)tabBar:(MTTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    
    NSInteger index=to-1000;
    
    if (index==5) {
//        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
//            if (granted) {
//                self.tabBarController.tabBar.userInteractionEnabled = NO;
//                DFCameraViewController *controller = [[DFCameraViewController alloc] init];
//                THNavigationController *nav = [[THNavigationController alloc] initWithRootViewController:controller];
//                [self presentViewController:nav animated:YES completion:^{
//                    self.tabBarController.tabBar.userInteractionEnabled = YES;
//                }];
//            }else{
//                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"打开相机才能识花" message:@"允许\"听花\"访问您的相机" preferredStyle:(UIAlertControllerStyleAlert)];
//                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                        //如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
//                        [[UIApplication sharedApplication] openURL:url];
//                    }
//                }];
//                
//                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    
//                }];
//                [alert addAction:cancleAction];
//                [alert addAction:sureAction];
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//        }];
//        
        return;
    }
    self.selectedIndex = index;
    
}

-(void)setTabBar1Num:(int)num{
    
    if (num>0) {
        [_tabBar setGCRedHidden:NO];
    }else{
        [_tabBar setGCRedHidden:YES];
    }
    
    
}

-(void)setMessageNum:(int)num{
    [_tabBar setMessageNum:num];          //
    
}

-(void)setTabBar4Num:(int)num{
    
    if (num>0) {
        [_tabBar setMeRedHidden:NO];
    }else{
        [_tabBar setMeRedHidden:YES];
    }
}


-(void)setTabBarHidden:(BOOL)hidden{
    
    if (isHidden!=hidden) {
        if (hidden) {
            [UIView animateWithDuration:0.4 animations:^{
                CGRect rect=self->_tabBar.frame;
                rect.origin.y=_boundHeihgt+15-self->ChangeStateNum;
                self->_tabBar.frame=rect;
                
            } completion:^(BOOL finished) {
                
            }];
        }else{
            [UIView animateWithDuration:0.4 animations:^{
                CGRect rect=self->_tabBar.frame;
                rect.origin.y=_boundHeihgt-TFTabBarHeight-self->ChangeStateNum;
                self->_tabBar.frame=rect;
                
            } completion:^(BOOL finished) {
                
            }];
        }
        isHidden=hidden;
        
    }
    
    
}


-(void)setTabBarSelected:(NSNotification *)notification
{
    int selIndex=[[notification object]intValue];
    
    self.selectedIndex=selIndex;
    UIButton *btn=[_tabBar viewWithTag:1000+selIndex];
    [_tabBar clickBtn:btn];
}

//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//
//    if (indexFlag!=index) {
//       [self animationWithIndex:index];
//    }
//
//
//}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    
    indexFlag =(int) index;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


