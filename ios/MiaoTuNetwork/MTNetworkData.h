//
//  MTNetworkData.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MiaoTuNetworkConst.h"
#import <Foundation/Foundation.h>
#import "NSDictionary+PropertyCode.h"

#define network	[MTNetworkData shareInstance]

@interface MTNetworkData : NSObject

@property(nonatomic,assign) int tag;
@property(nonatomic,assign) int ntpage;

/**
 解析返回结果根据 tag
 */
-(NSDictionary *)parseResult:(NSDictionary*)dic
						 tag:(IHFunctionTag)tag;

//根据tag 来封装数据
-(void)httpRequestTagWithParameter:(NSDictionary *)dic
                            method:(NSString *)method
                               tag:(IHFunctionTag)tag
                           success:(void (^)(id))success
                           failure:(void (^)(id))failure;

-(void)httpRequestWithParameter:(NSDictionary *)dic
                         method:(NSString *)method
                        success:(void (^)(id))success
                        failure:(void (^)(id))failure;

-(void)httpRequestWithParameter:(NSDictionary *)dic
                         method:(NSString *)method
                        success:(void (^)(id))success;

//根据tag 来封装数据 GET请求
-(void)httpGETRequestTagWithParameter:(NSDictionary *)dic
                               method:(NSString *)method
                                  tag:(IHFunctionTag)tag
                              success:(void (^)(id))success
                              failure:(void (^)(id))failure;


-(void)httpGETWeatherTagWithParameter:(NSDictionary *)dic
                                  url:(NSString *)url
                                  tag:(IHFunctionTag)tag
                              success:(void (^)(id))success
                              failure:(void (^)(id))failure;

+(MTNetworkData *)shareInstance;


#pragma mark 获取验证码 type  0 注册  1找回密码
-(void)getSendRegisterSms:(NSString *)phone
                     type:(int)type
                   chanle:(int)chanle
                  success:(void (^)(NSDictionary *obj))success;
#pragma mark 获取登录 手机验证码
-(void)getPhoneNumCode:(NSString *)phone
               success:(void (^)(NSDictionary *obj))success;
#pragma mark 验证 验证码
-(void)getValidateCode:(NSString *)phone
                 vcode:(NSString *)vcode
               success:(void (^)(NSDictionary *obj))success;


#pragma mark 用户登录
-(void)getUserLogin:(NSString *)userName
           passWord:(NSString *)passWord
            success:(void (^)(NSDictionary *obj))success;

#pragma mark用户短信验证码登录
-(void)getCodeNumUserLogin:(NSString *)userName
                   codeNum:(NSString *)codeNum
                   success:(void (^)(NSDictionary *obj))success;
//#pragma mark 新用户注册登录
//-(void)NewgetUserPhoneNumber:(int)user_id
//                        code:(NSString *)code
//                       phone:(NSString *)phone
//                     success:(void (^)(NSDictionary *obj))success;

#pragma mark 用户注册
-(void)getuserRegister:(NSDictionary *)UserInfoParams
               success:(void (^)(NSDictionary *obj))success;


#pragma mark 初始化
-(void)getInitsuccess:(NSString *)user_id
            longitude:(CGFloat)longitude
             latitude:(CGFloat)latitude
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSError *error))failure;



#pragma mark 发布话题
-(void)getAddTopic:(NSString *)topic_url
     topic_content:(NSString *)topic_content
           address:(NSString *)address
           theme_Id:(NSString *)theme_Id
           success:(void (^)(NSDictionary *obj))success;

#pragma mark 发布供应
-(void)getAddSupplyInfo:(NSInteger)userid
                 number:(NSInteger)number
                  price:(CGFloat)price
                  point:(CGFloat)point
               diameter:(CGFloat)diameter
                width_s:(CGFloat)width_s
                width_e:(CGFloat)width_e
               height_s:(CGFloat)height_s
               height_e:(CGFloat)height_e
              varieties:(NSString *)varieties
                selling:(NSString *)selling
               seedling:(NSString *)seedling
             supply_url:(NSString *)url
                address:(NSString *)address
                success:(void (^)(NSDictionary *obj))success;

#pragma mark 发布求购
-(void)getAddBuyInfo:(NSInteger)userId
              number:(NSInteger)number
               point:(CGFloat)point
            diameter:(CGFloat)diameter
             width_s:(CGFloat)width_s
             width_e:(CGFloat)width_e
            height_s:(CGFloat)height_s
            height_e:(CGFloat)height_e
           varieties:(NSString *)varieties
             selling:(NSString *)selling
