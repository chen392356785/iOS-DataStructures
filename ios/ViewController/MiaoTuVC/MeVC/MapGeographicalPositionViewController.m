//
//  MapGeographicalPositionViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/29.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MapGeographicalPositionViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
//#import <AMapSearchKit/AMapSearchKit.h>
#import "CustomAnnotationView.h"
//#import "CustomCalloutView.h"
#import "AddressPickView.h"
//#import <CoreLocation/CoreLocation.h>
@interface MapGeographicalPositionViewController()<UIGestureRecognizerDelegate,MAMapViewDelegate,AMapSearchDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_location;
    CLLocation *_currentLocation;
    SMLabel *_adressLbl;
    MAPointAnnotation *_pointAnnotation;
    CLGeocoder *_geocoder;
    SMLabel *_lbl;
    UIImageView *_adressImageView;
    IHTextField *_textField;
    NSString *_city;
    NSString *_province;
    NSString *_town;
    UIView *_view;
    
}
@end
@implementation MapGeographicalPositionViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"地理位置"];
    
    [self creatAmap];
    [self craetBottomView];
}

-(void)craetBottomView
{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0.69*WindowHeight, WindowWith, WindowHeight-0.69*WindowHeight)];
    _view=view;
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    
    CGSize size=[IHUtility GetSizeByText:@"当前地图可拖动，以定位企业的地图位置" sizeOfFont:10 width:300];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, view.top-25, size.width+20, size.height+10) textColor:[UIColor whiteColor] textFont:sysFont(10)];
    lbl.text=@"当前地图可拖动，以定位企业的地图位置";
    lbl.centerX=self.view.centerX;
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.backgroundColor=RGB(190, 190, 190);
    lbl.layer.cornerRadius=10;
    lbl.clipsToBounds=YES;
    [self.view addSubview:lbl];
    
    
    SMLabel *provinceLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, view.height*0.11, 50, 21) textColor:cBlackColor textFont:sysFont(15)];
    provinceLbl.text=@"省市区";
    [view addSubview:provinceLbl];
    
    UIImage *img=Image(@"GQ_Left.png");
    UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
    imageView.frame=CGRectMake(0.9*WindowWith, provinceLbl.top+5, img.size.width, img.size.height);
    [view addSubview:imageView];
    
    _adressLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(provinceLbl.right, imageView.top-5, imageView.left-provinceLbl.right-10, 20) textColor:cGrayLightColor textFont:sysFont(14)];
    _adressLbl.textAlignment=NSTextAlignmentRight;
    _adressLbl.tag=1001;
    _adressLbl.text=@"点击选择城市";
    [view addSubview:_adressLbl];
    _adressLbl.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
    [_adressLbl addGestureRecognizer:tap];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, provinceLbl.bottom+15, WindowWith, 1)];
    lineView.backgroundColor=cLineColor;
    [view addSubview:lineView];
    
    _textField=[[IHTextField alloc]initWithFrame:CGRectMake(0, lineView.bottom, WindowWith, 0.3*view.height)];
    _textField.textAlignment=NSTextAlignmentRight;
    _textField.font=sysFont(13);
    [view addSubview:_textField];
    img=Image(@"GQ_Left.png");
    imageView=[[UIImageView alloc]initWithImage:img];
    imageView.frame=CGRectMake(0.9*WindowWith,lineView.bottom+_textField.height/2-img.size.height/2, img.size.width, img.size.height);
    [view addSubview:imageView];
    _textField.size=CGSizeMake(imageView.left-20, 0.3*view.height);
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _textField.bottom, WindowWith, 1)];
    lineView.backgroundColor=cLineColor;
    [view addSubview:lineView];
    
    UIButton *adressBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *Img=Image(@"iconfont-dingwei.png");
    [adressBtn setImage:[Img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    CGSize adressSize=[IHUtility GetSizeByText:@"当前位置" sizeOfFont:15 width:200];
    [adressBtn setTitle:@"当前位置" forState:UIControlStateNormal];
    [adressBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
    adressBtn.titleLabel.font=sysFont(15);
    adressBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    adressBtn.frame=CGRectMake(provinceLbl.left, lineView.bottom+0.13*view.height, adressSize.width+Img.size.width+20, Img.size.height+16);
    
    if (WindowWith==320) {
        adressBtn.frame=CGRectMake(provinceLbl.left, lineView.bottom+0.1*view.height, adressSize.width+Img.size.width+20, Img.size.height+16);
    }
    // 按钮边框宽度
    adressBtn.layer.borderWidth = 1;
    // 设置圆角
    adressBtn.layer.cornerRadius = 4.5;
    // 设置颜色空间为rgb，用于生成ColorRef
    CGColorSpaceRef backcolorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef backborderColorRef = CGColorCreate(backcolorSpace,(CGFloat[]){ 108/255.0, 123/255.0, 138/255.0, 1 });
    // 设置边框颜色
    adressBtn.layer.borderColor = backborderColorRef;
    adressBtn.layer.cornerRadius=18;
    [adressBtn addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:adressBtn];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(WindowWith-adressBtn.width*1.6-20, adressBtn.top, adressBtn.width*1.6, adressBtn.height);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确  定" forState:UIControlStateNormal];
    btn.backgroundColor=cGreenColor;
    btn.titleLabel.font=sysFont(18);
    btn.layer.cornerRadius=20;
    [view addSubview:btn];
    
    [btn addTarget:self action:@selector(determine) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *adressImg=Image(@"Pin.png");
    _adressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith/2-adressImg.size.width/2+5, _mapView.height/2-adressImg.size.height, adressImg.size.width, adressImg.size.height)];
    _adressImageView.image=adressImg;
    
    //   _adressImageView.hidden=YES;
    [self.view addSubview:_adressImageView];
    
    _lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, _adressImageView.top-30, 0, 0) textColor:cBlackColor textFont:sysFont(13)];
    //_lbl.hidden=YES;
    [self.view addSubview:_lbl];
    
    //监听键盘的升起和隐藏事件,需要用到通知中心 ****IQKeyboard
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//
//    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//    //监听隐藏:UIKeyboardWillHideNotification---
//    [center addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoardWillShow:(NSNotification *)notification
{
    //获取键盘的相关属性(包括键盘位置,高度...)
    NSDictionary *userInfo = notification.userInfo;
    
    //获取键盘的位置和大小
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue /*将对象转换为CGRect结构体*/];
    
    //键盘升起的时候
    
    [UIView animateWithDuration:.3 animations:^{
        self->_adressImageView.hidden=YES;
        self->_lbl.hidden=YES;
        self->_view.origin=CGPointMake(0, 0.69*WindowHeight-rect.size.height);
        
    } completion:nil];
}

