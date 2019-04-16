//
//  HomePageWeatherViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 11/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "HomePageWeatherViewController.h"
#import "YLWebViewController.h"
#import "CityAdminViewController.h"
//#import "UIImage+Extents.h"

@interface HomePageWeatherViewController ()<UIScrollViewDelegate,SelectedCollectionCellDelegate>
{
    NSMutableArray *dataArr;
    UIButton *_btn;//顶部切换城市
    
    UIAsyncImageView *_backImg;
//    UIImageView *_imageV;
    UIPageControl *_pageControl;
    int currentPage;
}
@end

@implementation HomePageWeatherViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
//    [self setLeftButtonImage:Image(@"weather_back.png") forState:UIControlStateNormal];
//
//    rightbutton.hidden = NO;
//    [self setRightButtonImage:Image(@"weather_refresh.png") forState:UIControlStateNormal];
//
//    UIImageView *barView = self.navigationController.navigationBar.subviews.firstObject;
//    barView = self.navigationController.navigationBar.subviews.firstObject;
//    barView.userInteractionEnabled = YES;
    
//    [barView addSubview:btn];

    
}
//切换天气城市,进入城市管理界面
- (void)switchCityWeather:(UIButton *)button
{
    NSArray *tampArr = _dataDic[@"forecast15"];
    NSDictionary *todayDic = tampArr[1];
    NSDictionary *dayDic;
    if ([IHUtility isWhetherDayOrNightWithNow]) {
        dayDic= todayDic[@"day"];
    }else{
        dayDic= todayDic[@"night"];
    }
    CityAdminViewController *vc = [[CityAdminViewController alloc] init];
    vc.delegate = self;
    vc.bgImgURL = dayDic[@"bgPic"];
    [self presentViewController:vc];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    UIImage *image = [UIImage pureImageFromColor:RGB(247 , 248, 250) withSize:CGSizeMake(_deviceSize.width, 64)];
////    [self imageWithColor:RGB(247 , 248, 250) andSize:CGSizeMake(_deviceSize.width, 64)];
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = nil;
//
//    UIImageView *barView = self.navigationController.navigationBar.subviews.firstObject;
//    [barView removeAllSubviews];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.naviBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    [self configNaviItems];
    
    _BaseScrollView.backgroundColor = [UIColor clearColor];
    _BaseScrollView.delegate = self;
    _BaseScrollView.pagingEnabled = YES;
    _BaseScrollView.showsVerticalScrollIndicator=NO;
    _BaseScrollView.showsHorizontalScrollIndicator=NO;
    _BaseScrollView.frame = CGRectMake(0, KtopHeitht, SCREEN_WIDTH, SCREEN_HEIGHT-KtopHeitht);

    
    dataArr = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //显示背景图片
    UIAsyncImageView *backImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, SCREEN_HEIGHT)];
    _backImg = backImg;
    [self.view insertSubview:backImg belowSubview:_BaseScrollView];
    
    //判断时间是白天还是晚上
    NSArray *tampArr = _dataDic[@"forecast15"];
    NSDictionary *todayDic = tampArr[1];
    NSDictionary *dayDic;
    if ([IHUtility isWhetherDayOrNightWithNow]) {
        dayDic= todayDic[@"day"];
    }else{
        dayDic= todayDic[@"night"];
    }
    
    [_backImg setImageAsyncWithURL:dayDic[@"bgPic"] placeholderImage:Image(@"weather_backImg.png")];
    
    //创建各个城市天气详情
     [self initCitysScrollView];
    
    //当在城市管理界面添加了城市之后 ，就会发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCityWeather:) name:@"AddCityWeather" object:nil];
}

