//
//  AdressChooseViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/11.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface AdressChooseViewController : SMBaseCustomViewController
@property(nonatomic,strong)NSString *Province;
@property(nonatomic,strong)NSString *City;
@property(nonatomic)ShowUserLocationBlock selectBlock;
@end
