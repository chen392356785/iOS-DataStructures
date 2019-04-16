//
//  MTNetworkData+extend.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "JSONUtility.h"
#import "NSString+AES.h"
#import "ServerConfig.h"
#import "NSObject+GetIP.h"
#import "MTNetworkData+extend.h"


@implementation MTNetworkData (extend)

//static MTNetworkData *_config;

//供应点赞
-(void)getAddSupplyClickLike:(int)user_id
                   supply_id:(int)supply_id
                        type:(int)type   // 0点赞 1取消点赞
 success:(void (^)(NSDictionary *obj))success {
	
    self.tag = IH_AddSupplyClickLike;
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(supply_id),@"supply_id",
                        stringFormatInt(type),@"type",
                        nil];
    [self httpRequestWithParameter:dic2 method:@"supply/addSupplyClickLike" success:^(NSDictionary *dic) {
        success(dic);
    }];
	
}

//求购点赞
-(void)getAddWantBuyClickLike:(int)user_id
                   want_buy_id:(int)want_buy_id
                         type:(int)type   // 0点赞 1取消点赞
                     success:(void (^)(NSDictionary *obj))success
{
    self.tag=IH_AddSupplyClickLike;
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(want_buy_id),@"want_buy_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"wantBuy/addWantBuyClickLike" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}

//活动点赞
-(void)getAddActivtiesClickLike:(int)user_id
                  activities_id:(int)activities_id
                      success:(void (^)(NSDictionary *obj))success
{
    self.tag=IH_AddSupplyClickLike;
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(activities_id),@"activities_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Activities/addActivitiesClickLike" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
    
    
}


#pragma mark删除 供应评论
-(void)getDeleteSupplyCommentID:(int)commentID
                         userID:(NSString *)userID
                        success:(void (^)(NSDictionary *obj))success{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(commentID),@"supply_comment_id",
                        stringFormatString(userID),@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"supply/deleteSupplyComment" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}

#pragma mark删除 求购评论
-(void)getDeleteBuyCommentID:(int)commentID
                         userID:(NSString *)userID
                        success:(void (^)(NSDictionary *obj))success{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(commentID),@"want_buy_comment_id",
                        stringFormatString(userID),@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"wantBuy/deleteWantBuyComment" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}

#pragma mark删除 话题评论
-(void)getDeleteTopicCommentID:(int)commentID
                        userID:(NSString *)userID
                       success:(void (^)(NSDictionary *obj))success{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(commentID),@"topic_comment_id",
                        stringFormatString(userID),@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Topic/deleteTopicComment" success:^(NSDictionary *dic) {
        success(dic);
    }];
}

#pragma mark删除 活动评论
-(void)getDeleteActivtiesCommentID:(int)commentID
                        userID:(NSString *)userID
                       success:(void (^)(NSDictionary *obj))success{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(commentID),@"activities_comment_id",
                        stringFormatString(userID),@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Activities/deleteActivitiesComment" success:^(NSDictionary *dic) {
        success(dic);
    }];
}
#pragma mark删除资讯评论
-(void)getDeleteNewsCommentID:(int)commentID
                            userID:(NSString *)userID
                           success:(void (^)(NSDictionary *obj))success{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(commentID),@"info_comment_id",
                        stringFormatString(userID),@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Information/deleteInformationComment" success:^(NSDictionary *dic) {
        success(dic);
    }];
}
//行业公司搜索列表
-(void)getSelectUserCompanyNameforTypeId:(NSArray *)i_type_id
                                     num:(int)num
                                    page:(int)page
                                latitude:(CGFloat)latitude
                              longitude:(CGFloat)longitude
                            company_name:(NSString *)company_name
                                 success:(void (^)(NSDictionary *obj))success
                                 failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_SelectUserCompanyName;

    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        i_type_id,@"itype_List",
                        stringFormatDouble(longitude),@"longitude",
                        stringFormatDouble(latitude),@"latitude",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        stringFormatString(company_name),@"company_name",
                        nil];

    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectUserCompanyNameforTypeId" tag:IH_SelectUserCompanyName success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
   
}


//分页查询用户列表,可设置排序类型
-(void)getQueryUserByList:(int)order
                      num:(int)num
                     page:(int)page
                 latitude:(CGFloat)latitude
                longitude:(CGFloat)longitude
                 nickname:(NSString *)nickname
                  version:(NSString *)version
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_QueryUserList;
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(order),@"order",
                        stringFormatDouble(longitude),@"longitude",
                        stringFormatDouble(latitude),@"latitude",
                        stringFormatString(nickname),@"nickname",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        stringFormatString(version),@"version",
                        nil];

    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectUserByList" tag:IH_QueryUserList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

    
    
}
#pragma mark 企业云热门搜索
-(void)getHistoryEPCloudByList:(int)searchType
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(searchType),@"searchType",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"openModel/selectSearchKeyWord" success:^(NSDictionary *dic) {
        success(dic);
    }failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark 查询供求点赞列表
-(void)getQueryClickLikeListType:(int)type
                     business_id:(NSString *)business_id
                             num:(int)num
                            page:(int)page
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(type),@"model",
                        stringFormatString(business_id),@"business_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectClickLikeUserByBusinessId" tag:IH_QueryClickLikeListType success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark 用户签到
-(void)getUserAign:(int)user_id
         sign_date:(NSString *)sign_date
         success:(void (^)(NSDictionary *obj))success
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatString(sign_date),@"sign_date",
                        stringFormatInt(user_id),@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"user/userSign" success:^(NSDictionary *dic) {
        success(dic);
    }];

}

