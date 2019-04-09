//
//  MiaoTuMainViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MiaoTuMainViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
//#import <AMapSearchKit/AMapSearchKit.h>
#import "CustomAnnotationView.h"
//#import "CustomCalloutView.h"
#import "MTSearchViewController.h"
#import "CityTableViewController.h"
#import "CityChooseViewController.h"
//#import <MapKit/MKFoundation.h>
#import <MapKit/MKPlacemark.h>
#import <MapKit/MKMapItem.h>
#import "MTOtherInfomationMainViewController.h"
#define  topBarHeigh  35


@interface  CustompointAnnotation: MAPointAnnotation

@property(nonatomic,strong)MTNearUserModel *model;
@end

@implementation CustompointAnnotation

@end

@interface MiaoTuMainViewController ()<UIGestureRecognizerDelegate,MAMapViewDelegate,AMapSearchDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_location;
    CLLocation *_currentLocation;
    CustomAnnotationView *_annotationView;
    MTBaseTableView *commTableView;
    NSInteger _i;
    SMLabel *lbl;
    
    NSInteger _createTime;
    NSString *_companyName;
    NSString *_imageUrl;
    
    UIView *_bgView;
    NSString *_companyAdress;
    tabBarType _type;
    CGPoint _startPoint;
    CGRect oldFrame;
    UIPanGestureRecognizer* panGS;
    int page;
    NSMutableArray *dataArray;
    
    CLLocationCoordinate2D coordinate;
    NSString *urlScheme;
    NSString *appName;
    CGFloat _latitude;
    CGFloat _longitude;
    SMLabel *_lbl;
    SMLabel *_cityLbl;
    UIImageView *_imageView;
    UIView *_view;
    NSString *_userid;
    NSMutableArray *_annotationArray;
    NSArray * _typeId;
    UIButton *_topBtn;
    UIButton *_centerButton;
    NSString *_userId;
}
@end

@implementation MiaoTuMainViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [MobClick beginLogPageView:@"地图模块"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"地图模块"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _i=0;
    page=0;
    _typeId=@[@0,@1,@2,@3,@4,@5];
    _latitude=USERMODEL.latitude;
    _longitude=USERMODEL.longitude;
    
    dataArray=[[NSMutableArray alloc]init];
    _annotationArray=[[NSMutableArray alloc]init];
    
    self.city=@"长沙";
    
    if (USERMODEL.city!=nil) {
        self.city=USERMODEL.city;
    }
    
    UIImage *img=Image(@"mt_changeCity.png");
    
    CGSize size=[IHUtility GetSizeByText:self.city sizeOfFont:16 width:200];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width+img.size.width+20, size.height)];
    [view setLayerMasksCornerRadius:10 BorderWidth:0 borderColor:cBlackColor];
    _view=view;
    _cityLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(5, 0, size.width, size.height) textColor:cBlackColor textFont:sysFont(16)];
    
    _cityLbl.text=self.city;
    if (self.province!=nil) {
        _cityLbl.text=self.province;
    }
    [view addSubview:_cityLbl];
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(size.width+7, 5, img.size.width, img.size.height)];
    _imageView.image=img;
    [view addSubview:_imageView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityPick)];
    [view addGestureRecognizer:tap];
    
    //    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.titleView=view;
    
    img=Image(@"Search Icon.png");
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, 80, img.size.height)];
    control.backgroundColor=[UIColor redColor];
    
    _centerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, WindowWith-view.width-70, 26)];
    _centerButton.layer.cornerRadius=5;
    
    [_centerButton addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
    
    _centerButton.backgroundColor =cLineColor;
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(_centerButton.width/2-40, 5, img.size.width, img.size.height)];
    //  imageView.image=img;
    
    _lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_centerButton.width/2-0.14*WindowWith, 8, 50, 15) textColor:[UIColor whiteColor] textFont:sysFont(16)];
    _lbl.text=@"附近";
    
    [_centerButton addSubview:imageView];
    [_centerButton addSubview:_lbl];
    
    
