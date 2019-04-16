//
//  CityChooseViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CityChooseViewController.h"
#import "SlideNavTabBarController.h"
#import "NavSlideView.h"
#import "CityTableViewController.h"
@interface CityChooseViewController ()<UITableViewDelegate,SlideNavTabBarDelegate>
{
//    MTBaseTableView *commTableView;
    SlideNavTabBarController *navTabBarController;
    
    NavSlideView *navView;
}

@end

@implementation CityChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *arr=@[@"城市",@"省份"];
    
    navView=[[NavSlideView alloc]initWithFrame:CGRectMake(0, 0, 200, 35) setTitleArr:arr isPoint:NO integer:0];
	__weak typeof(self)weakSelf = self;
    navView.selectBlock=^(NSInteger index){
		__strong typeof(weakSelf)strongSelf = weakSelf;
		[strongSelf->navTabBarController SegmentedDelegateViewclickedWithIndex:index];
    };
    self.navigationItem.titleView = navView;
    
    NSMutableArray* controllerArray =[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        
        CityTableViewController *controller=[[CityTableViewController alloc]init];
        controller.delegate=self;
        switch (i) {
            case 0:
                controller.cityType=ENT_City;
                controller.locationCity=self.locationCity;
                break;
            case 1:
                controller.cityType=ENT_Province;
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
}
-(void)displayCity:(NSString *)ctiy CityType:(CityType)type
{
    
    NSString *oreillyAddress=ctiy;
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil)
        {
            
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            if (type==ENT_City) {
                self.selectAreaBlock(oreillyAddress,nil,firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude);
            }else
            {
                self.selectAreaBlock(nil,oreillyAddress,firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude);
            }
            
        }
        else if ([placemarks count] == 0 && error == nil)
        {
            NSLog(@"Found no placemarks.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
}

#pragma mark navBarDelegate
-(void)itemSlideScroll:(CGFloat)f{
    NSLog(@"f=%f",f);
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