#pragma mark 查看话题评论
-(void)getQueryTopicCommentList:(int)page
                     maxResults:(int)maxResults
                        topicID:(NSString *)topicID
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure{
 
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(page),@"page",
                        stringFormatInt(maxResults),@"num",
                        [NSString stringWithFormat:@"%@",topicID],@"topic_id",
                        @"0",@"topic_comment_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectTopicCommentList" tag:IH_QueryTopicCommentList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}

#pragma mark 话题点赞
-(void)getTopicAddLike:(NSString *)user_id
              topic_id:(NSString *)topic_id
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        user_id,@"user_id",
                        [NSString stringWithFormat:@"%@",topic_id],@"topic_id",
                        nil];
   
    [self httpRequestWithParameter:dic2 method:@"Topic/addTopicClickLike" success:^(NSDictionary *dic) {
        success(dic);
    }failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark 我的收藏列表
-(void)getCollectionTypeList:(int)model // 查询类型 1.供应,2.话题,3.求购,
                     user_id:(NSString *)user_id
                         num:(int)num
                        page:(int)page
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure{
    
    if (model==1 ) {
       self.tag=IH_GetMyCollectionSupplyList;
    }else if (model==3){
        self.tag=IH_GetMyCollectionBuyList;
    }else if (model==2){
        self.tag=IH_GetMyCollectionTopicList;
    }
   
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(model),@"model",
                        stringFormatString(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"publicModel/selectCollectionByUserId" tag:self.tag success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}

#pragma mark 取消收藏

-(void)getUnselCollectionMyType:(int)model// 查询类型 1.供应,2.话题,3.求购,
                        user_id:(NSString *)user_id
                    business_id:(NSString *)business_id
                        success:(void (^)(NSDictionary *obj))success{
 
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(model),@"model",
                        stringFormatString(user_id),@"user_id",
                        stringFormatString(business_id),@"business_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"publicModel/deleteUserCollenction" success:^(NSDictionary *dic) {
        success(dic);
    }];
}


#pragma mark 评论我的
-(void)getCommentMeList:(NSString *)user_id
                    num:(int)num
                   page:(int)page
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
    
                        stringFormatString(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"user/selectUserComments" tag:IH_GetCommentMeList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
    
}



#pragma mark 用户信息更新
-(void)getUserInfoUpdate:(NSDictionary *)UserInfoParams
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_UserInfoUpdate;

    [self httpRequestTagWithParameter:UserInfoParams method:@"user/updateUser" tag:IH_UserInfoUpdate success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}


#pragma mark 地图标注单独接口
-(void)updataMap:(NSString *)address
       longitude:(CGFloat)longitude
        latitude:(CGFloat)latitude
         user_id:(int)user_id
     map_callout:(int)map_callout
        province:(NSString *)province
            city:(NSString *)city
            area:(NSString *)area
         success:(void (^)(NSDictionary *obj))success
         failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatString(address),@"address",
                        stringFormatDouble(longitude),@"longitude",
                        stringFormatDouble(latitude),@"latitude",
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(map_callout),@"map_callout",
                        province,@"province",
                        city,@"city",
                        area,@"area",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"user/updateUser" tag:IH_Map success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

    
    
}


#pragma mark 查看供应详情
-(void)getSupplyDetailID:(NSString *)user_id
               supply_id:(NSString *)supply_id
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure{
   
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        
                        stringFormatString(user_id),@"user_id",
                        stringFormatString(supply_id),@"supply_id",
                    
                        nil];

    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectSupplyforId" tag:IH_GetSupplyDetailID success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark 查看求购详情
-(void)getBuyDetailID:(NSString *)user_id
          want_buy_id:(NSString *)want_buy_id
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatString(user_id),@"user_id",
                        stringFormatString(want_buy_id),@"want_buy_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectWantBuyforId" tag:IH_GetBuyDetailID success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark 查看话题详情
-(void)getTopicDetailID:(NSString *)user_id
               topic_id:(NSString *)topic_id
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatString(user_id),@"user_id",
                        stringFormatString(topic_id),@"topic_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectTopicforId" tag:IH_GetTopicDetailID success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
    
}


#pragma mark 根据id查询用户信息
-(void)selectUseerInfoForId:(NSInteger)user_id
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_SelectUserInfoForId;
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectUserInfoForId" tag:IH_SelectUserInfoForId success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

    
    
    
    
}



#pragma mark 查询用户查看列表
-(void)getSelectViewsList:(int)user_id
                     page:(int)page
                      num:(int)num
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_SelectViewsList;
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"user/selectViewsList" tag:IH_SelectViewsList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}
-(void)getWXlogin:(NSString *)wx_key  // 微信key
         nickname:(NSString *)nickname
   heed_image_url:(NSString *)heed_image_url
          success:(void (^)(NSDictionary *obj))success
          failure:(void (^)(NSDictionary *obj2))failure{
    self.tag=IH_WXlogin;
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        wx_key,@"wx_key",
                        nickname,@"nickname",
                        heed_image_url,@"heed_image_url",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"registerAndLogin/wxlogin" tag:IH_SelectUserInfoForId success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}


#pragma mark 活动顶部图片列表

-(void)getActivityList:(int)page
                   num:(int)num
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure{
    
    self.tag = IH_ActivityList;
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"Activities/selectActivitiesList" tag:IH_ActivityList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
    
}
#pragma mark 活动列表
-(void)getAllActivityList:(NSDictionary *)dic2
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_AllActivityList;
    
    [self httpRequestTagWithParameter:dic2 method:@"Activities/selectActivitiesDetailedList" tag:IH_AllActivityList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark 我的活动列表
-(void)getUserActivityList:(int)user_id
                      page:(int)page
                     model:(int)model
                   num:(int)num
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure{
    
    self.tag=IH_UserActivityList;
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        stringFormatInt(model),@"model",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"Activities/selecOrderActivitiesforUserId" tag:IH_UserActivityList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
}

#pragma mark 活动详情
- (void)getActivitiesDetail:(NSString *)activities_id
                       type:(NSString *)type
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_UserActivityDetail;
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        type,@"model",
                        activities_id,@"activities_id",
                        USERMODEL.userID,@"user_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"Activities/selectActivities" tag:IH_UserActivityDetail success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark - 是否众筹过
- (void)getWhetherCrowdWithUserID:(NSString *)user_id
                    activities_id:(NSString *)activities_id
                          success:(void (^)(NSDictionary *obj))success
{
	NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
						  user_id,@"user_id",
						  activities_id,@"activities_id",
						  nil];
	[self httpRequestWithParameter:dic2 method:@"CrowdActivity/checkCrowdOrder" success:^(NSDictionary *dic) {
		success(dic);
	}];
    
}

