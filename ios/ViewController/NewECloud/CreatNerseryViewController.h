//
//  CreatNerseryViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"


@interface CreatNerseryViewController : SMBaseCustomViewController
 
@property(nonatomic)BtnType type;
@property (nonatomic,strong) NurseryListModel *listModel;
@property(nonatomic,copy)DidSelectNerseryEditBlock selectEditBlock;
@property (nonatomic,strong) NSArray *paramArr;
@property (nonatomic,copy)NSString *plantStr;
@end
