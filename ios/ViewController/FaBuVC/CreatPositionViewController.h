//
//  CreatPositionViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/13.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "EditInformationDelegate.h"
@interface CreatPositionViewController : SMBaseCustomViewController<EditInformationDelegate>
@property(nonatomic,strong)PositionListModel *model;
@end
