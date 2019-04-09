//
//  ClassSourceListController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/16.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "ClassroomModel.h"

@interface ClassSourceListController : SMBaseViewController

@property (nonatomic, strong) TearchListModel *tearchModel;            //推荐讲师  type 1

@property (nonatomic, strong) studyLableListModel *HomoemoreModel;     //首页更多 type 3

@property (nonatomic, assign) BOOL IsSearchVcJump;      //YES搜索进入
@property (nonatomic, copy) NSString * titleStr;      //标题
@property (nonatomic, strong) NSMutableArray *SearchArr;      //YES搜索进入
@end
