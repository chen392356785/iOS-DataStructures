//
//  GardenDetailController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/3.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "GardenModel.h"


typedef void (^DidSkrBackBut) ();

@interface GardenDetailController : SMBaseViewController

@property (nonatomic, strong) yuanbangModel *model;
@property (nonatomic, copy) NSString *HeadPic;

@property(nonatomic,copy) DidSkrBackBut SkrBlock;

@end
