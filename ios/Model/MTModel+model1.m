//
//  MTModel+model1.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/26.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTModel+model1.h"

@implementation MTModel (model1)

@end


@implementation jianliModel



@end


@implementation MyQuestionModel
+ (JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"id":@"Id",@"description":@"Description"};
    
//    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:dict];
	 JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithModelToJSONDictionary:dict];
    
    return mapper;
}



@end


@implementation NurseryListModel

@end

@implementation MyNerseryModel


//-(id)initWitListModel:(NurseryListModel *)model{
//    self.unit=model.unit;
//    self.location=model.location;
//     self.create_time=model.create_time;
//     self.loading_price=model.loading_price;
//     self.show_pic=model.show_pic;
//     self.plant_name=model.plant_name;
//     self.num=[model.num integerValue];
//     self.nursery_id=model.nursery_id;
//
//
//    return self;
//}

@end

@implementation NewsSearchModel



@end


@implementation CouponListModel
+ (JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"id":@"Id"};
    
//    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:dict];
	JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithModelToJSONDictionary:dict];

    
    return mapper;
}



@end



@implementation HomePageModel
-(instancetype)initWithIndex:(NSInteger)index
           DataArr:(NSArray *)arr{
    self = [super init];
    if (self) {
        self.rowIndex = index;
        self.hotArray = [arr mutableCopy];
    }
    return self;
}
@end

@implementation HomeInformationModel

@end

@implementation HomeZhanLueQiYeModel

@end

@implementation HomeXinPinzhongeModel

@end

@implementation HomeVarietiesModel

@end

@implementation HomeCompanyModel

@end

@implementation HomeContactsModel


@end
 
@implementation ScoreHistoryModel



@end


@implementation ScoreDetailModel



@end



@implementation FindCarModel
+ (JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"id":@"Id"};
    
//    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:dict];
	
	JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithModelToJSONDictionary:dict];

    
    return mapper;
}



@end
@implementation OwnerFaBuModel



@end

@implementation CheYuanModel

+ (JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"id":@"Id"};
    
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithModelToJSONDictionary:dict];
    
    return mapper;
}


@end

