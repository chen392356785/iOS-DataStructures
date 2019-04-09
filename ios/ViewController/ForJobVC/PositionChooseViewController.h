//
//  PositionChooseViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface PositionChooseViewController : SMBaseCustomViewController
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSArray *arr;
@property (nonatomic,assign) int Poptype;
@property(nonatomic,assign)NSInteger index;//点击的按钮
@end
