//
//  GongQiuAgreeDelegate.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/27.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SDTimeLineCell;
@protocol GongQiuAgreeDelegate <NSObject>
@optional
-(void)disPlayAgree:(MTSupplyAndBuyListModel *)model indexPath:(NSIndexPath *)indexPath;
 
-(void)displayAgree:(MTNewSupplyAndBuyListModel *)model cell:(SDTimeLineCell *)cell isAgree:(BOOL)isAgree;


-(void)GongQiuDeleteTableViewCell:(MTSupplyAndBuyListModel *)model indexPath:(NSIndexPath *)indexPath integer:(NSInteger)integer;//1删除 2编辑

-(void)disPlayActivtCollect:(ActivitiesListModel *)model indexPath:(NSIndexPath *)indexPath;
@end
