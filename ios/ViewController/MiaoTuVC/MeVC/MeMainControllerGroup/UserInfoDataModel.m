//
//  UserInfoDataModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/12.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "UserInfoDataModel.h"

@implementation itemListModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id",@"numStr":@"num"}];
}
@end

//卡券
@implementation CardListModel

@end

@implementation CardContentModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"codeStr":@"code"}];
}
@end


@implementation pointsAdvListModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end

@implementation pointParamsModel

@end

@implementation allUrlModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"yearurl":@"yearUrl"}];
}
@end

@implementation userInfoModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"messageNum":@"messageCount"}];
}
@end

@implementation UserInfoDataModel

@end
