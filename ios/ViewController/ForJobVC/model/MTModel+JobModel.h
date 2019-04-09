//
//  MTModel+JobModel.h
//  MiaoTuProject
//
//  Created by Zmh on 26/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface MTModel (JobModel)

@end

@interface PositionListModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *job_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *salary;
@property (nonatomic ,strong,nullable) NSString<Optional> *work_city;
@property (nonatomic ,strong,nullable) NSString<Optional> *work_province;
@property (nonatomic ,strong,nullable) NSString<Optional> *experience;
@property (nonatomic ,strong,nullable) NSString<Optional> *edu_require;
@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *position;
@property (nonatomic ,strong,nullable) NSString<Optional> *staff_size;
@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *deploy_time;
@property (nonatomic ,strong,nullable) NSString<Optional> *i_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *job_desc;
@property (nonatomic ,strong,nullable) NSString<Optional> *company_desc;
@property (nonatomic ,strong,nullable) NSString<Optional> *work_address;
@property (nonatomic ,strong,nullable) NSString<Optional> *short_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *jobNum;
@property (nonatomic ,strong,nullable) NSString<Optional> *company_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *user_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *sendFlag;
@property (nonatomic ,strong,nullable) NSString<Optional> *hx_user_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *job_type_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *status;
@property (nonatomic ,strong,nullable) NSString<Optional> *job_lon;
@property (nonatomic ,strong,nullable) NSString<Optional> *job_lat;
@property (nonatomic ,strong,nullable) NSString<Optional> *province_id;
@property(nonatomic,assign)NSInteger job_name_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *city_id;
@property (nonatomic ,assign) NSInteger job_id;
@end


@interface RecruitEdusModel : MTModel
@property (nonatomic ,assign) NSInteger edu_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *school_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *major;

@property (nonatomic ,strong,nullable) NSString<Optional> *start_date;

@property (nonatomic ,strong,nullable) NSString<Optional> *experience;

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *end_date;

@property (nonatomic ,assign) NSInteger resume_id;
@end


@interface RecruitWorksModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *job_name;

@property (nonatomic ,assign) NSInteger work_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *start_date;

@property (nonatomic ,strong,nullable) NSString<Optional> *work_content;

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *end_date;

@property (nonatomic ,assign) NSInteger resume_id;
@end

@interface ReleasePositionModel : MTModel//发布的职位

@property (nonatomic ,strong,nullable) NSString<Optional> *job_desc;

@property (nonatomic ,assign) NSInteger job_name_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *edu_require;

@property (nonatomic ,strong,nullable) NSString<Optional> *work_city;

@property (nonatomic ,strong,nullable) NSString<Optional> *work_address;

@property (nonatomic ,strong,nullable) NSString<Optional> *job_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *salary;

@property (nonatomic ,assign) NSInteger job_id;

//@property (nonatomic ,strong,nullable) NSString<Optional> *job_type_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *work_province;

@property (nonatomic ,strong,nullable) NSString<Optional> *deploy_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *experience;

@property (nonatomic ,assign) NSInteger status;

-(id)initWithModel:(PositionListModel *)model;
@end


@interface SearchJobNameModel : MTModel//搜索职位名称
@property (nonatomic ,strong,nullable) NSString<Optional> *firstJob;

@property (nonatomic ,strong,nullable) NSString<Optional> *secondJob;

@property (nonatomic ,strong,nullable) NSString<Optional> *jobName;//职位名称

@property (nonatomic ,assign) NSInteger jobId;//职位id



@end
NS_ASSUME_NONNULL_END



