//
//  SMConfig.m
//  SMAirlineTickets
//
//  Created by yaoyongping on 12-5-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IHBaseConfig.h"


#ifdef Production

#ifdef APP_MiaoTu

NSString* APP_KEY = @"1001";

NSString *serverURL=@"http://101.201.31.194:18081/zmh/"; //测试环境

NSString *shareURL=@"https://www.miaoto.net/zmh/H5Page/";

NSString *dwonShareURL=@"http://www.miaoto.net/zmh/pc/recommend/index.html?appkey=1001";//推荐下载

//#elif defined APP_YiLiang
//NSString* APP_KEY = @"1002";
//
//
//NSString *serverURL=@"http://test.miaoto.net/zmh/"; //测试环境
//
//NSString *shareURL=@"http://test.miaoto.net:8080/zmh/H5Page/";
//
//NSString *dwonShareURL=@"http://test.miaoto.net/zmh/pc/recommend/index.html?appkey=1002";//推荐下载
//
#endif

#else

#ifdef APP_MiaoTu

NSString* APP_KEY = @"1001";
NSString *serverURL=@"https://www.miaoto.net/zmh/"; //正式环境
NSString *shareURL=@"https://www.miaoto.net/zmh/H5Page/";
//NSString *ImageURL=@"http://img.weiyoutongcheng.com";
NSString *dwonShareURL=@"https://www.miaoto.net/zmh/pc/recommend/index.html?appkey=1001";//推荐下载

//#elif defined APP_YiLiang
//NSString* APP_KEY = @"1002";
//NSString *serverURL=@"https://www.miaoto.net/zmh/"; //正式环境
//NSString *shareURL=@"https://www.miaoto.net/zmh/H5Page/";
////NSString *ImageURL=@"http://img.weiyoutongcheng.com";
//NSString *dwonShareURL=@"https://www.miaoto.net/zmh/pc/recommend/index.html?appkey=1002";//推荐下载
//
#endif


#endif

//NSString* ServiceTelNumber=@"01059117777";

@implementation IHBaseConfig

static IHBaseConfig *_config;

+(IHBaseConfig *)config{
	@synchronized(self){
		if (_config==nil) {
			_config=[[IHBaseConfig alloc] init];
		}
	}
	return _config;
}

- (NSDictionary *)returnRoot
{
	NSString *path=[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	NSDictionary *root=[[NSDictionary alloc] initWithContentsOfFile:path];
	return root;
}

-(NSDictionary *)returnroot{
	NSString *path=[[NSBundle mainBundle] pathForResource:@"weatherCityList" ofType:@"plist"];
	NSDictionary *root=[[NSDictionary alloc] initWithContentsOfFile:path];
	return root;
}

#pragma mark 得到天气地址数据
-(NSDictionary *)getCityweatherList
{
	NSDictionary * root = [self returnroot];
	NSDictionary *data=[[NSDictionary alloc] initWithDictionary:[root objectForKey:@"cityweather"]];
	return data;
}

#pragma 得到本地tabbar 数据
-(NSArray *)getMainConfigList;
{
	
	NSDictionary * root = [self returnRoot];
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"MainTabBar"]];
	return data;
}

#pragma mark 得到本地我的界面数据
//-(NSArray *)getMeList
//{
//    NSDictionary * root = [self returnRoot];
//
//#ifdef APP_MiaoTu
//
//   NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"MElistView"]];
//
//#elif defined APP_YiLiang
//
//    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"MElistView - YL"]];
//
//#endif
//
//    return data;
//}

#pragma mark 得到行业数据
//-(NSArray *)getIndustryList
//{
//    NSDictionary * root = [self returnRoot];
//    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"IndustryPickView"]];
//    return data;
//}

#pragma mark 设置
-(NSArray *)getSettingView
{
	NSDictionary * root = [self returnRoot];
	
	
#ifdef APP_MiaoTu
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"SettingView"]];
#elif defined APP_YiLiang
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"SettingViewYL"]];
	
#endif
	
	return data;
}

#pragma mark举报
-(NSArray*)getReportArray{
	NSDictionary * root = [self returnRoot];
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"ReportArray"]];
	return data;
}

//首页板块分类
-(NSArray *)getHomePageCategoryList{
	NSDictionary *root=[self returnRoot];
	NSArray *data=[[NSArray alloc]initWithArray:[root objectForKey:@"HomePageCategoryList"]];
	return data;
}

