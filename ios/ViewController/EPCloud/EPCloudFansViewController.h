//
//  EPCloudFansViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface EPCloudFansViewController : SMBaseViewController
@property(nonatomic,strong)NSString *userId;
@property(nonatomic)FansType type;
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
@end
