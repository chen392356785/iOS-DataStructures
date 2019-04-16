//
//  MTModel.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IHParamModel.h"
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@class UserChildrenInfo;
@interface MTModel : JSONModel

@end

@interface ProvinceModel : MTModel
@property(nonatomic,strong)NSString *province;
@end

@interface SectionModel : MTModel
@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, strong) NSString *headerTitle;
@end

@interface MTTopicListModel : MTModel
@property(nonatomic,strong)UserChildrenInfo *userChildrenInfo;
@property(nonatomic,strong)NSString *topic_content;
@property(nonatomic,strong)NSString *topic_id;
@property(nonatomic,strong)NSString *topic_url;
@property(nonatomic,assign)BOOL hasClickLike;   // 是否点赞
@property(nonatomic,assign)BOOL hasCollection;   //是否喜欢
@property(nonatomic,assign)int clickLikeTotal; // 喜欢总数
@property(nonatomic,assign)int collectionTotal; //收藏总数
@property(nonatomic,assign)int commentTotal; //评论总数
@property(nonatomic,assign)int shareTotal; //分享总数
@property(nonatomic,strong)NSString *uploadtime;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSMutableArray <Optional>*imgArray; // 数组图片
@property (strong, nonatomic) NSNumber <Ignore> *cellHeigh;
@property(nonatomic,strong)NSNumber <Ignore> *bodyHeigh;
@end

@interface MTPhotosModel : MTModel

@property(nonatomic,strong)NSString *thumbUrl ;  //缩略图
@property(nonatomic,assign)CGFloat imgWidth;
@property(nonatomic,assign)CGFloat imgHeigh;
@property(nonatomic,strong)NSString *imgUrl; //原图
-(id)initWithDic:(NSDictionary *)dic;
-(id)initWithUrlDic:(NSDictionary *)dic;
@end


@interface MTSupplyListModel : JSONModel
@property(nonatomic,strong)NSString *branch_point;//分枝点
@property(nonatomic,strong)NSString *company_name;
@property(nonatomic,strong)NSString *crown_width_e;//冠幅
@property(nonatomic,strong)NSString *crown_width_s;
@property(nonatomic,strong)NSString *heed_image_url;
@property(nonatomic,strong)NSString *height_e;//高度
@property(nonatomic,strong)NSString *height_s;
@property(nonatomic,strong)NSString *i_type_id;//行业id
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *number;//数量
@property(nonatomic,strong)NSString *rod_diameter;//杆径
@property(nonatomic,strong)NSString *seedling_source_address;//苗源所在地
@property(nonatomic,strong)NSString *selling_point;//描述
@property(nonatomic,strong)NSString *sexy;
@property(nonatomic,strong)NSString *supply_id;//供应主键id
@property(nonatomic,strong)NSString *supply_url;//图片url 保存图片url
@property(nonatomic,strong)NSString *unit_price;//单价
@property(nonatomic,strong)NSString *uploadtime;//上传时间
@property(nonatomic,strong)NSString *user_authentication;//用户地址
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *varieties;//品种名
@end

@interface UserModel : JSONModel

@end

@interface MTBuyListModel : JSONModel
@property(nonatomic,strong)NSString *branch_point;//分枝点
@property(nonatomic,strong)NSString *company_name;
@property(nonatomic,strong)NSString *crown_width_e;//冠幅
@property(nonatomic,strong)NSString *crown_width_s;
@property(nonatomic,strong)NSString *heed_image_url;
@property(nonatomic,strong)NSString *height_e;//高度
@property(nonatomic,strong)NSString *height_s;
@property(nonatomic,strong)NSString *i_type_id;//行业id
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *number;//数量
@property(nonatomic,strong)NSString *rod_diameter;//杆径
@property(nonatomic,strong)NSString *seedling_source_address;//苗源所在地
@property(nonatomic,strong)NSString *selling_point;//描述
@property(nonatomic,strong)NSString *sexy;
@property(nonatomic,strong)NSString *want_buy_id;//供应主键id
@property(nonatomic,strong)NSString *want_buy_url;//图片url 保存图片url
@property(nonatomic,strong)NSString *uploadtime;//上传时间
@property(nonatomic,strong)NSString *user_authentication;//用户地址
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *varieties;//品种名
@property(nonatomic,strong)NSString *mining_area;//采苗区域
@property(nonatomic,strong)NSString *payment_methods_dictionary_id;//付款方式
@property(nonatomic,strong)NSString *urgency_level_id;//紧急程度
@property(nonatomic,strong)NSString *use_mining_area;//用苗区域

@end



@interface MTSupplyAndBuyListModel : JSONModel

@property(nonatomic,strong)UserChildrenInfo <Optional>*userChildrenInfo;
@property(nonatomic,strong)NSString *number;//数量
@property(nonatomic,assign)CGFloat branch_point;//分枝点
@property(nonatomic,assign)CGFloat rod_diameter;//杆径
@property(nonatomic,assign)int clickLikeTotal;     //点赞总数
@property(nonatomic,assign)int collectionTotal;    //喜欢总数
@property(nonatomic,assign)int commentTotal;  //评论总数
@property(nonatomic,assign)CGFloat crown_width_e;//冠幅
@property(nonatomic,assign)CGFloat crown_width_s;
@property(nonatomic,assign)CGFloat height_e;//高度  、、结束
@property(nonatomic,assign)CGFloat height_s;   //开始
@property(nonatomic,assign)BOOL hasClickLike;       // s是否点赞
@property(nonatomic,assign)BOOL hasCollection;   //是否喜欢
@property(nonatomic,strong)NSString *selling_point;//描述
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *uploadtime;//上传时间
@property(nonatomic,strong)NSString *varieties;//品种名