#pragma mark 资讯详情
- (void)getNewsDetail:(NSString *)info_id
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_UserNewsDetail;
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        
                        info_id,@"info_id",
                        USERMODEL.userID,@"user_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectInformationDetailedByInfoId" tag:IH_UserNewsDetail success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
}
#pragma mark 广告资讯详情
- (void)getPushNewsDetail:(NSString *)info_id
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_NewsDetail;
    NSString *str;
    if (!USERMODEL.isLogin) {
        str = @"0";
    }else {
        str = USERMODEL.userID;
    }
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        info_id,@"info_id",
                        str,@"user_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectInfoDetailByInfoId" tag:IH_NewsDetail success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
}
#pragma mark 图集资讯详情
- (void)getImageNewsDetail:(NSString *)info_id
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_UserImageNewsDetail;
    
    NSString *str;
    if (!USERMODEL.isLogin) {
        str = @"0";
    }else {
        str = USERMODEL.userID;
    }
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        info_id,@"info_id",
                        str,@"user_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectInfoImagesCollectListById" tag:IH_UserImageNewsDetail success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
}

#pragma mark 取消活动
- (void)cancleActivtiesOrder:(NSString *)orderID
                     success:(void (^)(NSDictionary *obj))success{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        orderID,@"a_order_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Activities/orderStatusCancel" success:^(NSDictionary *dic) {
        success(dic);
    }];

    
}

#pragma mark 收藏活动
- (void)collectActivties:(NSString *)activID
                     success:(void (^)(NSDictionary *obj))success{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        activID,@"activities_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Activities/addActivitiesCollection" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}

#pragma mark 收藏资讯
- (void)collectNews:(NSString *)infoID
                 success:(void (^)(NSDictionary *obj))success{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        infoID,@"info_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Information/addInformationCollection" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}
#pragma mark 活动查看次数
- (void)lookNumActivties:(NSString *)activID
                 success:(void (^)(NSDictionary *obj))success{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        activID,@"activities_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Activities/updateLookersUser" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}
-(void)findPassword:(NSString *)user_name
           password:(NSString *)password
               code:(NSString *)code
  success:(void (^)(NSDictionary *obj))success
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatString(user_name),@"user_name",
                        [IHUtility MD5Encode:[IHUtility MD5Encode:password]],@"password",
                        stringFormatString(code),@"code",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"registerAndLogin/resetPassword" success:^(NSDictionary *dic) {
        success(dic);
    }];

}

#pragma mark 查看其他用户
-(void)getuserView:(int)user_id
      view_user_id:(int)view_user_id
success:(void (^)(NSDictionary *obj))success
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(view_user_id),@"view_user_id",
                        nil];
    [self httpRequestWithParameter:dic2 method:@"openModel/viewUser" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}




#pragma mark 绑定用户联系方式
-(void)getUserPhoneNumber:(int)user_id
                     code:(NSString *)code
                    phone:(NSString *)phone
success:(void (^)(NSDictionary *obj))success
{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatString(code),@"code",
                        stringFormatString(phone),@"phone",
                        nil];
    [self httpRequestWithParameter:dic2 method:@"user/bandPhone" success:^(NSDictionary *dic) {
        success(dic);
    }];
}

#pragma mark 老用户绑定手机号
-(void) OldGetUserPhoneNumber:(int)user_id
                        code:(NSString *)code
                       phone:(NSString *)phone
                     success:(void (^)(NSDictionary *obj))success
{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatString(code),@"code",
                        stringFormatString(phone),@"phone",
                        nil];
    [self httpRequestWithParameter:dic2 method:@"user/bandPhone2" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}

#pragma mark 新用户注册绑定用户手机
- (void)NewGetUserPhoneNumber:(NSString *)WXKey
                     code:(NSString *)code
                    phone:(NSString *)phone
                       WXName:(NSString*)nickname
                       WXIcon:(NSString*)heed_image_url
                  success:(void (^)(NSDictionary *obj))success
{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                         WXKey,@"wx_key",
                        stringFormatString(code),@"code",
                        nickname,@"nickname",
                        heed_image_url,@"heed_image_url",
                        stringFormatString(phone),@"mobile",
                        nil];
    [self httpRequestWithParameter:dic2 method:registAndLoingUrl success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}


#pragma mark 意见反馈
-(void)getUserFeedBack:(int)user_id
     feed_back_content:(NSString *)feed_back_content
                 phone:(NSString *)phone
success:(void (^)(NSDictionary *obj))success
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatString(feed_back_content),@"feed_back_content",
                        stringFormatString(phone),@"phone",
                        nil];
    [self httpRequestWithParameter:dic2 method:@"user/addFeedBack" success:^(NSDictionary *dic) {
        success(dic);
    }];

}


#pragma mark通过环信id查用户信息
-(void)getUserInfoByHxName:(NSString *)hx_name
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatString(hx_name),@"hx_user_name",
                        nil];
    [self httpRequestWithParameter:dic2 method:@"openModel/selectUserInfoByHxName" success:^(NSDictionary *dic) {
        success(dic);
    }];

    
}