//获取DataPlist数组内容
//-(NSArray *)getDataPlistArrayInput:(NSString *)plistStr{
//    NSDictionary *root=[self returnRoot];
//    NSArray *data=[[NSArray alloc]initWithArray:[root objectForKey:plistStr]];
//    return data;
//}

//物流司机的认证信息DirverInforamation
-(NSArray *)getDirverInforamationList{
	NSDictionary *root=[self returnRoot];
	NSArray *data=[[NSArray alloc]initWithArray:[root objectForKey:@"DirverInforamation"]];
	return data;
}



//分享平台
-(NSArray *)getShareMenuList{
	NSDictionary * root = [self returnRoot];
	NSArray* data = [root objectForKey:@"ShareMenuList"];
	return data;
}


- (void)countdownSecond:(NSInteger)seconds  returnTitle:(void(^)(NSString *title))returnTitle;
{
	if (self->_timer)
	{
		dispatch_source_cancel(self->_timer);
		//        dispatch_release(_timer);
		self->_timer = nil;
	}
	__block NSInteger timeout = seconds; //倒计时时间
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	self->_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
	dispatch_source_set_timer(self->_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
	dispatch_source_set_event_handler(self->_timer, ^{
		if(timeout<=0){ //倒计时结束，关闭
			dispatch_source_cancel(self->_timer);
			//            dispatch_release(_timer);
			self->_timer = nil;
			dispatch_async(dispatch_get_main_queue(), ^{
				//设置界面的按钮显示 根据自己需求设置
				self.seconds = timeout  ;
				returnTitle(@"-1");
			});
		}else{
			
			int seconds = timeout % 61;
			NSString *strTime = [NSString stringWithFormat:@"%.2d秒后获取", seconds];
			dispatch_async(dispatch_get_main_queue(), ^{
				//设置界面的按钮显示 根据自己需求设置
				self.seconds = timeout  ;
				returnTitle(strTime);
			});
			timeout--;
			
		}
	});
	
	dispatch_resume(self->_timer);
	
	
}


-(UIImage*) createImageWithColor:(UIColor*) color
{
	CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return theImage;
}




-(void)setUserInfiDic:(NSDictionary *)dic{
	NSString *typeID=@"";
	if (![dic[@"i_type_id"] isEqual:[NSNull null]]) {
		typeID=dic[@"i_type_id"];
	}
	NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys: dic[@"addressInfo"][@"company_province"],@"company_province",
						dic[@"addressInfo"][@"company_city"],@"company_city",
						dic[@"addressInfo"][@"company_area"],@"company_area",
						dic[@"addressInfo"][@"company_street"],@"company_street"
						, nil];
	
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						dic[@"authorization"],@"authorization",
						dic[@"heed_image_url"],@"heed_image_url",
						dic[@"company_name"],@"company_name",
						dic[@"company_id"],@"company_id",
						dic[@"department"],@"department",
						dic[@"hx_password"],@"hx_password",
						dic[@"nickname"],@"nickname",
						dic[@"email"],@"email",
						dic[@"job_name"],@"job_name",
						dic[@"fansNum"],@"fansNum",
						dic[@"followNum"],@"followNum",
						dic[@"job_type"],@"job_type",
						dic[@"address"],@"address",
						dic[@"mobile"],@"mobile",
						stringFormatString(dic[@"user_authentication"]),@"user_authentication",
						dic[@"business_direction"],@"business_direction",//主营
						dic[@"brief_introduction"],@"brief_introduction",//简介
						dic[@"identity_key"],@"identity_key",
						stringFormatString(dic[@"sexy"]),@"sexy",
						stringFormatString(dic[@"user_id"]),@"user_id",
						dic[@"user_name"],@"user_name",
						typeID,@"i_type_id",
						dic[@"position"],@"position",
						dic1,@"addressInfo",
						dic[@"landline"],@"landline",
						stringFormatString(dic[@"identity_key"]),@"identity_key",
						dic[@"business_license_url"],@"business_license_url",
						dic[@"map_callout"],@"map_callout",
						dic[@"myUserIdentityKeyList"],@"myUserIdentityKeyList",
						nil];
	
	[IHUtility saveDicUserDefaluts:dic2 key:kUserDefalutLoginInfo];
}


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
							 addressInfo:(NSDictionary *)addressInfo
{
	NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
					   stringFormatInt(user_id),@"user_id",
					   [self returnString:user_name],@"user_name",
					   [self returnString:company_name],@"company_name",
					   password,@"password",
					   [self returnString:nickname],@"nickname",
					   [self returnString:address],@"address",
					   [self returnString:hx_password],@"hx_password",
					   [self returnString:mobile],@"mobile",
					   [self returnString:landline],@"landline",
					   [self returnString:email],@"email",
					   stringFormatInt([self returnInteger:i_type_id]),@"i_type_id",
					   stringFormatInt([self returnInteger:sexy]),@"sexy",
					   [self returnString:business_direction],@"business_direction",
					   stringFormatInt([self returnInteger:user_authentication]),@"user_authentication",
					   stringFormatInt([self returnInteger:identity_key]),@"identity_key",
					   [self returnString:heed_image_url],@"heed_image_url",
					   [self returnString:brief_introduction],@"brief_introduction",
					   [self returnString:position],@"position",
					   addressInfo,@"addressInfo",
					   [self returnString:wx_key],@"wx_key",
					   [self returnString:business_license_url],@"business_license_url",
					   stringFormatInt([self returnInteger:map_callout]),@"map_callout",
					   nil];
	return dic;
	
	
}

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
							company_street:(NSString *)company_street

