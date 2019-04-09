//
//  JobDelegate.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JobDelegate <NSObject>

@optional
-(void)closeOrOpenPosition:(BOOL)close;

-(void)disPlayText:(NSString *)text;

@end