//    UIBarButtonItem *searchBtn=[[UIBarButtonItem alloc]initWithImage:[Image(@"Search Icon.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(press)];
	
    UIBarButtonItem *adressBtn=[[UIBarButtonItem alloc]initWithImage:[Image(@"mapadress.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(locateAction)];
    self.navigationItem.rightBarButtonItems=@[adressBtn];
    
    
    
    //设置导航条中间的控件为一个按钮
    // self.navigationItem.titleView = _centerButton;
    
    
    [self creatAmap];
    
    [self createTableView];
}

-(void)setCity
{    CGSize size=[IHUtility GetSizeByText:self.city sizeOfFont:16 width:200];
    _cityLbl.text=self.city;
    if (self.province!=nil) {
        _cityLbl.text=self.province;
        size=[IHUtility GetSizeByText:self.province sizeOfFont:16 width:200];
    }
    _cityLbl.frame=CGRectMake(5, 0, size.width, size.height);
    _imageView.origin=CGPointMake(_cityLbl.right+5, 5);
    _view.size=CGSizeMake(_cityLbl.width+_imageView.width+15, _cityLbl.height);
    [_view setLayerMasksCornerRadius:10 BorderWidth:0 borderColor:cBlackColor];
}

-(void)createTableView{
    
    __weak MiaoTuMainViewController *weakSelf=self;
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0,WindowHeight-topBarHeigh, WindowWith, WindowHeight)];
    _bgView.backgroundColor=RGBA(255, 255, 255, 0.8);
    UIImage *img=Image(@"mt_listTop.png");
    img =[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height];
    
    UIImage *selimg=Image(@"expandtitle.png");
    selimg =[selimg stretchableImageWithLeftCapWidth:selimg.size.width/2 topCapHeight:selimg.size.height];
    
    UIButton *topBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame=CGRectMake(0, 0, WindowWith, topBarHeigh);
    [topBtn setBackgroundImage:selimg forState:UIControlStateNormal];
    [topBtn setBackgroundImage:img forState:UIControlStateHighlighted];
    topBtn.titleLabel.font=sysFont(12);
    [topBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topBtn setTitleColor:cGrayLightColor forState:UIControlStateHighlighted];
    _topBtn=topBtn;
    
    [topBtn setTitle:@"正在搜索附近用户" forState:UIControlStateNormal];
    topBtn.titleEdgeInsets=UIEdgeInsetsMake(-5, 0, 0, 0);
    [topBtn addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, topBtn.height-1, WindowWith, 1)];
    lineView.backgroundColor=cLineColor;
    [topBtn addSubview:lineView];
    
    [_bgView addSubview:topBtn];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, topBtn.height, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    
    [self beginRefesh:ENT_RefreshFooter]; //进行下拉刷新
    
    [commTableView setupData:dataArray index:1];
    
    
    commTableView.table.scrollEnabled=NO;
    [_bgView addSubview:commTableView];
    
    panGS = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [commTableView addGestureRecognizer:panGS];
    panGS.delegate = self;
    
    [self.view addSubview:_bgView];
    _type=ENT_down;
    
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    
    if ([self.city isEqualToString:@"全部"]) {
        self.city=@"";
    }
    
    
    NSLog(@"%f----%f",_longitude,_latitude);
    [network getNearUserInfoByUserWithlongitude:[ConfigManager returnDoule:_longitude]
                                       latitude:[ConfigManager returnDoule:_latitude]
                                           page:page
                                            num:25
                                       nickname:@""
                               company_province:[ConfigManager returnString:self.province]
                                   company_city:[ConfigManager returnString:self.city]
                                        user_id:[_userId intValue]
                                        success:^(NSDictionary *obj) {
                                            
                                            
                                            NSArray *arr=obj[@"nearCompanyList"];
                                            
                                            int count=[obj[@"count"] intValue];
                                            
                                            [self->_topBtn setTitle:[NSString stringWithFormat:@"%@ 共有%d个结果",self->_lbl.text,count] forState:UIControlStateNormal];
                                            if (count==0) {
                                                [self->_topBtn setTitle:[NSString stringWithFormat:@"附近没有用户信息"] forState:UIControlStateNormal];
                                            }
                                            
                                            if (arr.count>0) {
                                                self->page++;
                                                if (arr.count<pageNum) {
                                                    [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                                                }
                                            }else{
                                                [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                                                return ;
                                            }
                                            
                                            [self->dataArray addObjectsFromArray:arr];
                                            [self->commTableView.table reloadData];
                                            
                                            for (MTNearUserModel *model in self->dataArray) {
                                                CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake([[NSString stringWithFormat:@"%@",model.addressInfo.latitude] doubleValue],[[NSString stringWithFormat:@"%@",model.addressInfo.longitude] doubleValue]);
                                                
                                                
                                                [self addCustomViewAnnotationView:coordinate model:model];
                                                
                                            }
                                            
                                            [self endRefresh];
                                        } failure:^(NSDictionary *obj2) {
                                            [self endRefresh];
                                        }];
    
}

-(void)topClick:(UIButton *)sender{
    
    UIImage *img=Image(@"mt_listTop.png");
    img =[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height];
    
    UIImage *selimg=Image(@"expandtitle.png");
    selimg =[selimg stretchableImageWithLeftCapWidth:selimg.size.width/2 topCapHeight:selimg.size.height];
    
    if (_type==ENT_down) {
        [UIView animateWithDuration:0.3 animations:^{
            self->_bgView.frame = CGRectMake(0, WindowHeight*0.5, WindowWith , WindowHeight);
            
            [self->_topBtn setBackgroundImage:img forState:UIControlStateNormal];
            [self->_topBtn setBackgroundImage:selimg forState:UIControlStateHighlighted];
            [self->_topBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        }completion:^(BOOL finished) {
            self->_type=ENT_midden;
        }];
    }else if (_type==ENT_midden){
        [UIView animateWithDuration:0.3 animations:^{
            self->_bgView.frame = CGRectMake(0, WindowHeight-topBarHeigh, WindowWith , WindowHeight);
            [self->_topBtn setBackgroundImage:selimg forState:UIControlStateNormal];
            [self->_topBtn setBackgroundImage:img forState:UIControlStateHighlighted];
            [self->_topBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }completion:^(BOOL finished) {
            self->_type=ENT_down;
        }];
    }else if (_type==ENT_top){
        [UIView animateWithDuration:0.3 animations:^{
            self->_bgView.frame = CGRectMake(0, WindowHeight-topBarHeigh, WindowWith , WindowHeight);
            [self->_topBtn setBackgroundImage:selimg forState:UIControlStateNormal];
            [self->_topBtn setBackgroundImage:img forState:UIControlStateHighlighted];
            [self->_topBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }completion:^(BOOL finished) {
            self->_type=ENT_down;
        }];
    }
}

-(void)panGesture:(UITapGestureRecognizer *)pan{
    
    UIImage *img=Image(@"mt_listTop.png");
    img =[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height];
    
    UIImage *selimg=Image(@"expandtitle.png");
    selimg =[selimg stretchableImageWithLeftCapWidth:selimg.size.width/2 topCapHeight:selimg.size.height];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            
            CGPoint currentLoation = [pan locationInView:self.view];
            _startPoint = currentLoation;
            oldFrame = _bgView.frame;
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            CGPoint currentLoation = [pan locationInView:self.view];
            CGRect frame = _bgView.frame;
            frame =  CGRectMake(_bgView.frame.origin.x, _bgView.frame.origin.y + currentLoation.y - _startPoint.y,WindowWith,WindowHeight);
            _bgView.frame = frame;
            
            _startPoint = currentLoation;
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
            CGPoint currentLocation = [pan locationInView:self.view];
            CGRect frame = _bgView.frame;
            frame =  CGRectMake(_bgView.frame.origin.x, _bgView.frame.origin.y + currentLocation.y - _startPoint.y,WindowWith,WindowHeight);
            _bgView.frame = frame;
            
            if (_bgView.frame.origin.y > oldFrame.origin.y && _bgView.frame.origin.y >WindowHeight*0.5) {
                [UIView animateWithDuration:0.3 animations:^{
                    self->_bgView.frame = CGRectMake(0, WindowHeight-topBarHeigh, WindowWith, WindowHeight);
                }completion:^(BOOL finished) {
                    [self->_topBtn setBackgroundImage:selimg forState:UIControlStateNormal];
                    [self->_topBtn setBackgroundImage:img forState:UIControlStateHighlighted];
                    [self->_topBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    self->_type=ENT_down;
                }];
            }
            else if(oldFrame.origin.y >_bgView.frame.origin.y &&oldFrame.origin.y<=WindowHeight*0.5)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    self->_bgView.frame = CGRectMake(0, 0, WindowWith, WindowHeight);
                    
                }completion:^(BOOL finished) {
                    self->_type=ENT_top;
                }];
            }
            else
            {
                [UIView animateWithDuration:0.3 animations:^{
                    self->_bgView.frame = CGRectMake(0, WindowHeight*0.5, WindowWith, WindowHeight);
                }completion:^(BOOL finished) {
                    self->_type=ENT_midden;
                    self->commTableView.table.scrollEnabled = YES;
                }];
            }
            
            if (_bgView.frame.origin.y == 0 ) {
                pan.enabled = NO;
                commTableView.table.scrollEnabled = YES;
            }
            else
            {
                pan.enabled = YES;
            }
            
            
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (_type==ENT_midden) {
        // commTableView.table.scrollEnabled=NO;
    }else if (_type==ENT_down){
        
    }else if (_type==ENT_top){
        //  commTableView.table.scrollEnabled=NO;
    }
    
    //commTableView.table.scrollEnabled = NO;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y < 0) {
        
        _bgView.frame = CGRectMake(0, _bgView.frame.origin.y -  scrollView.contentOffset.y, WindowWith, WindowHeight);
        scrollView.contentOffset = CGPointZero;
        
        
    }
}
//
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ( _bgView.frame.origin.y > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self->_bgView.frame = CGRectMake(0, WindowHeight*0.5, WindowWith, WindowHeight);
        }];
        commTableView.table.scrollEnabled = NO;
        panGS.enabled = YES;
        
        
    }
}

