//
//  CityAdminViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 23/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CityAdminViewController.h"
#import "WeatherCityViewController.h"

@interface CityAdminViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SelectedWeatherCityDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *dataArr;
    
    BOOL isEdit;
}
@end

@implementation CityAdminViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    
//    [self setLeftButtonImage:Image(@"weather_back.png") forState:UIControlStateNormal];
//    
//    UIImageView *barView = self.navigationController.navigationBar.subviews.firstObject;
//    barView = self.navigationController.navigationBar.subviews.firstObject;
//    
//    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, WindowWith-120, 20) textColor:[UIColor whiteColor] textFont:boldFont(19)];
//    lbl.textAlignment = NSTextAlignmentCenter;
//    lbl.text = @"城市管理";
//    lbl.centerY = (barView.height+20)/2.0;
//    lbl.centerX = WindowWith/2.0;
//    [barView addSubview:lbl];
//    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
     self.naviBarHidden = YES;
//    UIImage *image = [self imageWithColor:RGB(247 , 248, 250) andSize:CGSizeMake(_deviceSize.width, 64)];
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = nil;
//    UIImageView *barView = self.navigationController.navigationBar.subviews.firstObject;
//    [barView removeAllSubviews];
}

- (void)configNaviItems{
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, KStatusBarHeight, WindowWith-120, 20) textColor:[UIColor whiteColor] textFont:boldFont(19)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = @"城市管理";
//    lbl.centerY = 44;
    lbl.centerX = SCREEN_WIDTH/2.0;
    [self.view addSubview:lbl];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, KStatusBarHeight, 44, 44);
    [leftButton setImage:Image(@"weather_back.png") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(previousController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-44-10, KStatusBarHeight, 44, 44)];
    [btn setImage:Image(@"weatherCity_edit.png") forState:UIControlStateNormal];
    [btn setImage:Image(@"weatherCity_editSelect.png") forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(editCity:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(SCREEN_WIDTH-44-10-44, KStatusBarHeight, 44, 44);
    [rightButton setImage:Image(@"weather_refresh.png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(refersh:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
}

- (void)previousController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBarHidden = YES;
    [self configNaviItems];
    // Do any additional setup after loading the view.
    
//    UIBarButtonItem *rightButtonItem1 = [[UIBarButtonItem alloc] initWithImage:Image(@"weather_refresh.png") style:UIBarButtonItemStylePlain target:self action:@selector(refersh:)];
//    [rightButtonItem1 setTintColor:[UIColor whiteColor]];
//    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [btn setImage:Image(@"weatherCity_edit.png") forState:UIControlStateNormal];
//    [btn setImage:Image(@"weatherCity_editSelect.png") forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(editCity:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    
//    self.navigationItem.rightBarButtonItems = @[rightButtonItem2,rightButtonItem1];
    
    //获取本地城市列表
    NSArray *cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
    dataArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<cityArr.count; i++) {
        
        //拿到本地城市
        NSString * localCityStr = cityArr[i];
        //去掉城市中带"市"的,因为本地weatherCityList.plist文件中存储的所有城市不带"市"
        NSString * cityStr = [localCityStr stringByReplacingOccurrencesOfString:@"市" withString:@""];
        
        NSDictionary *dic=[ConfigManager getCityweatherList];
        [self getDataWithCityId:dic[cityStr]];
    }
    
    UIAsyncImageView *backImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, SCREEN_HEIGHT)];
    [backImg setImageAsyncWithURL:self.bgImgURL placeholderImage:Image(@"weather_backImg.png")];
    [self.view insertSubview:backImg belowSubview:_BaseScrollView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((WindowWith - 40)/3.0, 152);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10 , 10);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KtopHeitht, WindowWith, SCREEN_HEIGHT-KtopHeitht) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[WeatherCityCollectionView class] forCellWithReuseIdentifier: @"WeatherCityCollectionView"];
    [self.view addSubview:_collectionView];
}
- (void)getDataWithCityId:(NSString *)cityID{
    
    [network getWeatherDetail:cityID date:@"" success:^(NSDictionary *obj) {
        NSLog(@"dic=%@",obj);
        
		[self->dataArr addObject:obj];
        
        NSArray *cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
        
        NSInteger index;
        
		if ([self->dataArr containsObject:obj]) {
			index = [self->dataArr indexOfObject:obj];
        }else {
           index = [cityArr indexOfObject:obj[@"meta"][@"city"]];
        }
		[self->dataArr replaceObjectAtIndex:index withObject:obj];
       
		if (self->dataArr.count == cityArr.count && ![self->dataArr containsObject:@""]) {
			NSMutableArray *MutableArray = [[NSMutableArray alloc] initWithArray:self->dataArr];
            NSArray *array = MutableArray;
            for (NSDictionary *dic in array) {
                NSInteger index = [cityArr indexOfObject:dic[@"meta"][@"city"]];
				[self->dataArr replaceObjectAtIndex:index withObject:dic];
            }
			if (self->dataArr.count<9) {
				if (!self->isEdit) {
					[self->dataArr addObject:@""];
                } 
            }
			[self->_collectionView reloadData];
        }
    } failure:^(NSDictionary *obj2) {
        
    }];
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherCityCollectionView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeatherCityCollectionView" forIndexPath:indexPath];
    cell.delegteBtn.tag = indexPath.row + 30;
    cell.tag = indexPath.row;
    [cell.delegteBtn addTarget:self action:@selector(delegteCity:) forControlEvents:UIControlEventTouchUpInside];
    [cell.addBtn addTarget:self action:@selector(addWeatherCity:) forControlEvents:UIControlEventTouchUpInside];
    if ([dataArr[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = dataArr[indexPath.row];
        [cell setWeatherData:dic];
        cell.addBtn.hidden = YES;
        cell.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [cell addGestureRecognizer:tap];
    }else {
        NSDictionary *dic;
        [cell setWeatherData:dic];
        cell.addBtn.hidden= NO;
    }
    
    if (isEdit) {
        cell.delegteBtn.hidden = NO;
    }else {
        cell.delegteBtn.hidden = YES;
    }
    return cell;
}
//选择城市天气
- (void)cellTapAction:(UITapGestureRecognizer *)tap
{
    WeatherCityCollectionView * cell = (WeatherCityCollectionView *)tap.view;
    NSDictionary *dic = dataArr[cell.tag];
    NSArray *cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
    NSInteger index = [cityArr indexOfObject:dic[@"meta"][@"city"]];
    
    [self.delegate disPlayCollectionCellIndex:(int)index cityWeatherDic:dic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//编辑删除城市天气
- (void)delegteCity:(UIButton *)button
{
    if (button.tag == 30) {
        [self addSucessView:@"定位城市不能删除!" type:2];
        return;
    }
    NSDictionary *cityDic = dataArr[button.tag - 30];
    //重新保存城市
    NSArray *cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
    NSMutableArray *cityArray = [[NSMutableArray alloc] initWithArray:cityArr];
    [cityArray removeObject:cityDic[@"meta"][@"city"]];
    [[NSUserDefaults standardUserDefaults] setObject:cityArray forKey:KWeatherCityArrHistory];
    
    [dataArr removeObjectAtIndex:button.tag-30];
    
    [_collectionView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddCityWeather" object:cityDic];
}
- (void)addWeatherCity:(UIButton *)button
{
    WeatherCityViewController *vc = [[WeatherCityViewController alloc] init];
    vc.Delegate = self;
    [self pushViewController:vc];
}


- (void)refersh:(id)buttonItem
{
    NSArray *cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
    [dataArr removeAllObjects];
    [_collectionView reloadData];
    for (int i = 0; i<cityArr.count; i++) {
        //拿到本地城市
        NSString * localCityStr = cityArr[i];
        //去掉城市中带"市"的,因为本地weatherCityList.plist文件中存储的所有城市不带"市"
        NSString * cityStr = [localCityStr stringByReplacingOccurrencesOfString:@"市" withString:@""];
        NSDictionary *dic=[ConfigManager getCityweatherList];
        [self getDataWithCityId:dic[cityStr]];
    }
}
- (void)editCity:(UIButton *)button
{
    button.selected = !button.selected;
    isEdit = button.selected;
    if (isEdit) {
        if (dataArr.count < 9) {
            [dataArr removeObject:@""];
        }
    }else{
        if (dataArr.count < 9) {
            [dataArr addObject:@""];
        }
    }
    [_collectionView reloadData];
}
//添加城市回调
- (void)disPlayCityWeatherInfo:(NSDictionary *)dic
{
    [dataArr removeObject:@""];
    [dataArr addObject:dic];
    if (dataArr.count < 9) {
        [dataArr addObject:@""];
    }
    [_collectionView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddCityWeather" object:nil];
}
- (void)back:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end