payment_methods_dictionary_id:(NSInteger)paymentId
     use_mining_area:(NSString *)use_mining_area
         mining_area:(NSString *)mining_area
    urgency_level_id:(NSInteger)urgencyId
        want_buy_url:(NSString *)url
             address:(NSString *)address
             success:(void (^)(NSDictionary *obj))success;

#pragma mark 提交活动订单
-(void)getAddActivtiesOrder:(int)order_num
              activities_id:(NSString *)activities_id
            contacts_people:(NSString *)contacts_people
             contacts_phone:(NSString *)contacts_phone
                        job:(NSString *)job
               company_name:(NSString *)company_name
                      email:(NSString *)email
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查询话题列表
-(void)getTopicList:(int)page
         maxResults:(int)maxResults
             userID:(int)userID
              isHot:(int)isHot  //是否热门话题
         my_user_id:(int)my_user_id
           theme_id:(int)theme_id
            success:(void (^)(NSDictionary *obj))success
            failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 查询供应列表
-(void)getSupplyList:(int)page
          maxResults:(int)maxResults
          my_user_id:(int)my_user_id
seedling_source_address:(NSString *)seedling_source_address
           varieties:(NSString *)varieties
             success:(void (^)(NSDictionary *obj))success
             failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查询求购列表
-(void)getBuyList:(int)page
       maxResults:(int)maxResults
       my_user_id:(int)my_user_id
      mining_area:(NSString *)mining_area
        varieties:(NSString *)varieties
          success:(void (^)(NSDictionary *obj))success
          failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 收藏供应
-(void)getSupplyCollections:(int)supply_id
                    user_id:(int)user_id
                    success:(void (^)(NSDictionary *obj))success;


#pragma mark 收藏求购
-(void)getBuyCollections:(int)want_buy_id
                 user_id:(int)user_id
                 success:(void (^)(NSDictionary *obj))success;

#pragma mark 收藏话题
-(void)getTopicCollection:(int)topic_id
                  user_id:(int)user_id
                  success:(void (^)(NSDictionary *obj))success;

#pragma mark 查看供应评论
-(void)getQuerySupplyCommentList:(int)page
                      maxResults:(int)maxResults
                        supplyID:(NSString *)supplyID
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查看求购评论
-(void)getQueryWantBuyCommentList:(int)page
                      maxResults:(int)maxResults
                        want_buy_id:(NSString *)want_buy_id
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查看活动评论
- (void)getActivtiesCommentList:(int)page
                     maxResults:(int)maxResults
                  activities_id:(NSString *)activities_id
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure;
#pragma mark 查看资讯评论
- (void)getNewsCommentList:(int)page
                maxResults:(int)maxResults
                   info_id:(NSString *)info_id
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;
#pragma mark 添加供应评论
-(void)getAddSupplyComment:(int)supply_id
				   user_id:(int)user_id     //供应主键ID,
			 reply_user_id:(int)reply_user_id   //回复用户主键ID,
		 supply_comment_id:(int)supply_comment_id ///评论 id
			reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
			supply_comment:(NSString *)supply_comment   //供应评论内容,
			  comment_type:(int)comment_type  //0:主动评论,1回复,
   reply_supply_comment_id:(int)reply_supply_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
				   success:(void (^)(NSDictionary *obj))success;

#pragma mark 添加求购评论
-(void)getAddWantBuyComment:(int)supply_id
                    user_id:(int)user_id     //供应主键ID,
              reply_user_id:(int)reply_user_id   //回复用户主键ID,
             reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
             supply_comment:(NSString *)supply_comment   //供应评论内容,
               comment_type:(int)comment_type  //0:主动评论,1回复,
    reply_supply_comment_id:(int)reply_supply_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
                    success:(void (^)(NSDictionary *obj))success;
#pragma mark 添加话题评论
-(void)getAddTopicComment:(int)topic_id
                    user_id:(int)user_id     //供应主键ID,
              reply_user_id:(int)reply_user_id   //回复用户主键ID,
             reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
             topic_comment:(NSString *)topic_comment   //话题评论内容,
               comment_type:(int)comment_type  //0:主动评论,1回复,
    reply_topic_comment_id:(int)reply_topic_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
                    success:(void (^)(NSDictionary *obj))success;


#pragma mark 添加活动评论
-(void)getAddActivtiesComment:(int)activities_id
                      user_id:(int)user_id     //供应主键ID,
                reply_user_id:(int)reply_user_id   //回复用户主键ID,
               reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
           activities_comment:(NSString *)activities_comment   //话题评论内容,
                 comment_type:(int)comment_type  //0:主动评论,1回复,
  reply_activities_comment_id:(int)reply_activities_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
                      success:(void (^)(NSDictionary *obj))success;

