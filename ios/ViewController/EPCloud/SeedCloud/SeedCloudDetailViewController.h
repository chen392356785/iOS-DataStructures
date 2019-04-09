//
//  SeedCloudDetailViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 8/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "NerseryDelegate.h"
@interface SeedCloudDetailViewController : SMBaseCustomViewController<NerseryDelegate>
@property (nonatomic,strong) NurseryListModel *listModel;
@property(nonatomic,weak)id<NerseryDelegate>delegate;
@end
