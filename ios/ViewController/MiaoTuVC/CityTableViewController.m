//
//  CityTableViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CityTableViewController.h"
//#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
//#import <AMapSearchKit/AMapSearchKit.h>
//#import "MiaoTuMainViewController.h"
@interface CityTableViewController ()<UITableViewDelegate,AMapSearchDelegate>
{
    MTBaseTableView *commTableView;
    NSMutableArray *_areaArr;
    NSMutableDictionary *_areaDic;
    NSMutableArray *_dataSource;
    AMapSearchAPI *_search;
//    CLLocation *_location;
//    CLLocation *_currentLocation;
}

@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate=self;
    
    _dataSource=[[NSMutableArray alloc]init];
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
	commTableView.attribute = self;
	commTableView.table.delegate = self;
	commTableView.table.dataSource = (id<UITableViewDataSource>)self;
    
    [self.view addSubview:commTableView];
    
    if (self.cityType == ENT_City) {
        
        NSString *pathString = [[NSBundle mainBundle]pathForResource:@"citydict" ofType:@"plist"];
        
        _citysDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:pathString];
        
        commTableView.table.sectionIndexColor = cBlackColor;
        commTableView.table.sectionIndexBackgroundColor = cLineColor;
        _keysArray = [NSMutableArray array];
        
        [_keysArray addObjectsFromArray:[[_citysDictionary allKeys]sortedArrayUsingSelector:@selector(compare:)]];
        
        NSString *hotKey = @"#";
        [_keysArray insertObject:hotKey atIndex:0];
        // 遍历所有城市的数组
        for (NSString *key in _keysArray) {
            SectionModel *model=[[SectionModel alloc]init];
            model.rows=_citysDictionary[key];
            model.headerTitle=key;
            [_dataSource addObject:model];
            //[_citysArray addObject:city];
          
        }
        
        [commTableView setupData:_dataSource index:11];
        
        // 添加热门城市
        NSArray * hotCityArray = [NSArray arrayWithObjects:@"重庆市",@"北京市",@"天津市",@"上海市",@"长沙市",@"",nil];
        
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 200)];
        topView.backgroundColor=[UIColor whiteColor];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 10, 65, 16) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"定位城市";
        [topView addSubview:lbl];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(lbl.left, lbl.bottom+10, 65, 26);
        [btn setTitle:USERMODEL.city forState:UIControlStateNormal];
        [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(14);
        [btn addTarget:self action:@selector(hotcitychoose:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setLayerMasksCornerRadius:5 BorderWidth:1 borderColor:cGreenColor];
        [topView addSubview:btn];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, btn.bottom+15, WindowWith, 5)];
        lineView.backgroundColor=cLineColor;
        [topView addSubview:lineView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(btn.left, lineView.bottom+15, 65, 16) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"热门城市";
        [topView addSubview:lbl];
        for (NSInteger i=0; i<2; i++) {
            for (NSInteger j=0; j<3; j++) {
                btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(lbl.left+(0.032*WindowWith+0.165*WindowWith)*j, lbl.bottom+10+i*(26+10), 0.165*WindowWith, 26);
                btn.tag=2001+i;
                [btn addTarget:self action:@selector(hotcitychoose:) forControlEvents:UIControlEventTouchUpInside];
                NSInteger k=j+i*3;
                [btn setTitle:hotCityArray[k] forState:UIControlStateNormal];
                [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
                btn.titleLabel.font=sysFont(14);
                [btn setLayerMasksCornerRadius:5 BorderWidth:1 borderColor:cGreenColor];
                [topView addSubview:btn];
                
                if (i==1 &&j==2) {
                    btn.hidden=YES;
                }
            }
        }
        commTableView.table.tableHeaderView=topView;
    }else
    {
        
        NSString *pathString = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
        _areaDic=[NSMutableDictionary dictionaryWithContentsOfFile:pathString];
        
        _areaArr=[[NSMutableArray alloc]init];
        
        [_areaArr addObjectsFromArray:[[_areaDic allKeys]sortedArrayUsingSelector:@selector(compare:)]];
        for (NSString *s in _areaArr) {
            ProvinceModel *model=[[ProvinceModel alloc]init];
            model.province=s;
            [_dataSource addObject:model];
        }
        
        [commTableView setupData:_dataSource index:10];
    }
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)hotcitychoose:(UIButton *)sender
{
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==2001) {
        
    }else if(btn.tag==2002){
        
    }else if (btn.tag==2003){
        
    }else if (btn.tag==2004){
        
    }
    
    CityType type=ENT_City;
    if ([btn.titleLabel.text isEqualToString:@"北京"] ||[btn.titleLabel.text isEqualToString:@"天津"] ||[btn.titleLabel.text isEqualToString:@"上海"] ||[btn.titleLabel.text isEqualToString:@"重庆"] ) {
        type=ENT_Province;
    }
    
    [self.delegate displayCity:btn.titleLabel.text CityType:type];
    [self.inviteParentController back:nil];
    
}

#pragma mark tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cityType==ENT_City) {
        SectionModel *model=_dataSource[indexPath.section];
        if ([model.rows[indexPath.row] isEqualToString:@"北京"] ||[model.rows[indexPath.row] isEqualToString:@"天津"] ||[model.rows[indexPath.row] isEqualToString:@"上海"] ||[model.rows[indexPath.row] isEqualToString:@"重庆"]) {
            [self.delegate displayCity:model.rows[indexPath.row] CityType:ENT_Province];
        }else{
            [self.delegate displayCity:model.rows[indexPath.row] CityType:ENT_City];
        }
    }else
    {ProvinceModel *model=_dataSource[indexPath.row];
        [self.delegate displayCity:model.province CityType:ENT_Province];
    }
    
    [self.inviteParentController back:nil];
}

//正向地理编码
//- (void)reGeoAction
//{
//    if (_currentLocation)
//    {
//        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
//        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude
//                                                    longitude:_currentLocation.coordinate.longitude];
//        [_search AMapReGoecodeSearch:request];
//    }
//}

//段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.cityType==ENT_City)
    {
        if (section==0) {
            return 0;
        }
        return 40;
    }
    return 0;
}

#pragma mark - 外观代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.cityType==ENT_City) {
        SectionModel *model = _dataSource[section];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 40)];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 15, WindowWith, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=model.headerTitle;
        [view addSubview:lbl];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(20, view.height-1, WindowWith-40, 1)];
        lineView.backgroundColor=cLineColor;
        [view addSubview:lineView];
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 7)];
        lineView.backgroundColor=cLineColor;
        [view addSubview:lineView];
        view.backgroundColor=[UIColor whiteColor];
        return view;
    }
    return nil;
}

@end
