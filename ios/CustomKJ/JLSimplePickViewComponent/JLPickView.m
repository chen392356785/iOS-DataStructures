//
//  JLPickView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/9.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "JLPickView.h"

@implementation JLPickView

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = cBgColor;
        
        self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
        
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.cancelBtn];
        
        self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 5, 40, 30)];
        
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [self.confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.confirmBtn];
        
        self.lbProCityName = [[UILabel alloc] initWithFrame:CGRectMake(self.cancelBtn.frame.origin.x + self.cancelBtn.frame.size.width, 5, self.confirmBtn.frame.origin.x - self.cancelBtn.frame.size.width - self.cancelBtn.frame.origin.x, 30)];
        
        self.lbProCityName.text = text;
        
        self.lbProCityName.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.lbProCityName];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.lbProCityName.frame.origin.y + self.lbProCityName.frame.size.height, self.frame.size.width, self.frame.size.height - self.lbProCityName.frame.size.height)];
        
        self.pickerView.delegate = self;
        
        self.pickerView.dataSource = self;
        
        [self addSubview:self.pickerView];
        
        [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
        
        
    }
    
    return self;
    
}

#pragma mark - 取消按钮点击事件
-(void)cancelBtnClick{
    
    //self.SelectBlock(nil,nil);
    
    [self disMiss];
    
}

#pragma mark - 确定按钮点击事件
-(void)confirmBtnClick{
    
    if (!self.CityName&&!self.proCityName) {
         NSDictionary *dic=self.citiesArray[0];
        self.CityName=dic.allKeys[0];
        self.proCityName=dic[dic.allKeys[0]][0];
    }
    
    self.SelectBlock(self.CityName,self.proCityName);
    
    [self disMiss];
    
}

#pragma mark - 删除视图
-(void)disMiss{
    
    [self removeFromSuperview];
    
}

#pragma mark -懒加载
//-(NSArray *)citiesArray{
//    if (!_citiesArray) {
//        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"]];
//        NSMutableArray *nmArray = [NSMutableArray arrayWithCapacity:array.count];
//        for (NSDictionary *dic in array) {
//          //  [nmArray addObject:[city citiesWithDic:dic]];
//        }
//        _citiesArray = nmArray;
//    }
//    
//    return _citiesArray;
//}


#pragma mark - 实现 pickerview 协议
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
  
        
    if (component == 0) {
        
        return self.citiesArray.count;
        
    }else{
        
        
        NSInteger seleProIndx = [pickerView selectedRowInComponent:0];
        
        NSDictionary *dic=self.citiesArray[seleProIndx];
        
        
        NSArray *arr=dic[dic.allKeys[0]];
        self.selecletProArr=arr;
        return arr.count;
    }

        
   }

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        
        NSDictionary *dic=self.citiesArray[row];

        
        return dic.allKeys[0];
        
    }else{
        
        return self.selecletProArr[row];
        
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        [pickerView reloadComponent:1];
        
    }
    
    NSInteger selePro = [pickerView selectedRowInComponent:0];
    NSInteger seleCity = [pickerView selectedRowInComponent:1];
    
    NSDictionary *dic = self.citiesArray[selePro];
    
    NSString * city = self.selecletProArr[seleCity];
    
    self.CityName = dic.allKeys[0];
    self.proCityName=city;
    
   // self.lbProCityName.text = self.proCityName;
    
}

@end