- (void)configNaviItems{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, KStatusBarHeight, 44, 44);
    [leftButton setImage:Image(@"weather_back.png") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(previousController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(SCREEN_WIDTH-44-10, KStatusBarHeight, 44, 44);
    [rightButton setImage:Image(@"weather_refresh.png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(refreshWeatherInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    UIImage *img = Image(@"weather_city");
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, KStatusBarHeight, WindowWith-120, 20)];
    [btn setTitle:_dataDic[@"meta"][@"city"] forState:UIControlStateNormal];
    [btn setImage:Image(@"weather_city") forState:UIControlStateNormal];
    btn.titleLabel.font = boldFont(19);
    _btn = btn;
    
    NSString *city = _dataDic[@"meta"][@"city"];
    CGSize size=[IHUtility GetSizeByText:city sizeOfFont:19 width:WindowWith-120];
    btn.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, -img.size.width, 0, img.size.width+3);
//    btn.centerY = 40;
    btn.centerX = SCREEN_WIDTH/2.0;
    [btn addTarget:self action:@selector(switchCityWeather:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];

}

- (void)previousController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initCitysScrollView
{
    //当刷新界面时  清理原有子试图
    [_BaseScrollView removeAllSubviews];
    [dataArr removeAllObjects];
    if (_pageControl) {
        [_pageControl removeFromSuperview];
    }
    //保存当前定位城市，先判断本地是否保存了定位城市，没有就保存
    NSArray *cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
    NSMutableArray *cityArray = [[NSMutableArray alloc] initWithArray:cityArr];
    
    currentPage = 0;
    if (![cityArray containsObject:_dataDic[@"meta"][@"city"] ]) {
        [cityArray insertObject:_dataDic[@"meta"][@"city"] atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:cityArray forKey:KWeatherCityArrHistory];
    }else{
        //当本地存有定位城市时  直接显示当前城市的天气城市
        currentPage = (int)[cityArray indexOfObject:_dataDic[@"meta"][@"city"]];
    }
    
    //循环创建每个城市的天气详情
    for (int i = 0; i<cityArray.count; i++) {
        
        NSDictionary *dic=[ConfigManager getCityweatherList];
        //拿到本地城市
        NSString * localCityStr = cityArray[i];
        //去掉城市中带"市"的,因为本地weatherCityList.plist文件中存储的所有城市不带"市"
        NSString * cityStr = [localCityStr stringByReplacingOccurrencesOfString:@"市" withString:@""];
        [self getDataWithCityId:dic[cityStr] tag:0];
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kNavigationHeight, 100, 10)];
    pageControl.numberOfPages = cityArray.count;
    pageControl.currentPage = currentPage;
    pageControl.centerX = WindowWith/2.0;
    _pageControl = pageControl;
    pageControl.pageIndicatorTintColor = cGrayLightColor;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
}
- (void)getDataWithCityId:(NSString *)cityID tag:(int)tag{
    
    [network getWeatherDetail:cityID date:@"" success:^(NSDictionary *obj) {
        
		[self->dataArr addObject:obj];
        NSInteger index;
		if ([self->dataArr containsObject:obj]) {
			index = [self->dataArr indexOfObject:obj];
        }else {
            NSArray *Arr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
            index = [Arr indexOfObject:obj[@"meta"][@"city"]];
        }
		[self->dataArr replaceObjectAtIndex:index withObject:obj];
        
        //tag值大于0  是刷新天气
        if (tag > 0) {
			if ([self->_BaseScrollView viewWithTag:tag]) {
				UIScrollView *view = [self->_BaseScrollView viewWithTag:tag];
                [view.mj_header endRefreshing];
                [view removeFromSuperview];
            }
            [self initViewsWithTag:tag];
            
        }else{
            NSArray *cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
			if (self->dataArr.count == cityArr.count&& ![self->dataArr containsObject:@""]) {
				self->_BaseScrollView.contentSize = CGSizeMake(self->dataArr.count *WindowWith, self->_BaseScrollView.height);
				for (int i = 0; i<self->dataArr.count; i++) {
					if ([self->_BaseScrollView viewWithTag:i+10000]) {
						UIScrollView *view = [self->_BaseScrollView viewWithTag:i+10000];
                        [view removeFromSuperview];
                    }
                    [self initViewsWithTag:i+10000];
                }
				self->_BaseScrollView.contentOffset = CGPointMake(WindowWith*self->currentPage, 0);
            }
        }
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)initViewsWithTag:(int)tag
{
    NSDictionary *weatherDic = dataArr[tag-10000];
    NSArray *tampArr = weatherDic[@"forecast15"];
    NSDictionary *todayDic = tampArr[1];
    NSDictionary *dayDic;
    if ([IHUtility isWhetherDayOrNightWithNow]) {
        dayDic= todayDic[@"day"];
    }else{
        dayDic= todayDic[@"night"];
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((tag-10000)*WindowWith, 0, WindowWith, _BaseScrollView.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.tag = tag;
    [_BaseScrollView addSubview:scrollView];
    scrollView.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshWeatherInfo)];
    
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator=NO;

    //更新时间
    SMLabel *timeLbl = [SMLabel new];
    timeLbl.font = sysFont(10);
    timeLbl.textColor = [UIColor whiteColor];
    
    NSDictionary *timeDic = weatherDic[@"meta"];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式
    
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSString *monthStr = [IHUtility FormatMonthAndDayByString2:dateString];
    timeLbl.text = [NSString stringWithFormat:@"%@  %@更新",monthStr,timeDic[@"up_time"]];
    [scrollView addSubview:timeLbl];
    timeLbl.sd_layout.topSpaceToView(scrollView,20).centerXIs(WindowWith/2.0).heightIs(14);
    [timeLbl setSingleLineAutoResizeWithMaxWidth:WindowWith];
    
    //当前温度
    SMLabel *tempLbl = [SMLabel new];
    tempLbl.font = sysFont(116);
    tempLbl.textColor = [UIColor whiteColor];
    tempLbl.text = [NSString stringWithFormat:@"%@",weatherDic[@"observe"][@"temp"]];
    [scrollView addSubview:tempLbl];
 
    tempLbl.sd_layout.centerXIs(WindowWith/2.0).heightIs(95).topSpaceToView(timeLbl,70);
    [tempLbl setSingleLineAutoResizeWithMaxWidth:300];
    
    UIImage *degreeImg = Image(@"weather_degree.png");
    UIImageView *degreeImageV = [UIImageView new];
    degreeImageV.image = degreeImg;
    [scrollView addSubview:degreeImageV];
    degreeImageV.sd_layout.leftSpaceToView(tempLbl,0).topEqualToView(tempLbl).widthIs(degreeImg.size.width).heightIs(degreeImg.size.height);

    //最低温度
    SMLabel *downLbl = [SMLabel new];
    downLbl.font = sysFont(13);
    downLbl.textColor = [UIColor whiteColor];
    downLbl.text = [NSString stringWithFormat:@"%@°",todayDic[@"low"]];
    downLbl.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:downLbl];
    downLbl.sd_layout.leftSpaceToView(tempLbl,8).bottomEqualToView(tempLbl).heightIs(18.5);
    [downLbl setSingleLineAutoResizeWithMaxWidth:150];
    
    UIImage *downImg = Image(@"weather_low.png");
    UIImageView *downImageV = [UIImageView new];
    downImageV.image = downImg;
    [scrollView addSubview:downImageV];
    downImageV.sd_layout.leftSpaceToView(downLbl,2).centerYEqualToView(downLbl).widthIs(downImg.size.width).heightIs(downImg.size.height);
    
    //最高温度
    SMLabel *highLbl = [SMLabel new];
    highLbl.font = sysFont(13);
    highLbl.textColor = [UIColor whiteColor];
    highLbl.text = [NSString stringWithFormat:@"%@°",todayDic[@"high"]];
    highLbl.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:highLbl];
    highLbl.sd_layout.rightEqualToView(downLbl).bottomSpaceToView(downLbl,9.5).heightIs(18.5);
    [highLbl setSingleLineAutoResizeWithMaxWidth:150];
    
    UIImage *highImg = Image(@"weather_high.png");
    UIImageView *highImageV = [UIImageView new];
    highImageV.image = highImg;
    [scrollView addSubview:highImageV];
    highImageV.sd_layout.leftSpaceToView(highLbl,2).centerYEqualToView(highLbl).widthIs(highImg.size.width).heightIs(highImg.size.height);
    
    //获取天气图片
    NSDictionary *weatherImgDic = [ConfigManager getWeatherImage];
    
    UIAsyncImageView *weatherImg = [UIAsyncImageView new];
    
    UIImage *image;
    for (NSString *key in [weatherImgDic allKeys]) {
        if ([dayDic[@"wthr"] rangeOfString:key].location != NSNotFound) {
            NSDictionary *imgDic = [weatherImgDic objectForKey:key];
            if ([IHUtility isWhetherDayOrNightWithNow]) {
                image = Image([imgDic objectForKey:@"smallday"]);
            }else{
                image = Image([imgDic objectForKey:@"smallnight"]);
            }
            weatherImg.image = image;
        }
    }
    [scrollView addSubview:weatherImg];
    weatherImg.sd_layout.leftEqualToView(tempLbl).topSpaceToView(tempLbl,8).heightIs(22).widthIs(22);
    
    SMLabel *weatherlbl = [SMLabel new];
    weatherlbl.textColor = [UIColor whiteColor];
    weatherlbl.text = dayDic[@"wthr"];
    weatherlbl.font = sysFont(16);
    [scrollView addSubview:weatherlbl];
    weatherlbl.sd_layout.leftSpaceToView(weatherImg,3).centerYEqualToView(weatherImg).heightIs(18.5);
    [weatherlbl setSingleLineAutoResizeWithMaxWidth:160];
    
    //气象参数
    UIView *backV = [UIView new];
    backV.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:backV];
    
    backV.sd_layout.leftSpaceToView(scrollView,0).topSpaceToView(weatherImg,35).widthIs(WindowWith);
    
    NSArray *arr = @[@"空气湿度",weatherDic[@"observe"][@"wd"],@"体感温度"];
    
    NSArray *imagArr = @[@"weather_humidity.png",@"weather_windDirection.png",@"weather_bodyTemp.png"];
    NSArray *contentArr = @[weatherDic[@"observe"][@"shidu"],weatherDic[@"observe"][@"wp"],[NSString stringWithFormat:@"%@°",weatherDic[@"observe"][@"tigan"]]];
    for (int i = 0; i<arr.count; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [backV addSubview:view];
        view.sd_layout.leftSpaceToView(backV,(WindowWith -270)
                                       /4.0+(90 + (WindowWith -270)
                                             /4.0)*i).topSpaceToView(backV,0).widthIs(90).autoHeightRatio(0);
        if (i==1) {
            view.sd_layout.centerXIs(WindowWith/2.0);
        }
        
        UIImage *img = Image(imagArr[i]);
        UIImageView *imageV = [UIImageView new];
        imageV.image = img;
        [view addSubview:imageV];
        imageV.sd_layout.leftSpaceToView(view,1).centerYEqualToView(view).widthIs(img.size.width).heightIs(img.size.height);
        
        SMLabel *namelbl = [SMLabel new];
        namelbl.font = sysFont(16);
        namelbl.textColor = [UIColor whiteColor];
        namelbl.text = arr[i];
        namelbl.textAlignment = NSTextAlignmentCenter;
        [view addSubview:namelbl];
        namelbl.sd_layout.leftSpaceToView(imageV,7).topSpaceToView(0,5).heightIs(22);
        [namelbl setSingleLineAutoResizeWithMaxWidth:(WindowWith/3.0 - img.size.width - 10)];
        
        SMLabel *contentlbl = [SMLabel new];
        contentlbl.font = sysFont(16);
        contentlbl.textColor = [UIColor whiteColor];
        contentlbl.text = contentArr[i];
        contentlbl.textAlignment = NSTextAlignmentCenter;
        [view addSubview:contentlbl];
        contentlbl.sd_layout.centerXEqualToView(namelbl).topSpaceToView(namelbl,0).heightIs(22);
        [contentlbl setSingleLineAutoResizeWithMaxWidth:WindowWith /3.0 - img.size.width - 10];
        
        [view setupAutoHeightWithBottomView:contentlbl bottomMargin:5];
        
        [backV setupAutoHeightWithBottomView:view bottomMargin:0];
    }
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = RGBA(203, 203, 203,0.3);
    [scrollView addSubview:lineView1];
    lineView1.sd_layout.leftSpaceToView(scrollView,0).topSpaceToView(backV,10).widthIs(WindowWith).heightIs(0.5);
    
    //天气质量
    UIImage *img = Image(@"weather_quality.png");
    UIImageView *imageV = [UIImageView new];
    imageV.image = img;
    [scrollView addSubview:imageV];
    imageV.sd_layout.leftSpaceToView(scrollView,18).topSpaceToView(lineView1,10.5).widthIs(img.size.width).heightIs(img.size.height);
    
    SMLabel *lbl = [SMLabel new];
    lbl.font = sysFont(16);
    lbl.textColor = [UIColor whiteColor];
    lbl.text = [NSString stringWithFormat:@"%@ %@",weatherDic[@"evn"][@"aqi"],weatherDic[@"evn"][@"quality"]];
    [scrollView addSubview:lbl];
    lbl.sd_layout.leftSpaceToView(imageV,8).centerYEqualToView(imageV).heightIs(22);
    [lbl setSingleLineAutoResizeWithMaxWidth:200];
    
    //污染物
    SMLabel *ContaminantLbl = [SMLabel new];
    
    if ([weatherDic[@"evn"][@"mp"] isEqualToString:@""]) {
        ContaminantLbl.text = [NSString stringWithFormat:@"主要污染物:暂无"];
    }else{
        ContaminantLbl.text = [NSString stringWithFormat:@"主要污染物:%@",weatherDic[@"evn"][@"mp"]];
    }
    
    ContaminantLbl.textColor = [UIColor whiteColor];
    ContaminantLbl.font = sysFont(13);
    [scrollView addSubview:ContaminantLbl];
    ContaminantLbl.sd_layout.centerYEqualToView(imageV).rightSpaceToView(scrollView,15).heightIs(18.5);
    [ContaminantLbl setSingleLineAutoResizeWithMaxWidth:200];
    
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = RGBA(203, 203, 203,0.3);
    [scrollView addSubview:lineView2];
    lineView2.sd_layout.leftSpaceToView(scrollView,0).topSpaceToView(imageV,11).widthIs(WindowWith).heightIs(0.5);
    
    //显示一个星期的天气
    UIScrollView *weatherScroll = [UIScrollView new];
    weatherScroll.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:weatherScroll];
    weatherScroll.sd_layout.leftSpaceToView(scrollView,0).topSpaceToView(lineView2,22).widthIs(WindowWith).heightIs(96);
    
    NSArray *array =  weatherDic[@"forecast"];
    for (int i = 0; i<array.count; i++) {
        WeatherCellView *cellView = [[WeatherCellView alloc] initWithFrame:CGRectMake(WindowWith/6.0*i, 0, WindowWith/6.0, 96)];
        [weatherScroll addSubview:cellView];
        [cellView setData:array[i]];
        
        [weatherScroll setupAutoContentSizeWithBottomView:cellView bottomMargin:0];
    }
    weatherScroll.contentSize = CGSizeMake(WindowWith/6.0*array.count, 96);
    
    UIView *lineView3 = [UIView new];
    lineView3.backgroundColor = RGBA(203, 203, 203,0.3);
    [scrollView addSubview:lineView3];
    lineView3.sd_layout.leftSpaceToView(scrollView,0).topSpaceToView(weatherScroll,35).widthIs(WindowWith).heightIs(0.5);
    
    NSArray *nameArr = @[@"晨练",@"穿衣",@"舒适度",@"感冒",@"紫外线强度",@"旅游",@"洗车",@"晾晒"];
    NSArray *imageArr = @[@"weather_chenlian.png",@"weather_chuanyi.png",@"weather_shushi.png",@"weather_ganmao.png",@"weather_ziwaixian.png",@"weather_lvxing.png",@"weather_xiche.png",@"weather_liangshai.png"];
    //其他指数展示
    UIView *otherView = [UIView new];
    otherView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:otherView];
    otherView.sd_layout.leftSpaceToView(scrollView,0).topSpaceToView(lineView3,0).widthIs(WindowWith).heightIs((nameArr.count +1)/2*62.5);
    
    for (int i=0; i<nameArr.count; i++) {
        NSDictionary *dic = weatherDic[@"indexes"][i];
        WeatherOtherInfoView *infoView = [[WeatherOtherInfoView alloc] initWithFrame:CGRectMake(i%2 * WindowWith/2.0, i/2 * 62.5, WindowWith/2.0, 62)];
        infoView.userInteractionEnabled = YES;
        infoView.tag =  10 + i;
        infoView.backgroundColor = [UIColor clearColor];
        
        [infoView setWeatherData:nameArr[i] content:dic[@"value"] image:Image(imageArr[i])];
        [otherView addSubview:infoView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInfoView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [infoView addGestureRecognizer:tap];
        
        UIView *lineV = [UIView new];
        lineV.backgroundColor = RGBA(203, 203, 203,0.3);
        [otherView addSubview:lineV];
        lineV.sd_layout.leftSpaceToView(otherView,0).topSpaceToView(infoView,0).widthIs(WindowWith).heightIs(0.5);
    }
    
    UIView *lineView4 = [UIView new];
    lineView4.backgroundColor = RGBA(203, 203, 203,0.3);
    [otherView addSubview:lineView4];
    lineView4.sd_layout.leftSpaceToView(otherView,WindowWith/2.0).topSpaceToView(otherView,0).widthIs(0.8).heightIs((nameArr.count +1)/2*62.5);
    
    [scrollView setupAutoContentSizeWithBottomView:otherView bottomMargin:60 + KtopHeitht];
}
- (void)home:(id)sender
{
    //刷新城市天气
    if ([_BaseScrollView viewWithTag:_pageControl.currentPage + 10000]) {
        UIScrollView *view = [_BaseScrollView viewWithTag:_pageControl.currentPage + 10000];
        [view.mj_header beginRefreshing];
    }
}
- (void)refreshCityWeather:(NSNotification *)notification
{
    //删除城市之后会带删除城市的天气数据
    NSDictionary *dic = (NSDictionary *)notification.object;
    if ([_dataDic isEqualToDictionary:dic]) {
        _dataDic = dataArr[0];
    }
    //当添加或者删除了城市，及时刷新添加城市天气详情
    [self initCitysScrollView];
}

