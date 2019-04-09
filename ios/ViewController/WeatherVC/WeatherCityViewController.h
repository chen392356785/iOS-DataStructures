//
//  WeatherCityViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 25/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol SelectedWeatherCityDelegate <NSObject>

- (void)disPlayCityWeatherInfo:(NSDictionary *)dic;

@end
@interface WeatherCityViewController : SMBaseCustomViewController
@property (nonatomic,strong) id<SelectedWeatherCityDelegate>Delegate;
@end
