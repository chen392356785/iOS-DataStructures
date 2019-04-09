//
//  MTModel+model1.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/26.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTModel.h"
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTModel (model1)

@end


@interface jianliModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *salary;

@property (nonatomic ,strong,nullable) NSString<Optional> *job_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;

@property (nonatomic ,strong,nullable) NSString<Optional> *year_of_work;

@property (nonatomic ,strong,nullable) NSString<Optional> *highest_edu;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,strong,nullable) NSString<Optional> *work_city;

@property (nonatomic ,strong,nullable) NSString<Optional> *workoff_status;

@property (nonatomic ,strong,nullable) NSString<Optional> *resume_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *user_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *receive_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *hx_user_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *send_user_id;
@property (nonatomic,strong,nullable) NSString<Optional> *advantage;
@end



@interface MyQuestionModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *answer_status;//回答状态
@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;
@property (nonatomic ,strong,nullable) NSString<Optional> *forum_topic_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *forum_topic_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *Id;
@property (nonatomic ,strong,nullable) NSString<Optional> *ignore;
@property (nonatomic ,strong,nullable) NSString<Optional> *title;
@property (nonatomic ,strong,nullable) NSString<Optional> *user_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;
@property (nonatomic ,strong,nullable) NSString<Optional> *Description;//标题描述
@property (nonatomic ,strong,nullable) NSString<Optional> *show_pic;//首页背景
@property (nonatomic ,strong,nullable) NSString<Optional> *user_desc;//版主介绍
@property (nonatomic ,strong,nullable) NSString<Optional> *question_num;
@property (nonatomic ,strong,nullable) NSString<Optional> *user_title;
@property (nonatomic ,strong,nullable) NSString<Optional> *view_num;//多少人看过
@property(nonatomic,strong,nullable)NSString<Optional> *detailed_pic;//问吧主题详情背景图
@property(nonatomic,strong,nullable)AnswerInfoModel<Optional> *answerInfo;//回复信息
@end




@interface NurseryListModel : MTModel//苗木云列表
@property (nonatomic ,strong,nullable) NSString<Optional> *crown;//冠幅

@property (nonatomic ,strong,nullable) NSString<Optional> *loading_price;//装车价

@property (nonatomic ,strong,nullable) NSString<Optional> *mobile;//电话

@property (nonatomic ,assign) NSInteger nursery_id;//id

@property (nonatomic ,strong,nullable) NSString<Optional> *company_id;//公司id

@property (nonatomic ,strong,nullable) NSString<Optional> *diameter;//胸径

@property (nonatomic ,strong,nullable) NSString<Optional> *tree_age;//树龄
@property (nonatomic ,assign) NSInteger user_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *branch_point;//分支点

@property (nonatomic ,strong,nullable) NSString<Optional> *heignt;//高度

@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *num;//数量
@property (nonatomic ,strong,nullable) NSString<Optional> *rod_diameter;//杆径
@property (nonatomic ,strong,nullable) NSString<Optional> *show_pic;//显示图片

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *parent_nursery_name;//品类

@property (nonatomic ,strong,nullable) NSString<Optional> *plant_name;//类名
//
@property (nonatomic ,strong,nullable) NSString<Optional> *ground_diameter;

@property (nonatomic ,strong,nullable) NSString<Optional> *soil_thickness;

@property (nonatomic ,strong,nullable) NSString<Optional> *remark;

@property (nonatomic ,strong,nullable) NSString<Optional> *density;

@property (nonatomic ,strong,nullable) NSString<Optional> *soil_ball_shape;

@property (nonatomic ,strong,nullable) NSString<Optional> *soil_ball_dress;

@property (nonatomic ,strong,nullable) NSString<Optional> *four;

@property (nonatomic ,strong,nullable) NSString<Optional> *soil_ball;
@property (nonatomic ,strong,nullable) NSString<Optional> *weight;

@property (nonatomic ,strong,nullable) NSString<Optional> *advanced;
@property (nonatomic ,strong,nullable) NSString<Optional> *location;
@property (nonatomic ,strong,nullable) NSString<Optional> *plant_type;
@property (nonatomic ,strong,nullable) NSString<Optional> *material;
@property (nonatomic ,strong,nullable) NSString<Optional> *dendroids;
@property (nonatomic ,strong,nullable) NSString<Optional> *offspring;
@property (nonatomic ,strong,nullable) NSString<Optional> *branch;
@property (nonatomic ,strong,nullable) NSString<Optional> *wear_bag;
@property (nonatomic ,strong,nullable) NSString<Optional> *has_trunk;

@property (nonatomic ,strong,nullable) NSString<Optional> *seedling_type;

@property (nonatomic ,strong,nullable) NSString<Optional> *a_require;
@property (nonatomic ,strong,nullable) NSString<Optional> *size;
@property (nonatomic ,strong,nullable) NSString<Optional> *safeguard;
@property (nonatomic ,strong,nullable) NSString<Optional> *soil_ball_size;
@property (nonatomic ,strong,nullable) NSString<Optional> *subsoil;
@property (nonatomic ,strong,nullable) NSString<Optional> *hx_user_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,strong,nullable) NSArray<Optional> *imageArr;

