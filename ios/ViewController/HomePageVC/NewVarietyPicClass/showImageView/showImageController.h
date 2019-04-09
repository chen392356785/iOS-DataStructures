//
//  showImageController.h
//  HZOA
//
//  Created by huizhi01 on 17/1/18.
//  Copyright © 2017年 hz_02. All rights reserved.
//

#import "SMBaseViewController.h"
#import "NewVarietyPicModel.h"


@interface showImageController : SMBaseViewController

@property (nonatomic, strong) NSMutableArray *CompressImage;
@property (nonatomic, strong) NewVarietyPicModel *model;
- (instancetype)initWithSourceArr:(NSMutableArray *)sourceArr index:(NSInteger) index;

@end
