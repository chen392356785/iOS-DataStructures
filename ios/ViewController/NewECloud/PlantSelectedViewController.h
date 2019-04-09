//
//  PlantSelectedViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 29/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol PlantSelectedDelegate <NSObject>

- (void)disPlaySelectedSuccess:(NSString *)palntName plant_type:(NSString *)plantType unitArr:(NSArray *)unitArr;

@end

@interface PlantSelectedViewController : SMBaseCustomViewController
@property (nonatomic,strong) NSArray *nameArr;
@property (nonatomic,strong) id<PlantSelectedDelegate>delegate;

@end
