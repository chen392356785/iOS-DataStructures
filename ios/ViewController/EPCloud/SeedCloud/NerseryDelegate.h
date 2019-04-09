//
//  NerseryDelegate.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/18.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NerseryDelegate <NSObject>

@optional

-(void)disPalyMyNersery:(NurseryListModel *)model;
-(void)deleteMyNersery;

@end