@property (nonatomic ,strong,nullable) NSString<Optional> *nursery_address;//地址

@property (strong, nonatomic) NSNumber <Ignore> *cellHeigh;

@property (nonatomic ,strong,nullable) NSString<Optional> *unit;//单位

@property(nonatomic,strong,nullable)NSString<Optional> *hint;//错误提示
@end



@interface MyNerseryModel : MTModel//我发布的苗木云
@property (nonatomic ,assign) NSInteger status;//苗木信息状态，0审核通过，1审核失败，2待审核

@property (nonatomic ,strong,nullable) NSString<Optional> *unit;//数量的单位

@property (nonatomic ,strong,nullable) NSString<Optional> *location;//地区

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *loading_price;//装车价

@property (nonatomic ,strong,nullable) NSString<Optional> *show_pic;//图片

@property (nonatomic ,strong,nullable) NSString<Optional> *plant_name;//品种名

@property (nonatomic ,assign) NSInteger num;//数量

@property (nonatomic ,assign) NSInteger nursery_id;

//-(instancetype)initWitListModel:(NurseryListModel *)model;

@end


@interface NewsSearchModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *img_type;//资讯类型
@property (nonatomic ,strong,nullable) NSString<Optional> *info_id;//资讯id
@property (nonatomic ,strong,nullable) NSString<Optional> *info_title;//
@property (nonatomic ,strong,nullable) NSString<Optional> *info_title_html;//
@end



@interface CouponListModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *amount;//消耗积分
@property (nonatomic ,strong,nullable) NSString<Optional> *buyStatus;//抢购状态 0 已抢光  1 可抢购
@property (nonatomic ,strong,nullable) NSString<Optional> *couponHour;//有效时间
@property (nonatomic ,strong,nullable) NSString<Optional> *couponNumber;//
@property (nonatomic ,strong,nullable) NSString<Optional> *endTime;//结束时间
@property (nonatomic ,strong,nullable) NSString<Optional> *Id;//id
@property (nonatomic ,strong,nullable) NSString<Optional> *name;//优惠卷名
@property (nonatomic ,strong,nullable) NSString<Optional> *startTime;//
@property (nonatomic ,strong,nullable) NSString<Optional> *status;//状态 0 已开始  1 未开始  2 已结束
@property (nonatomic ,strong,nullable) NSString<Optional> *sysTime;//当前时间
@property (nonatomic ,strong,nullable) NSString<Optional> *type;//1 个人 2企业
@property (nonatomic ,strong,nullable) NSString<Optional> *userStatus;//0 未抢购，1 已抢购
@property (assign, nonatomic) BOOL couponStatus;//状态   fale 未开始  true 已开始
@property(nonatomic,strong,nullable)NSString <Optional>*buyTime;//开抢时间

@end






@interface HomePageModel : MTModel
@property(nonatomic,assign)NSInteger rowIndex; //当前行
@property(nonatomic,strong)NSMutableArray *hotArray; //数据
@property(nonatomic,assign)NSInteger currentIndex ;//当前行对象

-(instancetype)initWithIndex:(NSInteger)index
           DataArr:(NSArray *)arr;
@end

@interface HomeInformationModel : HomePageModel  //资讯

@end

@interface HomeZhanLueQiYeModel : HomePageModel  //战略企业

@end

@interface HomeXinPinzhongeModel : HomePageModel  //新品种

@end

@interface HomeVarietiesModel : HomePageModel //品种

@end

@interface HomeCompanyModel : HomePageModel //企业

@end

@interface HomeContactsModel : HomePageModel //人脉

@end



@interface ScoreHistoryModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *History_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *couponActivitiesId;
@property (nonatomic ,strong,nullable) NSString<Optional> *couponName;
@property (nonatomic ,strong,nullable) NSString<Optional> *amount;
@property (nonatomic ,strong,nullable) NSString<Optional> *couponCode;//
@property (nonatomic ,strong,nullable) NSString<Optional> *startTime;//
@property (nonatomic ,strong,nullable) NSString<Optional> *endTime;//
@property (nonatomic ,strong,nullable) NSString<Optional> *useTime;
@property (nonatomic ,strong,nullable) NSString<Optional> *status;//
@property (nonatomic ,strong,nullable) NSString<Optional> *orderId;
@property (nonatomic ,strong,nullable) NSString<Optional> *couponType;
@property (nonatomic ,strong,nullable) NSString<Optional> *couponHour;
@end


@interface ScoreDetailModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *creditNumber;
@property (nonatomic ,strong,nullable) NSString<Optional> *creditType;
@property (nonatomic ,strong,nullable) NSString<Optional> *creditName;//
@property (nonatomic ,strong,nullable) NSString<Optional> *creditTime;//

@end


@interface FindCarModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *mobile;
@property (nonatomic ,strong,nullable) NSString<Optional> *car_num;//车牌
@property (nonatomic ,strong,nullable) NSString<Optional> *carType_name;//车型

