//
//  MTNetworkData+extend.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData.h"

@interface MTNetworkData (extend)
#pragma mark 供应点赞
-(void)getAddSupplyClickLike:(int)user_id
                   supply_id:(int)supply_id
                        type:(int)type   // 0点赞 1取消点赞
                     success:(void (^)(NSDictionary *obj))success;
#pragma mark 求购点赞
-(void)getAddWantBuyClickLike:(int)user_id
                  want_buy_id:(int)want_buy_id
                         type:(int)type // 0点赞 1取消点赞
                      success:(void (^)(NSDictionary *obj))success;
#pragma mark删除 供应评论
-(void)getDeleteSupplyCommentID:(int)commentID
                         userID:(NSString *)userID
                        success:(void (^)(NSDictionary *obj))success;
#pragma mark删除 话题评论
-(void)getDeleteTopicCommentID:(int)commentID
                         userID:(NSString *)userID
                        success:(void (^)(NSDictionary *obj))success;

#pragma mark删除 求购评论
-(void)getDeleteBuyCommentID:(int)commentID
                      userID:(NSString *)userID
                     success:(void (^)(NSDictionary *obj))success;
#pragma mark删除 活动评论
-(void)getDeleteActivtiesCommentID:(int)commentID
                            userID:(NSString *)userID
                           success:(void (^)(NSDictionary *obj))success;


#pragma mark删除资讯评论
-(void)getDeleteNewsCommentID:(int)commentID
                       userID:(NSString *)userID
                      success:(void (^)(NSDictionary *obj))success;

#pragma mark 取消活动
//status 0:待付款;1:已付款;2:付款失败;3:取消订单; orderID 活动的订单ID
- (void)cancleActivtiesOrder:(NSString *)orderID
                     success:(void (^)(NSDictionary *obj))success;
#pragma mark 行业公司搜索列表
-(void)getSelectUserCompanyNameforTypeId:(NSArray *)i_type_id
                                     num:(int)num
                                    page:(int)page
                                latitude:(CGFloat)latitude
                               longitude:(CGFloat)longitude
                            company_name:(NSString *)company_name
                                 success:(void (^)(NSDictionary *obj))success
                                 failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 分页查询用户列表,可设置排序类型
-(void)getQueryUserByList:(int)order
                      num:(int)num
                     page:(int)page
                 latitude:(CGFloat)latitude
                longitude:(CGFloat)longitude
                 nickname:(NSString *)nickname
                  version:(NSString *)version
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查询点赞列表
-(void)getQueryClickLikeListType:(int)type
                     business_id:(NSString *)business_id
                             num:(int)num
                            page:(int)page
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 用户签到
-(void)getUserAign:(int)user_id
         sign_date:(NSString *)sign_date
           success:(void (^)(NSDictionary *obj))success;


#pragma mark 查看话题评论
-(void)getQueryTopicCommentList:(int)page
                      maxResults:(int)maxResults
                        topicID:(NSString *)topicID
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 话题点赞
-(void)getTopicAddLike:(NSString *)user_id
              topic_id:(NSString *)topic_id
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 我的收藏列表
-(void)getCollectionTypeList:(int)model // 查询类型 1.供应,2.话题,3.求购,
                     user_id:(NSString *)user_id
                         num:(int)num
                        page:(int)page
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 取消收藏

-(void)getUnselCollectionMyType:(int)model// 查询类型 1.供应,2.话题,3.求购,
                        user_id:(NSString *)user_id
                    business_id:(NSString *)business_id
                        success:(void (^)(NSDictionary *obj))success;

#pragma mark 评论我的 
-(void)getCommentMeList:(NSString *)user_id
                    num:(int)num
                   page:(int)page
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark 用户信息更新
-(void)getUserInfoUpdate:(NSDictionary *)UserInfoParams
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure;

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
         failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 查看供应详情