#pragma mark 举报接口
-(void)getAddReport:(NSString *)user_id
     report_content:(NSString *)report_content
        report_type:(NSString *)report_type
        business_id:(NSString *)business_id
            success:(void (^)(NSDictionary *obj))success
            failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatString(user_id),@"user_id",
                        report_content,@"report_content",
                        stringFormatString(report_type),@"report_type",
                        stringFormatString(business_id),@"business_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"Activities/selectActivitiesList" tag:IH_AddReport success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
}

#pragma mark 行业资讯列表
- (void)getNewsList:(int)page
                num:(int)num
         program_id:(int)program_id
            user_id:(int)user_id
            success:(void (^)(NSDictionary *))success
            failure:(void (^)(NSDictionary *))failure
{
    self.tag=IH_NewsList;
    if (program_id == 18) {
        self.tag = IH_GetThemeList;
    }
    if (program_id == 19) {
        self.tag = IH_AllActivityList;
    }
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        stringFormatInt(program_id),@"program_id",
                        stringFormatInt(user_id),@"user_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"Information/selectInfomationList" tag:self.tag success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}


#pragma mark 根据用户id查询用户任务信息
- (void)selectUserTaskInfoForId:(int)user_id
                        success:(void (^)(NSDictionary *))success
                        failure:(void (^)(NSDictionary *))failure
{
 
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        
                        nil];
   
    [self httpRequestWithParameter:dic2 method:@"openModel/selectUserTaskById" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic2) {
        failure(dic2);
    }];
   
}

#pragma mark 主题列表
- (void)getThemeList:(int)page
                num:(int)num
            success:(void (^)(NSDictionary *))success
             failure:(void (^)(NSDictionary *))failure{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    self.ntpage=page;
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectThemeList" tag:IH_GetThemeList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}
#pragma mark 邀请好友统计
-(void)getInviteFriendfoForId:(int)user_id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"publicModel/inviteFriendTask" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic2) {
        failure(dic2);
    }];
    
}
#pragma mark 本周任务统计
-(void)getWeekTaskInfofoForId:(int)user_id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
 
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"openModel/callUserWeekTask" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic3) {
        failure(dic3);
    }];
}


#pragma mark绑定百度推送
-(void)GetBindBaiduPush:(NSString *)UserID
             channel_id:(NSString *)channel_id
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure{
    NSDictionary *dic2;
    
    if (UserID ==nil || UserID.length==0) {
        dic2=[NSDictionary dictionaryWithObjectsAndKeys:
              stringFormatString(channel_id),@"channel_id",
              @"4",@"deviceType",
              nil];
    }else{
        dic2=[NSDictionary dictionaryWithObjectsAndKeys:
              stringFormatString(UserID),@"user_id",
              stringFormatString(channel_id),@"channel_id",
              @"4",@"deviceType",
              nil];
    }
    
    [self httpRequestTagWithParameter:dic2 method:@"user/addBandBaiduChannelId" tag:IH_addBandBaiduChannelId success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
}


-(void)getThemeAndInformationListSuccess:(void (^)(NSDictionary *obj))success
                                 failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2;
  
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectThemeAndInformationList" tag:IH_ThemeAndNewsList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}


-(void)getTopicforId:(int)user_id
            topic_id:(int)topic_id
             success:(void (^)(NSDictionary *obj))success
             failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                         stringFormatInt(topic_id),@"topic_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectTopicforId" tag:IH_TopicForId success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

}

-(void)updateTopicLookersUser:(int)topic_id
success:(void (^)(NSDictionary *obj))success
{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(topic_id),@"topic_id",
                       
                        nil];
    [self httpRequestWithParameter:dic2 method:@"openModel/updateTopicLookersUser" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
   
    
}


-(void)selectIdentikeyForUserID:(int)user_id
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        nil];
   
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectIdentikeyForUserID" tag:IH_IdentForId success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
}

#pragma mark 企业云列表
- (void)getEPCloudListWithProvice:(NSString *)provice
                             City:(NSString *)city
                             Area:(NSString *)area
                     company_name:(NSString *)company_name
                        design_lv:(NSString *)design_lv
                       project_lv:(NSString *)project_lv
                 company_label_id:(NSString *)company_label_id
                           TypeID:(int)typeID
                            Level:(int)level
                             page:(int)page
                              num:(int)num
                       staff_size:(NSString *)staff_size
                          success:(void (^)(NSDictionary *obj))success
                          failure:(void (^)(NSDictionary *obj2))failure
{
    
    self.tag=IH_EPCloudList;
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                        provice,@"provice",
                        city,@"city",
                        area,@"area",
                        company_name,@"company_name",
                        design_lv,@"design_lv",
                        project_lv,@"project_lv",
                        stringFormatInt(typeID),@"i_type_id",
                        stringFormatInt(level),@"level",
                        staff_size,@"staff_size",
                        stringFormatInt(page),@"page",
                        company_label_id,@"company_label_id",
                        stringFormatInt(num),@"num",nil];
    
	[self httpRequestTagWithParameter:dic2 method:@"Company/selectCompanyInfoList" tag:IH_EPCloudList success:^(NSDictionary * dic) {
		success(dic);
	} failure:^(NSDictionary * dic) {
		failure(dic);
	}];
    
}
#pragma mark 企业动态
- (void)getCompanyTrackListWithCompanyID:(int)companyID
                                    page:(int)page
                                     num:(int)num
                                 success:(void (^)(NSDictionary *obj))success
                                 failure:(void (^)(NSDictionary *obj2))failure
{
	self.tag = IH_EPCloudTrackList;
	NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
						  stringFormatInt(companyID),@"company_id",
						  stringFormatInt(page),@"page",
						  stringFormatInt(num),@"num",
						  nil];
	[self httpRequestTagWithParameter:dic2 method:@"Company/selectCompanyNews" tag:IH_EPCloudTrackList success:^(NSDictionary * dic) {
		success(dic);
	} failure:^(NSDictionary * dic) {
		failure(dic);
	}];
    
}