//非共用

@property(nonatomic,strong)NSMutableArray <Optional>*imgArray; // 数组图片
@property (strong, nonatomic) NSNumber <Ignore> *cellHeigh;   //cell高度
@property (strong, nonatomic) NSNumber <Ignore> *bodyHeigh;  //中间试图高度

@property(nonatomic,strong)NSString <Optional>*mining_area;//求购采苗区域
@property(nonatomic,strong)NSString <Optional>*payment_methods_dictionary_id;//求购付款方式
@property(nonatomic,strong)NSString <Optional>*urgency_level_id;//求购紧急程度
@property(nonatomic,strong)NSString <Optional>*use_mining_area;//求购用苗区域
@property(nonatomic,strong)NSString <Optional>*want_buy_id;//求购主键id
@property(nonatomic,strong)NSString <Optional>*want_buy_url;//求购图片url 保存图片url


@property(nonatomic,strong)NSString <Optional>*seedling_source_address;//供应苗源所在地
@property(nonatomic,strong)NSString <Optional>*supply_id;//供应主键id
@property(nonatomic,strong)NSString <Optional>*supply_url;//供应图片url 保存图片url
@property(nonatomic,strong)NSString <Optional>*unit_price;//供应单价
@end
















@class ExperienceinfoModel;
@interface MTNearUserModel : JSONModel
@property(nonatomic,strong)NSMutableArray <Optional>*userIdentityKeyList;
@property(nonatomic,strong)NSString <Optional>*position;
@property(nonatomic,strong)NSIndexPath <Optional>*indexPath;
@property(nonatomic,strong)NSString *address;//用户地址
@property(nonatomic,strong)ExperienceinfoModel <Optional>*experience_info;
@property(nonatomic,strong)NSString *company_name;
@property(nonatomic,strong)NSString *heed_image_url;
@property(nonatomic,strong)NSString *hx_password;//环信密码
@property(nonatomic,strong)NSString *i_type_id;//行业id
@property(nonatomic,strong)NSString <Optional>*identity_key;//认证类型
@property(nonatomic,strong)NSString *register_time;//注册时间
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *nickname;//昵称
@property(nonatomic,strong)NSString *sexy;
@property(nonatomic,strong)NSString *user_authentication;//是否认证
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *landline;//座机
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *hx_user_name;
@property(nonatomic,strong)NSString *business_direction;//主营
@property(nonatomic,strong)NSString *authorization;
@property(nonatomic,strong)UserChildrenInfo <Optional>*addressInfo;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *isVip;
@end





@interface ExperienceinfoModel : JSONModel
@property(nonatomic,strong)NSString *consumption_value;
@property(nonatomic,strong)NSString *behavior_value;
@property(nonatomic,strong)NSString *residual_value;
@property(nonatomic,strong)NSString *user_id;
@end








@interface UserChildrenInfo : JSONModel
@property(nonatomic,strong)NSString <Optional>*position;
@property(nonatomic,strong)NSString <Optional>*company_name;
@property(nonatomic,strong)NSString <Optional>*company_area;
@property(nonatomic,strong)NSString <Optional>*company_city;
@property(nonatomic,strong)NSString <Optional>*company_street;
@property(nonatomic,strong)NSString <Optional>*heed_image_url;
@property(nonatomic,strong)NSNumber <Optional> *i_type_id;//行业id
@property(nonatomic,strong)NSString <Optional>*nickname;
@property(nonatomic,strong)NSNumber <Optional> *sexy;
@property(nonatomic,strong)NSString <Optional>*user_authentication; //用户评级
@property(nonatomic,strong)NSString <Optional>*a_id;
@property(nonatomic,strong)NSString <Optional>*user_id;
@property(nonatomic,strong)NSString <Optional>*city;
@property(nonatomic,strong)NSString <Optional>*hx_user_name;  // 环信id
@property(nonatomic,strong)NSString <Optional>*company_province;//省份
@property(nonatomic,strong)NSString <Optional>*province;
@property(nonatomic,strong)NSString <Optional>*identity_key;//认证类型
@property(nonatomic,strong)NSString <Optional>*mobile;
@property(nonatomic,strong)NSString <Optional>*country;
@property(nonatomic,strong)NSString <Optional>*area;
@property(nonatomic,strong)NSString <Optional>*street;
@property(nonatomic,strong)NSString <Optional>*longitude;
@property(nonatomic,strong)NSString <Optional>*latitude;
@property(nonatomic,strong)NSString <Optional>*company_lon;
@property(nonatomic,strong)NSString <Optional>*company_lat;
@property(nonatomic,strong)NSString <Optional>*viewTime;
@property(nonatomic,strong)NSString <Optional>*email;
@property(nonatomic,strong)NSString <Optional>*distance;
@property(nonatomic,strong)NSString <Optional>*landline;//座机
@property(nonatomic,strong)NSString <Optional>*business_direction;//主营
@property(nonatomic,strong)NSString <Optional>*address;
@property(nonatomic,strong)NSString <Optional>*department;
@property(nonatomic,strong)NSString <Optional>*fansNum;
@property(nonatomic,strong)NSString <Optional>*title;
@property(nonatomic,strong)NSString <Optional>*isVip;//是否为vip
-(id)initWithDic:(NSDictionary *)dic;
-(id)initWithModel:(MTNearUserModel *)model;
@end