-(void)getSupplyDetailID:(NSString *)user_id
               supply_id:(NSString *)supply_id
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查看求购详情
-(void)getBuyDetailID:(NSString *)user_id
               want_buy_id:(NSString *)want_buy_id
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查看话题详情
-(void)getTopicDetailID:(NSString *)user_id
          topic_id:(NSString *)topic_id
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark 根据id查询用户信息
-(void)selectUseerInfoForId:(NSInteger)user_id
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 查询用户查看列表
-(void)getSelectViewsList:(int)user_id
                     page:(int)page
                      num:(int)num
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 微信登录


-(void)getWXlogin:(NSString *)wx_key  // 微信key
         nickname:(NSString *)nickname
   heed_image_url:(NSString *)heed_image_url
          success:(void (^)(NSDictionary *obj))success
          failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 活动列表

-(void)getActivityList:(int)page
                   num:(int)num
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure;

-(void)getAllActivityList:(NSDictionary *)dic2
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 活动详情
- (void)getActivitiesDetail:(NSString *)activities_id
                       type:(NSString *)type
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 收藏活动
- (void)collectActivties:(NSString *)activID
                 success:(void (^)(NSDictionary *obj))success;
#pragma mark 收藏资讯
- (void)collectNews:(NSString *)infoID
            success:(void (^)(NSDictionary *obj))success;
#pragma mark 活动查看次数
- (void)lookNumActivties:(NSString *)activID
                 success:(void (^)(NSDictionary *obj))success;

#pragma mark 我的活动列表
-(void)getUserActivityList:(int)user_id
                      page:(int)page
                     model:(int)model
                       num:(int)num
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 找回密码
-(void)findPassword:(NSString *)user_name
           password:(NSString *)password
               code:(NSString *)code
            success:(void (^)(NSDictionary *obj))success;

#pragma mark 查看其他用户
-(void)getuserView:(int)user_id
      view_user_id:(int)view_user_id
           success:(void (^)(NSDictionary *obj))success;


#pragma mark 绑定用户联系方式
-(void)getUserPhoneNumber:(int)user_id
                     code:(NSString *)code
                    phone:(NSString *)phone
                  success:(void (^)(NSDictionary *obj))success;

#pragma mark 老用户绑定手机号
-(void)OldGetUserPhoneNumber:(int)user_id
                        code:(NSString *)code
                       phone:(NSString *)phone
                     success:(void (^)(NSDictionary *obj))success;

#pragma mark 新用户注册绑定手机登录
- (void)NewGetUserPhoneNumber:(NSString *)WXKey
                         code:(NSString *)code
                        phone:(NSString *)phone
                       WXName:(NSString*)nickname
                       WXIcon:(NSString*)heed_image_url
                      success:(void (^)(NSDictionary *obj))success;

#pragma mark 意见反馈
-(void)getUserFeedBack:(int)user_id
     feed_back_content:(NSString *)feed_back_content
                 phone:(NSString *)phone
               success:(void (^)(NSDictionary *obj))success;

#pragma mark通过环信id查用户信息
-(void)getUserInfoByHxName:(NSString *)hx_name
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 举报接口
-(void)getAddReport:(NSString *)user_id
     report_content:(NSString *)report_content
        report_type:(NSString *)report_type
        business_id:(NSString *)business_id
            success:(void (^)(NSDictionary *obj))success
            failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark 行业资讯列表
- (void)getNewsList:(int)page
                num:(int)num
         program_id:(int)program_id
            user_id:(int)user_id
            success:(void (^)(NSDictionary *))success
            failure:(void (^)(NSDictionary *))failure;

#pragma mark 资讯详情
- (void)getNewsDetail:(NSString *)info_id
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure;
#pragma mark 广告资讯详情
- (void)getPushNewsDetail:(NSString *)info_id
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 图集资讯详情
- (void)getImageNewsDetail:(NSString *)info_id
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 活动点赞
-(void)getAddActivtiesClickLike:(int)user_id
                  activities_id:(int)activities_id
                        success:(void (^)(NSDictionary *obj))success;
