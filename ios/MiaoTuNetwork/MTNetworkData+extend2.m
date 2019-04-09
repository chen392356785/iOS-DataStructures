//
//  MTNetworkData+extend2.m
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/11/8.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData+extend2.h"

@implementation MTNetworkData (extend2)


#pragma mark   苗木云 列表
-(void)GetMiaoMuYunListSuccess:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure{
 
    [self httpRequestTagWithParameter:nil method:@"openModel/selectAllNurseryType" tag:IH_MiaoMuYunList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
 
}
#pragma mark   苗木云详情
-(void)GetSeedCloudDetailByNursery_id:(int)nursery_id
                          success:(void (^)(NSDictionary *obj))success
                          failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(nursery_id),@"nursery_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectNurseryDetailById" tag:IH_SeedCloudDetail success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

-(void)getWeatherlist:(NSString *)cityKey
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        cityKey,@"citykey",
                        nil];
 
    [self httpGETWeatherTagWithParameter:dic2 url:@"http://wthrcdn.etouch.cn/weather_mini" tag:IH_WeatherList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark获取天天气详情
-(void)getWeatherDetail:(NSString *)cityKey
                   date:(NSString *)date   //20161112
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        cityKey,@"citykey",
                        date,@"date",
                        @"99817882",@"app_key",
                        nil];
    
    [self httpGETWeatherTagWithParameter:dic2 url:@"http://zhwnlapi.etouch.cn/Ecalender/api/v2/weather" tag:IH_WeatherDetail success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

}

#pragma mark /Company/selectCompanyRandListByLabel 随机获取战略伙伴企业信息
-(void)selectCompanyRandListByLabelsuccess:(void (^)(NSDictionary *obj))success
                                   failure:(void (^)(NSDictionary *obj2))failure{
    
    
    [self httpRequestTagWithParameter:nil method:@"Company/selectCompanyRandListByLabel" tag:IH_recommendCompany success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
}



#pragma mark /Company/selectCompanyList 企业云首页查询入住企业

-(void)selectCompanyRandListpage:(int)page
                             num:(int)num
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"Company/selectCompanyList" tag:IH_recommendCompany success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    

    
}

#pragma mark - 发布苗木云
- (void)sendNerseryDetailWith:(NSString *)plant_type
                   plant_name:(NSString *)plant_name
                     show_pic:(NSString *)show_pic
                loading_price:(NSString *)loading_price
                     location:(NSString *)location
                       heignt:(NSString *)heignt
                        crown:(NSString *)crown
                     tree_age:(NSString *)tree_age
                     diameter:(NSString *)diameter
                          num:(NSString *)num
                         unit:(NSString *)unit
                 rod_diameter:(NSString *)rod_diameter
                         four:(NSString *)four
              ground_diameter:(NSString *)ground_diameter
                 branch_point:(NSString *)branch_point
                    offspring:(NSString *)offspring
                seedling_type:(NSString *)seedling_type
                    dendroids:(NSString *)dendroids
                       branch:(NSString *)branch
                      density:(NSString *)density
              soil_ball_dress:(NSString *)soil_ball_dress
                    soil_ball:(NSString *)soil_ball
               soil_ball_size:(NSString *)soil_ball_size
               soil_thickness:(NSString *)soil_thickness
              soil_ball_shape:(NSString *)soil_ball_shape
                    safeguard:(NSString *)safeguard
                       remark:(NSString *)remark
              nursery_address:(NSString *)nursery_address
                     material:(NSString *)material
                      subsoil:(NSString *)subsoil
                         size:(NSString *)size
                     wear_bag:(NSString *)wear_bag
                    a_require:(NSString *)a_require
                     advanced:(NSString *)advanced
                    has_trunk:(NSString *)has_trunk
                  create_time:(NSString *)create_time
                       weight:(NSString *)weight
                       status:(NSString *)status
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        plant_type,@"plant_type",
                        plant_name,@"plant_name",
                        show_pic,@"show_pic",
                        loading_price,@"loading_price",
                        location,@"location",
                        num,@"num",
                        unit,@"unit",
                        heignt,@"heignt",
                        crown,@"crown",
                        tree_age,@"tree_age",
                        diameter,@"diameter",
                        rod_diameter,@"rod_diameter",
                        four,@"four",
                        ground_diameter,@"ground_diameter",
                        branch_point,@"branch_point",
                        offspring,@"offspring",
                        seedling_type,@"seedling_type",
                        dendroids,@"dendroids",
                        branch,@"branch",
                        density,@"density",
                        soil_ball_dress,@"soil_ball_dress",
                        soil_ball,@"soil_ball",
                        soil_ball_size,@"soil_ball_size",
                        soil_thickness,@"soil_thickness",
                        soil_ball_shape,@"soil_ball_shape",
                        safeguard,@"safeguard",
                        remark,@"remark",
                        nursery_address,@"nursery_address",
                        material,@"material",
                        subsoil,@"subsoil",
                        size,@"size",
                        wear_bag,@"wear_bag",
                        a_require,@"a_require",
                        advanced,@"advanced",
                        has_trunk,@"has_trunk",
                        create_time,@"create_time",
                        weight,@"weight",
                        status,@"status",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"nursery/addNurseryDetail" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 编辑苗木云