- (void)keyBoardWillHide{
    //键盘隐藏的时候
    [UIView animateWithDuration:.3 animations:^{
        self->_adressImageView.hidden=NO;
        self->_lbl.hidden=NO;
        self->_view.origin=CGPointMake(0, 0.69*WindowHeight);
        
    } completion:nil];
    
}

-(void)determine
{
    if (self.type==ENT_FaBu){
        self.selectAdressBlock(_province,_city,_town,_textField.text);
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSString *adress=[NSString stringWithFormat:@"%@%@%@%@",_province,_city,_town,_textField.text];
    
    NSRange range3=[adress rangeOfString:_adressLbl.text];
    
    if (range3.location == NSNotFound)
    {
        
        NSRange range=[adress rangeOfString:@"区"];
        if (range.location==NSNotFound) {
            range=[adress rangeOfString:@"县"];
            if (range.location==NSNotFound) {
                range=[adress rangeOfString:@"市"];
            }
        }
        
        // NSString *sub1=[_lbl.text substringToIndex:range.location+range.length];
//        NSString *sub2=[adress substringFromIndex:range.location+1];
        if (self.type==ENT_RenZheng) {
            NSString *oreillyAddress=adress;
            CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
            [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
                if ([placemarks count] > 0 && error == nil)
                {
                    NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
                    CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                    NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
                    NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
                    
                    self.selectPilotBlock(firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude,adress);
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
            
        }else{
            [self addWaitingView];
            [network updataMap:adress longitude:_mapView.centerCoordinate.longitude latitude:_mapView.centerCoordinate.latitude user_id:[USERMODEL.userID intValue]map_callout:1  province:_province city:_city area:_town  success:^(NSDictionary *obj){
                [self removeWaitingView];
                [self addSucessView:@"标注成功" type:1];
                [IHUtility saveDicUserDefaluts:obj[@"content"] key:kUserDefalutLoginInfo];
                
                NSString *oreillyAddress=adress;
                CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
                [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
                    if ([placemarks count] > 0 && error == nil)
                    {
                        NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
                        CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                        NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
                        NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
                        
                        self.selectPilotBlock(firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude,adress);
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
            } failure:^(NSDictionary *obj2) {
                
            }];
        }
        // [self.delegate displayAdress:sub2 city:_city province:_province town:_town latitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
    }else
    {
        if (self.type==ENT_RenZheng) {
//            NSRange range=[adress rangeOfString:_adressLbl.text];
//            NSString *str=[adress substringFromIndex:range.length+range.location];
            NSString *oreillyAddress=adress;
            CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
            [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
                if ([placemarks count] > 0 && error == nil)
                {
                    NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
                    CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                    NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
                    NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
                    
                    self.selectPilotBlock(firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude,adress);
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
        else{
            NSRange range=[adress rangeOfString:_adressLbl.text];
            NSString *str=[adress substringFromIndex:range.length+range.location];
            
            [self addWaitingView];
            [network updataMap:adress longitude:_mapView.centerCoordinate.longitude latitude:_mapView.centerCoordinate.latitude user_id:[USERMODEL.userID intValue]map_callout:1  province:_province city:_city area:_town  success:^(NSDictionary *obj){
                [self removeWaitingView];
                [self addSucessView:@"标注成功" type:1];
                [IHUtility saveDicUserDefaluts:obj[@"content"] key:kUserDefalutLoginInfo];
                NSString *oreillyAddress=adress;
                CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
                [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
                    if ([placemarks count] > 0 && error == nil)
                    {
                        NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
                        CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                        NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
                        NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
                        
                        self.selectPilotBlock(firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude,adress);
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
            } failure:^(NSDictionary *obj2) {
                
            }];
            [self.delegate displayAdress:str city:_city province:_province town:_town  latitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)headTap:(UITapGestureRecognizer *)tap{
    
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        self->_province=province;
        self->_city=city;
        self->_town=town;
        self->_adressLbl.text = [NSString stringWithFormat:@"%@%@%@",province,city,town] ;
        
        NSString *oreillyAddress=[NSString stringWithFormat:@"%@%@%@",province,city,town];
        CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
        [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] > 0 && error == nil)
            {
                NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
                CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
                NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
                
                self->_mapView.centerCoordinate=firstPlacemark.location.coordinate;
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
    };
    
}
-(CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(void)creatAmap
{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, WindowWith,0.76*WindowHeight+64)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.zoomLevel=16.0;
    _mapView.showsCompass=NO;
    _mapView.showsScale=NO;
    _mapView.userTrackingMode = 1;
    [self.view addSubview:_mapView];
    
    if (![self.latitude isEqualToString:@"0"]&&![self.longitude isEqualToString:@"0"]&&self.latitude&&self.longitude) {
        
        CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake([self.latitude doubleValue],[self.longitude doubleValue]);
        _mapView.centerCoordinate=coordinate;
    }
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate=self;
    
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    
    //[_mapView addAnnotation:_pointAnnotation];
    
}

/**
 *  地图将要发生移动时调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction
{
    //_pointAnnotation.coordinate=_mapView.centerCoordinate;
    //    _adressImageView.hidden=NO;
    //    _lbl.hidden=NO;
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

/**
 *  地图移动结束后调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    
    
    //    _adressImageView.hidden=NO;
    //    _lbl.hidden=NO;
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
/**
 *  地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapGeocodeSearchResponse 。
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    
}
//用户位置改变时
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    _currentLocation = [userLocation.location copy];
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
        
        
        NSMutableString *str=[[NSMutableString alloc]initWithString:response.regeocode.formattedAddress];
        NSRange range=[str rangeOfString:[NSString stringWithFormat:@"%@%@%@",_province,_city,_town]];
        [str deleteCharactersInRange:range];
        _textField.text=str;
    }
}

//点击定位按钮弹出当前位置
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    
    
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        [self reGeoAction];
    }
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:_mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        view.canShowCallout = YES;
        
        if (!CGRectContainsRect(_mapView.frame, frame))
        {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect: _mapView.frame];
            
            CGPoint theCenter = _mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:theCenter toCoordinateFromView:_mapView];
            
            [_mapView setCenterCoordinate:coordinate animated:YES];
        }
    }
}

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

//正向地理编码
- (void)reGeoAction
{
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude
                                                    longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
}

//返回按钮事件
- (void)locateAction
{
    _adressImageView.hidden=YES;
    _lbl.hidden=YES;
    if (_mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        // annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

@end