#pragma mark 企业的评论列表
- (void)getCompanyCommentList:(int)companyID
                         page:(int)page
                          num:(int)num
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_EPCloudCommentList;
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(companyID),@"company_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"Company/selectCompanyComment" tag:IH_EPCloudCommentList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark 添加企业评价
- (void)addCompanyComment:(NSString *)userId
                companyId:(int)companyId
                  content:(NSString *)content
                anonymous:(int)anonymous
                    level:(int)level
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure
{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(companyId),@"company_id",
                        stringFormatString(userId),@"user_id",
                        content,@"comment_content",
                        stringFormatInt(anonymous),@"anonymous",
                        stringFormatInt(level),@"level",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Company/saveCompanyComment" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}





-(void)selectUserCloudInfoById:(int)user_id
                     follow_id:(int)follow_id
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(follow_id),@"follow_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectUserCloudInfoById" tag:IH_CloudInfo success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
    
}


-(void)followUser:(int)user_id
        follow_id:(int)follow_id
             type:(NSString *)type
          success:(void (^)(NSDictionary *obj))success
          failure:(void (^)(NSDictionary *obj2))failure
{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(follow_id),@"follow_id",
                        stringFormatString(type),@"type",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"user/followUser" tag:IH_CloudInfo success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}



-(void)selectFansUserList:(int)user_id
                follow_id:(int)follow_id
                      num:(int )num
page:(int)page
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(follow_id),@"follow_id",
                        stringFormatInt(num),@"num",
                        stringFormatInt(page),@"page",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectFansUserList" tag:IH_fans success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}



-(void)selectFollowUserList:(int)user_id
                follow_id:(int)follow_id
                      num:(int )num
page:(int)page
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(follow_id),@"follow_id",
                        stringFormatInt(num),@"num",
                        stringFormatInt(page),@"page",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectFollowUserList" tag:IH_guanzhu success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
    
}

-(void)selectRecommendUserInfo:(int)user_id
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure{
    
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                                              nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectRecommendUserInfo" tag:IH_recommendConnection success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}

-(void)selectCompanyInfoByTopsuccess:(void (^)(NSDictionary *obj))success
                             failure:(void (^)(NSDictionary *obj2))failure
{
  
    [self httpRequestTagWithParameter:nil method:@"Company/selectCompanyInfoByTop" tag:IH_recommendCompany success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    

    
    
    
}



#pragma mark 添加企业反馈
- (void)addCompanyFeedBack:(NSString *)userId
                 companyId:(int)companyId
                   content:(NSString *)content
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(companyId),@"company_id",
                        stringFormatString(userId),@"user_id",
                        content,@"content",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Company/saveCompanyFeedbackInfo" success:^(NSDictionary *dic) {
        success(dic);
    }];
}

#pragma mark 邀请好友数统计
- (void)getInvatedFriends:(NSString *)userID
                     page:(int)page
                      num:(int)num
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatString(userID),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"user/countOfInviteUserInfo" tag:IH_invatedFriendsId success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}





- (void)selectUserInfoCloudListtWithProvice:(NSString *)provice
                                       City:(NSString *)city
                                       Area:(NSString *)area
                                      title:(NSString *)title
                                   job_type:(int)job_type
                                    user_id:(int)user_id
                                   nickname:(NSString *)nickname
                                       page:(int)page
                                        num:(int)num
                                      order:(NSString *)order
                                    success:(void (^)(NSDictionary *obj))success
                                    failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        provice,@"provice",
                        city,@"city",
                        area,@"area",
                        title,@"title",
                        stringFormatInt(job_type),@"job_type",
                        stringFormatInt(user_id),@"user_id",
                        nickname,@"nickname",
                        order,@"order",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",nil];
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectUserInfoCloudList" tag:IH_EPConnectionList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
}

#pragma mark 绑定企业搜索列表
- (void)getCompanyBycompanyName:(NSString *)companyName
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure
{

    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        companyName,@"company_name",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"Company/selectCompanyNameByName" tag:IH_BindCompanyList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}




-(void)selectPublicDicInfo:(int)dicType
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure{
    
    
   
    [self httpRequestWithParameter:nil method:[NSString stringWithFormat:@"openModel/selectPublicDicInfo?dicType=%d",dicType]  success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}


-(void)CompleteUserCloudInfoById:(NSString *)nickname
                           title:(NSString *)title
                      department:(NSString *)department
                        job_type:(int)job_type
                        position:(NSString *)position
                      company_id:(int)company_id
                          mobile:(NSString *)mobile
                           email:(NSString *)email
                         user_id:(int)user_id
                  heed_image_url:(NSString *)heed_image_url
                            sexy:(int)sexy
                        job_name:(NSString *)job_name
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(job_type),@"job_type",
                        stringFormatInt(company_id),@"company_id",
                        stringFormatInt(sexy),@"sexy",
                        stringFormatString(nickname),@"nickname",
                         stringFormatString(title),@"title",
                         stringFormatString(department),@"department",
                         stringFormatString(position),@"position",
                         stringFormatString(mobile),@"mobile",
                         stringFormatString(heed_image_url),@"heed_image_url",
                         stringFormatString(job_name),@"job_name",
                         stringFormatString(email),@"email",
                        nil];
    
    
    [self httpRequestTagWithParameter:dic2 method:@"user/completeUserCloudInfoById" tag:IH_completeUserCloudInfoById success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

    
    
    
    
    
}



