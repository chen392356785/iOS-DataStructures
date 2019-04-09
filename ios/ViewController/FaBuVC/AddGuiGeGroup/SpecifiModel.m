//
//  SpecifiModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/2.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SpecifiModel.h"

@implementation SpecifiModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"specifications":@"spec",@"speciType":@"type",@"moneyStr":@"price"}];
}
@end
