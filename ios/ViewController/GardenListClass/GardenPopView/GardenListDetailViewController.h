//
//  GardenListDetailViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/2.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "GardenModel.h"

@interface GardenListDetailViewController : SMBaseViewController

@property (nonatomic, strong) yuanbangModel *model;
@property(nonatomic,copy) DidSelectBlock updataCellBlock;
@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图
@end