@property (nonatomic ,strong,nullable) NSString<Optional> *hx_user_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *t_province;//出发地

@property (nonatomic ,strong,nullable) NSString<Optional> *car_height;//车宽

@property (nonatomic ,strong,nullable) NSString<Optional> *f_province;//目的地

@property (nonatomic ,strong,nullable) NSString<Optional> *t_city;

@property (nonatomic ,strong,nullable) NSString<Optional> *t_area;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,strong,nullable) NSString<Optional> *f_city;

@property (nonatomic ,strong,nullable) NSString<Optional> *loads;

@property (nonatomic ,strong,nullable) NSString<Optional> *contact_phone;//联系电话

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *f_area;

@property (nonatomic ,strong,nullable) NSString<Optional> *Id;

@property (nonatomic ,strong,nullable) NSString<Optional> *remark;//备注

@property (nonatomic ,strong,nullable) NSString<Optional> *user_id;
@end



@interface OwnerFaBuModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *paymentType;//支付方式

@property (nonatomic ,strong,nullable) NSString<Optional> *goodsTypeName;//货物名称

@property (nonatomic ,strong,nullable) NSString<Optional> *ownerOrderId;

@property (nonatomic ,strong,nullable) NSString<Optional> *placeOfDepartureAddress;//装车地

@property (nonatomic ,strong,nullable) NSString<Optional> *carTypeName;//车辆类型

@property (nonatomic ,strong,nullable) NSString<Optional> *goodsName;//货物名称

@property (nonatomic ,strong,nullable) NSString<Optional> *carTime;//用车时间

@property (nonatomic ,strong,nullable) NSString<Optional> *carloadingMode;//装车方式

@property (nonatomic ,strong,nullable) NSString<Optional> *placeOfDepartureProvince;

@property (nonatomic ,strong,nullable) NSString<Optional> *driverNumber;//跟车人数

@property (nonatomic ,strong,nullable) NSString<Optional> *destinationAddress;

@property (nonatomic ,strong,nullable) NSString<Optional> *destinationProvince;

@property (nonatomic ,strong,nullable) NSString<Optional> *placeOfDepartureCity;

@property (nonatomic ,strong,nullable) NSString<Optional> *placeOfDepartureArea;

@property (nonatomic ,strong,nullable) NSString<Optional> *userheedImageUrl;

@property (nonatomic ,strong,nullable) NSString<Optional> *destinationCity;

@property (nonatomic ,strong,nullable) NSString<Optional> *mobile;

@property (nonatomic ,strong,nullable) NSString<Optional> *pattern;//装车形态

@property (nonatomic ,strong,nullable) NSString<Optional> *goodsWeight;//货物重量

@property (nonatomic ,strong,nullable) NSString<Optional> *preferredModels;

@property (nonatomic ,strong,nullable) NSString<Optional> *userName;

@property (nonatomic ,strong,nullable) NSString<Optional> *destinationArea;

@property (nonatomic ,strong,nullable) NSString<Optional> *goodsType;

@property (nonatomic ,strong,nullable) NSString<Optional> *remark;

@property (nonatomic ,strong,nullable) NSString<Optional> *section;//路段

@property (nonatomic ,strong,nullable) NSString<Optional> *userId;

@property (nonatomic,strong,nullable) NSString <Optional>*carHeight;//车宽

@property(nonatomic,strong,nullable)NSString <Optional>*createTime;


@end

@interface CheYuanModel : MTModel
@property (nonatomic ,strong,nullable) NSString<Optional> *car_height;

@property (nonatomic ,strong,nullable) NSString<Optional> *province;

@property (nonatomic ,strong,nullable) NSString<Optional> *hx_user_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *loads;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,strong,nullable) NSString<Optional> *user_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *carType_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *f_city;

@property (nonatomic ,strong,nullable) NSString<Optional> *contact_phone;

@property (nonatomic ,strong,nullable) NSString<Optional> *city;

@property (nonatomic ,strong,nullable) NSString<Optional> *car_num;

@property (nonatomic ,strong,nullable) NSString<Optional> *t_area;

@property (nonatomic ,strong,nullable) NSString<Optional> *t_address;

@property (nonatomic ,strong,nullable) NSString<Optional> *f_province;

@property (nonatomic ,strong,nullable) NSString<Optional> *Id;

@property (nonatomic ,strong,nullable) NSString<Optional> *t_province;

@property (nonatomic ,strong,nullable) NSString<Optional> *mobile;

@property (nonatomic ,strong,nullable) NSString<Optional> *driving_user_num;

@property (nonatomic ,strong,nullable) NSString<Optional> *area;

@property (nonatomic ,strong,nullable) NSString<Optional> *update_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *t_city;

@property (nonatomic ,strong,nullable) NSString<Optional> *f_area;

@property (nonatomic ,strong,nullable) NSString<Optional> *f_address;

@property (nonatomic ,strong,nullable) NSString<Optional> *remark;

@property (nonatomic ,strong,nullable) NSString<Optional> *car_type;

@property (nonatomic ,strong,nullable) NSString<Optional> *user_name;

@end



NS_ASSUME_NONNULL_END


