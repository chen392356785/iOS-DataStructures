//
//  MTNetworkData+JobModel.m
//  MiaoTuProject
//
//  Created by Zmh on 26/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData+JobModel.h"

@implementation MTNetworkData (JobModel)
- (NSDictionary *)getPositionList:(NSDictionary *)dic tag:(IHFunctionTag)tag
{
    NSArray *arr;
    if (tag == IH_PositionList) {
        arr = dic[@"content"][@"jobList"];
    }else if (tag == IH_CompanyPositionList){
        arr = dic[@"content"];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        PositionListModel *model = [[PositionListModel alloc] initWithDictionary:Dic error:nil];
        model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url];
        [array addObject:model];
    }

    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    if (tag == IH_PositionList) {
       [dic2 setObject:dic[@"content"][@"purpose"] forKey:@"purpose"];
    }
    return dic2;
}

- (NSDictionary *)getPositionDetail:(NSDictionary *)dic
{
    NSDictionary *Dic = dic[@"content"];
    NSDictionary *dic1 = Dic[@"detail"];
    PositionListModel *model = [[PositionListModel alloc] initWithDictionary:dic1 error:nil];

    model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url];
    model.jobNum = [NSString stringWithFormat:@"%@",Dic[@"jobNum"]];
    model.sendFlag = [NSString stringWithFormat:@"%@",Dic[@"sendFlag"]];
    model.company_id = [NSString stringWithFormat:@"%@",dic1[@"company_id"]];
    model.user_id = [NSString stringWithFormat:@"%@",dic1[@"user_id"]];

    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    return dic2;
}

-(NSDictionary *)getCurricuiumDetaile:(NSDictionary *)dic{
   
    NSArray *array = dic[@"content"][@"recruitEdus"];
    NSArray *Array= dic[@"content"][@"recruitWorks"];
    
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    NSMutableArray *MArray=[[NSMutableArray alloc]initWithCapacity:[Array count]];
    
    for (NSDictionary *dic in array) {
        
        RecruitEdusModel *model=[[RecruitEdusModel alloc]initWithDictionary:dic error:nil];
        [mArray addObject:model];
    }
    for (NSDictionary *dic in Array) {
        RecruitWorksModel *model=[[RecruitWorksModel alloc]initWithDictionary:dic error:nil];
        [MArray addObject:model];
    }

    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
    [dic3 setObject:dic[@"content"][@"advantage"] forKey:@"advantage"];
    [dic3 setObject:mArray forKey:@"recruitEdus"];
    [dic3 setObject:MArray forKey:@"recruitWorks"];
    
    [dic2 setObject:dic3 forKey:@"content"];
    [dic2 setObject:dic forKey:@"dic"];
    return dic2;
}

-(NSDictionary *)ReceiveCurrculum:(NSDictionary *)dic{
    NSArray *arr=dic[@"content"];
      NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[arr count]];
    for (NSDictionary *dic in arr) {
        jianliModel *model=[[jianliModel alloc]initWithDictionary:dic error:nil];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}

-(NSDictionary *)ReleasePosition:(NSDictionary *)dic{
    
    NSArray *arr=dic[@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[arr count]];
    for (NSDictionary *dic in arr) {
        ReleasePositionModel *model=[[ReleasePositionModel alloc]initWithDictionary:dic error:nil];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}

- (NSDictionary *)getJobCompanyInfo:(NSDictionary *)dic
{
    NSDictionary *Dic = dic[@"content"];
    EPCloudListModel *model = [[EPCloudListModel alloc] initWithDictionary:Dic error:nil];
    
    NSString * str=model.company_image;
    if (str.length>0) {
        
        NSArray *arr1=[self getJsonForString:str];
        NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr1.count];
        
        for (NSDictionary * dic2 in arr1) {
            MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
            [imgArr addObject:photoModel];
        }
        model.imageArr=imgArr;
    }

    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    
    return dic2;
}

-(NSDictionary *)SearchJobName:(NSDictionary *)dic{
    NSArray *arr=dic[@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[arr count]];
    for (NSDictionary *dic in arr) {
        SearchJobNameModel *model=[[SearchJobNameModel alloc]initWithDictionary:dic error:nil];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}
@end
