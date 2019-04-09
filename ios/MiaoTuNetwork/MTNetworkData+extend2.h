//
//  MTNetworkData+extend2.h
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/11/8.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData.h"

@interface MTNetworkData (extend2)
-(void)GetMiaoMuYunListSuccess:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark   苗木云详情
-(void)GetSeedCloudDetailByNursery_id:(int)nursery_id
                              success:(void (^)(NSDictionary *obj))success
                              failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark获取天天气列表
-(void)getWeatherlist:(NSString *)cityKey
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark获取天天气详情
-(void)getWeatherDetail:(NSString *)cityKey
                 date:(NSString *)date   //20161112
              success:(void (^)(NSDictionary *obj))success
              failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark /Company/selectCompanyRandListByLabel{num} 随机获取N个战略伙伴企业信息
-(void)selectCompanyRandListByLabelsuccess:(void (^)(NSDictionary *obj))success
                                   failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark /Company/selectCompanyList 企业云首页查询入住企业
-(void)selectCompanyRandListpage:(int)page
                             num:(int)num
success:(void (^)(NSDictionary *obj))success
failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark /nursery/myNurseryInfo 查询我的苗木云
-(void)myNurseryInfo:(int)page
                 num:(int)num
                   success:(void (^)(NSDictionary *obj))success
                    failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 发布苗木云
- (void)sendNerseryDetailWith:(NSString *)plant_type//品种类型
                   plant_name:(NSString *)plant_name//品种名
                     show_pic:(NSString *)show_pic//图片
                loading_price:(NSString *)loading_price//装车价
                     location:(NSString *)location//产地
                       heignt:(NSString *)heignt//高度
                        crown:(NSString *)crown//冠幅
                     tree_age:(NSString *)tree_age//树龄
                     diameter:(NSString *)diameter//胸径
                          num:(NSString *)num//数量
                         unit:(NSString *)unit//单位
                 rod_diameter:(NSString *)rod_diameter//杆径
                         four:(NSString *)four//
              ground_diameter:(NSString *)ground_diameter
                 branch_point:(NSString *)branch_point//分支点
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
                       remark:(NSString *)remark//备注
              nursery_address:(NSString *)nursery_address
                     material:(NSString *)material
                      subsoil:(NSString *)subsoil
                         size:(NSString *)size
                     wear_bag:(NSString *)wear_bag
                    a_require:(NSString *)a_require
                     advanced:(NSString *)advanced//优势
                    has_trunk:(NSString *)has_trunk
                  create_time:(NSString *)create_time
                       weight:(NSString *)weight
                       status:(NSString *)status
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark /nursery/deleteNurseryDetail 删除加苗木云数据
-(void)deleteNurseryDetail:(int)user_id
                nursery_id:(int)nursery_id
                   success:(void (^)(NSDictionary *obj))success
                   failure:(void (^)(NSDictionary *obj2))failure;


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
                      failure:(void (^)(NSDictionary *obj2))failure;



#pragma mark /openModel/selectInformationBytitle/{info_title} 根据资讯标题搜索资讯信息(搜索引擎)
-(void)selectInformationBytitle:(NSString *)info_title
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /registerAndLogin/IndexInitializationInfo 首页动态展示
-(void)getQueryHomePageTypeListSuccess:(void (^)(NSDictionary *obj))success
                               failure:(void (^)(NSDictionary *obj2))failure;
 
#pragma mark - 积分兑换记录
- (void)userScoreConvertHistory:(NSString *)userId
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure;
 


#pragma mark /openModel/selectNurseryTypeByParentid 根据一级类型ID获取苗木云苗木类型
-(void)selectNurseryTypeByParentid:(int)parent_id
                              page:(int)page
                               num:(int)num
                           success:(void (^)(NSDictionary *obj))success
                           failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /coupon/selectCouponInfoList 查询优惠券活动
-(void)selectCouponInfoListSuccess:(void (^)(NSDictionary *obj))success
                           failure:(void (^)(NSDictionary *obj2))failure;






#pragma mark - 积分明细
- (void)userScoreDetailed:(NSString *)userId
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /coupon/placeOrder 积分兑换 0 表示成功 -1 表示数据异常 602 表示积分不足 603 没有可兑换的优惠券
-(void)placeOrder:(int)couponId
           amount:(int)amount
          success:(void (^)(NSDictionary *obj))success
          failure:(void (^)(NSDictionary *obj2))failure;


//获取聊天室列表
-(void)getChatRoomListSuccess:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;

//获取群组
-(void)getChatGroupListSuccess:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure;


//logistic/owner/getOwnerCarTime 货主用车时间设置
-(void)getOwnerCarTimeSuccess:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /logistic/owner/selectAllCarType 获取所有苗木物流车辆类型

-(void)selectAllCarType:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure;


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
              failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /flowcar/owner/selectOwnerOrderList 查询货主订单列表
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
                    failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /logistic/owner/getSelectCarParams 获取搜索车源的搜索条件
-(void)getSelectCarParamsSuccess:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /logistic/owner/selectFlowCarRouteById 车主根据车源Id查询车源
-(void)selectFlowCarRouteById:(int)Id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /logistic/owner/selectOwnerOrderByUserId 根据用户ID查询货主需求列
-(void)selectOwnerOrderByUserId:(int)user_id
                           page:(int)page
                            num:(int)num
                        success:(void (^)(NSDictionary *obj))success
                        failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark /logistic/owner/deleteOwnerOrder 删除货主需求
-(void)deleteOwnerOrder:(int)ownerOrderId
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark /logistic/owner/selectFlowCarRouteList 根据车主ID或手机号码查询车源
-(void)selectFlowCarRouteList:(int)user_id
                       mobile:(NSString *)mobile
                         page:(int)page
                          num:(int)num
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /logistic/owner/selectHxUserType 根据环信账号判断用户归属
-(void)selectHxUserType:(NSString *)hx_user_name
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark /logistic/owner/selectFlowCarUserByMobile 根据车主用户id查询车主信息
-(void)selectFlowCarUserByMobile:(int)user_id
                         success:(void (^)(NSDictionary *obj))success
                         failure:(void (^)(NSDictionary *obj2))failure;

@end