- (void)editNerseryDetailWith:(NSString *)plant_type
                   plant_name:(NSString *)plant_name
                     show_pic:(NSString *)show_pic
                loading_price:(NSString *)loading_price
                     location:(NSString *)location
                       heignt:(NSString *)heignt
                        crown:(NSString *)crown
                     tree_age:(NSString *)tree_age
                     diameter:(NSString *)diameter
                          num:(NSString *)num
                         unit:(NSString *)unit
                 rod_diameter:(NSString *)rod_diameter
                         four:(NSString *)four
              ground_diameter:(NSString *)ground_diameter
                 branch_point:(NSString *)branch_point
                    offspring:(NSString *)offspring
                seedling_type:(NSString *)seedling_type
                    dendroids:(NSString *)dendroids
                       branch:(NSString *)branch
                      density:(NSString *)density
              soil_ball_dress:(NSString *)soil_ball_dress
                    soil_ball:(NSString *)soil_ball
               soil_ball_size:(NSString *)soil_ball_size
               soil_thickness:(NSString *)soil_thickness
              soil_ball_shape:(NSString *)soil_ball_shape
                    safeguard:(NSString *)safeguard
                       remark:(NSString *)remark
              nursery_address:(NSString *)nursery_address
                     material:(NSString *)material
                      subsoil:(NSString *)subsoil
                         size:(NSString *)size
                     wear_bag:(NSString *)wear_bag
                    a_require:(NSString *)a_require
                     advanced:(NSString *)advanced
                    has_trunk:(NSString *)has_trunk
                  create_time:(NSString *)create_time
                       status:(NSString *)status
                   nursery_id:(NSString *)nursery_id
                       weight:(NSString *)weight
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        plant_type,@"plant_type",
                        plant_name,@"plant_name",
                        show_pic,@"show_pic",
                        loading_price,@"loading_price",
                        location,@"location",
                        num,@"num",
                        unit,@"unit",
                        heignt,@"heignt",
                        crown,@"crown",
                        tree_age,@"tree_age",
                        diameter,@"diameter",
                        rod_diameter,@"rod_diameter",
                        four,@"four",
                        ground_diameter,@"ground_diameter",
                        branch_point,@"branch_point",
                        offspring,@"offspring",
                        seedling_type,@"seedling_type",
                        dendroids,@"dendroids",
                        branch,@"branch",
                        density,@"density",
                        soil_ball_dress,@"soil_ball_dress",
                        soil_ball,@"soil_ball",
                        soil_ball_size,@"soil_ball_size",
                        soil_thickness,@"soil_thickness",
                        soil_ball_shape,@"soil_ball_shape",
                        safeguard,@"safeguard",
                        remark,@"remark",
                        nursery_address,@"nursery_address",
                        material,@"material",
                        subsoil,@"subsoil",
                        size,@"size",
                        wear_bag,@"wear_bag",
                        a_require,@"a_require",
                        advanced,@"advanced",
                        has_trunk,@"has_trunk",
                        create_time,@"create_time",
                        status,@"status",
                        nursery_id,@"nursery_id",
                        weight,@"weight",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"nursery/editNurseryDetail" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}


