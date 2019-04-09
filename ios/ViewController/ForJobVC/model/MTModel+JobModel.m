//
//  MTModel+JobModel.m
//  MiaoTuProject
//
//  Created by Zmh on 26/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTModel+JobModel.h"

@implementation MTModel (JobModel)

@end

@implementation PositionListModel



@end






@implementation RecruitEdusModel



@end




@implementation RecruitWorksModel



@end


@implementation ReleasePositionModel
-(id)initWithModel:(PositionListModel *)model{
    self.job_desc=model.job_desc;
    self.job_name_id=model.job_name_id;
    self.edu_require=model.edu_require;
    self.work_city=model.work_city;
    self.work_address=model.work_address;
    self.job_name=model.job_name;
    self.salary=model.salary;
    self.job_id=model.job_id;
    self.work_province=model.work_province;
    self.deploy_time=model.deploy_time;
    self.experience=model.experience;
    self.status=model.status;
    
    return self;
}


@end


@implementation SearchJobNameModel



@end

