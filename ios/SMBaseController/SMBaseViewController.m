//
//  SMBaseViewController.m
//  SkillExchange
//
//  Created by xu bin on 15/3/10.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
//#import "keychainItemManager.h"
//#import "IHUtility+category.h"
#import "XHFriendlyLoadingView.h"
//#import "ZhuCeViewController.h"
//#import "AppDelegate.h"
//#import "SDWebImageManager.h"
//#import "MTLoginViewController.h"
#import "THModalNavigationController.h"
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define  bactTopWidth  44
#import "MTTopicDetailsViewController.h"
#import "ShareSheetView.h"
#import <Photos/Photos.h>

@interface SMBaseViewController ()<UIGestureRecognizerDelegate,CNPPopupControllerDelegate>
{
    NSString  *_city;
    NSString  *_province;
    IHTextField *_passWordText;
    IHTextField *_phoneText;
    IHTextField *_oldPassWordTextFeild;
    IHTextField *_newPassWordTextFeild;
     int channel;
    BOOL  isErrorLocation;
    BOOL isLocation ;
    
}
@end

@implementation SMBaseViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:NO];

    


//    backTopbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    backTopbutton.frame=CGRectMake(WindowWith-55, WindowHeight-60, bactTopWidth, bactTopWidth);
//    [backTopbutton setBackgroundImage:Image(@"s_backTop.png") forState:UIControlStateNormal];
//    [backTopbutton addTarget:self action:@selector(backTopClick:) forControlEvents:UIControlEventTouchUpInside];
//    backTopbutton.alpha=0;
//    [self.view addSubview:backTopbutton];
    
 
//    _barlineView=[[UIView alloc]initWithFrame:CGRectMake(0, 43, WindowWith, 1)];
//    _barlineView.backgroundColor = RGBA(0, 0, 0, 0.1);
//    [self.navigationController.navigationBar addSubview:_barlineView];
 
//    _barlineView=[[UIView alloc]initWithFrame:CGRectMake(0, 43, WindowWith, 1)];
//    _barlineView.backgroundColor = cLineColor;
//    [self.navigationController.navigationBar addSubview:_barlineView];
 
//    [self.view bringSubviewToFront:lineview];
    
    // Do any additional setup after loading the view.
}

- (void)setNaviBarHidden:(BOOL)naviBarHidden{
    _naviBarHidden = naviBarHidden;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSArray *ViewControllers=self.navigationController.viewControllers;
    if (ViewControllers.count>1) {
        [self setHomeTabBarHidden:YES];
    }else{
         [self setHomeTabBarHidden:NO];
    }
    
    [self.navigationController setNavigationBarHidden:self.naviBarHidden animated:animated];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.navigationController.viewControllers.firstObject == self) {
        self.navigationController.interactivePopGestureRecognizer.enabled = false;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = true;
    }
    
}


//渐变颜色
- (CAGradientLayer *) retureCagradColor:(UIColor *)color1 andColor:(UIColor *)color2 andBounds:(CGRect )bounds{
    //渐变色，加蒙版，显示的蒙版的区域
    CAGradientLayer *gradientLayer =[[CAGradientLayer alloc]init];
    gradientLayer.frame = bounds;
    gradientLayer.colors = @[(id)color1.CGColor,(id)color2.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1); //径向渐变
    return gradientLayer;
    
}


-(void)backTopClick:(UIButton *)sender{
    
}

-(void)setbackTopFrame:(CGFloat)y{
//    backTopbutton.frame=CGRectMake(WindowWith-55,y, bactTopWidth, bactTopWidth);
}

-(void)scrollTopPoint:(UIScrollView *)scroll{
    [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y=scrollView.contentOffset.y;
    if (y>_boundHeihgt) {
        [UIView animateWithDuration:0.5f animations:^{
            self->backTopbutton.alpha=1;
            [self.view bringSubviewToFront:self->backTopbutton];
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self->backTopbutton.alpha=0;
            // [self.view bringSubviewToFront:backTopbutton];
        } completion:^(BOOL finished) {
        }];
    }
}

-(void)setHomeTabBarHidden:(BOOL)isHidden{
    if (isHidden) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationtabBarHidden object:[NSNumber numberWithBool:YES]];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationtabBarHidden object:[NSNumber numberWithBool:NO]];
    }
}

