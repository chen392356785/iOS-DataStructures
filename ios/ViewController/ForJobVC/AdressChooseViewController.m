//
//  AdressChooseViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/11.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "AdressChooseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
//#import <AMapSearchKit/AMapSearchKit.h>
//#import "CustomAnnotationView.h"
//#import "CustomCalloutView.h"
//#import "AddressPickView.h"
//#import <CoreLocation/CoreLocation.h>

@interface AdressChooseViewController ()<UIGestureRecognizerDelegate,MAMapViewDelegate,AMapSearchDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
//    CLLocation *_location;
//    CLLocation *_currentLocation;
    SMLabel *_adressLbl;
    MAPointAnnotation *_pointAnnotation;
//    CLGeocoder *_geocoder;
    SMLabel *_lbl;
    UIImageView *_adressImageView;
    IHTextField *_textField;
    NSString *_city;
    NSString *_province;
    NSString *_town;
    UIView *_view;
    NSInteger i;
}
@end

@implementation AdressChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"工作地点"];
    [self creatAmap];
    [self craetBottomView];
}

-(void)creatAmap
{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, WindowWith,0.76*WindowHeight+64)];
    _mapView.delegate = self;
    // _mapView.showsUserLocation = YES;
    _mapView.zoomLevel=16.0;
    _mapView.showsCompass=NO;
    _mapView.showsScale=NO;
    _mapView.userTrackingMode = 1;
    [self.view addSubview:_mapView];
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate=self;
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    NSString *oreillyAddress=[NSString stringWithFormat:@"%@%@",self.Province,self.City];
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil)
        {
            
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude);
			self->_mapView.centerCoordinate=coordinate;
            
			self->_pointAnnotation.coordinate=self->_mapView.centerCoordinate;
            
//			CLLocation *location=[[CLLocation alloc]initWithLatitude:self->_pointAnnotation.coordinate.latitude longitude:_pointAnnotation.coordinate.longitude];
			
            AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
            // regeoRequest.searchType = AMapSearchType_ReGeocode;
			regeoRequest.location = [AMapGeoPoint locationWithLatitude:self->_pointAnnotation.coordinate.latitude longitude:self->_pointAnnotation.coordinate.longitude];
            regeoRequest.radius = 10000;
            regeoRequest.requireExtension = YES;
            
            //发起逆地理编码
			[self->_search AMapReGoecodeSearch: regeoRequest];

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
    
    UIImage *adressImg=Image(@"Pin.png");
    _adressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith/2-adressImg.size.width/2+5, _mapView.height/2-adressImg.size.height, adressImg.size.width, adressImg.size.height)];
    _adressImageView.image=adressImg;
    
    //   _adressImageView.hidden=YES;
    [self.view addSubview:_adressImageView];
    
    _lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, _adressImageView.top-30, 0, 0) textColor:cBlackColor textFont:sysFont(13)];
    //_lbl.hidden=YES;
    [self.view addSubview:_lbl];
    
    //    if (![self.latitude isEqualToString:@"0"]&&![self.longitude isEqualToString:@"0"]&&self.latitude&&self.longitude) {
    //
    //        CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake([self.latitude doubleValue],[self.longitude doubleValue]);
    //        _mapView.centerCoordinate=coordinate;
    //
    //
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    
    _pointAnnotation.coordinate=_mapView.centerCoordinate;
    
//    CLLocation *location=[[CLLocation alloc]initWithLatitude:_pointAnnotation.coordinate.latitude longitude:_pointAnnotation.coordinate.longitude];
    
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    // regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:_pointAnnotation.coordinate.latitude longitude:_pointAnnotation.coordinate.longitude];
    regeoRequest.radius = 10000;
    regeoRequest.requireExtension = YES;
    
    //发起逆地理编码
    [_search AMapReGoecodeSearch: regeoRequest];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:
(AMapReGeocodeSearchResponse *)response
{
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0)
    {
        title = response.regeocode.addressComponent.province;
    }
    // _mapView.userLocation.title = title;
    // _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        // NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
        
        _pointAnnotation.title=response.regeocode.formattedAddress;
        CGSize size=[IHUtility GetSizeByText:response.regeocode.formattedAddress sizeOfFont:13 width:300];
        _lbl.text=response.regeocode.formattedAddress;
        
        _lbl.size=CGSizeMake(size.width+10, 13+10);
        _lbl.textAlignment=NSTextAlignmentCenter;
        _lbl.centerX=self.view.centerX;
        _lbl.backgroundColor=[UIColor whiteColor];
        
        _adressLbl.text=[NSString stringWithFormat:@"%@%@%@",response.regeocode.addressComponent.province,response.regeocode.addressComponent.city,response.regeocode.addressComponent.district];
        
        _province=response.regeocode.addressComponent.province;
        _city=response.regeocode.addressComponent.city;
        _town=response.regeocode.addressComponent.district;
        
        NSLog(@"----%@--%@",_city,self.City);
        if (![_city isEqualToString:@""]&&![_city isEqualToString:self.City]) {
            
            [IHUtility addSucessView:@"超出选择范围" type:2];
            [UIView animateWithDuration:.3 animations:^{
                
                self->_view.origin=CGPointMake(0, WindowHeight);
                
            } completion:nil];
        }else if([_city isEqualToString:self.City]){
            [UIView animateWithDuration:.3 animations:^{
                
                self->_view.origin=CGPointMake(0, 0.69*WindowHeight);
                
            } completion:nil];
        }else if ([_city isEqualToString:@""]){
            if (![_province isEqualToString:@""]&&![_province isEqualToString:self.Province]) {
                
                if (i==1) {
                    i=1;
                    [IHUtility addSucessView:@"超出选择范围" type:2];
                    [UIView animateWithDuration:.3 animations:^{
                        
                        self->_view.origin=CGPointMake(0, WindowHeight);
                        
                    } completion:nil];
                }
            }else if ([_province isEqualToString:self.Province]){
                _view.origin=CGPointMake(0, 0.69*WindowHeight);
            }
        }
        NSMutableString *str=[[NSMutableString alloc]initWithString:response.regeocode.formattedAddress];
        NSRange range=[str rangeOfString:[NSString stringWithFormat:@"%@%@%@",_province,_city,_town]];
        [str deleteCharactersInRange:range];
        _textField.text=str;
    }
}

-(void)craetBottomView
{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0.69*WindowHeight, WindowWith, WindowHeight-0.69*WindowHeight)];
    _view=view;
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    
    CGSize size=[IHUtility GetSizeByText:@"当前地图可拖动，以定位工作地点" sizeOfFont:10 width:300];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, view.top-25, size.width+20, size.height+10) textColor:[UIColor whiteColor] textFont:sysFont(10)];
    lbl.text=@"当前地图可拖动，以定位工作地点";
    lbl.centerX=self.view.centerX;
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.backgroundColor=RGB(190, 190, 190);
    lbl.layer.cornerRadius=10;
    lbl.clipsToBounds=YES;
    [self.view addSubview:lbl];
    
    _textField=[[IHTextField alloc]initWithFrame:CGRectMake(20, 20, WindowWith-40, 0.3*view.height)];
    // _textField.textAlignment=NSTextAlignmentRight;
    _textField.font=sysFont(13);
    [view addSubview:_textField];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(0, _textField.bottom+20, 150, 39);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.centerX=view.centerX;
    [btn setTitle:@"确  定" forState:UIControlStateNormal];
    btn.backgroundColor=cGreenColor;
    btn.titleLabel.font=sysFont(18);
    btn.layer.cornerRadius=20;
    [view addSubview:btn];
    
    [btn addTarget:self action:@selector(determine) forControlEvents:UIControlEventTouchUpInside];
    
    //监听键盘的升起和隐藏事件,需要用到通知中心 ****IQKeyboard
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//
//    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//    //监听隐藏:UIKeyboardWillHideNotification
//    [center addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)determine{
    
    NSString *oreillyAddress=[NSString stringWithFormat:@"%@%@%@%@",_province,_city,_town,_textField.text];
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil)
        {
            
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            //  CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude);
            self.selectBlock(self->_town,self->_textField.text,firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude);
            [self back:nil];
            
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

//- (void)keyBoardWillShow:(NSNotification *)notification
//{
//    //获取键盘的相关属性(包括键盘位置,高度...)
//    NSDictionary *userInfo = notification.userInfo;
//
//    //获取键盘的位置和大小
//    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue /*将对象转换为CGRect结构体*/];
//
//    //键盘升起的时候
//
//    [UIView animateWithDuration:.3 animations:^{
//        self->_adressImageView.hidden=YES;
//        self->_lbl.hidden=YES;
//        self->_view.origin = CGPointMake(0, 0.69*WindowHeight-rect.size.height);
//
//    } completion:nil];
//}

//- (void)keyBoardWillHide
//{
//    //键盘隐藏的时候
//    [UIView animateWithDuration:.3 animations:^{
//        self->_adressImageView.hidden=NO;
//        self->_lbl.hidden=NO;
//        self->_view.origin=CGPointMake(0, 0.69*WindowHeight);
//
//    } completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
