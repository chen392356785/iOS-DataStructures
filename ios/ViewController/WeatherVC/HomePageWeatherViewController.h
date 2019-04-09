//
//  HomePageWeatherViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 11/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface HomePageWeatherViewController : SMBaseCustomViewController
@property (nonatomic,strong)NSDictionary *dataDic;
@property (nonatomic,copy)NSString *cityId;

- (void)configNaviItems;

@end