#pragma mark 根据id查询用户任务
-(void)selectUserTaskInfoForId:(int)user_id
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 主题列表
- (void)getThemeList:(int)page
                 num:(int)num
             success:(void (^)(NSDictionary *))success
             failure:(void (^)(NSDictionary *))failure;


#pragma mark 邀请好友统计
-(void)getInviteFriendfoForId:(int)user_id
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark 本周任务统计
-(void)getWeekTaskInfofoForId:(int)user_id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;

 

#pragma mark绑定百度推送
-(void)GetBindBaiduPush:(NSString *)UserID
             channel_id:(NSString *)channel_id
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark 首页资讯和热门话题获取
-(void)getThemeAndInformationListSuccess:(void (^)(NSDictionary *obj))success
failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 更新话题查看次数
-(void)updateTopicLookersUser:(int)topic_id
                      success:(void (^)(NSDictionary *obj))success;



#pragma mark 根据id查用户标签
-(void)selectIdentikeyForUserID:(int)user_id
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure;
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
                          failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 企业动态
- (void)getCompanyTrackListWithCompanyID:(int)companyID
                                    page:(int)page
                                     num:(int)num
                                 success:(void (^)(NSDictionary *obj))success
                                 failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 企业的评论列表
- (void)getCompanyCommentList:(int)companyID
                         page:(int)page
                          num:(int)num
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 添加企业评价
- (void)addCompanyComment:(NSString *)userId
                companyId:(int)companyId
                  content:(NSString *)content
                anonymous:(int)anonymous
                    level:(int)level
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark  根据用户ID获取用户信息（包括话题数，供求数，关注数）
-(void)selectUserCloudInfoById:(int)user_id
                     follow_id:(int)follow_id
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark 关注指定用户
-(void)followUser:(int)user_id
        follow_id:(int)follow_id
             type:(NSString *)type
          success:(void (^)(NSDictionary *obj))success
          failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark 粉丝列表/openModel/selectFansUserList
-(void)selectFansUserList:(int)user_id
                follow_id:(int)follow_id
                     num:(int )num
                     page:(int)page
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark 关注列表/openModel/selectFollowUserList
-(void)selectFollowUserList:(int)user_id
                follow_id:(int)follow_id
                      num:(int )num
                    page:(int)page
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;





#pragma mark 查询推荐的人脉云/openModel/selectRecommendUserInfo
-(void)selectRecommendUserInfo:(int)user_id
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark 查询推荐的企业/Company/selectCompanyInfoByTop
-(void)selectCompanyInfoByTopsuccess:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark 添加企业反馈
- (void)addCompanyFeedBack:(NSString *)userId
                 companyId:(int)companyId
                   content:(NSString *)content
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 邀请好友数统计
- (void)getInvatedFriends:(NSString *)userID
                     page:(int)page
                      num:(int)num
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;







#pragma mark 人脉云列表 POST /openModel/selectUserInfoCloudList
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
                          failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark 绑定企业搜索列表
- (void)getCompanyBycompanyName:(NSString *)companyName
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure;





#pragma mark POST /openModel/selectPublicDicInfo 查询公共字典信息
//1.职位类型
//2.身份头衔
//3.公司性质
//4.行业类型
-(void)selectPublicDicInfo:(int)dicType
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;





#pragma mark POST /user/completeUserCloudInfoById 完善个人云名片信息


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
                         failure:(void (^)(NSDictionary *obj2))failure;





#pragma mark POST /openModel/selectSupplyAndWantByList 查询供求大厅

-(void)selectSupplyAndWantByList:(NSString *)varieties
                            page:(int)page
                             num:(int)num
                   operator_type:(int)operator_type  //操作类型｛0,查看全部；1,查看供应;2查看求购;3 我关注的｝
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark-投票列表
- (void)getVoteList:(NSString *)vote_id
       project_code:(NSString *)project_code
            success:(void (^)(NSDictionary *obj))success
            failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark-投票
