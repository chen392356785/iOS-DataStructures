//
//  MTModel.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTModel.h"

@implementation MTModel

@end

@implementation ProvinceModel



@end


@implementation SectionModel



@end

@implementation MTTopicListModel

//-(id)initWithDic:(NSDictionary *)dic{
//    self = [super init];
//    if (self) {
////        self.company_name=dic[@"company_name"];
////        self.heed_image_url=dic[@"heed_image_url"];
////        self.nickname=dic[@"nickname"];
////        self.sexy=[dic[@"sexy"]intValue];
////        self.topic_content=[dic objectForKey:@"topic_content"];
////        self.topic_id=dic[@"topic_id"];
////        self.topic_url=dic[@"topic_url"];
////        self.i_type_id=[dic[@"i_type_id"]intValue];
//    }
//    return self;
//}

@end

@implementation MTNearUserModel
@end





@implementation MTSupplyListModel

+ (BOOL)propertyIsOptional:(NSString *)assessDate
{
    return YES;
}

@end

@implementation MTBuyListModel
+ (BOOL)propertyIsOptional:(NSString *)assessDate
{
    return YES;
}
@end



@implementation MTPhotosModel

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.imgHeigh=[dic[@"t_height"] floatValue];
        self.imgWidth=[dic[@"t_width"]floatValue];
//        self.imgUrl=  [NSString stringWithFormat:@"%@%@@!body", ConfigManager.ImageUrl, dic[@"t_url"]];
        NSArray *arr =[dic[@"t_url"] componentsSeparatedByString:@"."];
        if (arr.count >= 2) {
            self.thumbUrl=  [NSString stringWithFormat:@"%@%@-w228h_h228.%@", ConfigManager.ImageUrl, arr[0],arr[1]];
        }else {
            self.thumbUrl = [NSString stringWithFormat:@"%@%@", ConfigManager.ImageUrl, dic[@"t_url"]];
        }
        self.imgUrl = [NSString stringWithFormat:@"%@%@", ConfigManager.ImageUrl, dic[@"t_url"]];
    }
    return self;
}

-(id)initWithUrlDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        if ([dic[@"t_url"] hasPrefix:@"http"]) {
            self.imgUrl=[NSString stringWithFormat:@"%@",dic[@"t_url"]];
        }else {
            self.imgUrl=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"t_url"]];
        }
        
    }
    return self;
}


@end

@implementation MTSupplyAndBuyListModel



@end






@implementation UserChildrenInfo

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.company_province=dic[@"addressInfo"][@"company_province"];
         self.company_city=dic[@"addressInfo"][@"company_city"];
        self.company_area=dic[@"addressInfo"][@"company_area"];
         self.company_street=dic[@"addressInfo"][@"company_street"];
        self.nickname=dic[@"nickname"];
        self.sexy=dic[@"sexy"];
        self.user_id=stringFormatString(dic[@"user_id"]);
        self.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]];
        self.i_type_id=dic[@"i_type_id"];
        self.identity_key=dic[@"identity_key"];
        self.company_name=dic[@"company_name"];
         self.hx_user_name=dic[@"hx_user_name"];
        self.user_authentication=dic[@"user_authentication"];
        self.position=dic[@"position"];
        self.province=dic[@"addressInfo"][@"province"];
        self.city=dic[@"addressInfo"][@"city"];
        self.mobile=dic[@"mobile"];
        self.isVip=dic[@"isVip"];
    }
    return self;
}

-(id)initWithModel:(MTNearUserModel *)model
{
    
    self=[super init];
    if (self) {
        self.user_id=stringFormatString(model.user_id);
        self.company_province=model.addressInfo.company_province;
        self.company_city=model.addressInfo.company_city;
        self.company_street=model.addressInfo.company_street;
        self.company_area=model.addressInfo.company_area;
        self.nickname=model.nickname;
        self.sexy = [NSNumber numberWithInteger:model.sexy.integerValue];
        self.heed_image_url = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url];
        self.i_type_id = [NSNumber numberWithInteger:model.i_type_id.integerValue];
        //self.identity_key=model.identity_key;
        self.company_name=model.company_name;
        self.hx_user_name=model.hx_user_name;
        self.mobile=model.mobile;
        self.user_authentication=model.user_authentication;
        self.position=model.position;
        self.landline=model.landline;
        self.business_direction=model.business_direction;
        self.isVip = model.isVip;
    }
    return self;
}


@end






@implementation CommentListModel



@end

@implementation ExperienceinfoModel



@end

@implementation MyCollectionSupplyAndBuyModel
@end

@implementation MyCollectionTopicModel

@end

@implementation MTCommentMeModel


@end

@implementation ChildrenCommentModel

@end

@implementation NewsListModel

- (id)initWithDic:(NSDictionary *)dic
{
    
    self=[super init];
    
    if (self) {
        self.img_type=(int)[dic objectForKey:@"img_type"];
        self.info_content=dic[@"info_content"];
        self.info_from=dic[@"info_from"];
        self.info_id=(int)dic[@"info_id"];
        self.info_title=dic[@"info_title"];
        self.info_url=dic[@"info_url"];
        self.uploadtime=dic[@"uploadtime"];
        self.view_Total=(int)dic[@"view_Total"];
        self.infomation_url=dic[@"infomation_url"];
       
        
    }
    return self;
}

@end

@implementation NewsImageModel


@end



@implementation zcouListModelModel

@end
@implementation KeyListModel

@end

@implementation imageListModel

@end

@implementation TeamListModel

@end


@implementation talkListModel

@end

@implementation ActivitiesListModel


@end



@implementation ThemeListModel



@end


@implementation HomePageTopicModel



@end

@implementation NewDetailModel


@end

@implementation EPCloudListModel



@end





@implementation MTFansModel



@end



@implementation MTConnectionModel



@end

@implementation VoteListModel



@end

@implementation MTCompanyModel



@end








@implementation CompanyTrackModel



@end

@implementation companyListModel



@end

@implementation InvatedFriendslistModel



@end

@implementation BindCompanyModel



@end

@implementation CrowdInfoModel
@end

@implementation CrowdListModel
@end

@implementation CrowdOrderInfoModel
@end

@implementation CrowdOrderModel
@end

@implementation ExperienceNoticeInfoModel
@end

@implementation AuthInfoModel

@end

@implementation JionEPCloudInfoModel

@end

@implementation EPCloudCompanyModel


@end

@implementation AskBarDetailModel



@end

@implementation AnswerInfoModel



@end

@implementation ReplyProblemListModel



@end

@implementation AnswerCommentListModel



@end