-(void)selectSupplyAndWantByList:(NSString *)varieties //品种名称
                            page:(int)page
                             num:(int)num
                   operator_type:(int)operator_type  //操作类型｛0,查看全部；1,查看供应;2查看求购;3 我关注的｝
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure{
    self.ntpage=page;
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                       stringFormatInt(operator_type),@"operator_type",
                         varieties,@"varieties",
                      USERMODEL.userID,@"user_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectSupplyAndWantByList" tag:IH_SupplyAndBuy success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}

#pragma mark-投票列表
- (void)getVoteList:(NSString *)vote_id
       project_code:(NSString *)project_code
            success:(void (^)(NSDictionary *obj))success
            failure:(void (^)(NSDictionary *obj2))failure
{
    NSString *userID;
    if (!USERMODEL.isLogin) {
                userID = @"";
    }else
    {
        userID = USERMODEL.userID;
    }
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        vote_id,@"vote_id",
                        project_code,@"project_code",
                        userID,@"user_id",
                        nil];
    [self httpRequestTagWithParameter:dic2 method:@"vote/selectVoteProjectList" tag:IH_VoteList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    

}

#pragma mark-投票
- (void)getVoteForUser:(NSString *)vote_id
            project_id:(NSString *)project_id
               user_id:(NSString *)user_id
              vote_num:(NSString *)vote_num
            success:(void (^)(NSDictionary *obj))success
            failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        vote_id,@"vote_id",
                        project_id,@"project_id",
                        user_id,@"user_id",
                        vote_num,@"toujipiao",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"vote/clickVoteToProject" success:^(NSDictionary *dic) {
        success(dic);
    }];
    
}
#pragma mark-投票排行榜
- (void)getVoteChartsList:(NSString *)vote_id
                     page:(int)page
                      num:(int)num
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        vote_id,@"vote_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"vote/selectVoteInfoTop" tag:IH_VoteChartsList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark-投票个人详情
- (void)getVoteDetil:(NSString *)project_id
             vote_id:(int)vote_id
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure
{
    int userID;
    if (!USERMODEL.isLogin) {
        //登录
        userID = 0;
    }else
    {
        userID = [USERMODEL.userID intValue];
    }
    
    NSNumber *num = [NSNumber numberWithInt:userID];
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        project_id,@"project_id",
                        stringFormatInt(vote_id),@"vote_id",
                        num,@"user_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"vote/selectVoteProjectById" tag:IH_VoteDetail success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}



#pragma mark 发起众筹 /CrowdActivity/addCrowOrderActivities
-(void)addCrowOrderActivities:(int)user_id
                activities_id:(int)activities_id
                    order_num:(int)order_num //订单号
              contacts_people:(NSString *)contacts_people
               contacts_phone:(NSString *)contacts_phone
                          job:(NSString *)job
                 company_name:(NSString *)company_name
                        email:(NSString *)email
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(activities_id),@"activities_id",
                        stringFormatInt(order_num),@"order_num",
                        contacts_people,@"contacts_people",
                        contacts_phone,@"contacts_phone",
                        job,@"job",
                        company_name,@"company_name",
                        email,@"email",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"CrowdActivity/addCrowOrderActivities" tag:IH_AddCrowOrderActivities success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}


#pragma mark  根据id查询众筹明细  /CrowdActivity/selectCrowdDetailByCrowdId
-(void)selectCrowdDetailByCrowdId:(int)crowd_id
                           openid:(NSString *)openid
                          success:(void (^)(NSDictionary *obj))success
                          failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(crowd_id),@"crowd_id",
                        USERMODEL.userID,@"user_id",
                        openid,@"openid",
                        nil];
                          //                  @"CrowdActivity/selectCrowdDetailByCrowdId"
    [self httpRequestTagWithParameter:dic2 method:selectCrowdByIdUrl tag:IH_selectCrowdDetailByCrowdId success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}

#pragma mark 支付锁定
- (void)getlockCrowd:(NSString *)type
            crowd_id:(NSString *)crowd_id
               success:(void (^)(NSDictionary *obj))success
             failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        type,@"type",
                        crowd_id,@"crowd_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"CrowdActivity/lockCrowdOrder" success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
}



#pragma mark /CrowdActivity/UpdateCrowdTalkParams 更新众筹宣言
-(void)UpdateCrowdTalkParams:(NSInteger)corwd_id
                        talk:(NSString *)talk
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        talk,@"talk",
                        stringFormatInt(corwd_id),@"corwd_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"CrowdActivity/UpdateCrowdTalkParams" success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
}




#pragma mark /Company/updateCompanyInfoById 用户根据企业ID更新企业信息
-(void)updateCompanyInfoById:(int)user_id
                company_name:(NSString *)company_name
                   i_type_id:(int)i_type_id
                  company_id:(int)company_id
                        logo:(NSString *)logo
                  short_name:(NSString *)short_name
                   nature_id:(NSString *)nature_id
                  staff_size:(NSString *)staff_size
                company_desc:(NSString *)company_desc
                     address:(NSString *)address
                     provice:(NSString *)provice
                        city:(NSString *)city
                        area:(NSString *)area
                 company_lon:(NSString *)company_lon
                 company_lat:(NSString *)company_lat
               main_business:(NSString *)main_business
               company_image:(NSString *)company_image
                       level:(NSString *)level
                      mobile:(NSString *)mobile
                    landline:(NSString *)landline
                     website:(NSString *)website
                       email:(NSString *)email
                         fax:(NSString *)fax
                  company_qq:(NSString *)company_qq
                  wechat_num:(NSString *)wechat_num
               company_label:(NSString *)company_label
         company_license_url:(NSString *)company_license_url
                   design_lv:(NSString *)design_lv
                  project_lv:(NSString *)project_lv
                      status:(int)status
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        company_name,@"company_name",
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(i_type_id),@"i_type_id",
                        stringFormatInt(company_id),@"company_id",
                        logo,@"logo",
                        short_name,@"short_name",
                        nature_id,@"nature_id",
                        staff_size,@"staff_size",
                        company_desc,@"company_desc",
                        address,@"address",
                        provice,@"provice",
                        city,@"city",
                        area,@"area",
                        company_lon,@"company_lon",
                        company_lat,@"company_lat",
                        main_business,@"main_business",
                        company_image,@"company_image",
                        level,@"level",
                        mobile,@"mobile",
                        landline,@"landline",
                        website,@"website",
                        email,@"email",
                        fax,@"fax",
                        company_qq,@"company_qq",
                        wechat_num,@"wechat_num",
                        company_label,@"company_label",
                        company_license_url,@"company_license_url",
                        design_lv,@"design_lv",
                        project_lv,@"project_lv",
                        stringFormatInt(status),@"status",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Company/updateCompanyInfoById" success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
   
    
    
    
    
    
}



