//
//  NewSlideHeadingViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/6/23.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface NewSlideHeadingViewController : SMBaseViewController

@property(nonatomic,strong)NSMutableArray *ShowPagesClassNameArray;
@property(nonatomic,strong)NSMutableArray *programIdArray;
@property(nonatomic,strong)NSMutableArray *arrayTittles;

- (void)addPortData;

@end
