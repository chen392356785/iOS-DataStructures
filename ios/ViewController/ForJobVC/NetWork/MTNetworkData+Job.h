//
//  MTNetworkData+Job.h
//  MiaoTuProject
//
//  Created by Zmh on 26/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData.h"

@interface MTNetworkData (Job)

#pragma mark - 职位列表
- (void)getPositionList:(int)UID
               province:(NSString *)province
                   city:(NSString *)city
                 salary:(NSString *)salary
               workYear:(NSString *)workYear
                  staff:(NSString *)staff
                   page:(int)page
                    num:(int)num
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark - 企业所有职位列表
- (void)loadCompanyPositionList:(NSString *)user_id
                           page:(int)page
                            num:(int)num
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /recruit/selectPersonlRecruitDetail 查询简历详情
-(void)selectPersonlRecruitDetail:(int)resume_id
                          user_id:(int)user_id
success:(void (^)(NSDictionary *obj))success
failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark - 职位详情
- (void)loadPositionDetail:(NSString *)jobID
                   user_id:(NSString *)user_id
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 投递个人简历
- (void)getDeliveryResume:(NSString *)nickname
             hx_user_name:(NSString *)hx_user_name
                   job_id:(int)job_id
             company_name:(NSString *)company_name
               staff_size:(NSString *)staff_size
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 保存个人简历
- (void)saveUserResume:(NSString *)resume_id
        workoff_status:(NSString *)workoff_status
                salary:(NSString *)salary
          year_of_work:(NSString *)year_of_work
           highest_edu:(NSString *)highest_edu
             advantage:(NSString *)advantage
               display:(NSString *)display
       expect_job_type:(NSString *)expect_job_type
           province_id:(NSString *)province_id
         work_province:(NSString *)work_province
               city_id:(NSString *)city_id
             work_city:(NSString *)work_city
           recruitEdus:(NSArray *)recruitEdus
          recruitWorks:(NSArray *)recruitWorks
               success:(void (^)(NSDictionary *obj))success
               failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 举报职位
- (void)userReportPosition:(NSString *)job_id
                   content:(NSString *)content
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark /recruit/selectReceiveResruitList 查询收到的简历列表
-(void)selectReceiveResruitList:(int)user_id
                           page:(int)page
                            num:(int)num
                          success:(void (^)(NSDictionary *obj))success
                          failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark /recruit/selectPublishJboList 查询我发布的职位列表
-(void)selectPublishJboList:(int)user_id
                           page:(int)page
                            num:(int)num
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure;





#pragma mark /recruit/deleteReceiveJob 删除我收到的简历记录
-(void)deleteReceiveJob:(int)receive_id
                success:(void (^)(NSDictionary *obj))success;




#pragma mark - 我的投递记录
- (void)getUserDeliveryRecord:(NSString *)user_id
                         page:(int)page
                          num:(int)num
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark /recruit/updateRecruitUserIdentity 求职者身份切换
-(void)updateRecruitUserIdentity:(int)user_id
                   identity_flag:(int)identity_flag//1求职者 2招聘者
                success:(void (^)(NSDictionary *obj))success;




#pragma mark /recruit/selectRecruitListWithSearch 查询简历列表（搜索）
-(void)selectRecruitListWithSearch:(NSString *)job_name
                              page:(int)page
                               num:(int)num
                           success:(void (^)(NSDictionary *obj))success
                           failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark /recruit/closeRecruitJob 关闭已发布的职位
-(void)closeRecruitJob:(int)job_id
                status:(int)status
               success:(void (^)(NSDictionary *obj))success;




#pragma mark - 职位列表搜索
- (void)searchPositionWithName:(NSString *)job_name
                      province:(NSString *)province
                          city:(NSString *)city
                        salary:(NSString *)salary
                      workYear:(NSString *)workYear
                         staff:(NSString *)staff
                          page:(int)page
                           num:(int)num
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark - 公司信息
- (void)getCompanyHomePage:(NSString *)company_id
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /recruit/selectJobInfoByJobName 根据职位名称模糊搜索职位信息(搜索引擎)
-(void)selectJobInfoByJobName:(NSString *)jobName
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark - 更新管理求职意向
- (void)updateUserJobIntentionInfo:(NSString *)province_id
                     work_province:(NSString *)work_province
                           city_id:(NSString *)city_id
                         work_city:(NSString *)work_city
                       job_name_id:(NSString *)job_name_id
                          job_name:(NSString *)job_name
                           success:(void (^)(NSDictionary *obj))success
                           failure:(void (^)(NSDictionary *obj2))failure;
@end