-(void)refreshWeatherInfo
{
    NSDictionary *dic=[ConfigManager getCityweatherList];
    //拿到本地城市
    NSDictionary * metaDic = _dataDic[@"meta"];
    //去掉城市中带"市"的,因为本地weatherCityList.plist文件中存储的所有城市不带"市"
    NSString * cityStr = [metaDic[@"city"] stringByReplacingOccurrencesOfString:@"市" withString:@""];
    NSString *cityID = dic[cityStr];
    [self getDataWithCityId:cityID tag:(int)_pageControl.currentPage + 10000];
}
- (void)tapInfoView:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    
    NSDictionary *dic = _dataDic[@"indexes"][view.tag - 10];
    
    if ([[dic allKeys] containsObject:@"link"]) {
        
        YLWebViewController *controller=[[YLWebViewController alloc]init];
        controller.type=1;
        controller.mUrl=[NSURL URLWithString:dic[@"link"]];
        [self pushViewController:controller];
    }else{
        
        BombBoxView *boxView  = [[BombBoxView alloc] initWithFrame:self.view.window.bounds context:dic[@"desc"] title:dic[@"name"]];
        boxView.alpha = 0;
        [self.view.window addSubview:boxView];
        [UIView animateWithDuration:.5 animations:^{
            boxView.alpha = 1;
        }];
    }
}
- (void)disPlayCollectionCellIndex:(int)index cityWeatherDic:(NSDictionary *)cityWeatherDic
{
    _BaseScrollView.contentOffset = CGPointMake(WindowWith*index, 0);
//    _dataDic = dataArr[index];//之前是城市管理页面点击传过来一个index,然后在这个页面的城市天气数组dataArr里取,数组排序不对,会取错
    _dataDic = cityWeatherDic;//现在直接从城市天气管理页面穿过来点击的城市的天气信息cityWeatherDic,作展示
    
    _pageControl.currentPage = index;
    
    NSArray *tampArr = _dataDic[@"forecast15"];
    NSDictionary *todayDic = tampArr[1];
    NSDictionary *dayDic;
    if ([IHUtility isWhetherDayOrNightWithNow]) {
        dayDic= todayDic[@"day"];
    }else{
        dayDic= todayDic[@"night"];
    }
    
    //临时添加imageview 方便实现背景切换
    UIAsyncImageView *backView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, SCREEN_HEIGHT)];
    [backView setImageAsyncWithURL:dayDic[@"bgPic"] placeholderImage:Image(@"weather_backImg.png")];
    backView.alpha = 0;
    [self.view insertSubview:backView belowSubview:_BaseScrollView];
    
    [UIView animateWithDuration:.5 animations:^{
        backView.alpha = 1;
    } completion:^(BOOL finished) {
		[self->_backImg setImageAsyncWithURL:dayDic[@"bgPic"] placeholderImage:Image(@"weather_backImg.png")];
        [backView removeFromSuperview];
    }];
    
    [_btn setTitle:_dataDic[@"meta"][@"city"] forState:UIControlStateNormal];
    
    UIImage *img = Image(@"weather_city");
    NSString *city = _dataDic[@"meta"][@"city"];
    CGSize size=[IHUtility GetSizeByText:city sizeOfFont:19 width:WindowWith-120];
    _btn.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
    _btn.titleEdgeInsets=UIEdgeInsetsMake(0, -img.size.width, 0, img.size.width+3);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    int count = x/WindowWith;
    _dataDic = dataArr[count];
    
    _pageControl.currentPage = count;
    
    NSArray *tampArr = _dataDic[@"forecast15"];
    NSDictionary *todayDic = tampArr[1];
    NSDictionary *dayDic;
    if ([IHUtility isWhetherDayOrNightWithNow]) {
        dayDic= todayDic[@"day"];
    }else{
        dayDic= todayDic[@"night"];
    }
    
    //临时添加imageview 方便实现背景切换
    UIAsyncImageView *backView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, -KtopHeitht, WindowWith, WindowHeight + KtopHeitht)];
    [backView setImageAsyncWithURL:dayDic[@"bgPic"] placeholderImage:Image(@"weather_backImg.png")];
    backView.alpha = 0;
    [self.view insertSubview:backView belowSubview:_BaseScrollView];
    
    [UIView animateWithDuration:.5 animations:^{
        backView.alpha = 1;
    } completion:^(BOOL finished) {
		[self->_backImg setImageAsyncWithURL:dayDic[@"bgPic"] placeholderImage:Image(@"weather_backImg.png")];
        [backView removeFromSuperview];
    }];
    
    [_btn setTitle:_dataDic[@"meta"][@"city"] forState:UIControlStateNormal];
    
    UIImage *img = Image(@"weather_city");
    NSString *city = _dataDic[@"meta"][@"city"];
    CGSize size=[IHUtility GetSizeByText:city sizeOfFont:19 width:WindowWith-120];
    _btn.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
    _btn.titleEdgeInsets=UIEdgeInsetsMake(0, -img.size.width, 0, img.size.width+3);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