#pragma mark /nursery/myNurseryInfo 查询我的苗木云
-(void)myNurseryInfo:(int)page
                 num:(int)num
             success:(void (^)(NSDictionary *obj))success
             failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt([USERMODEL.userID intValue]),@"userId",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"nursery/myNurseryInfo" tag:IH_MyNersery success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
}


#pragma mark /nursery/deleteNurseryDetail 删除加苗木云数据
-(void)deleteNurseryDetail:(int)user_id
                nursery_id:(int)nursery_id
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(nursery_id),@"nursery_id",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"nursery/deleteNurseryDetail" tag:IH_deleteNersery success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}

#pragma mark /openModel/selectInformationBytitle/{info_title} 根据资讯标题搜索资讯信息(搜索引擎)
-(void)selectInformationBytitle:(NSString *)info_title
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:info_title,@"info_title", nil];
    
    [self httpRequestTagWithParameter:dic2 method:[NSString stringWithFormat:@"openModel/selectInformationBytitle"] tag:IH_NewsSearch success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
    
}


#pragma mark /registerAndLogin/IndexInitializationInfo 首页动态展示
-(void)getQueryHomePageTypeListSuccess:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure{
    
    
 
    [self httpRequestTagWithParameter:nil method:[NSString stringWithFormat:@"openModel/IndexInitializationInfo"] tag:IH_getQueryHomePageTypeList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
    
}

#pragma mark - 积分兑换记录
- (void)userScoreConvertHistory:(NSString *)userId
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId", nil];
    
    [self httpRequestTagWithParameter:dic2 method:[NSString stringWithFormat:@"coupon/selectCouponRecord"] tag:IH_ScoreHistory success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}



#pragma mark /openModel/selectNurseryTypeByParentid 根据一级类型ID获取苗木云苗木类型
-(void)selectNurseryTypeByParentid:(int)parent_id
                page:(int)page
                 num:(int)num
             success:(void (^)(NSDictionary *obj))success
             failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(parent_id),@"parent_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"openModel/selectNurseryTypeByParentid" tag:IH_MiaoMuYunList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
}


#pragma mark - 积分明细
- (void)userScoreDetailed:(NSString *)userId
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId", nil];
    
    [self httpRequestTagWithParameter:dic2 method:[NSString stringWithFormat:@"coupon/myCouponDetail"] tag:IH_ScoreDetail success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark /coupon/selectCouponInfoList 查询优惠券活动
-(void)selectCouponInfoListSuccess:(void (^)(NSDictionary *obj))success
failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:USERMODEL.userID,@"userId", nil];
    
    [self httpRequestTagWithParameter:dic2 method:[NSString stringWithFormat:@"coupon/selectCouponInfoList"] tag:IH_CouponList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];


    
}

#pragma mark /coupon/placeOrder 积分兑换 0 表示成功 -1 表示数据异常 602 表示积分不足 603 没有可兑换的优惠券
-(void)placeOrder:(int)couponId
           amount:(int)amount
          success:(void (^)(NSDictionary *obj))success
          failure:(void (^)(NSDictionary *obj2))failure{
    
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:USERMODEL.userID,@"userId",
                        stringFormatInt(couponId),@"couponId",
                        stringFormatInt(amount),@"amount",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"coupon/placeOrder" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
}