#pragma mark /user/authenticationForUser 用户认证企业认证信息提交
-(void)authenticationForUser:(NSDictionary *)UserInfoParams
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure{
    
    
  
    
    [self httpRequestWithParameter:UserInfoParams method:@"user/authenticationForUser"  success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

    
    
}


#pragma mark 根据ID查询用户园林云信息
- (void)getUserInfoFollow_id:(NSString *)follow_id
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        follow_id,@"follow_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"user/selectUserInfoForId" tag:IH_UserEPCloudAuthInfo success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark 根据公司名称搜索

- (void)searchCompanyList:(NSString *)company_name
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        company_name,@"company_name",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"Company/selectCompanyInfoByCompanyName" tag:IH_searchCompanyList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

- (void)getSearchCompanyInfo:(NSString *)company_id
                company_name:(NSString*)company_name
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        company_id,@"company_id",
                        company_name,@"company_name",
                        @"0",@"page",
                        @"1",@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"Company/selectCompanyInfoByIdOrName" tag:IH_CompanyInfo success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}



#pragma mark  /recruit/publishJobInfo 发布职位
-(void)publishJobInfo:(int)job_id
           company_id:(int)company_id
                  user_id:(int)user_id
             job_name:(NSString *)job_name
             job_name_id:(int)job_name_id
           experience:(NSString *)experience
          edu_require:(NSString *)edu_require
        work_province:(NSString *)work_province
            work_city:(NSString *)work_city
            work_area:(NSString *)work_area
         work_address:(NSString *)work_address
             job_desc:(NSString *)job_desc
               salary:(NSString *)salary
               status:(int)status
          province_id:(int)province_id
              city_id:(int)city_id
              area_id:(int)area_id
              job_lon:(NSString *)job_lon
              job_lat:(NSString *)job_lat
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure
{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        job_name,@"job_name",
                        stringFormatInt(job_id),@"job_id",
                        stringFormatInt(company_id),@"company_id",
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(job_name_id),@"job_name_id",
                        stringFormatInt(status),@"status",
                        stringFormatInt(province_id),@"province_id",
                        stringFormatInt(city_id),@"city_id",
                        stringFormatInt(area_id),@"area_id",
                         experience,@"experience",
                         edu_require,@"edu_require",
                         work_province,@"work_province",
                         work_city,@"work_city",
                        work_area,@"work_area",
                         work_address,@"work_address",
                         job_desc,@"job_desc",
                         salary,@"salary",
                        job_lon,@"job_lon",
                        job_lat,@"job_lat",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"recruit/publishJobInfo" success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
    
    
    
    
}




#pragma mark /recruit/selectRecruitList 查询简历列表
-(void)selectRecruitList:(NSString *)highest_edu
                  salary:(NSString *)salary
              experience:(NSString *)experience
                job_name_id:(int)job_name_id
                 user_id:(int)user_id
                    page:(int)page
                     num:(int)num
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        highest_edu,@"highest_edu",
                        salary,@"salary",
                        experience,@"experience",
                        stringFormatInt(job_name_id),@"job_name_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        stringFormatInt(user_id),@"user_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectRecruitList" tag:IH_selectRecruitList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
   
    
    
    
    
}




-(void)selectMyQuestionByUserId:(int)user_id
                           page:(int)page
                            num:(int)num
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"Forum/selectMyQuestionByUserId" tag:IH_MyQuestion success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
    
    
}


#pragma mark /Forum/forumTopicList 查询问吧主题列表
-(void)forumTopicListpage:(int)page
                      num:(int)num
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"Forum/forumTopicList" tag:IH_Question success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
    
}



