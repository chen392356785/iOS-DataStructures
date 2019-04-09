//
//  DFDiscernListModel.m
//  DF
//
//  Created by Tata on 2017/12/1.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFDiscernListModel.h"
#import "DFCommentModel.h"

@implementation DFDiscernListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"CommentList" : [DFCommentModel class]
             };
}

@end
