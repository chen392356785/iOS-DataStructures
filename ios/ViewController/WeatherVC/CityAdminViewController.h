//
//  CityAdminViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 23/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol SelectedCollectionCellDelegate <NSObject>

- (void)disPlayCollectionCellIndex:(int)index cityWeatherDic:(NSDictionary *)cityWeatherDic;

@end

@interface CityAdminViewController : SMBaseCustomViewController
@property (nonatomic,copy)NSString *bgImgURL;

@property(nonatomic,strong) id<SelectedCollectionCellDelegate>delegate;
@end