{
	NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
					   stringFormatInt([self returnInteger:user_id]),@"user_id",
					   [self returnString:country],@"country",
					   [self returnString:area],@"area",
					   [self returnString:street],@"street",
					   stringFormatDouble([self returnDoule:longitude]) ,@"longitude",
					   stringFormatDouble([self returnDoule:latitude]),@"latitude",
					   stringFormatDouble([self returnDoule:company_lon]),@"company_lon",
					   stringFormatDouble([self returnDoule:company_lat]),@"company_lat",
					   stringFormatDouble([self returnDoule:distance]),@"distance",
					   [self returnString:company_province],@"company_province",
					   [self returnString:company_city],@"company_city",
					   [self returnString:company_area],@"company_area",
					   [self returnString:company_street],@"company_street",
					   nil];
	return dic;
	
}

-(NSString *)returnString:(NSString *)str
{
	if (!str) {
		return @"";
	}
	return str;
}

-(int)returnInteger:(int)inter
{
	if (!inter) {
		return 0;
	}
	return inter;
}

-(CGFloat)returnDoule:(CGFloat)Float
{
	if (!Float) {
		return 0;
	}
	return Float;
}


#pragma mark 得到本地身份列表数据
-(NSArray *)getIdentList1
{
	NSDictionary * root = [self returnRoot];
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"IdentListView"]];
	return data;
}

#pragma mark 首页列表
-(NSArray *)getHomePageListView
{
	NSDictionary * root = [self returnRoot];
	
#ifdef APP_MiaoTu
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"HomePageListView_1"]];
#elif defined APP_YiLiang
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"HomePageListView_YL"]];
	
#endif
	return data;
	
}


#pragma mark 企业名片申请
-(NSArray *)getEPCloudCumlativeList
{
	NSDictionary * root = [self returnRoot];
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"EPCloudCumlativeList"]];
	return data;
}


#pragma mark 企业性质
-(NSArray *)getCompanyNature{
	NSDictionary * root = [self returnRoot];
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"CompanyNature"]];
	return data;
	
}


#pragma mark 企业编辑基本信息
-(NSArray *)getEPCloudEditList
{
	NSDictionary * root = [self returnRoot];
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"EPCloudEditListView"]];
	return data;
	
}
#pragma mark 首页模块
//-(NSArray *)getHomePageImageList
//{
//    NSDictionary *root=[self returnRoot];
//    NSArray *data=[[NSArray alloc]initWithArray:[root objectForKey:@"HomePageImageList"]];
//    return data;
//}



#pragma mark 我的任务列表
-(NSArray *)getMyTaskInfo
{
	NSDictionary * root = [self returnRoot];
	NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"myTask"]];
	return data;
}

#pragma mark 苗木云参数
-(NSArray *)getSeedCloudInfoList
{
	NSDictionary * root = [self returnRoot];
	
	NSArray *data = [[NSArray alloc] initWithArray:[root objectForKey:@"SeedCloudInfoList"]];
	
	return data;
}

#pragma mark 天气图片
- (NSDictionary *)getWeatherImage
{
	NSString *path=[[NSBundle mainBundle] pathForResource:@"weatherCityList" ofType:@"plist"];
	NSDictionary *root=[[NSDictionary alloc] initWithContentsOfFile:path];
	NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[root objectForKey:@"weathImageList"]];
	return dic;
}

#pragma mark 获取发布苗木云必要参数
- (NSDictionary *)getSendMiaoMuYunParameter
{
	NSDictionary * root = [self returnRoot];
	
	NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[root objectForKey:@"SendSeedInfo"]];
	return dic;
}
@end

