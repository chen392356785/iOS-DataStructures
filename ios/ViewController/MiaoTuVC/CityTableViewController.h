//
//  CityTableViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "CityChooseDelegate.h"
@interface CityTableViewController : SMBaseViewController
@property(nonatomic)CityType cityType;
@property(nonatomic,strong)NSString *locationCity; // 定位的城市
@property(nonatomic,strong)NSMutableDictionary *citysDictionary; // 所有城市
@property(nonatomic,strong)NSMutableArray *citysArray;  // 分组城市
@property (nonatomic, strong) NSMutableArray *keysArray; //城市首字母
@property(nonatomic,strong)id<CityChooseDelegate>delegate;
@property(nonatomic,strong)DidSelectAreaBlock selectAreaBlock;
@end
