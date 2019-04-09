//
//  WeatherCityViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 25/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "WeatherCityViewController.h"

@interface WeatherCityViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IHTextField *_textFiled;
    NSArray *dataSource;
    NSArray *cityDataArr;
    UITableView *commTableView;
    SMLabel *_lbl;
}
@end

@implementation WeatherCityViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    UIImage *image = [self imageWithColor:RGB(135,206,250) andSize:CGSizeMake(_deviceSize.width, KtopHeitht)];
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
//    [self setLeftButtonImage:Image(@"weather_back.png") forState:UIControlStateNormal];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    UIImage *image = [self imageWithColor:RGB(247 , 248, 250) andSize:CGSizeMake(_deviceSize.width, KtopHeitht)];
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SMLabel *titlelbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, WindowWith-120, 20) textColor:[UIColor whiteColor] textFont:boldFont(19)];
    titlelbl.textAlignment = NSTextAlignmentCenter;
    titlelbl.text = @"选择城市";
    titlelbl.centerX = WindowWith/2.0;
//    self.navigationItem.titleView = titlelbl;
    self.title = @"选择城市";
    
    _BaseScrollView.backgroundColor = [UIColor whiteColor];
    _BaseScrollView.showsVerticalScrollIndicator = NO;
    _BaseScrollView.showsHorizontalScrollIndicator = NO;
    _BaseScrollView.delegate =self;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 45)];
    view.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:view];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTextfiled:)];
    singleTap.numberOfTapsRequired = 1;
    view.userInteractionEnabled = YES;
    [view  addGestureRecognizer:singleTap];
    
    UIImage *img = Image(@"weatherCity_search.png");
    CGSize size = [IHUtility GetSizeByText:@"请输入城市名称" sizeOfFont:14 width:WindowWith];
    IHTextField *textFiled = [[IHTextField alloc] initWithFrame:CGRectMake(0, 0, size.width + img.size.width, 45)];
    textFiled.centerX = WindowWith/2.0;
    textFiled.font = sysFont(14);
    textFiled.delegate = self;
    textFiled.clearButtonMode= UITextFieldViewModeWhileEditing;
    _textFiled= textFiled;
    textFiled.placeholder = @"请输入城市名称";
    [textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [view addSubview:textFiled];
    
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    searchImg.image = img;
    textFiled.leftView =  searchImg;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, WindowWith, 1)];
    lineView.backgroundColor = cLineColor;
    [_BaseScrollView addSubview:lineView];
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(8, lineView.bottom + 30, WindowWith- 16, 18) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text = @"国内热门城市";
    [_BaseScrollView addSubview:lbl];
    
    //从本地获取热门城市
    NSString *path=[[NSBundle mainBundle] pathForResource:@"capital" ofType:@"plist"];
    NSArray *cityArr=[[NSArray alloc] initWithContentsOfFile:path];
    cityDataArr = cityArr;
    
    //热门城市
    UIView *cityView = [[UIView alloc] initWithFrame:CGRectMake(0, lbl.bottom + 8, WindowWith, ((cityArr.count -1)/4 +1)*40)];
    [_BaseScrollView addSubview:cityView];
    
    for (int i=0; i<cityArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%4*WindowWith/4.0, i/4*40, WindowWith/4.0, 40)];
        [btn setTitle:cityArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = sysFont(15);
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        btn.tag = 30 + i;
        [btn addTarget:self action:@selector(selectedCity:) forControlEvents:UIControlEventTouchUpInside];
        [cityView addSubview:btn];
    }
    
    commTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, lineView.bottom, WindowWith,WindowHeight - lineView.bottom) style:UITableViewStylePlain];
    commTableView.dataSource=self;
    commTableView.delegate=self;
    commTableView.backgroundColor = [UIColor whiteColor];
    commTableView.layer.borderColor = RGBA(203, 203, 203,0.6).CGColor;
    commTableView.layer.borderWidth = 1.0;
    commTableView.hidden = YES;
    [_BaseScrollView addSubview:commTableView];
    
    SMLabel *tablelbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, 0, commTableView.width - 20, 40) textColor:cBlackColor textFont:sysFont(14)];
    tablelbl.text = @"无匹配城市";
    _lbl = tablelbl;
    
    _BaseScrollView.contentSize = CGSizeMake(WindowWith, view.bottom + 60);
}
- (void)selectedCity:(UIButton *)button
{
    NSDictionary *dic=[ConfigManager getCityweatherList];
    NSString *cityId = dic[cityDataArr[button.tag-30]];
    [self getDataWithCityId:cityId];
}
- (void)textFieldDidChange:(UITextField *)textFiled
{
    if (textFiled.text.length>0) {
        commTableView.hidden = NO;
        NSDictionary *dic=[ConfigManager getCityweatherList];
        NSArray *allCity = [dic allKeys];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSString *str in allCity) {
            if ([str containsString:textFiled.text]) {
                [array addObject:str];
            }
        }
        dataSource = array;
        if (dataSource.count<=0) {
            
            [commTableView addSubview:_lbl];
        }else{
            [_lbl removeFromSuperview];
        }
        [commTableView reloadData];
    }else{
        commTableView.hidden = YES;
    }
}
- (void)getDataWithCityId:(NSString *)cityID{
    
    [network getWeatherDetail:cityID date:@"" success:^(NSDictionary *obj) {
        NSLog(@"dic=%@",obj);
        //重新保存城市
        NSArray *cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:KWeatherCityArrHistory];
        NSMutableArray *cityArray = [[NSMutableArray alloc] initWithArray:cityArr];
        if (![cityArray containsObject:obj[@"meta"][@"city"] ]) {
            [cityArray addObject:obj[@"meta"][@"city"]];
            [[NSUserDefaults standardUserDefaults] setObject:cityArray forKey:KWeatherCityArrHistory];
            
            [self.Delegate disPlayCityWeatherInfo:obj];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
- (void)tapTextfiled:(UITapGestureRecognizer *)tap
{
    [_textFiled becomeFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.3 animations:^{
		self->_textFiled.left = 10;
		self->_textFiled.width = WindowWith - 20;
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UIImage *img = Image(@"weatherCity_search.png");
    CGSize size = [IHUtility GetSizeByText:@"请输入城市名称" sizeOfFont:14 width:WindowWith];
    _textFiled.width = size.width + img.size.width;
    [UIView animateWithDuration:.3 animations:^{
		self->_textFiled.centerX = WindowWith/2.0;
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identify=@"TableViewCell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    cell.textLabel.font = sysFont(16);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlantCell:)];
    singleTap.numberOfTapsRequired = 1;
    cell.userInteractionEnabled = YES;
    [cell  addGestureRecognizer:singleTap];
    cell.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tapPlantCell:(UITapGestureRecognizer *)tap
{
    UITableViewCell *cell = (UITableViewCell *)tap.view;
    NSString *city = dataSource[cell.tag];
    NSDictionary *dic=[ConfigManager getCityweatherList];
    NSString *cityId = dic[city];
    [self getDataWithCityId:cityId];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_BaseScrollView endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