//获取聊天室列表
-(void)getChatRoomListSuccess:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure{

    [self httpRequestTagWithParameter:nil method:[NSString stringWithFormat:@"openModel/getAllChatRoomInfo"] tag:IH_GetAllChatRoomList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
}

//获取群组
-(void)getChatGroupListSuccess:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure{
    NSDictionary *parameter = @{
                                @"user_id" : stringFormatInt([USERMODEL.userID intValue])
                                };
    [self httpRequestTagWithParameter:parameter method:[NSString stringWithFormat:@"openModel/getAllChatGroupInfo"] tag:IH_getAllChatGroupList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}



//logistic/owner/getOwnerCarTime 货主用车时间设置
-(void)getOwnerCarTimeSuccess:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure{
    
    
    [self httpGETRequestTagWithParameter:nil method:@"logistic/owner/getOwnerCarTime" tag:IH_getOwnerCarTime success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
         failure(dic);
    }];


}

#pragma mark /logistic/owner/selectAllCarType 获取所有苗木物流车辆类型

-(void)selectAllCarType:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure{
    [self httpRequestWithParameter:nil method:[NSString stringWithFormat:@"logistic/owner/selectAllCarType"]  success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}


#pragma mark /logistic/owner/saveOwnerOrder 货主发布需求
-(void)saveOwnerOrder:(int)userId
placeOfDepartureProvince:(NSString *)placeOfDepartureProvince
 placeOfDepartureCity:(NSString *)placeOfDepartureCity
 placeOfDepartureArea:(NSString *)placeOfDepartureArea
placeOfDepartureAddress:(NSString *)placeOfDepartureAddress
  destinationProvince:(NSString *)destinationProvince
      destinationCity:(NSString *)destinationCity
      destinationArea:(NSString *)destinationArea
   destinationAddress:(NSString *)destinationAddress
               mobile:(NSString *)mobile
              carTime:(NSString *)carTime
            goodsType:(int)goodsType
            goodsName:(NSString *)goodsName
          goodsWeight:(int)goodsWeight
      preferredModels:(int)preferredModels
       carloadingMode:(NSString *)carloadingMode
              pattern:(NSString *)pattern
              section:(NSString *)section
         driverNumber:(NSString *)driverNumber
          paymentType:(NSString *)paymentType
               remark:(NSString *)remark
         ownerOrderId:(int)ownerOrderId
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure{
    
    
    
    if (ownerOrderId==0) {
        
        NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                            stringFormatInt(userId),@"userId",
                            stringFormatInt(goodsType),@"goodsType",
                            stringFormatInt(goodsWeight),@"goodsWeight",
                            stringFormatInt(preferredModels),@"preferredModels",
                            placeOfDepartureProvince,@"placeOfDepartureProvince",
                            placeOfDepartureCity,@"placeOfDepartureCity",
                            placeOfDepartureArea,@"placeOfDepartureArea",
                            placeOfDepartureAddress,@"placeOfDepartureAddress",
                            destinationProvince,@"destinationProvince",
                            destinationCity,@"destinationCity",
                            destinationArea,@"destinationArea",
                            destinationAddress,@"destinationAddress",
                            mobile,@"mobile",
                            carTime,@"carTime",
                            goodsName,@"goodsName",
                            carloadingMode,@"carloadingMode",
                            pattern,@"pattern",
                            section,@"section",
                            driverNumber,@"driverNumber",
                            paymentType,@"paymentType",
                            remark,@"remark",
                            nil];

        [self httpRequestWithParameter:dic2 method:@"logistic/owner/saveOwnerOrder"  success:^(NSDictionary * dic) {
            success(dic);
        } failure:^(NSDictionary * dic) {
            failure(dic);
        }];

    }else{
        
        NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                            stringFormatInt(userId),@"userId",
                            stringFormatInt(goodsType),@"goodsType",
                            stringFormatInt(goodsWeight),@"goodsWeight",
                            stringFormatInt(preferredModels),@"preferredModels",
                            placeOfDepartureProvince,@"placeOfDepartureProvince",
                            placeOfDepartureCity,@"placeOfDepartureCity",
                            placeOfDepartureArea,@"placeOfDepartureArea",
                            placeOfDepartureAddress,@"placeOfDepartureAddress",
                            destinationProvince,@"destinationProvince",
                            destinationCity,@"destinationCity",
                            destinationArea,@"destinationArea",
                            destinationAddress,@"destinationAddress",
                            mobile,@"mobile",
                            carTime,@"carTime",
                            goodsName,@"goodsName",
                            carloadingMode,@"carloadingMode",
                            pattern,@"pattern",
                            section,@"section",
                            driverNumber,@"driverNumber",
                            paymentType,@"paymentType",
                            remark,@"remark",
                            stringFormatInt(ownerOrderId),@"ownerOrderId",
                            nil];

        [self httpRequestWithParameter:dic2 method:@"logistic/owner/updateOwnerOrder"  success:^(NSDictionary * dic) {
            
            success(dic);
        } failure:^(NSDictionary * dic) {
            failure(dic);
        }];

    }
    
   
    
    
    
}