#pragma mark /openModel/selectNurseryDetailListByPage 根据苗木类型Id分页查询苗木数据
-(void)selectNurseryDetailListByPage:(int)nursery_type_id
                   nursery_type_name:(NSString *)nursery_type_name
                                page:(int)page
                                 num:(int)num
                             success:(void (^)(NSDictionary *obj))success
                             failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                       stringFormatInt(nursery_type_id),@"nursery_type_id",
                                     nursery_type_name,@"nursery_type_name",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectNurseryDetailListByPage" tag:IH_NurseryDetailList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

}
//支持列表回复
- (void) SpperhuifuParames:(NSDictionary *)dic success:(void (^)(NSDictionary *obj))success{
    [self httpRequestTagWithParameter:dic method:SupperHuihuiUrl tag:IH_init success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
//        failure(dic);
    }];
}
- (void)orderPay:(NSString *)orderNo
      orderPrice:(NSString *)orderPrice
         subject:(NSString *)subject
            type:(NSString *)type
         success:(void (^)(NSDictionary *obj))success
         failure:(void (^)(NSDictionary *obj2))failure{
    
    NSMutableDictionary *jsonDict = [@{} mutableCopy];
    
    [jsonDict setValue:subject forKey:@"subject"];
    [jsonDict setValue:orderNo forKey:@"outTradeNo"];
    [jsonDict setValue:type forKey:@"type"];
    [jsonDict setValue:[NSString deviceIPAdress] forKey:@"spbillCreateIp"];
    [jsonDict setValue:orderPrice forKey:@"totalAmount"];

    NSString *jsonStr = [jsonDict jsonString];
    NSString *jsonString_encrpty = [jsonStr aci_encryptWithAES];

    NSMutableDictionary *jsonParam = [@{} mutableCopy];
    [jsonParam setValue:jsonString_encrpty forKey:@"data"];
    
    [self httpRequestTagWithParameter:jsonParam method:@"http://192.168.1.168:8080/beetl/alipay/topay" tag:IH_orderPay success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
}

- (void)orderPay:(NSString *)orderNo
      orderPrice:(NSString *)orderPrice
         subject:(NSString *)subject
            type:(NSString *)type
          crowID:(NSString *)crowID
    activitieID:(NSString *)activitie_id
         success:(void (^)(NSDictionary *obj))success
         failure:(void (^)(NSDictionary *obj2))failure{
    
    NSMutableDictionary *jsonDict = [@{} mutableCopy];
    NSMutableDictionary *crowIDDic = [@{} mutableCopy];

    [jsonDict setValue:subject forKey:@"subject"];
    [jsonDict setValue:orderNo forKey:@"outTradeNo"];
    [jsonDict setValue:type forKey:@"type"];
    [jsonDict setValue:[NSString deviceIPAdress] forKey:@"spbillCreateIp"];
    [jsonDict setValue:orderPrice forKey:@"totalAmount"];
    
    
    if (!ISEmptyString(crowID)) {
        [crowIDDic setValue:crowID forKey:@"crowdId"];
        NSString *crowIDStr = [crowIDDic jsonString];
        [jsonDict setValue:crowIDStr forKey:@"body"];
    }
    
    
    NSString *jsonStr = [jsonDict jsonString];
    NSString *jsonString_encrpty = [jsonStr aci_encryptWithAES];
    
    NSMutableDictionary *jsonParam = [@{} mutableCopy];
    [jsonParam setValue:jsonString_encrpty forKey:@"data"];
    [jsonParam setValue:activitie_id forKey:@"activitie_id"];
	
	NSData *data = [NSJSONSerialization dataWithJSONObject:jsonParam options:NSJSONWritingPrettyPrinted error:NULL];
	
    NSString *DataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *aesString = [DataStr aci_encryptWithAES];
    NSDictionary *dict1 = @{@"data" : aesString};
    
//    [self httpRequestTagWithParameter:jsonParam method:@"http://open.miaoto.net/beetl/alipay/topay" tag:IH_orderPay
//    NSString *Server =  @"https://www.miaoto.net/zmh/Activities/toPay";
    NSString *StoreSerStr = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],@"Activities/toPayNew"];
    [self httpRequestTagWithParameter:dict1 method:StoreSerStr tag:IH_orderPay success:^(NSDictionary * dic) {
        if (![dic[@"code"] isEqualToString:@"1"]) {
            [IHUtility addSucessView:dic[@"msg"] type:2];
        }else {
            success(dic);
        }
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
}
- (void)orderPayParameter:(NSDictionary *)Parameter
                       method:(NSString *)method
                       playType:(NSString *)Type
         success:(void (^)(NSDictionary *obj))success
         failure:(void (^)(NSDictionary *obj2))failure{
     NSString *StoreSerStr = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],method];
    [self httpRequestTagWithParameter:Parameter method:StoreSerStr tag:IH_orderPay success:^(NSDictionary * obj) {
        if ([Type isEqualToString:@"0"]) {     //免费
            success(obj);
            return ;
        }
        NSData *data =[obj[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (![dic[@"code"] isEqualToString:@"1"]) {
            [IHUtility addSucessView:dic[@"msg"] type:2];
        }else {
            success(dic);
        }
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}
//支付时加验证过期验证
- (void)orderPay:(NSString *)orderNo
      orderPrice:(NSString *)orderPrice
         subject:(NSString *)subject
            type:(NSString *)type
          crowID:(NSString *)crowID
          Other:(NSDictionary *)otherDic
         success:(void (^)(NSDictionary *obj))success
         failure:(void (^)(NSDictionary *obj2))failure{
    
    NSMutableDictionary *jsonDict = [@{} mutableCopy];
    NSMutableDictionary *crowIDDic = [@{} mutableCopy];
    
    [jsonDict setValue:subject forKey:@"subject"];
    [jsonDict setValue:orderNo forKey:@"outTradeNo"];
    [jsonDict setValue:type forKey:@"type"];
    [jsonDict setValue:[NSString deviceIPAdress] forKey:@"spbillCreateIp"];
    [jsonDict setValue:orderPrice forKey:@"totalAmount"];
    
    if (!ISEmptyString(crowID)) {
        [crowIDDic setValue:crowID forKey:@"crowdId"];
        NSString *crowIDStr = [crowIDDic jsonString];
        [jsonDict setValue:crowIDStr forKey:@"body"];
    }
    
    NSString *jsonStr = [jsonDict jsonString];
    NSString *jsonString_encrpty = [jsonStr aci_encryptWithAES];
    
    NSMutableDictionary *jsonParam = [@{} mutableCopy];
    [jsonParam setValue:jsonString_encrpty forKey:@"data"];
    [jsonParam setValue:otherDic[@"activitie_id"] forKey:@"activitie_id"];
    
    [self httpRequestTagWithParameter:jsonParam method:@"http://open.miaoto.net/beetl/alipay/topay" tag:IH_orderPay success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
}








@end
