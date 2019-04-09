//
//  MyMiaoBiModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/15.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyMiaoBiModel.h"


@implementation headModel

@end

@implementation pointsRecordsModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end

@implementation MyMiaoBiModel

@end