@interface CommentListModel : JSONModel
@property(nonatomic,strong)UserChildrenInfo *userChildrenInfo;
@property(nonatomic,assign)int  busness_id;  //业务id
@property(nonatomic,strong)NSString *comment_cotent;  // 评论内容
@property(nonatomic,assign)int comment_id;
@property(nonatomic,strong)NSString *comment_time;  //评论时间
@property(nonatomic,assign)int comment_type;  //评论类型
@property(nonatomic,assign)int reply_comment_id;  //回复 评论的ID
@property(nonatomic,strong)NSString *reply_nickname; //评论回复人 昵称
@property(nonatomic,assign)int reply_user_id;   //回复用户ID

@property (strong, nonatomic) NSNumber <Ignore> *cellHeigh;   //cell高度
@end


@interface MyCollectionSupplyAndBuyModel : JSONModel  //我的收藏
@property(nonatomic,strong)NSString *collectionTime; // 收藏时间
@property(nonatomic,strong)MTSupplyAndBuyListModel *supplyBuyInfo;
@end

@interface MyCollectionTopicModel : JSONModel
@property(nonatomic,strong)NSString *collectionTime; // 收藏时间
@property(nonatomic,strong)MTTopicListModel *topicInfo;
@end

@interface ChildrenCommentModel : JSONModel
@property(nonatomic,strong)NSString *comment;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,assign)int user_id;
@end

@interface MTCommentMeModel : JSONModel
@property(nonatomic,assign)int busness_id;
@property(nonatomic,assign)int comment_id;

@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *comment_c;

@property(nonatomic,strong)NSString *comment_time;
@property(nonatomic,assign)int comment_type;
@property(nonatomic,strong)NSString *content_url;
@property(nonatomic,strong)NSString *busness_cotent;
@property(nonatomic,strong)NSString *varieties;
@property(nonatomic,strong)ChildrenCommentModel *childrenComments;
@property(nonatomic,strong)UserChildrenInfo *userInfo;
@property (strong, nonatomic) NSNumber <Ignore> *cellHeigh;   //cell高度
@property(nonatomic,strong)NSMutableArray <Optional>*imgArray; // 数组图片
@end


@interface NewsImageModel : JSONModel
@property (nonatomic,assign)int height;//图片高度
@property (nonatomic,assign)int width;
@property(nonatomic,strong)NSString *img_path;
@property(nonatomic,strong)NSString <Optional>*descriptionStr;

@end


@interface NewsListModel : JSONModel
@property(nonatomic,strong)NSMutableArray <Optional>*imgArray; // 数组图片
@property (nonatomic,assign)NSInteger commentTotal;//p评论次数
@property (nonatomic,assign)int hasCollection;//是否收藏
@property (nonatomic,assign)int img_type; //种类
@property (nonatomic,strong)NSString <Optional>* info_content;  //资讯内容
@property (nonatomic,strong)NSString <Optional>* info_from;     //来源
@property (nonatomic,assign)int info_id;
@property (nonatomic,strong)NSString <Optional>* info_title;
@property (nonatomic,strong)NSString <Optional>* info_url; // 数组图片
@property (nonatomic,strong)NSString <Optional>* uploadtime;
@property (nonatomic,assign)int view_Total;
@property (nonatomic,strong)NSString <Optional>* infomation_url;
@property (nonatomic,strong)NSString <Optional>* infomation_desc;//资讯描述
@property (strong, nonatomic) NSNumber <Ignore> *cellHeigh;
@property(nonatomic,strong)NSString <Optional>*label_name;
@property (nonatomic,strong) NSArray <Optional>*imgModels;
@property(nonatomic,strong)NSString <Optional>*label_bg_color;
@property(nonatomic,strong)NSString <Optional>*label_color;
@property(nonatomic,strong)NSString <Optional>*detail_url;
//-(id)initWithDic:(NSDictionary *)dic;
@end



//活动列表 - 众筹支持
@protocol zcouListModelModel <NSObject>
@end
@interface zcouListModelModel :JSONModel
@property (nonatomic,strong)NSString <Optional>* record_id;
@property (nonatomic,strong)NSString <Optional>* crowd_id;
@property (nonatomic,strong)NSString <Optional>* head_image;
@property (nonatomic,strong)NSString <Optional>* openid;
@property (nonatomic,strong)NSString <Optional>* nickname;
@property (nonatomic,strong)NSString <Optional>* message;
@property (nonatomic,strong)NSString <Optional>* pay_amount;
@property (nonatomic,strong)NSString <Optional>* order_no;
@property (nonatomic,strong)NSString <Optional>* pay_no;
@property (nonatomic,strong)NSString <Optional>* app_id;
@property (nonatomic,strong)NSString <Optional>* mch_id;
@property (nonatomic,strong)NSString <Optional>* mch_secret;

