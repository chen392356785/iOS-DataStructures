//
//  AdditionalRequirementViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/9.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface AdditionalRequirementViewController : SMBaseCustomViewController
@property(nonatomic,copy)DidSelectJobAdressBlock selectBlock;
@property(nonatomic,strong)NSString *ZhuanghuoType;
@property(nonatomic,strong)NSString *Luduan;
@property(nonatomic,strong)NSString *DireverNumber;
@property(nonatomic,strong)NSString *PayType;

@end
