//
//  MTHomePopModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTHomePopModel.h"

@implementation advButtonModel

+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}

@end

@implementation MTHomePopModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end