@property (nonatomic,strong)NSString <Optional>* order_type;
@property (nonatomic,strong)NSString <Optional>* order_status;

@property (nonatomic,strong)NSString <Optional>* user_id;
@property (nonatomic,strong)NSString <Optional>* create_time;
@property (nonatomic,strong)NSString <Optional>* bili;
@property (nonatomic,strong)NSString <Optional>* remark;
@property (nonatomic,strong)NSString <Optional>* obtain_money;
@property (nonatomic,strong)NSString <Optional>* total_money;
@property (nonatomic,strong)NSString <Optional>* team_name;
@property (nonatomic,strong)NSString <Optional>* talk;
@property (nonatomic,strong)NSString <Optional>* zhongchouPeople;
@property (nonatomic,copy) NSString <Optional>*huifu;//回复
@property (nonatomic,strong)NSString <Optional>*huifu_name;//回复人
@property (nonatomic,strong)NSString <Optional>*is_hide; //0不隐藏  1隐藏

@end

//活动列表 - 活动限制
@protocol KeyListModel <NSObject>
@end
@interface KeyListModel :JSONModel
@property (nonatomic,strong)NSString <Optional>* key;       //活动限额
@property (nonatomic,strong)NSString <Optional>* value;     //人数
@end

//活动列表 - 详情图片
@protocol imageListModel <NSObject>
@end
@interface imageListModel :JSONModel
@property (nonatomic,strong)NSString <Optional>* key;       //活动限额
@property (nonatomic,strong)NSString <Optional>* value;     //人数
@end

//队伍列表 - 选择队伍
@protocol TeamListModel <NSObject>
@end
@interface TeamListModel :JSONModel
@property (nonatomic,strong)NSString <Optional>* activity_id;
@property (nonatomic,strong)NSString <Optional>* create_time;
@property (nonatomic,strong)NSString <Optional>* sort;
@property (nonatomic,strong)NSString <Optional>* team_id;
@property (nonatomic,strong)NSString <Optional>* team_name;
@property (nonatomic,strong)NSString <Optional>* update_time;
@end


//队伍列表 - 宣言列表
@protocol talkListModel <NSObject>
@end
@interface talkListModel :JSONModel
@property (nonatomic,strong)NSString <Optional>* activity_id;
@property (nonatomic,strong)NSString <Optional>* activity_talk;
@property (nonatomic,strong)NSString <Optional>* activity_talk_id;
@end

@protocol ActivitiesListModel <NSObject>
@end

@interface ActivitiesListModel : JSONModel
//活动列表
@property (nonatomic,strong)NSDictionary <Optional>*userinfoDic;
@property (nonatomic,strong)UserChildrenInfo <Optional>*userChildrenInfo;
@property (nonatomic,strong)NSString <Optional>*activities_id;                  //活动id
@property (nonatomic,strong)NSString <Optional> * activities_titile;                       //活动标题
@property (nonatomic,strong)NSString <Optional> * activities_starttime;                    //
@property (nonatomic,strong)NSString <Optional> * activities_endtime;
@property (nonatomic,strong)NSString <Optional> * activities_content;
@property (nonatomic,strong)NSString <Optional> * activities_pic;
@property (nonatomic,strong)NSString <Optional> * pichigth;          //图片高度
@property (nonatomic,strong)NSString <Optional> * picwidth;
@property (nonatomic,strong)NSString <Optional> * activities_expiretime;
@property (nonatomic,strong)NSString <Optional> * activities_ExpireStarttime;       //报名开始
@property (nonatomic,strong)NSString <Optional> * huodong_status;      //1-下架 --0正常
@property (nonatomic,strong)NSString <Optional> * isRefund;      //1-支持退款 --0不支持退款
@property (nonatomic,strong)NSString <Optional> * uploadtime;
@property (nonatomic,strong)NSString <Optional> * activities_contacts;
 @property (nonatomic,strong)NSString <Optional>* contact_phone;
@property (nonatomic,strong)NSString <Optional> * payment_amount;
@property (nonatomic,strong)NSString <Optional>*activities_address_lat;
@property (nonatomic,strong)NSString <Optional>*activities_address_lon;
@property (nonatomic,strong)NSString <Optional>* activities_address;
@property (nonatomic,strong)NSString <Optional>*user_upper_limit_num;
@property (nonatomic,strong)NSString <Optional>*registration_user;
@property (nonatomic,strong)NSString <Optional>* activities_content_text;
@property (nonatomic,strong)NSString <Optional>* html_content;
@property (nonatomic,strong)NSString <Optional>* onlookers_user;
@property (strong, nonatomic) NSNumber <Ignore> *cellHeigh;
@property (nonatomic,strong)NSString <Optional>* shareTotal;
@property (nonatomic,strong)NSString <Optional>* collectionTotal;
@property (nonatomic,strong)NSString <Optional>* clickLikeTotal;//点赞数
@property (nonatomic,strong)NSString <Optional>* commentTotal;
@property (nonatomic,strong)NSString <Optional>* sign_up_num;//报名次数
@property (nonatomic,strong)NSString <Optional>* hasClickLike;//是否点赞
@property (nonatomic,strong)NSString <Optional>* curtime;//截止时间
@property (nonatomic,strong)NSString <Optional>* require_field;
@property (nonatomic,strong)NSString <Optional>* update_time;       //付款时间
@property (nonatomic,strong)NSString <Optional>* hasCollection;//是否点赞
@property (nonatomic,strong)NSString <Optional>*model;//任务类型4->活动，8->众筹，7->投票
@property (nonatomic,strong)NSString <Optional>*crowd_method;   //（0:仅支持众筹;1:支持众筹和自己支付,2自己支持）
@property (nonatomic,strong)NSString <Optional>*zcou;   //支持人数
@property (nonatomic,strong)NSString <Optional>*zccount;//众筹人数
@property (nonatomic,strong)NSString <Optional>*huodongzhuangtai;//活动状态
@property (nonatomic,strong)NSString <Optional>*type;   //1代表众筹2活动
@property (nonatomic,strong)NSString <Optional>*status;
@property (nonatomic,strong)NSString <Optional>*is_xmxs;    //活动详情页下面是否显示
@property (nonatomic,strong)NSString <Optional>*team_name;  //战队名字
@property (nonatomic,strong)NSString <Optional>*talk;;      //宣言

