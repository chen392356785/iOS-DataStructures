//
//  FabuBuyModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "FabuBuyModel.h"

@implementation FabuBuyModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
    
}
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"companyname":@"companyName",@"supplyurl":@"supplyUrl"}];
}
@end


@implementation FabuQiuGModel : JSONModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

@end
