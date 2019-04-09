//
//  MTChooseViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/18.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "EditInformationDelegate.h"
@interface MTChooseViewController : SMBaseCustomViewController
@property(nonatomic,strong)NSString *text;
@property (nonatomic, weak) id<EditInformationDelegate> delegate;
@property(nonatomic)EditBlock type;
@end