@property (nonatomic,strong)NSString <Optional>*is_zc_goumai;  //1代表支持购买选票 0否
@property (nonatomic,strong)NSString <Optional>*times;;        // 一块钱能购买多少票

@property (nonatomic,strong)NSMutableArray <Optional,KeyListModel> *keyList; //活动限额
@property (nonatomic,strong)NSMutableArray <Optional,imageListModel> *imgList2;                      //活动详情图片列表
@property (nonatomic,strong)NSMutableArray <Optional,zcouListModelModel> *zcouList;  //众筹人数列表限额
@property (nonatomic,strong)NSMutableArray <Optional,zcouListModelModel> *zclist;    //支持人数限额

@property (nonatomic,strong)NSMutableArray <Optional,talkListModel> *talkList;    //支持人数限额

@property (nonatomic,strong)NSMutableArray <Optional,zcouListModelModel> *daiyanren;    //代言人
@property (nonatomic,strong)NSMutableArray <Optional,zcouListModelModel> *zhong;        //众筹中
@property (nonatomic,strong)NSMutableArray <Optional,zcouListModelModel> *wancheng;        //已筹满

@property (nonatomic,strong)NSString <Optional>*team_id;//众筹人数
@property (nonatomic,strong)NSMutableArray <Optional,TeamListModel> *teamList;
@property (nonatomic,strong)NSString <Optional> *is_team;  //战队众筹
@property (nonatomic,strong)NSString <Optional> *is_pop;  //发起众筹是否先支付
@property (nonatomic,strong)NSString <Optional> *pop_money;//众筹先支付金额

//我的活动
@property (nonatomic,strong)NSString <Optional>*user_id;
@property (nonatomic,strong)NSString <Optional>*a_order_id;//订单ID
@property (nonatomic,strong)NSString <Optional>* order_status;//订单状态
@property (nonatomic,strong)NSString <Optional>* activities_uploadtime;
@property (nonatomic,strong)NSString <Optional>* order_num;//订单数量
@property (nonatomic,strong)NSString <Optional>* unit_price;//订单单价
@property (nonatomic,strong)NSString <Optional>* contacts_people;
@property (nonatomic,strong)NSString <Optional>* contacts_phone;
@property (nonatomic,strong)NSString <Optional>* email;
@property (nonatomic,strong)NSString <Optional>* order_no;//订单号
@property (nonatomic,strong)NSString <Optional>* job;
@property (nonatomic,strong)NSString <Optional>* company_name;
@property (nonatomic,strong)NSString <Optional>* crowd_status;//众筹状态
@property (nonatomic,strong)NSString <Optional>* crowd_id;//众筹状态
@property (nonatomic,strong)NSString <Optional>* total_money;
@property (nonatomic,strong)NSString <Optional>* obtain_money;
@end




@interface ThemeListModel : JSONModel

@property (nonatomic,strong)NSString * theme_id;
@property (nonatomic,strong)NSString <Optional>* content_url;
@property (nonatomic,strong)NSString * push_timer;
@property (nonatomic,strong)NSString * theme_content;
@property (nonatomic,strong)NSString * theme_header;
@property (nonatomic,strong)NSString <Optional>* commentTotal_num;

@property (nonatomic,strong)NSString <Optional>* onlookers_user_num;
@end




@interface HomePageTopicModel : JSONModel

@property (nonatomic,strong)NSString * recommend_id;
@property (nonatomic,strong)NSString <Optional>* topic_id;
@property (nonatomic,strong)NSString * show_image;
@property (nonatomic,strong)NSString * recommend_title;
@property (nonatomic,strong)NSString * recommend_desc;
@property (nonatomic,strong)NSString <Optional>* deploy_time;
@property (nonatomic,strong)NSString <Optional>* user_id;
@property(nonatomic,strong)NSString *create_time;
@property(nonnull,strong)NSString *nickname;
@end

@interface NewDetailModel : JSONModel
@property (nonatomic,strong)NSString *html_content;
@property (nonatomic,strong)NSArray *listModel;
@end

@interface EPCloudListModel : JSONModel
@property (nonatomic,strong,nullable)NSArray <Optional>*imageArr;
@property (nonatomic ,strong) NSString <Optional>* company_desc;

@property (nonatomic ,strong,nullable) NSString<Optional> *landline;