-(void)back:(id)sender{
   
//    NSArray *ViewControllers=self.navigationController.viewControllers;
//    if (ViewControllers.count==2) {
//        [self setHomeTabBarHidden:NO];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)pushViewController:(UIViewController *)viewcontroller {
    [self setHomeTabBarHidden:YES];
 //   viewcontroller.hidesBottomBarWhenPushed = YES;   //这个必须写在super前面, 否则跳转已经过了
    
    [self.navigationController pushViewController:viewcontroller animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentViewController:(UIViewController *)viewcontroller{
	THModalNavigationController *nav = [[THModalNavigationController alloc]initWithRootViewController:viewcontroller];
	[self presentViewController:nav animated:YES completion:nil];
}

//数据缓存 1小时刷新一次
-(void)refreshTableViewLoading:(MTBaseTableView *)_commTableView
                          data:(NSMutableArray *)dataArray
                      dateType:(NSString *)dateType{
    if([_commTableView.table.mj_header isRefreshing])
    {
        return;
    }
    
    //1小时更新一次
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSDate *date1=[NSDate date];
    NSDate *oldDate;
    oldDate=[userDefault objectForKey:dateType];
    int t=[IHUtility daysWithinEraFromDate:oldDate toDate:date1];
    if (oldDate!=nil) {
        if (dataArray.count==0) {
            
        }else{
            if (t<0.5){
                return;
            }
        }
    }
    [_commTableView.table.mj_header beginRefreshing];
    
    NSDate *date=[NSDate date];
    [userDefault setObject:date forKey:dateType];
    [userDefault synchronize];
}

-(void)refreshTableViewLoading2:(UITableView *)_commTableView
                          data:(NSMutableArray *)dataArray
                      dateType:(NSString *)dateType{
    if([_commTableView.mj_header isRefreshing])
    {
        return;
    }
    
    //1小时更新一次
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSDate *date1=[NSDate date];
    NSDate *oldDate;
    oldDate=[userDefault objectForKey:dateType];
    int t=[IHUtility daysWithinEraFromDate:oldDate toDate:date1];
    if (oldDate!=nil) {
        if (dataArray.count==0) {
            
        }else{
            if (t<0.5){
                return;
            }
        }
    }
    [_commTableView.mj_header beginRefreshing];
    
    NSDate *date=[NSDate date];
    [userDefault setObject:date forKey:dateType];
    [userDefault synchronize];
    
}


-(void)CreateBaseRefesh:(MTBaseTableView *)commtableView
                   type:(RefreshEnumType)type
          successRefesh:(void(^)(MJRefreshComponent *refreshView))successRefesh{
    [self.view setBackgroundColor:cBgColor];
    
     self.successRefeshBlock=successRefesh;
    if (type==ENT_RefreshAll) {
        commtableView.table.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
        commtableView.table.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }else if (type==ENT_RefreshHeader){
        commtableView.table.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }else if (type==ENT_RefreshFooter){
         commtableView.table.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }
    
    commBaseTableView=commtableView;
}

- (void)addBaseTableViewRefesh:(UITableView *)tableView
                          type:(RefreshEnumType)type
                 successRefesh:(void(^)(MJRefreshComponent *refreshView))successRefesh{
    self.successRefeshBlock=successRefesh;
    if (type==ENT_RefreshAll) {
        tableView.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
        tableView.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }else if (type==ENT_RefreshHeader){
        tableView.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }else if (type==ENT_RefreshFooter){
        tableView.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }
}


-(void)CreateCollectionViewRefesh:(UICollectionView *)collectionView
                   type:(RefreshEnumType)type
          successRefesh:(void(^)(MJRefreshComponent *refreshView))successRefesh{
    [self.view setBackgroundColor:cBgColor];
    
    self.successRefeshBlock=successRefesh;
    if (type==ENT_RefreshAll) {
        collectionView.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
        collectionView.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }else if (type==ENT_RefreshHeader){
        collectionView.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }else if (type==ENT_RefreshFooter){
        collectionView.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }
    
    CollectionView=collectionView;
}


-(void)CreateTableViewRefesh:(UITableView *)TableView
                             type:(RefreshEnumType)type
                    successRefesh:(void(^)(MJRefreshComponent *refreshView))successRefesh{
    [self.view setBackgroundColor:cBgColor];
    
    self.successRefeshBlock=successRefesh;
    if (type==ENT_RefreshAll) {
        TableView.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
        TableView.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }else if (type==ENT_RefreshHeader){
        TableView.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }else if (type==ENT_RefreshFooter){
        TableView.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    }
    
    mTableView = TableView;
}

-(void)beginRefesh:(RefreshEnumType)type{
    if (type==ENT_RefreshHeader){
        [commBaseTableView.table.mj_header beginRefreshing];
    }
    else if (type==ENT_RefreshFooter){
         [commBaseTableView.table.mj_footer beginRefreshing];
    }
}

-(void)begincollectionViewRefesh:(RefreshEnumType)type{
    if (type==ENT_RefreshHeader){
        [CollectionView.mj_header beginRefreshing];
    }
    else if (type==ENT_RefreshFooter){
        [CollectionView.mj_footer beginRefreshing];
    }
}

-(void)beginTableViewRefesh:(RefreshEnumType)type{
    if (type==ENT_RefreshHeader){
        [mTableView.mj_header beginRefreshing];
    }
    else if (type==ENT_RefreshFooter){
        [mTableView.mj_footer beginRefreshing];
    }
}





-(void)endRefresh{
    if([commBaseTableView.table.mj_header isRefreshing])
    {
        [commBaseTableView.table.mj_header endRefreshing];
    }else if ([commBaseTableView.table.mj_footer isRefreshing]){
         [commBaseTableView.table.mj_footer endRefreshing];
    }
}

-(void)endcollectionViewRefresh{
    if([CollectionView.mj_header isRefreshing])
    {
        [CollectionView.mj_header endRefreshing];
    }else if ([CollectionView.mj_footer isRefreshing]){
        [CollectionView.mj_footer endRefreshing];
    }
}

-(void)endTableViewRefresh{
    if([mTableView.mj_header isRefreshing])
    {
        [mTableView.mj_header endRefreshing];
        
    }else if ([mTableView.mj_footer isRefreshing]){
        
        [mTableView.mj_footer endRefreshing];
    }
}




-(void)loadRefreshData:(MJRefreshComponent *)refreshView{
    self.successRefeshBlock(refreshView);
}



-(void)setNavBarItem:(BOOL)hasCollection{
    UIImage *img=Image(@"Group 35.png");
    UIImage *shareImg=Image(@"shareGreen.png");
    if (hasCollection) {
        img=Image(@"activ_detailCollect.png");
    }
    searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 44, 44);
    
    [searchBtn addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:img forState:UIControlStateNormal];
     searchBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);
    
    
    moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(0, 0, 40, 40);
    [moreBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:shareImg forState:UIControlStateNormal];
    
    moreBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);
    UIBarButtonItem *barSearchBtn=[[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    UIBarButtonItem *barMoreBtn=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    NSArray *rightBtns=[NSArray arrayWithObjects:barMoreBtn,barSearchBtn, nil];
    self.navigationItem.rightBarButtonItems=rightBtns;
    
//    UIButton *Btn2=[UIButton buttonWithType:UIButtonTypeCustom];
//    Btn2.frame=CGRectMake(0, 0, 40, 40);
//
//    [Btn2 setBackgroundImage:img forState:UIControlStateNormal];
//    Btn2.hidden=YES;
//
//    UIBarButtonItem *leftBtn2=[[UIBarButtonItem alloc]initWithCustomView:Btn2];
//
    
//    img=Image(@"iconfont-fanhui.png");
//    UIButton *Btn3=[UIButton buttonWithType:UIButtonTypeCustom];
//    Btn3.frame=CGRectMake(0, 0, 44, 44);
//    [Btn3 setImage:img forState:UIControlStateNormal];
//    [Btn3 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
//    UIBarButtonItem *item3  = [[UIBarButtonItem alloc] initWithCustomView:Btn3];
//    self.navigationItem.leftBarButtonItems=@[item3,leftBtn2];
    
}
//导航栏透明的按钮
- (void)setApleaNavgationItem:(BOOL)hasCollection{
    
    UIImage *collectImg = Image(@"Group 35.png");
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, collectImg.size.width, collectImg.size.height);
    [collectBtn setImage:collectImg forState:UIControlStateNormal];
    [collectBtn setImage:Image(@"activ_detailCollect.png") forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
    searchBtn = collectBtn;
    
    if (hasCollection){
        collectBtn.selected = YES;
    }
    
    UIBarButtonItem *collectBarItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
    
    UIImage *shareImg = Image(@"shareGreen.png");
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, shareImg.size.width, shareImg.size.height);
    [shareBtn setImage:shareImg forState:UIControlStateNormal];
    [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    moreBtn = shareBtn;
    UIBarButtonItem *shareBarItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItems = @[shareBarItem,collectBarItem];
    
}
-(void)share
{
    
}

-(void)collection
{
    
}



#pragma mark - Actions

-(void)showUserLocation :(void(^)(NSString *province,NSString *city,CGFloat latitude,CGFloat longtitude))success
{
    // 判断的手机的定位功能是否开启
    // 实例化一个位置管理器
    self.locationManager = [[CLLocationManager alloc] init];
    isErrorLocation=YES;
    isLocation=NO;
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
     self.showUserLocationBlock=success;
    // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
    // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
    self.locationManager.distanceFilter = 1000.0f; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
    
    
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
         if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
         {
             [_locationManager requestAlwaysAuthorization];
         }
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
      
    }
    else
    {
        self.showUserLocationBlock(@"",@"",0.f,0.f);
        [IHUtility AlertMessage:@"定位服务已关闭" message:@"请到设置->隐私->定位服务中开启，以便苗木供求方更快找到您。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置" tag:1001];
        isErrorLocation=NO;
        
    }
}