- (void)getVoteForUser:(NSString *)vote_id
            project_id:(NSString *)project_id
               user_id:(NSString *)user_id
              vote_num:(NSString *)vote_num
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark-投票排行榜
- (void)getVoteChartsList:(NSString *)vote_id
                     page:(int)page
                      num:(int)num
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark-投票个人详情
- (void)getVoteDetil:(NSString *)project_id
             vote_id:(int)vote_id
             success:(void (^)(NSDictionary *obj))success
             failure:(void (^)(NSDictionary *obj2))failure;




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
                      failure:(void (^)(NSDictionary *obj2))failure;





#pragma mark  根据id查询众筹明细  /CrowdActivity/selectCrowdDetailByCrowdId
-(void)selectCrowdDetailByCrowdId:(int)crowd_id
                           openid:(NSString *)openid
                          success:(void (^)(NSDictionary *obj))success
                          failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark - 是否众筹过
- (void)getWhetherCrowdWithUserID:(NSString *)user_id
                    activities_id:(NSString *)activities_id
                          success:(void (^)(NSDictionary *obj))success;
#pragma mark 支付锁定
- (void)getlockCrowd:(NSString *)type
            crowd_id:(NSString *)crowd_id
             success:(void (^)(NSDictionary *obj))success
             failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark /CrowdActivity/UpdateCrowdTalkParams 更新众筹宣言
-(void)UpdateCrowdTalkParams:(NSInteger)corwd_id
                        talk:(NSString *)talk
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;




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
                     failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark /user/authenticationForUser 用户认证企业认证信息提交
-(void)authenticationForUser:(NSDictionary *)UserInfoParams
         success:(void (^)(NSDictionary *obj))success
         failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 根据ID查询用户园林云信息
- (void)getUserInfoFollow_id:(NSString *)follow_id
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 根据公司名称搜索

- (void)searchCompanyList:(NSString *)company_name
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 根据企业ID查询信息
- (void)getSearchCompanyInfo:(NSString *)company_id
                company_name:(NSString*)company_name
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;


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
              failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark /recruit/selectRecruitList 查询简历列表
-(void)selectRecruitList:(NSString *)highest_edu
                  salary:(NSString *)salary
              experience:(NSString *)experience
                job_name_id:(int)job_name_id
                 user_id:(int)user_id
                    page:(int)page
                     num:(int)num
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark 企业云热门搜索
-(void)getHistoryEPCloudByList:(int)searchType
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark 查询发布的问题
-(void)selectMyQuestionByUserId:(int)user_id
                           page:(int)page
                            num:(int)num
success:(void (^)(NSDictionary *obj))success
failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark /Forum/forumTopicList 查询问吧主题列表
-(void)forumTopicListpage:(int)page
                      num:(int)num
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark /openModel/selectNurseryDetailListByPage 根据苗木类型Id分页查询苗木数据
-(void)selectNurseryDetailListByPage:(int)nursery_type_id
                   nursery_type_name:(NSString *)nursery_type_name
                                page:(int)page
                                 num:(int)num
                             success:(void (^)(NSDictionary *obj))success
                             failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark 支持列表回复
- (void) SpperhuifuParames:(NSDictionary *)dic success:(void (^)(NSDictionary *obj))success;

//支付接口
- (void)orderPay:(NSString *)orderNo
      orderPrice:(NSString *)orderPrice
         subject:(NSString *)subject
            type:(NSString *)type
          crowID:(NSString *)crowID
    activitieID:(NSString *)activitie_id
         success:(void (^)(NSDictionary *obj))success
         failure:(void (^)(NSDictionary *obj2))failure;

//课程支付
- (void)orderPayParameter:(NSDictionary *)Parameter
                   method:(NSString *)method
                 playType:(NSString *)Type
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;

@end





