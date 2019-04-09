//
//  MTNetworkData+ForModel2.m
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/11/8.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData+ForModel2.h"

@implementation MTNetworkData (ForModel2)
-(NSDictionary *)getSeedCloudDetail:(NSDictionary *)dic{
    
    NSDictionary *Dic = dic[@"content"];
//    [Dic propertyCode];
    NurseryListModel *model = [[NurseryListModel alloc] initWithDictionary:Dic error:nil];
    model.heed_image_url =[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[Dic objectForKey:@"heed_image_url"]];
    NSString * str=model.show_pic;
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
    if (model != nil) {
        [dic2 setObject:Dic forKey:@"content"];
        [dic2 setObject:model forKey:@"content2"];
    }
    return dic2;
}


-(NSDictionary *)getMyNurseryInfo:(NSDictionary *)dic{
    
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        MyNerseryModel *model = [[MyNerseryModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
}

-(NSDictionary *)selectInformationBytitle:(NSDictionary *)dic{
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        NewsSearchModel *model = [[NewsSearchModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
    
    
    
    
}


-(NSDictionary *)selectCouponInfoList:(NSDictionary *)dic{
    NSArray *arr = dic[@"content"][@"couponInfos"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        CouponListModel *model = [[CouponListModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"couponInfos"];
    
    return dic2;
    
    
    
    
}

-(NSDictionary *)scoreHistoryList:(NSDictionary *)dic{
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        ScoreHistoryModel *model = [[ScoreHistoryModel alloc] initWithDictionary:Dic error:nil];
        model.History_id = [NSString stringWithFormat:@"%@",Dic[@"id"]];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
    
    
    
    
}






-(NSDictionary *)scoreDetailList:(NSDictionary *)dic{
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        ScoreDetailModel *model = [[ScoreDetailModel alloc] initWithDictionary:Dic error:nil];
        model.creditType = [NSString stringWithFormat:@"%@",Dic[@"creditType"]];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
    
    
    
    
}

-(NSDictionary *)selectOwnerOrderList:(NSDictionary *)dic{
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        FindCarModel *model = [[FindCarModel alloc] initWithDictionary:Dic error:nil];
      
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
}

-(NSDictionary *)selectOwnerOrderByUserId:(NSDictionary *)dic{
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        OwnerFaBuModel *model = [[OwnerFaBuModel alloc] initWithDictionary:Dic error:nil];
        
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;

}

-(NSDictionary *)selectFlowCarRouteList:(NSDictionary *)dic{
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        CheYuanModel *model = [[CheYuanModel alloc] initWithDictionary:Dic error:nil];
        
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;

}



@end