#pragma mark - CLLocationManagerDelegate
// 地理位置发生改变时触
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    
    [manager stopUpdatingLocation];
    
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       
                       for (CLPlacemark *place in placemarks) {
                           self->_city=place.locality;
                           self->_province=place.administrativeArea;
                           if (self->isLocation) {
                               return;
                           }
                           self.showUserLocationBlock(self->_province,self->_city,newLocation.coordinate.latitude,newLocation.coordinate.longitude);
                           self->isLocation=YES;
                         // NSLog(@"%@",_userLocation);
                                        // 位置名
                           //                           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
                           //                           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
                           //                           NSLog(@"locality,%@",place.locality);               // 市
                           //                           NSLog(@"subLocality,%@",place.subLocality);         // 区
                           //                           NSLog(@"country,%@",place.country);                 // 国家
                       }
                       
                   }];
 
}




// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
    
    if (isErrorLocation) {
        
        self.showUserLocationBlock(@"",@"",0.f,0.f);
        
        [IHUtility AlertMessage:@"定位服务已关闭" message:@"请到设置->隐私->定位服务中开启，以便苗木供求方更快找到您。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置" tag:1001];
        isErrorLocation=NO;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}



-(void)addPushViewWaitingView{
    
   XHFriendlyLoadingView* HUD = [[XHFriendlyLoadingView alloc] initWithFrame:CGRectMake(0, 0, WindowWith,WindowHeight)];
    HUD.tag=8172;
    _HUD = HUD;
    [HUD showFriendlyLoadingViewWithText:@"正在加载..." loadingAnimated:YES];
    [self.view addSubview:HUD];
    __weak typeof(self) weakSelf = self;
    HUD.reloadButtonClickedCompleted = ^(UIButton *sender) {
        // 这里可以做网络重新加载的地方
        [weakSelf reloadWaitingView];
    };
    [self.view addSubview:HUD];
    
}

