//
//  FaBuBuyViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/29.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaBuBuyViewController : SMBaseViewController

@property(nonatomic, assign)buyType type;
@property(nonatomic, copy) DidSelectBlock updataTable;

@end

NS_ASSUME_NONNULL_END
