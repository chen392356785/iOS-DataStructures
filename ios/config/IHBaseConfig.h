//
//  SMConfig.h
//  SMAirlineTickets
//
//  Created by yaoyongping on 12-5-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
 
#define ConfigManager				[IHBaseConfig config]

#define TestImageURL				@"http://8yyq8.com"
#define upload_url_write             @"https://oss-cn-beijing.aliyuncs.com"
//#define upload_url_write             @"https://img-cn-beijing.aliyuncs.com"

#define VERSION_CODE  @"2"  //测试升级版本的

#define VERSION        @"2.8.1"

//#define smallHeaderImage             @"@!header"
#define smallHeaderImage             @""
#define Production   //不注销，为开启生产环境


#define shareSupply   @"supplies.html?supply_id="
#define shareBuy      @"want.html?want_buy_id="
#define shareTopic     @"topic.html?topic_id="
#define shareActivties     @"activity.html?activities_id="
#define shareEPCloud     @"firmCard.html?id="
#define shareCrowd       @"crowd/index.html?id="
#define shareQuestion       @"forum.html?tid="
#define shareAnswer       @"forum/index-topic.html?aid="
#define shareNursery     @"corporate.html?tid="
#ifdef Production
#define CAMPUS_IMAGE_URL(imagePath)       [@"http://img.weiyoutongcheng.com" stringByAppendingFormat:@"%@", imagePath]    //正式环境

#else
#define CAMPUS_IMAGE_URL(imagePath)       [@"http://182.92.195.95/web" stringByAppendingFormat:@"%@", imagePath]

#endif

extern NSString* serverURL;
extern NSString* LBSServerURL;
//extern NSString* serverURL;
extern NSString* APP_KEY;
extern NSString* APP_SECRET;
extern NSString* CHANNEL_ID;
extern NSString* API_VERSION;
extern NSString *API_BASE_VERSION;
extern NSString* shareURL;
extern NSString* ServiceTelNumber ;
extern NSString* weatherServerURL;
extern NSString* weatherRealTimeServerURL;

 
 
 
extern NSString *dwonShareURL;
@interface IHBaseConfig : NSObject
{
    dispatch_source_t _timer;

}
@property (nonatomic) NSInteger seconds ;
@property(nonatomic,strong)NSString *ImageUrl;  //图片下载地址
@property(nonatomic,strong)NSString *uploadImgUrl ; //图片上传地址
+(IHBaseConfig *)config;
-(NSArray *)getMainConfigList;
-(NSDictionary *)getCityweatherList;
//-(NSArray *)getMeList;
//-(NSArray *)getIndustryList;
-(NSArray *)getSettingView;
-(NSArray *)getIdentList1;
-(NSArray*)getReportArray;//举报列表
//-(NSArray *)getHomePageImageList;//首页模块
-(NSArray *)getMyTaskInfo;//我的任务
-(UIImage*) createImageWithColor:(UIColor*) color;
-(NSArray *)getEPCloudCumlativeList;
-(NSArray *)getDirverInforamationList;
-(NSArray *)getEPCloudEditList;
-(NSArray *)getCompanyNature;

-(NSArray *)getShareMenuList;
-(NSArray *)getSeedCloudInfoList;
#pragma mark 天气图片
- (NSDictionary *)getWeatherImage;

#pragma mark 获取发布苗木云必要参数
- (NSDictionary *)getSendMiaoMuYunParameter;

//首页板块分类
-(NSArray *)getHomePageCategoryList;
//获取DataPlist数组内容
//-(NSArray *)getDataPlistArrayInput:(NSString *)plistStr;
- (void)countdownSecond:(NSInteger)seconds  returnTitle:(void(^)(NSString *title))returnTitle;
-(void)setUserInfiDic:(NSDictionary *)dic;  //保存用户信息
 
-(NSString *)returnString:(NSString *)str;
-(int)returnInteger:(int)inter;
-(CGFloat)returnDoule:(CGFloat)Float;
-(NSArray *)getHomePageListView;
-(NSDictionary *)getUserDicWithUser_name:(NSString *)user_name
                                 user_id:(int)user_id
                            company_name:(NSString *)company_name
                                password:(NSString *)password
                                nickname:(NSString *)nickname
                                 address:(NSString *)address
                             hx_password:(NSString *)hx_password
                                  mobile:(NSString *)mobile
                                landline:(NSString *)landline
                                   email:(NSString *)email
                               i_type_id:(int)i_type_id
                                    sexy:(int)sexy
                      business_direction:(NSString *)business_direction
                     user_authentication:(int)user_authentication
                            identity_key:(int)identity_key
                          heed_image_url:(NSString *)heed_image_url
                      brief_introduction:(NSString *)brief_introduction
                                position:(NSString *)position
                                  wx_key:(NSString *)wx_key
                    business_license_url:(NSString *)business_license_url
                             map_callout:(int)map_callout
                             addressInfo:(NSDictionary *)addressInfo;


-(NSDictionary *)getAddressInfoWithUser_id:(int)user_id
                                   country:(NSString *)country
                                  province:(NSString *)province
                                      city:(NSString *)city
                                      area:(NSString *)area
                                    street:(NSString *)street
                                 longitude:(CGFloat)longitude
                                  latitude:(CGFloat)latitude
                               company_lon:(CGFloat)company_lon
                               company_lat:(CGFloat)company_lat
                                  distance:(CGFloat)distance
                          company_province:(NSString *)company_province
                              company_city:(NSString *)company_city
                              company_area:(NSString *)company_area
                            company_street:(NSString *)company_street;


@end