- (void)reloadWaitingView{
    //TODO
}

-(void)removePushViewWaitingView{
    
    
    XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
    if (v==nil)
    {
        return;
    }
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        v.alpha = 0.;
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
}


-(void)addWaitingView{
    
  [IHUtility addWaitingView];
   
}

-(void)removeWaitingView{
    [IHUtility removeWaitingView];
}

-(void)shareView2:(buyType)type object:(id)object vc:(UIViewController *)vc{
    NSString *crowID;
    if (type == ENT_Crowd) {
        CrowdOrderModel *model=(CrowdOrderModel *)object;
        crowID = stringFormatInt(model.infoModel.crowd_id);
    }else if (type == ENT_MyCrowdList) {
        ActivitiesListModel *mode = (ActivitiesListModel *)object;
        crowID = mode.crowd_id;
    }
    [self sharePosterdOject:crowID Vc:vc];    //分享海报
    
    /*
    shareView.selectShareMenu=^(NSInteger index){
        NSString *sharUrl;
        NSString *imgUrl=@"";
        NSString *title;
        NSString *content;
        NSString *crowID;
        if (type == ENT_Crowd) {
            CrowdOrderModel *model=(CrowdOrderModel *)object;
            sharUrl=[NSString stringWithFormat:@"%@%@%ld&appkey=%@",shareURL,shareCrowd,model.infoModel.crowd_id,APP_KEY];
            title=[NSString stringWithFormat:@"众筹|%@",model.infoModel.activities_titile];
            imgUrl = model.infoModel.activities_pic;
            content=[NSString stringWithFormat:@"%@",model.infoModel.activities_intro];
            crowID = stringFormatInt(model.infoModel.crowd_id);
        }else if (type == ENT_MyCrowdList) {
            ActivitiesListModel *mode = (ActivitiesListModel *)object;
            sharUrl=[NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareCrowd,mode.crowd_id,APP_KEY];
            title=[NSString stringWithFormat:@"众筹|%@",mode.activities_titile];
            imgUrl = mode.activities_pic;
            content=[NSString stringWithFormat:@""];
            crowID = mode.crowd_id;
        }
        if (index == 2) {
            [self sharePosterdOject:crowID Vc:vc];    //分享海报
        }else if (index == 0){
            [IHUtility SharePingTai:title url:sharUrl imgUrl:imgUrl content:content PlatformType:1 controller:vc];
        }else {
            [IHUtility SharePingTai:title url:sharUrl imgUrl:imgUrl content:content PlatformType:1 controller:vc];
        }
    };
    [shareView showCentY];
 //*/
    
}
- (void) sharePosterdOject:(NSString *)crowID Vc:(UIViewController *)vc{
    ShareSheetView  *shareViewPost=[[ShareSheetView alloc] initWithFrame:self.view.frame styleType:SharePostersType];
    NSString *CrowPath = [NSString stringWithFormat:@"pages/activity/detail/zcPersonDetail/zcPersonDetail?crowdId=%@",crowID];
    NSDictionary *dict = @{
                           @"appid"     :WXXCXappId,
                           @"appsecret" :WXXCXappSecret,
                           @"type"      :@"8",
                           @"id"        :crowID,
                           @"path"      :CrowPath,
                           };
   __block NSString *imageUrl;
    [IHUtility addWaitingViewText:@"海报生成中..."];
    [network httpGETRequestTagWithParameter:dict method:ProductCodeUrl tag:IH_init success:^(NSDictionary *obj) {
        imageUrl = obj[@"content"];
        [self removeWaitingView];
        shareViewPost.codImage = imageUrl;
        if (![imageUrl isEqualToString:@""]) {
            [shareViewPost show];
        }else {
            [self showTextHUD:@"生成海报失败请重试"];
        }
        
    } failure:^(NSDictionary *obj) {
        [self removeWaitingView];
        [self showTextHUD:@"生成海报失败请重试"];
    }];
    
    shareViewPost.selectShareMenu = ^(NSInteger index) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        if (index == 3) {
            [self loadImageFinished:[UIImage imageWithData:imageData]];
        }else {
            [IHUtility shareImageToPlatformType:index Image:[UIImage imageWithData:imageData] controller:vc completion:^(id data, NSError *error) {
                
            }];
        }
    };
}

//课堂分享小程序码到微信小程序
- (void) shareSmallProgramCodeOject:(NSDictionary *)paramet httpMethod:(NSInteger)httpMethod methoe:(NSString *)url Vc:(UIViewController *)vc completion:(void (^)(id, NSError *))completion{
    ShareSheetView  *shareViewPost=[[ShareSheetView alloc] initWithFrame:self.view.frame styleType:SharePostersType];
    __block NSString *imageUrl;
     [self addWaitingView];
    if (httpMethod == 1) {
        [network httpGETRequestTagWithParameter:paramet method:url tag:IH_init success:^(NSDictionary *obj) {
            imageUrl = obj[@"content"];
            [self removeWaitingView];
            shareViewPost.codImage = imageUrl;
            if (![imageUrl isEqualToString:@""]) {
                [shareViewPost show];
            }
        } failure:^(NSDictionary *obj) {
            [self removeWaitingView];
        }];
    }else {
        [network httpRequestTagWithParameter:paramet method:url tag:IH_init success:^(NSDictionary *obj) {
            imageUrl = obj[@"content"];
            [self removeWaitingView];
            shareViewPost.codImage = imageUrl;
            if (![imageUrl isEqualToString:@""]) {
                [shareViewPost show];
            }
        } failure:^(NSDictionary *obj) {
            [self removeWaitingView];
        }];
    }
    shareViewPost.selectShareMenu = ^(NSInteger index) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        if (index == 3) {
            [self loadImageFinished:[UIImage imageWithData:imageData]];
        }else {
            [IHUtility shareImageToPlatformType:index Image:[UIImage imageWithData:imageData] controller:vc completion:^(id data, NSError *error) {
                if (completion) {
                    completion(data,error);
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:NotificationShareSucces object:nil];
            }];
        }
    };
}

- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == YES) {
             [self addSucessView:@"保存成功！" type:1];
        }else{
            [self addSucessView:@"保存失败" type:2];
        }
    }];
}


//V2.9.9前分享
-(void)shareView:(buyType)type object:(id)object vc:(UIViewController *)vc{
//    ShareView *shareView=[[ShareView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
//    __weak ShareView *weakShare=shareView;
    
    ShareSheetView  *shareView=[[ShareSheetView alloc]initWithShare];
    shareView.selectShareMenu=^(NSInteger index){
        
        NSString *sharUrl;
        NSString *imgUrl=@"";
        NSString *title;
        NSString *content;
        if (type==ENT_Supply||type==ENT_Buy) {
            
            MTSupplyAndBuyListModel *model=(MTSupplyAndBuyListModel*)object;
            
            sharUrl=[NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareSupply,model.supply_id,APP_KEY];
            if (type==ENT_Supply) {
                NSArray *arr=[network getJsonForString:model.supply_url];
                if (arr.count>0) {
                    MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:arr[0]];
                    imgUrl=mod.thumbUrl;
                }

                
            }else if (type==ENT_Buy){
                NSArray *arr=[network getJsonForString:model.want_buy_url];
                if (arr.count>0) {
                    MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:arr[0]];
                    imgUrl=mod.thumbUrl;
                }
               
            }
                       if (type==ENT_Supply) {
                 sharUrl=[NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareSupply,model.supply_id,APP_KEY];
                title=[NSString stringWithFormat:@"供应-%@",model.varieties];
                content=[NSString stringWithFormat:@"单价:%@\n数量:%@",model.unit_price,model.number];
            }else if (type==ENT_Buy){
                title=[NSString stringWithFormat:@"求购-%@",model.varieties];
                content=[NSString stringWithFormat:@"数量:%@",model.number];
                 sharUrl=[NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareBuy,model.want_buy_id,APP_KEY];
            }
        }else if (type==ENT_Topic){
            MTTopicListModel *model=(MTTopicListModel *)object;
            sharUrl=[NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareTopic,model.topic_id,APP_KEY];
            if ([vc isMemberOfClass:[MTTopicDetailsViewController class]]) {

                MTTopicDetailsViewController *topicVC = (MTTopicDetailsViewController *)vc;
                if (topicVC.topicTitle == nil) {
                    if (model.topic_content.length>30) {
                        NSString *str=[model.topic_content substringToIndex:30];
                         title = [NSString stringWithFormat:@"%@",str];
                    }else{
                        title = [NSString stringWithFormat:@"%@",model.topic_content];
                    }
                   
                }else {
                 title=[NSString stringWithFormat:@"探讨园林行业话题之  %@",topicVC.topicTitle];
                }
                
                
                if (topicVC.subTitle == nil) {
                    content=[NSString stringWithFormat:@"分享一条%@的话题动态",model.userChildrenInfo.nickname];
                }else {
                    
                    if (model.topic_content.length>30) {
                        NSString *str=[model.topic_content substringToIndex:30];
                        content=[NSString stringWithFormat:@"%@\n%@",topicVC.subTitle,str];
                    }else{
                        content=[NSString stringWithFormat:@"%@\n%@",topicVC.subTitle,model.topic_content];
                    }

                    
                    
                }
            }else {
                if (model.topic_content.length>30) {
                    NSString *str=[model.topic_content substringToIndex:30];
                    title = [NSString stringWithFormat:@"%@",str];
                }else{
                    title = [NSString stringWithFormat:@"%@",model.topic_content];
                }

                
                 content=[NSString stringWithFormat:@"分享一条%@的话题动态",model.userChildrenInfo.nickname];
            }
            if (model.imgArray.count>0) {
                MTPhotosModel *mod=[model.imgArray objectAtIndex:0];
                imgUrl=mod.thumbUrl;
            }else{
                imgUrl=@"";
            }

        }else if (type == ENT_Activties){
            
            ActivitiesListModel *model = (ActivitiesListModel *)object;
            sharUrl=[NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareActivties,model.activities_id,APP_KEY];
            title=[NSString stringWithFormat:@"%@",model.activities_titile];
            if (model.activities_pic.length > 0) {
                imgUrl = model.activities_pic;
            }else{
                imgUrl = @"";
            }
            
            if (model.activities_content_text.length>0) {
                
                NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
                NSString *str=[NSString stringWithFormat:@"%@%@",@"<meta charset=\"UTF-8\" >",model.activities_content_text];//:@"%@%@",@"<meta charset=\"UTF-8\">",model.content];
                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                options:options documentAttributes:nil error:nil];
                NSString *text = [attrString string];
                if (model.activities_content_text.length >140) {
                    content = [text substringWithRange:NSMakeRange(0, 140)];
                }else {
                    content = text;
                }
                
            }else{
               
                
          
                 content = [NSString stringWithFormat:@"%@APP\n%@",KAppName,KAppTitle];
           

            }
        }else if (type==ENT_Photos){
            NewsListModel *model=(NewsListModel *)object;
            sharUrl=[NSString stringWithFormat:@"%@%@&appkey=%@",shareURL,model.info_url,APP_KEY];
            title=[NSString stringWithFormat:@"[图集]%@",model.info_title];
            if (model.imgModels.count > 0) {
                 NewsImageModel *mod=model.imgModels[0];
                imgUrl = mod.img_path;
            }else{
                imgUrl = @"";
            }
            
            if (model.infomation_desc.length>0) {
                
                NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
                NSString *str=[NSString stringWithFormat:@"%@%@",@"<meta charset=\"UTF-8\" >",model.infomation_desc];//:@"%@%@",@"<meta charset=\"UTF-8\">",model.content];
                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                options:options documentAttributes:nil error:nil];
                NSString *text = [attrString string];
                if (model.infomation_desc.length >140) {
                    content = [text substringWithRange:NSMakeRange(0, 140)];
                }else {
                    content = text;
                }
                
            }else{

                content = [NSString stringWithFormat:@"%@APP\n%@",KAppName,KAppTitle];

            }

        }else if (type==ENT_Crowd){
            CrowdOrderModel *model=(CrowdOrderModel *)object;

          
            sharUrl=[NSString stringWithFormat:@"%@%@%ld&appkey=%@",shareURL,shareCrowd,model.infoModel.crowd_id,APP_KEY];
            title=[NSString stringWithFormat:@"众筹|%@",model.infoModel.activities_titile];
            imgUrl = model.infoModel.activities_pic;
           
            content=[NSString stringWithFormat:@"%@",model.infoModel.activities_intro];
            
            
        }else if (type == ENT_questions){
            AskBarDetailModel *model = (AskBarDetailModel *)object;
            
            sharUrl=[NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareQuestion,model.form_id,APP_KEY];
            title=[NSString stringWithFormat:@"%@",model.Description];
            imgUrl = model.heed_image_url;
            
            content=[NSString stringWithFormat:@"%@",model.user_desc];
        }else if (type == ENT_Answer){
            ReplyProblemListModel *model = (ReplyProblemListModel *)object;
            
            sharUrl=[NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareAnswer,model.infoModel.answer_id,APP_KEY];
            title=[NSString stringWithFormat:@"%@",model.title];
            imgUrl = model.infoModel.heed_image_url;
            
            content=[NSString stringWithFormat:@"%@",model.infoModel.answer_content];
        }else if (type == ENT_SeedCloudDetail){
            NurseryListModel *model = (NurseryListModel *)object;
            sharUrl=[NSString stringWithFormat:@"%@%@%d&appkey=%@",shareURL,shareNursery,(int)model.nursery_id,APP_KEY];
            title=[NSString stringWithFormat:@"【供应】%@",model.plant_name];
            if (model.imageArr.count >0) {
                MTPhotosModel *mod = model.imageArr[0];
                imgUrl = mod.imgUrl;
            }
            content=[NSString stringWithFormat:@"装车价:%@\n数量:%@",model.loading_price,model.num];
        }
        
        if (index==6) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string =[NSString stringWithFormat:@"分享一条%@%@",title,sharUrl];
            [self addSucessView:@"复制成功" type:1];
            return ;
        }
        
       
          [IHUtility SharePingTai:title url:sharUrl imgUrl:imgUrl content:content PlatformType:index controller:vc completion:nil];
