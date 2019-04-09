//
//  MTNetworkData+ForModel2.h
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/11/8.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData.h"

@interface MTNetworkData (ForModel2)
-(NSDictionary *)getSeedCloudDetail:(NSDictionary *)dic;//苗木云详情
-(NSDictionary *)getMyNurseryInfo:(NSDictionary *)dic;//我发布的苗木云
-(NSDictionary *)selectInformationBytitle:(NSDictionary *)dic;//搜索资讯结果

-(NSDictionary *)selectCouponInfoList:(NSDictionary *)dic;//优惠卷


-(NSDictionary *)scoreHistoryList:(NSDictionary *)dic;//积分兑换记录

-(NSDictionary *)scoreDetailList:(NSDictionary *)dic;//积分明细
-(NSDictionary *)selectOwnerOrderList:(NSDictionary *)dic;//找车
-(NSDictionary *)selectOwnerOrderByUserId:(NSDictionary *)dic;//发布
-(NSDictionary *)selectFlowCarRouteList:(NSDictionary *)dic;//车源
@end
