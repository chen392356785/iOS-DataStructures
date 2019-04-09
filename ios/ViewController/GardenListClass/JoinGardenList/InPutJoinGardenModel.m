//
//  InPutJoinGardenModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "InPutJoinGardenModel.h"


@implementation buttonJsonModel

@end


@implementation gardensubListsModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end


@implementation InPutJoinGardenModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end
