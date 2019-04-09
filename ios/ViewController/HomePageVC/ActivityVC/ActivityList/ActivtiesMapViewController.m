//
//  ActivtiesMapViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 12/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivtiesMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <MapKit/MKMapItem.h>
#import <MapKit/MapKit.h>
#import "CustomAnnotationView.h"
//#import <MapKit/MKFoundation.h>
//#import <MapKit/MKPlacemark.h>

@interface ActivtiespointAnnotation : MAPointAnnotation

@end

@implementation ActivtiespointAnnotation

@end

@interface ActivtiesMapViewController ()<MAMapViewDelegate>
{
//    CLLocationManager *_locationManager;
    MAMapView *_mapView;
    CustomAnnotationView *_annotationView;
}
@end

@implementation ActivtiesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"地点";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.zoomLevel=11.5;
    _mapView.showsCompass=NO;
    _mapView.showsScale=NO;
    _mapView.userTrackingMode = 1;
    [self.view addSubview:_mapView];
    
    _mapView.mapType=MKMapTypeStandard;
    
    ActivtiespointAnnotation *pointAnnotation = [[ActivtiespointAnnotation alloc] init];
    pointAnnotation.title = self.name;
    pointAnnotation.coordinate = self.coordinate;
    [_mapView addAnnotation:pointAnnotation];
    _mapView.centerCoordinate = self.coordinate;
}
//自定义标注
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(ActivtiespointAnnotation *)annotation
{
    __weak ActivtiesMapViewController *weakSelf=self;
    if ([annotation isKindOfClass:[ActivtiespointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        _annotationView = (CustomAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (_annotationView == nil)
        {
            _annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        _annotationView.image = Image(@"map_pin copy 2.png");
        UIAsyncImageView *imageview=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(17.5, 17.5, 36, 36)];
        
        [imageview setLayerMasksCornerRadius:18 BorderWidth:0 borderColor:[UIColor clearColor]];
        
        [imageview setImageAsyncWithURL:[NSString stringWithFormat:@""] placeholderImage:Image(@"index_activity.png")];
        
        [_annotationView addSubview:imageview];
        
        //  [_mapView bringSubviewToFront:_annotationView];
        // 设置为NO，用以调用自定义的calloutView
        _annotationView.canShowCallout = NO;
        
        _annotationView.selectBtnBlock=^(CGFloat latitude,CGFloat longtitude,NSString *adress){
			self->_coordinate.latitude=latitude;
			self->_coordinate.longitude=longtitude;
            [weakSelf testAppleMap];
        };
        
        _annotationView.selectBlock=^(NSInteger index){
            
        };
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        _annotationView.centerOffset = CGPointMake(0, -18);
        _annotationView.name=self.name;
        
        return _annotationView;
    }
    
    return nil;
}
-(void)testAppleMap{
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_coordinate addressDictionary:nil]];
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