@property (nonatomic ,strong,nonnull) NSString<Optional> *nature_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *wechat_num;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_label;

@property (nonatomic ,strong,nullable) NSString<Optional> *short_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *fax;

@property (nonatomic ,strong,nullable) NSString<Optional> *main_business;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_image;

@property (nonatomic ,strong,nullable) NSString<Optional> *i_name;

@property (nonatomic ,assign) NSInteger comment_num;

@property (nonatomic ,assign) NSInteger company_id;

@property (nonatomic ,assign) NSInteger level;

@property (nonatomic ,strong,nullable) NSString<Optional> *email;

@property (nonatomic ,strong,nullable) NSString<Optional> *website;

@property (nonatomic ,strong,nullable) NSString<Optional> *mobile;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_qq;

@property (nonatomic ,strong,nullable) NSArray<Optional> *qualify_list;

@property (nonatomic ,strong,nullable) NSString<Optional> *staff_size;

@property (nonatomic ,strong,nullable) NSString<Optional> *logo;

@property (nonatomic ,strong,nullable) NSString<Optional> *design_lv;

@property (nonatomic ,strong,nullable) NSString<Optional> *project_lv;

@property (nonatomic ,strong,nullable) NSString<Optional> *address;
@end




@interface MTFansModel : JSONModel
@property (nonatomic,strong,nullable)NSString <Optional>*nickname;
@property (nonatomic,strong,nullable)NSString <Optional>*heed_image_url;
@property (nonatomic,strong,nullable)NSString <Optional>* title;
@property (nonatomic,strong,nullable)NSString <Optional>* followStatus;
@property(nonatomic,strong,nullable)NSString <Optional>* follow_id;
@property(nonatomic,strong,nullable)NSString <Optional>* isVip;
@end



@interface MTConnectionModel :JSONModel


@property (nonatomic ,strong,nullable) NSString<Optional> *totalSupplyWantBy;

@property (nonatomic ,strong,nullable) NSString<Optional> *job_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_province;

@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;

@property (nonatomic ,strong,nullable) NSString<Optional> *fansNum;

@property (nonatomic ,strong,nullable) NSArray<Optional> *imgList;

@property (nonatomic ,strong,nullable) NSString<Optional> *follow_id;

@property (nonatomic ,strong,nullable) NSString <Optional> *user_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,strong,nullable) NSString<Optional> *user_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *followStatus;

@property (nonatomic ,strong,nullable) NSString<Optional> *short_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *identity_value;

@property (nonatomic ,strong,nullable) NSString<Optional> *totalSupply;

@property (nonatomic ,strong,nullable) NSString<Optional> *totalWantBy;

@end



@interface MTCompanyModel :JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *company_desc;

@property (nonatomic ,strong,nullable) NSString<Optional> *nature_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *wechat_num;

@property (nonatomic ,strong,nullable) NSString<Optional> *landline;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_label;

@property (nonatomic ,strong,nullable) NSString<Optional> *short_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *fax;

@property (nonatomic ,strong,nullable) NSString<Optional> *main_business;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_image;

@property (nonatomic ,strong,nullable) NSString<Optional> *i_name;

@property (nonatomic ,assign,nullable) NSString<Optional> *comment_num;

@property (nonatomic ,assign,nullable) NSString<Optional> *company_id;

@property (nonatomic ,assign,nullable) NSString<Optional> *level;

@property (nonatomic ,strong,nullable) NSString<Optional> *email;

@property (nonatomic ,strong,nullable) NSString<Optional> *website;

@property (nonatomic ,strong,nullable) NSString<Optional> *mobile;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_qq;

@property (nonatomic ,strong,nullable) NSArray<Optional> *qualify_list;

@property (nonatomic ,strong,nullable) NSString<Optional> *staff_size;

@property (nonatomic ,strong,nullable) NSString<Optional> *logo;

@property (nonatomic ,strong,nullable) NSString<Optional> *address;

@property (nonatomic ,assign) NSInteger status;

@property (nonatomic ,strong,nullable) NSString<Optional> *design_lv;

@property (nonatomic ,strong,nullable) NSString<Optional> *project_lv;
@end




@interface CompanyTrackModel : JSONModel
@property (nonatomic ,assign) NSInteger height_e;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,assign) NSInteger user_id;

@property (nonatomic ,assign) NSInteger news_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *unit_price;

@property (nonatomic ,assign) NSInteger branch_point;

@property (nonatomic ,assign) NSInteger crown_width_s;

@property (nonatomic ,assign) NSInteger crown_width_e;

@property (nonatomic ,assign) NSInteger number;

@property (nonatomic ,assign) NSInteger height_s;

@property (nonatomic ,strong,nullable) NSString<Optional> *varieties;

@property (nonatomic ,strong,nullable) NSString<Optional> *selling_point;

@property (nonatomic ,strong,nullable) NSString<Optional> *uploadtime;

@property (nonatomic ,strong,nullable) NSString<Optional> *type;

@property (nonatomic ,assign) NSInteger rod_diameter;

@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@end


@interface companyListModel : JSONModel
@property (nonatomic ,assign) NSInteger comment_id;

@property (nonatomic ,assign) NSInteger company_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;

@property (nonatomic ,assign) NSInteger anonymous;

@property (nonatomic ,strong,nullable) NSString<Optional> *comment_content;

