//
//  MyMessageModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/25.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "MyMessageModel.h"

@implementation MessageContentModel

+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}

@end

@implementation MessageTailsModel

@end

@implementation MyMessageModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id",@"pageNumStr":@"pageNum"}];
}
@end
