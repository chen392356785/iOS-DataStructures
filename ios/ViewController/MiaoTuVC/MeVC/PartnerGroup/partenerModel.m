//
//  partenerModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/19.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "partenerModel.h"


@implementation userPartner
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end


@implementation partenerModel

@end

@implementation partnerList
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end