@property (strong, nonatomic) NSNumber <Ignore> *cellHeigh;//单元格高度

@property (nonatomic ,assign) NSInteger level;

@property (nonatomic ,assign) NSInteger user_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;
@end

@interface InvatedFriendslistModel : JSONModel

@property (nonatomic ,strong,nullable) NSString<Optional> *status;

@property (nonatomic ,assign) NSInteger money;

@property (nonatomic ,assign) NSInteger user_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *user_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;
@end


@interface BindCompanyModel : JSONModel

@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *staff_size;

@property (nonatomic ,assign) NSInteger company_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_label;

@property (nonatomic ,assign) NSInteger level;

@property (nonatomic ,strong,nullable) NSArray<Optional> *qualify_list;

@property (nonatomic ,strong,nullable) NSString<Optional> *short_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *nature_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *logo;

@property (nonatomic ,strong,nullable) NSString<Optional> *i_name;
@end


@interface VoteListModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *head_image;

@property (nonatomic ,strong,nullable) NSString<Optional> *talk;

@property (nonatomic ,assign) NSInteger vote_num;

@property (nonatomic ,assign) NSInteger vote_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *title;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_info;

@property (nonatomic ,strong,nullable) NSString<Optional> *introduct;

@property (nonatomic ,strong,nullable) NSString<Optional> *city;

@property (nonatomic ,assign) NSInteger project_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *project_code;

@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *name;

@property (nonatomic ,strong,nullable) NSString<Optional> *totalNum;

@property (nonatomic ,copy,nullable) NSString<Optional> *times;       //一块钱能买几票

@property (nonatomic ,copy,nullable) NSString<Optional> *buyNote;       //购买说明
@end

@interface CrowdInfoModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *activities_expiretime;
@property(nonatomic,strong,nullable)NSString<Optional> *talk;//活动描述

@property(nonatomic,strong,nullable) NSString<Optional> *activities_intro;

@property (nonatomic ,assign) float total_money;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_pic;

@property (nonatomic ,assign) NSInteger version;

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,assign) NSInteger crowd_method;

@property (nonatomic ,strong,nullable) NSString<Optional> *random_num;

@property (nonatomic ,assign) float unit_price;

@property (nonatomic ,assign) NSInteger activity_id;

@property (nonatomic ,assign) NSInteger crowd_id;

@property (nonatomic ,assign) float obtain_money;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_titile;

@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;

@property (nonatomic ,assign) NSInteger order_num;

@property (nonatomic ,assign) NSInteger status;         //

@property (nonatomic ,assign) NSInteger lock_status;
@property (nonatomic ,copy) NSString *create_time;

@property (nonatomic ,strong,nullable) NSString<Optional> *remark;


@end


@protocol CrowdListModel <NSObject>
@end
@interface CrowdListModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *head_image;
@property (nonatomic ,strong,nullable) NSString<Optional> *openid;
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *message;
@property (nonatomic ,strong,nullable) NSString<Optional> *order_no;
@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;
@property (nonatomic ,assign) NSInteger record_id;
@property (nonatomic ,assign) NSInteger crowd_id;
@property (nonatomic ,assign) float pay_amount;
@property (nonatomic ,assign) NSInteger order_status;

@end

@interface CrowdOrderInfoModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *contacts_phone;

@property (nonatomic ,strong,nullable) NSString<Optional> *curtime;

@property (nonatomic ,assign) NSInteger crowd_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_contact_phone;

@property (nonatomic ,assign) NSInteger a_order_id;

@property (nonatomic ,assign) NSInteger user_id;

@property (nonatomic ,assign) NSInteger order_status;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_expiretime;

@property (nonatomic ,strong,nullable) NSString<Optional> *order_no;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;

@property (nonatomic ,assign) NSInteger crowd_status;

@property (nonatomic ,strong,nullable) NSString<Optional> *payment_amount;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_address;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_endtime;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_starttime;

@property (nonatomic ,assign) NSInteger activities_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_contacts;

@property (nonatomic ,assign) NSInteger activities_address_lat;

@property (nonatomic ,assign) NSInteger activities_address_lon;

@property (nonatomic ,strong,nullable) NSString<Optional> *job;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_uploadtime;

@property (nonatomic ,strong,nullable) NSString<Optional> *email;

@property (nonatomic ,strong,nullable) NSString<Optional> *unit_price;

@property (nonatomic ,strong,nullable) NSString<Optional> *contacts_people;

@property (nonatomic ,assign) NSInteger model;

@property (nonatomic ,strong,nullable) NSString<Optional> *uploadtime;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_content;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_titile;

@property (nonatomic ,strong,nullable) NSString<Optional> *activities_pic;

@property (nonatomic ,assign) NSInteger order_num;

@end



@interface CrowdOrderModel : JSONModel
@property (nonatomic,strong,nullable)CrowdInfoModel *infoModel;
@property (nonatomic,strong,nullable)NSArray <CrowdListModel>*listModels;
@property (nonatomic,strong,nullable)CrowdOrderInfoModel *orderInfoModel;
@property (nonatomic ,strong,nullable) NSString<Optional> *diffDay;//剩余时间
@property (nonatomic,strong,nullable)ActivitiesListModel *selectActivitiesListInfo;
@end

@interface ExperienceNoticeInfoModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *experience_value;
@property (nonatomic ,strong,nullable) NSString<Optional> *experience_msg;
@end
@interface AuthInfoModel : JSONModel
@property (nonatomic ,assign) NSInteger auth_id;
@property (nonatomic ,assign) NSInteger authtype_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *authimage_url;
@property (nonatomic ,assign) NSInteger status;

@end

@interface JionEPCloudInfoModel : JSONModel
@property (nonatomic ,assign) NSInteger user_authentication;
@property (nonatomic ,strong,nullable) NSString<Optional> *user_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *hx_user_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *address;
@property (nonatomic ,strong,nullable) ExperienceNoticeInfoModel<Optional> *experienceNoticeModel;
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,assign) NSInteger sexy;
@property (nonatomic ,assign) NSInteger company_id;
@property (nonatomic ,assign) NSInteger job_type;
@property (nonatomic ,strong,nullable) NSString<Optional> *brief_introduction;
@property (nonatomic ,assign) NSInteger i_type_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *job_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *area;
@property (nonatomic ,strong,nullable) NSString<Optional> *email;
@property (nonatomic ,strong,nullable) NSString<Optional> *hx_password;
@property (nonatomic ,strong,nullable) NSString<Optional> *position;
@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;
@property (nonatomic ,strong,nullable) NSString<Optional> *business_direction;
@property (nonatomic ,assign) NSInteger followNum;
@property (nonatomic ,assign) NSInteger auth_status;
@property (nonatomic ,assign) NSInteger status;
@property (nonatomic ,strong,nullable) UserChildrenInfo<Optional> *addressInfoModel;
@property (nonatomic ,strong,nullable) NSString<Optional> *city;
@property (nonatomic ,assign) BOOL fullInfo;
@property (nonatomic ,strong,nullable) NSString<Optional> *mobile;
@property (nonatomic ,strong,nullable) NSString<Optional> *business_license_url;
@property (nonatomic ,strong,nullable) NSString<Optional> *myUserIdentityKeyList;
@property (nonatomic ,strong,nullable) NSString<Optional> *province;
@property (nonatomic ,assign) NSInteger identity_key;
@property (nonatomic ,assign) NSInteger user_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *authorization;
@property (nonatomic ,assign) NSInteger map_callout;
@property (nonatomic ,strong,nullable) ExperienceinfoModel<Optional> *experienceInfoModel;
@property (nonatomic ,assign) NSInteger fansNum;
@property (nonatomic ,strong,nullable) NSString<Optional> *landline;
@property (nonatomic ,strong,nullable) NSString<Optional> *register_time;
@property (nonatomic ,strong,nullable) AuthInfoModel<Optional> *authInfoModel;
@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *title;
@property (nonatomic ,strong,nullable) NSString<Optional> *password;
@property (nonatomic ,strong,nullable) NSString<Optional> *department;
@property (nonatomic ,strong,nullable) MTCompanyModel<Optional> *companyinfoModel;
@end

@interface EPCloudCompanyModel : JSONModel
@property (nonatomic ,assign) NSInteger company_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *company_name_html;
@property (nonatomic ,strong,nullable) NSString<Optional> *short_name;
@property (nonatomic ,strong,nullable) NSString<Optional> *nature_name;
@end

@interface AskBarDetailModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *form_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *user_title;
@property (nonatomic ,strong,nullable) NSString<Optional> *show_pic;
@property (nonatomic ,strong,nullable) NSString<Optional> *name;
@property (nonatomic ,strong,nullable) NSString<Optional> *user_desc;
@property (nonatomic ,strong,nullable) NSString<Optional> *Description;

@property (nonatomic ,strong,nullable) NSString<Optional> *detailed_pic;
@property (nonatomic ,assign) int questionNum;
@property (nonatomic ,assign) int answerNum;
@property (nonatomic ,assign) int user_id;
@end

//回答
@interface AnswerInfoModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *answer_content;
@property (nonatomic ,strong,nullable) NSString<Optional> *answer_time;
@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *province;
@property (nonatomic ,strong,nullable) NSString<Optional> *answer_id;
@property (nonatomic ,assign) int forum_topic_id;
@property (nonatomic ,assign) int user_id;
@property (nonatomic ,assign) int question_id;
@property (nonatomic ,assign) int click_num;
@property (nonatomic ,assign) int replayNum;
@property (nonatomic ,assign) int isClick;
@end


@interface ReplyProblemListModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *title;
@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;
@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *province;
@property (nonatomic ,strong,nullable) NSString<Optional> *reply_id;
@property (nonatomic ,assign) int forum_topic_id;
@property (nonatomic ,assign) int user_id;


@property (nonatomic ,strong,nullable) AnswerInfoModel<Optional> *infoModel;
@end

@interface AnswerCommentListModel : JSONModel
@property (nonatomic ,strong,nullable) NSString<Optional> *comment_id;
@property (nonatomic ,strong,nullable) NSString<Optional> *comment_content;
@property (nonatomic ,strong,nullable) NSString<Optional> *province;
@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;
@property (nonatomic ,strong,nullable) NSString<Optional> *create_time;
@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;
@property (nonatomic ,assign) int clickNum;
@property (nonatomic ,assign) int user_id;
@property (nonatomic ,assign) int isClick;
@end

NS_ASSUME_NONNULL_END
