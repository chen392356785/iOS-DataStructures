//
//  CityChooseDelegate.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CityChooseDelegate <NSObject>
-(void)displayCity:(NSString *)ctiy CityType:(CityType)type;
@end
