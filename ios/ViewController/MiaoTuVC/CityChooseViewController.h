//
//  CityChooseViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "CityChooseDelegate.h"
@interface CityChooseViewController : SMBaseViewController<CityChooseDelegate>
@property(nonatomic,strong)NSString *locationCity;//当前城市
@property(nonatomic,strong)DidSelectAreaBlock selectAreaBlock;

@end