//
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (_bgView.frame.origin.y > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self->_bgView.frame = CGRectMake(0, WindowHeight*0.5, WindowWith, WindowHeight);
        }];
        commTableView.table.scrollEnabled = NO;
        panGS.enabled = YES;
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _mapView.showsUserLocation = NO;
    //_mapView.delegate=nil;
}

-(void)cityPick
{
    
    CityChooseViewController *vc=[[CityChooseViewController alloc]init];
    vc.locationCity=self.city;
    vc.selectAreaBlock=^(NSString *city,NSString *province,CGFloat latitude,CGFloat longtitude){
        
        self.city=city;
        self.province=province;
        self->_userId=@"";
        //        _latitude=latitude;
        //        _longitude=longtitude;
        
        CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake(latitude,longtitude);
        self->_mapView.centerCoordinate=coordinate;
        [self setCity];
        self->page=0;
        [self->dataArray removeAllObjects];
        
        [self->_mapView removeAnnotations:self->_mapView.annotations];
        [self->commTableView.table reloadData];
        [self beginRefesh:ENT_RefreshFooter]; //进行下拉刷新
    };
    [self pushViewController:vc];
}

-(void)press
{
    MTSearchViewController *vc=[[MTSearchViewController alloc]init];
    
    vc.selectCompanyBlock=^(NSArray *typeArray,NSString *userId,CGFloat latitude,CGFloat longtitude,NSString *companyProvince)
    {
        self->_typeId=typeArray;
        self->_userId=userId;
        self.province=companyProvince;
        self.city=nil;
        
        
        CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake(latitude,longtitude);
        self->_mapView.centerCoordinate=coordinate;
        [self setCity];
        self->page=0;
        [self->_mapView removeAnnotations:self->_mapView.annotations];
        [self->dataArray removeAllObjects];
        [self->commTableView.table reloadData];
        [self beginRefesh:ENT_RefreshFooter]; //进行下拉刷新
        
       self->_annotationView=[self->_mapView viewWithTag:[userId integerValue]];
        self->_annotationView.selected=YES;
        
    };
    vc.selectTypeBlock=^(NSArray *typeArray){
        
        self->_lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(5, 3, 60, 20) textColor:[UIColor whiteColor] textFont:sysFont(12)];
        self->_lbl.layer.cornerRadius=5;
        self->_lbl.clipsToBounds=YES;
        self->_userId=@"";
        
        if (typeArray.count>1) {
            self->_lbl.text=@"全部类别";
            self->_lbl.backgroundColor=cBlackColor;
        }else
        {
            if ([typeArray[0] intValue]==1) {
                self->_lbl.text=@"苗木基地";
                self->_lbl.backgroundColor=RGB(0, 202, 171);
                
            }else if ([typeArray[0] intValue]==3){
                self->_lbl.text=@"园林施工";
                self->_lbl.backgroundColor=RGB(53, 181, 222);
                
            }else if ([typeArray[0] intValue]==2){
                self->_lbl.text=@"景观设计";
                self->_lbl.backgroundColor=RGB(255, 92, 82);
                
            }else if ([typeArray[0] intValue]==4){
               self->_lbl.text=@"园林资材";
                self->_lbl.backgroundColor=RGB(246, 155, 0);
                
            }else
            {
                
            }
        }
        
        self->_lbl.textAlignment=NSTextAlignmentCenter;
        
        [self->_centerButton addSubview:self->_lbl];
        self->_typeId=typeArray;
        self->page=0;
        self.company_name=@"";
        [self->dataArray removeAllObjects];
        [self->commTableView.table reloadData];
        [self->_mapView removeAnnotations:self->_mapView.annotations];
        [self beginRefesh:ENT_RefreshFooter]; //进行下拉刷新
    };
    
    [self pushViewController:vc];
}
//实例化地图
-(void)creatAmap
{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    // _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.zoomLevel=11.5;
    _mapView.showsCompass=NO;
    _mapView.showsScale=NO;
    
    MAUserLocationRepresentation *UserLocationRepresentation=[[MAUserLocationRepresentation alloc]init];
    UserLocationRepresentation.showsAccuracyRing=NO;
    
    _mapView.userTrackingMode = 1;
    [self.view addSubview:_mapView];
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate=self;
    
    //回到原来位置
    UIButton *returnLocatonBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img=Image(@"local.png");
    [returnLocatonBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [returnLocatonBtn setImage:[Image(@"local_select.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
    returnLocatonBtn.frame=CGRectMake(WindowWith-img.size.width-20, 20, img.size.width, img.size.height);
    [returnLocatonBtn addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
    // [_mapView addSubview:returnLocatonBtn];
    
}

//用户位置改变时
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    // NSLog(@"userLocation: %@", userLocation.location);
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
    _mapView.userLocation.title = title;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
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
    if (_mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
}

-(void)addCustomViewAnnotationView:(CLLocationCoordinate2D)coordinate model:(MTNearUserModel *)model
{
    CustompointAnnotation *pointAnnotation = [[CustompointAnnotation alloc] init];
    pointAnnotation.coordinate =coordinate;
    pointAnnotation.model=model;
    [_mapView addAnnotation:pointAnnotation];
}

//自定义标注
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(CustompointAnnotation *)annotation
{
    __weak MiaoTuMainViewController *weakSelf=self;
    if ([annotation isKindOfClass:[CustompointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        _annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (_annotationView == nil)
        {
            _annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            [_annotationArray addObject:_annotationView];
        }
        _annotationView.image = Image(@"map_pin copy 2.png");
        UIAsyncImageView *imageview=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(17.5, 17.5, 36, 36)];
        
        [imageview setLayerMasksCornerRadius:(36)/2 BorderWidth:0 borderColor:[UIColor clearColor]];
        // imageview.center=_annotationView.center;
        [imageview setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,annotation.model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
        
        _annotationView.mod=annotation.model;
        
        [_annotationView addSubview:imageview];
        
        //  [_mapView bringSubviewToFront:_annotationView];
        // 设置为NO，用以调用自定义的calloutView
        _annotationView.canShowCallout = NO;
        
        _annotationView.selectBtnBlock=^(CGFloat latitude,CGFloat longtitude,NSString *adress){
            self->coordinate.latitude=latitude;
            self->coordinate.longitude=longtitude;
            [weakSelf testAppleMap];
        };
        
        _annotationView.selectBlock=^(NSInteger index){
            
            [weakSelf headwork:annotation.model];
        };
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        _annotationView.centerOffset = CGPointMake(0, -18);
        _annotationView.adress=annotation.model.address;
        _annotationView.name=annotation.model.nickname;
        _annotationView.tag=[annotation.model.user_id integerValue];
        return _annotationView;
    }
    return nil;
}

-(void)testAppleMap{
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

#pragma mark tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (CustomAnnotationView *obj in _annotationArray) {
        obj.selected=NO;
    }
    
    MTNearUserModel *model=dataArray[indexPath.row];
    CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake([[NSString stringWithFormat:@"%@",model.addressInfo.latitude] doubleValue],[[NSString stringWithFormat:@"%@",model.addressInfo.longitude] doubleValue]);
    _mapView.centerCoordinate=coordinate;
    _annotationView=[_mapView viewWithTag:[model.user_id integerValue]];
    
    _annotationView.selected=YES;
    
    UIImage *img=Image(@"mt_listTop.png");
    img =[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height];
    
    UIImage *selimg=Image(@"expandtitle.png");
    selimg =[selimg stretchableImageWithLeftCapWidth:selimg.size.width/2 topCapHeight:selimg.size.height];
    
    [UIView animateWithDuration:0.3 animations:^{
        self->_bgView.frame = CGRectMake(0, WindowHeight*0.5, WindowWith , WindowHeight);
        
        [self->_topBtn setBackgroundImage:img forState:UIControlStateNormal];
        [self->_topBtn setBackgroundImage:selimg forState:UIControlStateHighlighted];
        [self->_topBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    }completion:^(BOOL finished) {
        self->_type=ENT_midden;
    }];
}

-(void)headwork:(MTNearUserModel *)model
{
    UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:model];
    
    [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[usermodel.user_id intValue]success:^(NSDictionary *obj) {
        
        MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:usermodel.user_id :NO dic:obj[@"content"]];
        controller.userMod=usermodel;
        controller.dic=obj[@"content"];
        [self pushViewController:controller];
    } failure:^(NSDictionary *obj2) {
        
    }];
}


@end