//        if (index==SelectWXhaoyouBtnBlock) {
//            
//          
//          
//        }else if (index==SelectWXpengyouBtnBlock){
//            [IHUtility SharePingTai:title url:sharUrl imgUrl:imgUrl content:content PlatformType:2 controller:vc];
//            
//        }
        
    };
 
    [shareView show];
}

-(void)ShareApp:(NSInteger)index{
//    ShareView *shareView=[[ShareView alloc]initWithIsFriendFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
//     __weak ShareView *weakShare=shareView;
//    shareView.selectBtnBlock=^(NSInteger index){
    
        if (index==SelectWXhaoyouBtnBlock) {
 
           

           NSString *str=[NSString stringWithFormat:@"%@，加入%@，携手共赢",KAppTitle,KAppName];
             [IHUtility SharePingTai:str url:[NSString stringWithFormat:@"%@register/register.html?id=%@&appkey=%@",shareURL,[IHUtility base64WithString:USERMODEL.userID],APP_KEY] imgUrl:@"" content:[NSString stringWithFormat:@"用%@找苗木、找人脉、找企业，即刻邀请好友加入，直接送你微信红包",KAppName] PlatformType:1 controller:self completion:nil];
            
            
        }else if (index==SelectWXpengyouBtnBlock){
            NSString *str=[NSString stringWithFormat:@"%@，加入%@，携手共赢",KAppTitle,KAppName];
            [IHUtility SharePingTai:str url:[NSString stringWithFormat:@"%@register/register.html?id=%@&appkey=%@",shareURL,[IHUtility base64WithString:USERMODEL.userID],APP_KEY] imgUrl:@"" content:[NSString stringWithFormat:@"用%@找苗木、找人脉、找企业，即刻邀请好友加入，直接送你微信红包",KAppName] PlatformType:2 controller:self completion:nil];

   
        }
        
        
//        [weakShare hideView];
//        
//    };
//    [self.view.window addSubview:shareView];
}


