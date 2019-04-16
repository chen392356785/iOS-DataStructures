//
//  MTNetworkData+Job.m
//  MiaoTuProject
//
//  Created by Zmh on 26/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

//#import "AFNetworking.h"
#import "MTNetworkData+Job.h"
//#import "MTNetworkData+ForModel.h"

@implementation MTNetworkData (Job)

//static MTNetworkData *_config;

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
                failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_PositionList;
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(UID),@"user_id",
                        province,@"province_id",
                        city,@"city_id",
                        salary,@"salary",
                        workYear,@"year_of_work",
                        staff,@"staff",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];

    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectJobList" tag:IH_PositionList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark - 企业所有职位列表
- (void)loadCompanyPositionList:(NSString *)user_id
                           page:(int)page
                            num:(int)num
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure
{
    
    self.tag=IH_PositionList;
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        user_id,@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectJobListByUserId" tag:IH_CompanyPositionList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
}

#pragma mark /recruit/selectPersonlRecruitDetail 查询简历详情
-(void)selectPersonlRecruitDetail:(int)resume_id
                          user_id:(int)user_id
                          success:(void (^)(NSDictionary *obj))success
                          failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(resume_id),@"resume_id",
                        stringFormatInt(user_id),@"user_id",
                      nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectPersonlRecruitDetail" tag:IH_CurrculumDetail success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

    
}






#pragma mark - 职位详情
- (void)loadPositionDetail:(NSString *)jobID
                   user_id:(NSString *)user_id
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure
{
    self.tag=IH_PositionDetail;
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        jobID,@"job_id",
                        user_id,@"user_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectJobAndCompanyDetail" tag:IH_PositionDetail success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}


#pragma mark - 投递个人简历
- (void)getDeliveryResume:(NSString *)nickname
             hx_user_name:(NSString *)hx_user_name
                   job_id:(int)job_id
             company_name:(NSString *)company_name
               staff_size:(NSString *)staff_size
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure
{

    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        nickname,@"nickname",
                        hx_user_name,@"hx_user_name",
                        stringFormatInt(job_id),@"job_id",
                        company_name,@"company_name",
                        staff_size,@"staff_size",
                        nil];

    [self httpRequestWithParameter:dic2 method:@"recruit/sendPersonalRecruit" success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    
}

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
               failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        resume_id,@"resume_id",
                        workoff_status,@"workoff_status",
                        salary,@"salary",
                        year_of_work,@"year_of_work",
                        highest_edu,@"highest_edu",
                        advantage,@"advantage",
                        display,@"display",
                        expect_job_type,@"expect_job_name",
                        province_id,@"province_id",
                        work_province,@"work_province",
                        city_id,@"city_id",
                        work_city,@"work_city",
                        recruitEdus,@"recruitEdus",
                        recruitWorks,@"recruitWorks",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"recruit/savePersonalRecruit" success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}

#pragma mark - 举报职位
- (void)userReportPosition:(NSString *)job_id
                   content:(NSString *)content
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure
{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        job_id,@"job_id",
                        content,@"content",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"recruit/saveJobReport" success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}

#pragma mark /recruit/selectReceiveResruitList 查询收到的简历列表
-(void)selectReceiveResruitList:(int)user_id
                           page:(int)page
                            num:(int)num
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectReceiveResruitList" tag:IH_ReceiveCurrculum success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
 
    
    
}



#pragma mark /recruit/selectPublishJboList 查询我发布的职位列表
-(void)selectPublishJboList:(int)user_id
                       page:(int)page
                        num:(int)num
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure{
    
    
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectPublishJboList" tag:IH_ReleasePosition success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
    

    
    
}



#pragma mark /recruit/deleteReceiveJob 删除我收到的简历记录
-(void)deleteReceiveJob:(int)receive_id
                success:(void (^)(NSDictionary *obj))success{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(receive_id),@"receive_id",
                                               nil];
    
    [self httpRequestWithParameter:dic2 method:@"recruit/deleteReceiveJob" success:^(NSDictionary *dic) {
        success(dic);
    }];
}

#pragma mark - 我的投递记录
- (void)getUserDeliveryRecord:(NSString *)user_id
                         page:(int)page
                          num:(int)num
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        user_id,@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectSendRecruitList" tag:IH_CompanyPositionList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}

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
                      failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        job_name,@"job_name",
                        province,@"province_id",
                        city,@"city_id",
                        salary,@"salary",
                        workYear,@"year_of_work",
                        staff,@"staff",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectJobListWithSearch" tag:IH_CompanyPositionList success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}

#pragma mark /recruit/updateRecruitUserIdentity 求职者身份切换
-(void)updateRecruitUserIdentity:(int)user_id
                   identity_flag:(int)identity_flag//1求职者 2招聘者
                         success:(void (^)(NSDictionary *obj))success{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(identity_flag),@"identity_flag",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"recruit/updateRecruitUserIdentity" success:^(NSDictionary *dic) {
        success(dic);
    }];
}

- (void)getCompanyHomePage:(NSString *)company_id
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure
{
    
    [self httpRequestTagWithParameter:nil method:[NSString stringWithFormat:@"Company/selectCompanyInfoById/%@",company_id] tag:IH_JobCompanyInfo success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}

#pragma mark /recruit/selectRecruitListWithSearch 查询简历列表（搜索）
-(void)selectRecruitListWithSearch:(NSString *)job_name
                              page:(int)page
                               num:(int)num
                           success:(void (^)(NSDictionary *obj))success
                           failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        job_name,@"job_name",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectRecruitListWithSearch" tag:IH_selectRecruitListSearce success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];

}

#pragma mark /recruit/closeRecruitJob 关闭已发布的职位
-(void)closeRecruitJob:(int)job_id
                status:(int)status
               success:(void (^)(NSDictionary *obj))success{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(job_id),@"job_id",
                        stringFormatInt(status),@"status",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"recruit/closeRecruitJob" success:^(NSDictionary *dic) {
        success(dic);
    }];
}

#pragma mark /recruit/selectJobInfoByJobName 根据职位名称模糊搜索职位信息(搜索引擎)
-(void)selectJobInfoByJobName:(NSString *)jobName
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                       jobName,@"jobName",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"recruit/selectJobInfoByJobName" tag:IH_SearchJobName success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];    
}

#pragma mark - 更新管理求职意向
- (void)updateUserJobIntentionInfo:(NSString *)province_id
                     work_province:(NSString *)work_province
                           city_id:(NSString *)city_id
                         work_city:(NSString *)work_city
                       job_name_id:(NSString *)job_name_id
                          job_name:(NSString *)job_name
                           success:(void (^)(NSDictionary *obj))success
                           failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        province_id,@"province_id",
                        work_province,@"work_province",
                        city_id,@"city_id",
                        work_city,@"work_city",
                        job_name_id,@"job_name_id",
                        job_name,@"job_name",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"recruit/updateJobPurPose" success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSDictionary *dic) {
        failure(dic);
    }];
}

@end
