//
//  AddresModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/1.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "AddresModel.h"

@implementation AddresModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end