-(void)ShareUrl:(UIViewController *)vc withTittle:(NSString *)tittle content:(NSString *)content withUrl:(NSString *)urlStr imgUrl:(NSString *)imgURL
{
    
        NSString *str;
        if (content.length>0) {
            
            if (content.length > 140) {
                str = [content substringToIndex:140];
            }else {
                str = content;
            }
        }else{

            str = [NSString stringWithFormat:@"%@APP\n%@",KAppName,KAppTitle];


        }
    

        ShareSheetView  *shareView=[[ShareSheetView alloc]initWithShare];
        shareView.selectShareMenu=^(NSInteger index){
            
            if (index==6) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string =[NSString stringWithFormat:@"分享一条%@%@",tittle,urlStr];
                [self addSucessView:@"复制成功" type:1];
                return ;
            }
            
            //WS(weakSelf);
            [IHUtility SharePingTai:tittle url:urlStr imgUrl:imgURL content:str PlatformType:index controller:vc completion:^{
                if (!USERMODEL.isLogin) {
                    
                }else
                {
//                   [weakSelf ShareAddPoint];  
                }
            }];
        };
        
        
        
        [shareView show];
}


- (void) ShareAddPoint {
    NSDictionary *dict = @{  @"user_id":USERMODEL.userID };
    [network httpRequestWithParameter:dict method:shareAddPointUrl success:^(id obj) {
        NSLog(@"-分享+苗币--obj==%@",obj);
    } failure:^(id obj) {
        NSLog(@"-分享+苗币--obj==%@",obj);
    }];
}




//每日任务分享
-(void)taskShareApp:(UIViewController *)vc{
    ShareView *shareView=[[ShareView alloc]initWithIsFriendFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
    __weak ShareView *weakShare=shareView;
    shareView.selectBtnBlock=^(NSInteger index){
        
        if (index==SelectWXhaoyouBtnBlock) {
            

            NSString *str=[NSString stringWithFormat:@"HI，朋友，友谊的小船不会翻，送你100个%@积分，抵现金用",KAppName];
            [IHUtility SharePingTai:str url:@"http://www.miaoto.net/" imgUrl:@"" content:[NSString stringWithFormat:@"我一直在用%@找苗木、搜人脉、找企业。邀你一起来体验，积分还可抵现金用哦",KAppName] PlatformType:1 controller:self completion:nil];
            
          
        }else if (index==SelectWXpengyouBtnBlock){
            NSString *str=[NSString stringWithFormat:@"HI，朋友，友谊的小船不会翻，送你100个%@积分，抵现金用",KAppName];
            [IHUtility SharePingTai:str url:@"http://www.miaoto.net/" imgUrl:@"" content:[NSString stringWithFormat:@"我一直在用%@找苗木、搜人脉、找企业。邀你一起来体验，积分还可抵现金用哦",KAppName] PlatformType:2 controller:self completion:nil];
        }
        
        
        [weakShare hideView];
        
    };
    [self.view.window addSubview:shareView];
}

//个人名片
-(void)Shareinformation:(NSString *)userId name:(NSString *)name phone:(NSString *)phone adress:(NSString *)adress imgUrl:(NSString *)imgUrl vc:(UIViewController *)vc{
    
    
    NSString *str=[NSString stringWithFormat:@"【园林云】%@",name];
    NSString *content ;
    if (phone.length > 0) {
        content = [NSString stringWithFormat:@"主营：%@",phone];
    }else {
       
    content = [NSString stringWithFormat:@"%@园林云，易传播，易分享的园林行业专属名片。",KAppName];

    }

    ShareSheetView  *shareView=[[ShareSheetView alloc]initWithShare];
    shareView.selectShareMenu=^(NSInteger index){
        
        if (index==6) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string =[NSString stringWithFormat:@"分享一条%@%@",name,adress];
            [self addSucessView:@"复制成功" type:1];
            return ;
        }
        
        [IHUtility SharePingTai:str url:adress imgUrl:imgUrl content:content PlatformType:index controller:self completion:nil];
        
    };
    
    [shareView show];
}

// type 1成功  2失败
-(void)addSucessView:(NSString *)str type:(int)type{
    [IHUtility addSucessView:str type:type];
}
//文字提示
-(void)showTextHUD:(NSString *)str{
    [IHUtility OnlyShowTexHudPrompt:str];
}
- (void) showWaitingHUD:(NSString *)str {
    [IHUtility ShowTexHudPrompt:str];
}
- (void)HUDHidden {
    [IHUtility HudHidden];
}
-(void)prsentToLoginViewController
{
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil];
}

