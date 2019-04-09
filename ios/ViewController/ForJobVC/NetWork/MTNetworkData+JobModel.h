//
//  MTNetworkData+JobModel.h
//  MiaoTuProject
//
//  Created by Zmh on 26/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData.h"

@interface MTNetworkData (JobModel)
- (NSDictionary *)getPositionList:(NSDictionary *)dic tag:(IHFunctionTag)tag;//职位列表

- (NSDictionary *)getPositionDetail:(NSDictionary *)dic;//职位详情

-(NSDictionary *)getCurricuiumDetaile:(NSDictionary *)dic;//简历详情

-(NSDictionary *)ReceiveCurrculum:(NSDictionary *)dic;//收到的简历

-(NSDictionary *)ReleasePosition:(NSDictionary *)dic;//发布的职位

- (NSDictionary *)getJobCompanyInfo:(NSDictionary *)dic;//招聘获取公司信息

-(NSDictionary *)SearchJobName:(NSDictionary *)dic;//搜索职位名称

@end
