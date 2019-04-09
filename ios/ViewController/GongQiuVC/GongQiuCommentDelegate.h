//
//  GongQiuCommentDelegate.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/6/21.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GongQiuCommentDelegate <NSObject>
@optional

-(void)disPlayComment:(SDTimeLineCellCommentItemModel *)model indexPath:(NSIndexPath *)indexPath isAdd:(BOOL)isAdd;

@end
