//
//  GongQiuMainViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "GongQiuMainViewController.h"
#import "CityTableViewController.h"
#import "CityChooseViewController.h"
#import "GongQiuTableListViewController.h"
#import "SlideNavTabBarController.h"
#import "NavSlideView.h"
@interface GongQiuMainViewController ()<UITableViewDelegate,SlideNavTabBarDelegate>
{
//     MTBaseTableView *commTableView;
    SlideNavTabBarController *navTabBarController;
    NSMutableArray* controllerArray;
    NavSlideView *navView;
    
//    SMLabel *_lbl;
    SMLabel *_cityLbl;
    UIImageView *_imageView;
    UIView *_view;

}
@end

@implementation GongQiuMainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
     [MobClick beginLogPageView:@"供求列表"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"供求列表"];
}

-(void)SegmentedIndex:(NSInteger)index{
    [navTabBarController SegmentedDelegateViewclickedWithIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.city=@"全部";
//    self.automaticallyAdjustsScrollViewInsets=NO;
//    self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIImage *img=Image(@"mt_changeCity.png");
    
    CGSize size=[IHUtility GetSizeByText:self.city sizeOfFont:16 width:200];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width+img.size.width+20, size.height)];
     [view setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cBlackColor];
    _view=view;
    _cityLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(5, 0, size.width, size.height) textColor:cBlackColor textFont:sysFont(16)];
    
    _cityLbl.text=self.city;
    
       [view addSubview:_cityLbl];
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(size.width+7, 5, img.size.width, img.size.height)];
    _imageView.image=img;
    [view addSubview:_imageView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityPick)];
    [view addGestureRecognizer:tap];
    
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItem=item2;
    
    NSArray *arr=@[@"供应",@"求购"];
    
        __weak GongQiuMainViewController *weakSelf=self;
    
    navView=[[NavSlideView alloc]initWithFrame:CGRectMake(0, 0, 200, 35) setTitleArr:arr isPoint:NO integer:0];
    navView.selectBlock=^(NSInteger index){
        [weakSelf SegmentedIndex:index];
    };
    self.navigationItem.titleView = navView;
    
    
   controllerArray =[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        
        GongQiuTableListViewController *controller=[[GongQiuTableListViewController alloc]init];
        switch (i) {
            case 0:
                controller.type=ENT_Supply;
                
                break;
            case 1:
                controller.type=ENT_Buy;
                break;
            default:
                break;
        }
        controller.inviteParentController=self;
        
        [controllerArray addObject:controller];
    }
    navTabBarController = [[SlideNavTabBarController alloc] init];
    navTabBarController.navH=0;
    navTabBarController.subViewControllers = controllerArray;
    navTabBarController.isShowline=NO;
    navTabBarController.titleArray=arr;
    navTabBarController.navBarDelegate=self;
    // Do any additional setup after loading the view.
    [self.view addSubview:navTabBarController.view];
    
//    MTOppcenteView *oppcenteView=[[MTOppcenteView alloc]initWithOrgane:CGPointMake(WindowWith/2-70, WindowHeight-tabBarHeigh-70) Directiontype:ENT_Down BtnType:ENT_FaBu];
//    
//    [self.view addSubview:oppcenteView];
//    [oppcenteView becomeFirstResponder];
//    [self.view bringSubviewToFront:oppcenteView];
}

-(void)cityPick
{
    CityChooseViewController *vc=[[CityChooseViewController alloc]init];
    vc.locationCity=self.city;
    vc.selectAreaBlock=^(NSString *city,NSString *province,CGFloat latitude,CGFloat longtitude){
        
        self.city=city;
        if (province) {
            self.city=province;
        }
       
        [self setCity];
    };
    [self pushViewController:vc];
}


-(void)setCity
{    CGSize size=[IHUtility GetSizeByText:self.city sizeOfFont:16 width:200];
    _cityLbl.text=self.city;
    _cityLbl.frame=CGRectMake(5, 0, size.width, size.height);
    _imageView.origin=CGPointMake(_cityLbl.right+5, 5);
    _view.size=CGSizeMake(_cityLbl.width+_imageView.width+10, _cityLbl.height);
     [_view setLayerMasksCornerRadius:10 BorderWidth:1 borderColor:cBlackColor];
    
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:self.city,@"city",nil];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChooseCity object:nil userInfo:dic];
}

#pragma mark navBarDelegate
-(void)itemSlideScroll:(CGFloat)f{
   // NSLog(@"f=%f",f);
   // [navView slideScroll:f];
}

-(void)itemSelectedIndex:(NSInteger)index{
    [navView slideSelectedIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