#pragma mark 添加资讯评论
-(void)getAddNewsComment:(int)info_id
                 user_id:(int)user_id     //供应主键ID,
           reply_user_id:(int)reply_user_id   //回复用户主键ID,
          reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
            info_comment:(NSString *)info_comment   //话题评论内容,
            comment_type:(int)comment_type  //0:主动评论,1回复,
   reply_info_comment_id:(int)reply_info_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
                 success:(void (^)(NSDictionary *obj))success;
#pragma mark 删除供应`
-(void)getDeleteSupply:(int)supply_id
               success:(void (^)(NSDictionary *obj))success;

#pragma mark 删除求购
-(void)getDeleteBuy:(int)want_buy_id
            success:(void (^)(NSDictionary *obj))success;

#pragma mark 删除话题
-(void)getDeleteTopic:(int)topic_id
              success:(void (^)(NSDictionary *obj))success;



#pragma mark 查看供应详情
-(void)getQuerySupplyComment:(NSString *)supply_id
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查询求购详情
-(void)getQueryBuyComment:(int)want_buy_id
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;
#pragma mark 查询话题详情
-(void)getQueryTopicComment:(int)topic_id
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark 更新供应信息
-(void)getUpdateSupplyInfo:(int)userid
                 supply_id:(int)supply_id
                    number:(NSInteger)number
                     price:(CGFloat)price
                     point:(CGFloat)point
                  diameter:(CGFloat)diameter
                   width_s:(CGFloat)width_s
                   width_e:(CGFloat)width_e
                  height_s:(CGFloat)height_s
                  height_e:(CGFloat)height_e
                 varieties:(NSString *)varieties
                   selling:(NSString *)selling
                  seedling:(NSString *)seedling
                supply_url:(NSString *)url
                   address:(NSString *)address
                   success:(void (^)(NSDictionary *obj))success;

#pragma mark 更新求购列表
-(void)getUpdateBuyInfo:(int)userId
                 number:(NSInteger)number
            want_buy_id:(int)want_buy_id
                  point:(CGFloat)point
               diameter:(CGFloat)diameter
                width_s:(CGFloat)width_s
                width_e:(CGFloat)width_e
               height_s:(CGFloat)height_s
               height_e:(CGFloat)height_e
              varieties:(NSString *)varieties
                selling:(NSString *)selling
payment_methods_dictionary_id:(NSInteger)paymentId
        use_mining_area:(NSString *)use_mining_area
            mining_area:(NSString *)mining_area
       urgency_level_id:(NSInteger)urgencyId
           want_buy_url:(NSString *)url
                address:(NSString *)address
                success:(void (^)(NSDictionary *obj))success;


#pragma mark 分页查询附近用户
-(void)getNearUserInfoByUserWithlongitude:(CGFloat)longitude
                                 latitude:(CGFloat)latitude
                                     page:(int)page
                                      num:(int)num
                             company_name:(NSString *)company_name
                         company_province:(NSString *)company_province
                             company_city:(NSString *)company_city
                               itype_List:(NSArray *)itype_List
                                  user_id:(int)user_id
                                  success:(void (^)(NSDictionary *obj))success
                                  failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 分页查询附近用户
-(void)getNearUserInfoByUserWithlongitude:(CGFloat)longitude
                                 latitude:(CGFloat)latitude
                                     page:(int)page
                                      num:(int)num
                             nickname:(NSString *)nickname
                         company_province:(NSString *)company_province
                             company_city:(NSString *)company_city
                                  user_id:(int)user_id
                                  success:(void (^)(NSDictionary *obj))success
                                  failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark 分页查询最新用户
-(void)getNewUserInfoByUserWithpage:(int)page
                                num:(int)num
                            success:(void (^)(NSDictionary *obj))success
                            failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查询用户评论
-(void)getUserComments:(int)user_id
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 用户地址更新
-(void)getUpdateUserAdress:(int)user_id
                   country:(NSString *)country
                  province:(NSString *)province
                      city:(NSString *)city
                      area:(NSString *)area
                    street:(NSString *)street
                 longitude:(CGFloat)longitude
                  latitude:(CGFloat)latitude
                   success:(void (^)(NSDictionary *obj))success;

#pragma mark 提交众筹订单
- (void)getActivtyCrowdOrder:(NSString *)user_id
               activities_id:(NSString *)activities_id
                   order_num:(NSString *)order_num
             contacts_people:(NSString *)contacts_people
              contacts_phone:(NSString *)contacts_phone
                         job:(NSString *)job
                company_name:(NSString *)company_name
                       email:(NSString *)email
                      remark:(NSString *)remark
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;
@end
