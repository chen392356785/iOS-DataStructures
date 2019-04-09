//
//  ClassroomModel.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//


#import "ClassroomModel.h"

//V3.0
@implementation subjectVoLisModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end
@implementation ClassDetailModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"subjectVoLis":@"subjectVoList"}];
}

@end



@implementation MyClassSourceListModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end

@implementation ClassroomModel

@end

@implementation ClassVedioListModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end

@implementation TearchListModel

@end

@implementation studyLableListModel

@end


@implementation configClientItemListModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end

@implementation keywordListModel

@end

@implementation studyBannerListModel
+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"jid":@"id"}];
}
@end
