//
//  GardenModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenModel.h"
//园榜回复评论
@implementation gardenReplyCommentModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end
//园榜评论
@implementation GardenCommentListModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id",@"createTime":@"createTimeStr"}];
}
@end




//园榜搜索
@implementation gardenSearchModel
@end


@implementation informationsModel

@end

@implementation ActivitiesModel

@end


@implementation menuListModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end

@implementation yuanbangModel

@end

@implementation gardenListsModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end

@implementation biaoqianModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end

@implementation GardenModel

@end