-(void)showLoginViewWithType:(LaginType)type
{
    MTLoginView *loginView = [[MTLoginView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight) :type];
    __block MTLoginView *manager = loginView;
    __weak MTLoginView *weakmanager = manager;

    manager.selectSurnBlock=^(NSString *str,NSString *str2){
        [self addWaitingView];
        [network getUserPhoneNumber:[USERMODEL.userID intValue]code:str2 phone:str success:^(NSDictionary *obj) {
            [self addSucessView:@"手机号绑定成功^_^" type:1];
            [weakmanager hideView];
            
            NSDictionary *dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
            
            NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
            [dic2 setObject:str forKey:@"mobile"];
            USERMODEL.mobile=str;
            [IHUtility saveDicUserDefaluts:dic2 key:kUserDefalutLoginInfo];
        }];
        
    };
    
    manager.selectYZMBlock=^(NSString *phone){
        [network getSendRegisterSms:phone type:2 chanle:self->channel  success:^(NSDictionary *obj) {
            self->channel++;
            [self removeWaitingView];
            [self addSucessView:@"验证码发送成功，请耐心等待哦^_^" type:1];
            [ConfigManager countdownSecond:60  returnTitle:^(NSString *title)
             {
                 
                 if (ConfigManager.seconds>0) {
                     [weakmanager.loginBtn setTitle:title forState:UIControlStateNormal];
                     loginView.loginBtn.userInteractionEnabled = NO;
                 }
                 else
                 {
                     [loginView.loginBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                     loginView.loginBtn.userInteractionEnabled = YES;
                 }
             }];
            }];
    };
    [self.view.window addSubview:loginView];
    
}

@end


@implementation SMBaseCustomViewController

@synthesize _usersettings,_BaseScrollView,_activityTextField;


- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scroll setContentSize:CGSizeMake(_deviceSize.width, _boundHeihgt)];
    [scroll setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scroll];
    _BaseScrollView=scroll;
    
    
    if (_usersettings==nil) {
        _usersettings=[AppUserSettings usersettings];
    }
    
    [self registerForKeyboardNotifications];
    
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLeaveViewController) name:@"leftViewController" object:nil];
    
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    [self.view addGestureRecognizer:singleTapGR];
}


- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    
    [self.view endEditing:YES];
}


- (void)dealloc {
    [self removeKeyboardNotifications];
    //	[_usersettings release];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark UIKeyboard

-(void)removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //如果不是当前页面
    if (![self.navigationController.visibleViewController isEqual:self] || (_activityTextField == nil && _activityTextView==nil)) {
        return;
    }
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
   // NSLog(@"\n\n  keyboardWasShown   kbSize height:%f",kbSize.height);
    
    //如果加过一次，就不再加了。 不然重复加会出问题
    if(_hadKeyboardShow == NO)
    {
        CGSize size= _BaseScrollView.contentSize;
 
        size.height +=kbSize.height;
        
        
        _addContentSize = kbSize;
        [_BaseScrollView setContentSize:CGSizeMake(size.width, size.height)];
    }
    
    
    UIView *container;
    CGRect fieldFrame;
    if (_activityTextField!=nil) {
        container=[_activityTextField superview];
        fieldFrame=[_activityTextField frame];
    }else {
        container=[_activityTextView superview];
        fieldFrame=[_activityTextView frame];
    }
 
    float h = _boundHeihgt;
    
    UIWindow* window = [AppDelegate sharedAppDelegate].window;
    
    //全部都转到window里去
    CGPoint ptToWindow = [_BaseScrollView convertPoint:_BaseScrollView.frame.origin toView:window];
    
    float off =   ptToWindow.y + fieldFrame.origin.y + fieldFrame.size.height -  (h - kbSize.height);
    
    
    while ([container isEqual:_BaseScrollView] == NO && container !=nil) {
        off = off + container.frame.origin.y;
        container = [container superview];
    }
    
    if (off>0) {
        CGPoint pp=CGPointMake(0, off+_BaseScrollView.contentOffset.y+_moreOffset_y+50);
  
      [_BaseScrollView setContentOffset:pp animated:YES];
    }
    _hadKeyboardShow = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_activityTextField resignFirstResponder];
    [_activityTextView resignFirstResponder];
    //[AppUserSettings SETCURRENTACTIVITYFIELD:nil];
    [self.view endEditing:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //如果不是当前页面
    if (!_hadKeyboardShow) {
        return;
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _BaseScrollView.contentInset = contentInsets;
    _BaseScrollView.scrollIndicatorInsets = contentInsets;
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //    CGRect bkgndRect = _activityTextField.superview.frame;
    CGSize c= _BaseScrollView.contentSize;
    
    NSLog(@"\n\n keyboardWillBeHidden :kbSize height:%f",kbSize.height);
    
    c.height = c.height-_addContentSize.height;
    
    [_BaseScrollView setContentSize:c];
    
    NSLog(@"size after,content height:%f",c.height);
    
    _scrollOffset_y = 0.0f;
    _activityTextField=nil;
    _activityTextView=nil;
    
    _hadKeyboardShow = NO;
}



-(BOOL)textFieldShouldBeginEditing:(IHTextField *)textField{
    
    if ([textField isKindOfClass:[UITextFieldLogin class]]) {
        UITextFieldLogin* text = (UITextFieldLogin *)textField;
        [text refreshTextField:YES];
    }
    
    [AppUserSettings SETCURRENTACTIVITYFIELD:textField];
    _activityTextField=textField;
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isKindOfClass:[UITextFieldLogin class]]) {
        UITextFieldLogin* text = (UITextFieldLogin *)textField;
        [text refreshTextField:NO];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _activityTextView = textView;
    return YES;
}


@end