#pragma mark /logistic/owner/selectFlowCarRoute 货主查询车源信息
-(void)selectOwnerOrderList:(NSString *)t_province
       t_city:(NSString *)t_city
       t_area:(NSString *)t_area
        f_province:(NSString *)f_province
            f_city:(NSString *)f_city
            f_area:(NSString *)f_area
   flowCarSelectParamsInfos:(NSArray *)flowCarSelectParamsInfos
                       page:(int)page
                        num:(int)num
                    success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        t_province,@"t_province",
                        t_city,@"t_city",
                        t_area,@"t_area",
                        f_province,@"f_province",
                        f_city,@"f_city",
                        f_area,@"f_area",
                        flowCarSelectParamsInfos,@"flowCarSelectParamsInfos",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"logistic/owner/selectFlowCarRoute" tag:IH_FindCar success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
}

#pragma mark /logistic/owner/getSelectCarParams 获取搜索车源的搜索条件
-(void)getSelectCarParamsSuccess:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure{
    [self httpRequestWithParameter:nil method:[NSString stringWithFormat:@"logistic/owner/getSelectCarParams"]  success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}


#pragma mark /logistic/owner/selectFlowCarRouteById 车主根据车源Id查询车源
-(void)selectFlowCarRouteById:(int)Id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(Id),@"id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"logistic/owner/selectFlowCarRouteById"  success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
    
}



#pragma mark /logistic/owner/selectOwnerOrderByUserId 根据用户ID查询货主需求列
-(void)selectOwnerOrderByUserId:(int)user_id
                           page:(int)page
                            num:(int)num
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"logistic/owner/selectOwnerOrderByUserId" tag:IH_OwnerFaBu success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
    
    
    
    
}

#pragma mark /logistic/owner/deleteOwnerOrder 删除货主需求
-(void)deleteOwnerOrder:(int)ownerOrderId
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                      stringFormatInt(ownerOrderId),@"ownerOrderId",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"logistic/owner/deleteOwnerOrder"  success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

}

#pragma mark /logistic/owner/selectFlowCarRouteList 根据车主ID或手机号码查询车源
-(void)selectFlowCarRouteList:(int)user_id
                       mobile:(NSString *)mobile
                         page:(int)page
                          num:(int)num
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure{
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(user_id),@"user_id",
                        mobile,@"mobile",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"logistic/owner/selectFlowCarRouteList" tag:IH_cheyuan success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
    
    
    
    
}

#pragma mark /logistic/owner/selectHxUserType 根据环信账号判断用户归属
-(void)selectHxUserType:(NSString *)hx_user_name
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure{
    
    
    [self httpRequestWithParameter:@{@"hx_user_name":hx_user_name} method:@"logistic/owner/selectHxUserType"  success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];

    
}

#pragma mark /logistic/owner/selectFlowCarUserByMobile 根据车主用户id查询车主信息
-(void)selectFlowCarUserByMobile:(int)user_id
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure{
    
    
    [self httpRequestWithParameter:@{@"user_id":stringFormatInt(user_id)} method:@"logistic/owner/selectFlowCarUserByMobile"  success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
    
    
}




@end
