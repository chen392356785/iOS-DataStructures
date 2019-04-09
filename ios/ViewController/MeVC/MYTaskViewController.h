//
//  MYTaskViewController.h
//  MiaoTuProject
//
//  Created by XBL on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol GrageProtocol <NSObject>

-(void)upDateGrade:(NSString *)str indexPath:(NSIndexPath *)indexPath;

@end

@interface MYTaskViewController : SMBaseCustomViewController

@property (nonatomic,strong)NSString *type;

@property (nonatomic,weak)id<GrageProtocol>delegate;

@property (nonatomic,strong)NSIndexPath *indexPath;
@end
