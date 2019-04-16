//
//  MTNetworkData.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

//#import "AFNetworking.h"
#import "ServerConfig.h"
#import "NSString+AES.h"
//#import "MTNetworkData.h"
//#import "MTNetworkData+ForModel.h"

@implementation MTNetworkData

static MTNetworkData *_config;

//MARK:init

+(MTNetworkData *)shareInstance{
	@synchronized(self){
		if (_config==nil) {
			_config=[[MTNetworkData alloc] init];
		}
	}
	return _config;
}

/**
 打印网络请求返回结果
 */
static inline void printResponseData(NSDictionary *dic) {
	
#ifdef DEBUG
	NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:NULL];
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"res= %@",jsonString);
#endif
	
}

/**
 打印网络请求参数信息
 */
static inline void printReqeustParams(NSString *service,NSDictionary *dic) {
#ifdef DEBUG
	NSString * parameter;
	if (dic.allKeys.count > 0) {
		parameter = [IHUtility getParameterString:dic];
	}
	NSLog(@"total url:  %@?%@", service, parameter);
#endif
}

+ (AFHTTPSessionManager *) shareSessionManager {
	static AFHTTPSessionManager *_shareSessionManager;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_shareSessionManager = [AFHTTPSessionManager manager];
		_shareSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
		_shareSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
		_shareSessionManager.operationQueue.maxConcurrentOperationCount = 5;
		// 设置超时时间
		[_shareSessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
		_shareSessionManager.requestSerializer.timeoutInterval = 15.f;
		[_shareSessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
		[_shareSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		[_shareSessionManager.requestSerializer setValue:@"4" forHTTPHeaderField:@"device_type"];
		[_shareSessionManager.requestSerializer setValue:VERSION_CODE forHTTPHeaderField:@"version_code"];
		[_shareSessionManager.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"app_key"];
		///手机类型
		[_shareSessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"modelType"];
		///版本信息
		NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
		NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
		[_shareSessionManager.requestSerializer setValue:app_Version forHTTPHeaderField:@"api_version"];
		
#ifdef DEBUG
		[_shareSessionManager.requestSerializer setValue:@"woshiceshi" forHTTPHeaderField:@"woshiceshi"];
#endif
		
	});
	return _shareSessionManager;
}

/**
 拼接请求头信息
 */
static inline void appendHTTPHeaders(AFHTTPSessionManager *sessionManager,IHFunctionTag tag) {
	
	NSDictionary *mDic = [NSDictionary dictionaryWithObjectsAndKeys:
						  USERMODEL.userName,@"user_name",
						  USERMODEL.token,@"authorization_code",nil];
	
	NSData *data = [NSJSONSerialization dataWithJSONObject:mDic options:NSJSONWritingPrettyPrinted error:nil];
	NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	NSData *basicAuthCredentials = [str dataUsingEncoding:NSUTF8StringEncoding];
	NSString *base64AuthCredentials = [basicAuthCredentials base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
	[sessionManager.requestSerializer setValue:USERMODEL.token forHTTPHeaderField:@"token"];
	
	[sessionManager.requestSerializer setValue:base64AuthCredentials forHTTPHeaderField:@"Authorization"];
	if (tag == IH_Vediorefer) {
		[sessionManager.requestSerializer setValue:@"/zmh/" forHTTPHeaderField:@"referer"];
	}
	
	NSString *Aestime = [[IHUtility getNowTimeTimestamp] aci_encryptWithAES];
	[sessionManager.requestSerializer setValue:Aestime forHTTPHeaderField:@"verger"]; //时间加密
	
}

//根据tag 来封装数据
-(void)httpRequestTagWithParameter:(NSDictionary *)dic
							method:(NSString *)method
							   tag:(IHFunctionTag)tag
						   success:(void (^)(id))success
						   failure:(void (^)(id))failure{
	
	AFHTTPSessionManager *sessionManager = [MTNetworkData shareSessionManager];
	///拼接请求头信息
	appendHTTPHeaders(sessionManager,tag);
	
	NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],method];
	if(tag == IH_orderPay || tag == IH_PCLogin){
		service = method;
	}
	
	//打印请求参数信息
	printReqeustParams(service,dic);
	
	[sessionManager POST:service parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if (success) {
			NSError *err=nil;
			NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
			printResponseData(ret);
			
			NSInteger errorNo=[[ret objectForKey:@"errorNo"]integerValue];
			
			if (errorNo!=0) {
				[IHUtility removeWaitingView];
				failure(ret);
				if (errorNo==401 && USERMODEL.isLogin) {
					[IHUtility addSucessView:[ret objectForKey:@"errorContent"] type:2];
					
					[[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil]; //挤登录
				}else if(errorNo==502){
					[IHUtility addSucessView:@"您的简历尚未填写，请完善！" type:1];
				}else if(errorNo==1401){
					NSDictionary *dic2=[self parseResult:ret tag:tag];
					success(dic2);
				}else {
					[IHUtility addSucessView:[ret objectForKey:@"errorContent"] type:2];
				}
				
				return ;
			}
			
			NSDictionary *dic2=[self parseResult:ret tag:tag];
			success(dic2);
			
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[IHUtility removeWaitingView];
		NSLog(@"%@",error);
		NSDictionary *userInfo=error.userInfo;
		[IHUtility addSucessView:[userInfo objectForKey:@"NSLocalizedDescription"] type:2];
		failure(error);
	}];
	
}

-(void)httpRequestWithParameter:(NSDictionary *)dic method:(NSString *)method success:(void (^)(id))success failure:(void (^)(id))failure{
	
	//	AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
	//	sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
	//	sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
	//	sessionManager.operationQueue.maxConcurrentOperationCount = 5;
	//	// 设置超时时间
	//	[sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
	//	sessionManager.requestSerializer.timeoutInterval = 8.f;
	//	[sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
	//
	//	[sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	//	NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],method];
	//	NSString* parameter;
	//	if (dic.allKeys.count>0) {
	//		parameter  = [IHUtility getParameterString:dic];
	//	}
	//
	//	NSLog(@"total url:  %@?%@", service,parameter);
	//	NSDictionary *mDic = [NSDictionary dictionaryWithObjectsAndKeys:
	//						  //       @"4",@"deviceType",  //IOS
	//						  USERMODEL.userName,@"user_name",
	//						  USERMODEL.token,@"authorization_code",nil];
	//	//    NSString *str = [mDic JSONRepresentation];
	//
	//	NSString *str = [mDic mj_JSONString];
	//
	//	NSData *basicAuthCredentials = [str dataUsingEncoding:NSUTF8StringEncoding];
	//	NSString *base64AuthCredentials = [basicAuthCredentials base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
	//
	//	[sessionManager.requestSerializer setValue:USERMODEL.token forHTTPHeaderField:@"token"];
	//	[sessionManager.requestSerializer setValue:base64AuthCredentials forHTTPHeaderField:@"Authorization"];
	//	//   [sessionManager.requestSerializer setValue:@"4" forHTTPHeaderField:@"deviceType"];
	//	[sessionManager.requestSerializer setValue:@"4" forHTTPHeaderField:@"device_type"];
	//	[sessionManager.requestSerializer setValue:VERSION_CODE forHTTPHeaderField:@"version_code"];
	//	[sessionManager.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"app_key"];
	//	[sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"modelType"];
	//
	//#ifdef DEBUG
	//	[sessionManager.requestSerializer setValue:@"woshiceshi" forHTTPHeaderField:@"woshiceshi"];
	//#else
	//
	//#endif
	//
	//	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	//	NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
	//	[sessionManager.requestSerializer setValue:app_Version forHTTPHeaderField:@"api_version"];
	//
	//	NSString *Aestime = [[IHUtility getNowTimeTimestamp] aci_encryptWithAES];
	//	[sessionManager.requestSerializer setValue:Aestime forHTTPHeaderField:@"verger"]; //时间加密
	//
	//    NSString* apiVersion = [IHApiConfigManager getAPIVersionWithMethod:method];
	//    if (app_Version) {
	//        apiVersion = [NSString stringWithFormat:@"%@", apiVersion];
	//        [sessionManager.requestSerializer setValue:apiVersion forHTTPHeaderField:@"api_version"];
	//    }else{
	//        [sessionManager.requestSerializer setValue:@"1" forHTTPHeaderField:@"api_version"];
	//    }
	
	AFHTTPSessionManager *sessionManager = [MTNetworkData shareSessionManager];
	///拼接请求头信息
	appendHTTPHeaders(sessionManager,0);
	
	NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],method];
	
	//打印请求参数信息
	printReqeustParams(service,dic);
	
	[sessionManager POST:service parameters:dic
				progress:nil
				 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
					 
					 if (success) {
						 
						 NSError *err=nil;
						 NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers
																			   error:&err];
						 printResponseData(ret);
						 
						 
						 NSInteger errorNo = [[ret objectForKey:@"errorNo"]integerValue];
						 
						 if (errorNo!=0) {
							 [IHUtility removeWaitingView];
							 [IHUtility addSucessView:[ret objectForKey:@"errorContent"] type:2];
							 failure(ret);
							 
							 if (errorNo==401 && USERMODEL.isLogin) {
								 [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil]; //挤登录
							 }
							 return ;
						 }
						 NSDictionary *dic2=[self parseResult:ret tag:IH_init];
						 success(dic2);
					 }
					 
				 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
					 NSLog(@"%@",error);
					 NSDictionary *userInfo=error.userInfo;
					 [IHUtility addSucessView:[userInfo objectForKey:@"NSLocalizedDescription"] type:2];
					 failure(error);
				 }];
	
}


-(void)httpRequestWithParameter:(NSDictionary *)dic method:(NSString *)method success:(void (^)(id))success{
	
	//	AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
	//	sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
	//	sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
	//	sessionManager.operationQueue.maxConcurrentOperationCount = 5;
	//	// 设置超时时间
	//	[sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
	//	sessionManager.requestSerializer.timeoutInterval = 8.f;
	//	[sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
	//
	//	[sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	//	[sessionManager.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"app_key"];
	//	[sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"modelType"];
	//
	//	NSString *Aestime = [[IHUtility getNowTimeTimestamp] aci_encryptWithAES];
	//	[sessionManager.requestSerializer setValue:Aestime forHTTPHeaderField:@"verger"]; //时间加密
	//
	//#ifdef DEBUG
	//	[sessionManager.requestSerializer setValue:@"woshiceshi" forHTTPHeaderField:@"woshiceshi"];
	//#else
	//
	//#endif
	//
	//	NSDictionary *mDic=[NSDictionary dictionaryWithObjectsAndKeys:
	//						//   @"4",@"deviceType",  //IOS
	//						USERMODEL.userName,@"user_name",
	//						USERMODEL.token,@"authorization_code",nil];
	//	//    NSString *str=[mDic JSONRepresentation];
	//	NSString *str = [mDic mj_JSONString];
	//
	//	NSData *basicAuthCredentials = [str dataUsingEncoding:NSUTF8StringEncoding];
	//	NSString *base64AuthCredentials = [basicAuthCredentials base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
	//	[sessionManager.requestSerializer setValue:USERMODEL.token forHTTPHeaderField:@"token"];
	//	[sessionManager.requestSerializer setValue:base64AuthCredentials forHTTPHeaderField:@"Authorization"];
	//	[sessionManager.requestSerializer setValue:@"4" forHTTPHeaderField:@"device_type"];
	//	[sessionManager.requestSerializer setValue:VERSION_CODE forHTTPHeaderField:@"version_code"];
	//	[sessionManager.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"app_key"];
	//
	//#ifdef DEBUG
	//	[sessionManager.requestSerializer setValue:@"woshiceshi" forHTTPHeaderField:@"woshiceshi"];
	//#else
	//
	//#endif
	//
	//	//    NSString* apiVersion = [IHApiConfigManager getAPIVersionWithMethod:method];
	//	//
	//	//    if (apiVersion) {
	//	//        apiVersion = [NSString stringWithFormat:@"%@", apiVersion];
	//	//        [sessionManager.requestSerializer setValue:apiVersion forHTTPHeaderField:@"api_version"];
	//	//    }else{
	//	//        [sessionManager.requestSerializer setValue:@"1" forHTTPHeaderField:@"api_version"];
	//	//    }
	//
	//
	//	NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],method];
	//	NSString *parameter=nil;
	//	if (dic.allKeys.count>0) {
	//		parameter  = [IHUtility getParameterString:dic];
	//	}
	//
	//	NSLog(@"total url:  %@?%@", service, parameter);
	//    NSError *serializationError = nil;
	//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:service parameters:dic error:&serializationError];
	
	//    [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
	//        if (error) {
	//            NSLog(@"--------------%@",error);
	//            NSDictionary *userInfo=error.userInfo;
	//            [IHUtility addSucessView:[userInfo objectForKey:@"NSLocalizedDescription"] type:2];
	//        } else {
	//            if (success) {
	//                NSError *err=nil;
	//                NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseObject
	//                                                                    options:NSJSONReadingMutableContainers
	//                                                                      error:&err];
	//
	//                NSLog(@"res= %@", ret);
	//
	//                NSInteger errorNo=[[ret objectForKey:@"errorNo"]integerValue];
	//
	//                if (errorNo!=0) {
	//                    [IHUtility removeWaitingView];
	//                    [IHUtility addSucessView:[ret objectForKey:@"errorContent"] type:2];
	//
	//                    if (errorNo==401 && USERMODEL.isLogin) {
	//                        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil]; //挤登录
	//                    }
	//
	//                    return ;
	//                }
	//                NSDictionary *dic2=[self parseResult:ret tag:IH_init];
	//                success(dic2);            }
	//        }
	//    }];
	
	AFHTTPSessionManager *sessionManager = [MTNetworkData shareSessionManager];
	///拼接请求头信息
	appendHTTPHeaders(sessionManager,0);
	
	NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],method];
	//打印请求参数信息
	printReqeustParams(service,dic);
	
	[sessionManager POST:service parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		if (success) {
			
			NSError *err = nil;
			NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
			printResponseData(ret);
			
			
			NSInteger errorNo=[[ret objectForKey:@"errorNo"]integerValue];
			
			if (errorNo!=0) {
				[IHUtility removeWaitingView];
				[IHUtility addSucessView:[ret objectForKey:@"errorContent"] type:2];
				
				if (errorNo==401 && USERMODEL.isLogin) {
					[[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil]; //挤登录
				}
				
				return ;
			}
			NSDictionary *dic2=[self parseResult:ret tag:IH_init];
			success(dic2);
			
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"--------------%@",error);
		NSDictionary *userInfo=error.userInfo;
		[IHUtility addSucessView:[userInfo objectForKey:@"NSLocalizedDescription"] type:2];
	}];
	
}
//根据tag 来封装数据 GET请求
-(void)httpGETRequestTagWithParameter:(NSDictionary *)dic
							   method:(NSString *)method
								  tag:(IHFunctionTag)tag
							  success:(void (^)(id))success
							  failure:(void (^)(id))failure{
	
	//	AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
	//	sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
	//	sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
	//	sessionManager.operationQueue.maxConcurrentOperationCount = 5;
	//
	//	// 设置超时时间
	//	[sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
	//	sessionManager.requestSerializer.timeoutInterval = 8.f;
	//	[sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
	//
	//	[sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	//
	//	NSDictionary *mDic=[NSDictionary dictionaryWithObjectsAndKeys:
	//
	//						USERMODEL.userName,@"user_name",
	//						USERMODEL.token,@"authorization_code",nil];
	//	//    NSString *str=[mDic JSONRepresentation];
	//	NSString *str = [mDic mj_JSONString];
	//
	//	NSData *basicAuthCredentials = [str dataUsingEncoding:NSUTF8StringEncoding];
	//	NSString *base64AuthCredentials = [basicAuthCredentials base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
	//	[sessionManager.requestSerializer setValue:USERMODEL.token forHTTPHeaderField:@"token"];
	//	[sessionManager.requestSerializer setValue:base64AuthCredentials forHTTPHeaderField:@"Authorization"];
	//	[sessionManager.requestSerializer setValue:@"4" forHTTPHeaderField:@"device_type"];
	//	[sessionManager.requestSerializer setValue:VERSION_CODE forHTTPHeaderField:@"version_code"];
	//	[sessionManager.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"app_key"];
	//	[sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"modelType"];
	//
	//#ifdef DEBUG
	//	[sessionManager.requestSerializer setValue:@"woshiceshi" forHTTPHeaderField:@"woshiceshi"];
	//#else
	//
	//#endif
	//
	//	NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],method];
	//
	//	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	//	NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
	//	[sessionManager.requestSerializer setValue:app_Version forHTTPHeaderField:@"api_version"];
	//
	//	NSString *Aestime = [[IHUtility getNowTimeTimestamp] aci_encryptWithAES];
	//	[sessionManager.requestSerializer setValue:Aestime forHTTPHeaderField:@"verger"]; //时间加密
	//	//    NSString* apiVersion = [IHApiConfigManager getAPIVersionWithMethod:method];
	//	//
	//	//    if (apiVersion) {
	//	//        apiVersion = [NSString stringWithFormat:@"%@", apiVersion];
	//	//        [sessionManager.requestSerializer setValue:apiVersion forHTTPHeaderField:@"api_version"];
	//	//    }else{
	//	//        [sessionManager.requestSerializer setValue:@"1" forHTTPHeaderField:@"api_version"];
	//	//    }
	//
	//	//   NSString* parameter;
	//	//    if (dic.allKeys.count>0) {
	//	//        parameter  = [IHUtility getParameterString:dic];
	//	//    }
	//	//
	//	//    NSLog(@"total url:  %@?%@", service, parameter);
	//
	AFHTTPSessionManager *sessionManager = [MTNetworkData shareSessionManager];
	///拼接请求头信息
	appendHTTPHeaders(sessionManager,0);
	//拼接请求URL
	NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],method];
	//打印请求参数信息
	printReqeustParams(service,dic);
	
	[sessionManager GET:service parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		if (success) {
			
			NSError *err=nil;
			NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
			printResponseData(ret);
			
			NSInteger errorNo = [[ret objectForKey:@"errorNo"]integerValue];
			
			if (errorNo!=0) {
				[IHUtility removeWaitingView];
				[IHUtility addSucessView:[ret objectForKey:@"errorContent"] type:2];
				failure(ret);
				
				if (errorNo==401 && USERMODEL.isLogin) {
					[[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil]; //挤登录
				}
				
				return ;
			}
			
			NSDictionary *dic2=[self parseResult:ret tag:tag];
			success(dic2);
			
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"%@",error);
		NSDictionary *userInfo = error.userInfo;
		
		[IHUtility addSucessView:[userInfo objectForKey:@"NSLocalizedDescription"] type:2];
		failure(error);
	}];
	
}


#pragma mark获取天气接口
-(void)httpGETWeatherTagWithParameter:(NSDictionary *)dic
								  url:(NSString *)url
								  tag:(IHFunctionTag)tag
							  success:(void (^)(id))success
							  failure:(void (^)(id))failure{
	
	//	AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
	//	sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
	//	sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
	//	sessionManager.operationQueue.maxConcurrentOperationCount = 5;
	//
	//	// 设置超时时间
	//	[sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
	//	sessionManager.requestSerializer.timeoutInterval = 8.f;
	//	[sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
	//
	//	[sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	//
	//	NSString *Aestime = [[IHUtility getNowTimeTimestamp] aci_encryptWithAES];
	//	[sessionManager.requestSerializer setValue:Aestime forHTTPHeaderField:@"verger"]; //时间加密
	
	AFHTTPSessionManager *sessionManager = [MTNetworkData shareSessionManager];
	///拼接请求头信息
	appendHTTPHeaders(sessionManager,0);
	//拼接请求URL
	NSString *service = [NSString stringWithFormat:@"%@", url];
	//打印请求参数信息
	printReqeustParams(service,dic);
	
	[sessionManager GET:service parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		if (success) {
			NSError *err=nil;
			NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers
																  error:&err];
			NSDictionary *dic2=[self parseResult:ret tag:tag];
			success(dic2);
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"%@",error);
		NSDictionary *userInfo=error.userInfo;
		
		[IHUtility addSucessView:[userInfo objectForKey:@"NSLocalizedDescription"] type:2];
		failure(error);
	}];
	
}



#pragma mark 构建模型
-(NSDictionary *)parseResult:(NSDictionary*)dic tag:(IHFunctionTag)tag{
	if (tag==IH_User_Login) {
		return [self parseGetLogin:dic];
	}else if (tag==IH_QueryTopicList||tag==IH_QueryHotTopicList){
		return [self parseGetTopicList:dic page:self.ntpage tag:tag];
	}
	else if (tag==IH_QueryBuyList ||tag==IH_QuerySupplyList){
		return [self getSupplyAndBuyList:dic type:tag page:self.ntpage];
	}else if (tag==IH_QueryNearUser){
		return [self parseGetNearUserList:dic];
	}else if (tag==IH_QuerySupplyCommentList || tag == IH_QueryWantBuyCommentList||tag == IH_QueryTopicCommentList||tag == IH_ActivtiesCommentList){
		return [self parseGetSupplyCommentList:dic];
	}
	else if(tag==IH_SelectUserCompanyName ){
		return [self getQueryCompanyList:dic];
	}else if (tag==IH_QueryClickLikeListType){
		return [self getQueryClickLikeList:dic];
	}else if (tag==IH_GetMyCollectionSupplyList|| tag==IH_GetMyCollectionBuyList){
		return [self getCollectionSupplyAndWantBuyList:dic type:tag];
	}else if (tag==IH_GetMyCollectionTopicList){
		return [self getCollectionTopicList:dic];
	}else if (tag==IH_GetCommentMeList){
		return [self getCommentMeList:dic];
	}else if (tag==IH_SelectViewsList)
	{
		return [self getQueryFindOutList:dic];
	}else if (tag==IH_QueryUserList)
	{
		return [self parseGetContactList:dic];
	}else if (tag==IH_NewsList)
	{
		return [self getNewsList:dic];
	}else if (tag==IH_UserActivityList||tag==IH_AllActivityList){
		return [self getActivityList:dic tag:tag];
		
	}else if (tag==IH_AddActivties ||tag== IH_UserActivityDetail){
		return [self getaddActivties:dic tag:tag];
		
	}else if (tag==IH_GetThemeList){
		return [self GetThemeList:dic page:self.ntpage];
		
	}else if (tag==IH_ThemeAndNewsList){
		return [self getThemeAndInformation:dic];
	}else if (tag==IH_TopicForId){
		return [self getTopicForId:dic];
	}else if (tag == IH_UserNewsDetail){
		return [self getNewsDetailContent:dic];
	}else if (tag == IH_UserImageNewsDetail){
		return [self getImageNewsDetailContent:dic];
	}else if (tag == IH_NewsDetail){
		return [self getPushNewsDetailContent:dic];
	}else if (tag == IH_EPCloudList){
		return [self getEPCloudlistData:dic];
		
	}else if (tag==IH_fans || tag==IH_guanzhu){
		return [self getFans:dic];
		
	}else if (tag == IH_EPCloudTrackList){
		return  [self getCompanyTrackData:dic];
	}else if (tag == IH_EPCloudCommentList)
	{
		return  [self getCompanyCommentListData:dic];
	}else if (tag == IH_invatedFriendsId)
	{
		return  [self getinvatedFriendsList:dic];
	}else if (tag==IH_EPConnectionList){
		return [self getConnection:dic];
		
	}else if (tag==IH_BindCompanyList){
		return [self getBindCompanyListData:dic];
		
	}else if (tag==IH_SupplyAndBuy){
		return [self getSupplyAndBuyList:dic page:self.ntpage];
	}else if (tag == IH_VoteList){
		return [self getVoteListData:dic];
	}else if (tag == IH_VoteChartsList){
		return [self getVoteChartisListData:dic];
	}else if (tag ==  IH_VoteDetail){
		return [self getVoteDetailtData:dic];
	}else if (tag == IH_AddCrowdActivties||tag == IH_selectCrowdDetailByCrowdId){
		return [self getAddCrowdOrderData:dic];
	}else if (tag == IH_UserEPCloudAuthInfo){
		return [self getEPCloudUserInfoData:dic];
	}else if (tag == IH_searchCompanyList){
		return [self searchCompanyList:dic];
	}else if (tag == IH_CompanyInfo){
		return [self CompanyInfoWith:dic];
	}else if (tag == IH_PositionList ||tag == IH_CompanyPositionList){
		return [self getPositionList:dic tag:tag];
		
	}else if (tag == IH_selectRecruitList){
		return [self searchJianliList:dic];
	}
	else if (tag == IH_PositionDetail){
		return [self getPositionDetail:dic];
	}else if (tag==IH_CurrculumDetail){
		return [self getCurricuiumDetaile:dic];
	}else if (tag==IH_ReceiveCurrculum){
		return [self ReceiveCurrculum:dic];
	}else if (tag==IH_ReleasePosition){
		return [self ReleasePosition:dic];
	}else if (tag== IH_JobCompanyInfo){
		return [self getJobCompanyInfo:dic];
	}else if (tag==IH_selectRecruitListSearce){
		return [self searchJianliListJobName:dic];
	}else if (tag==IH_SearchJobName){
		return [self SearchJobName:dic];
	}else if (tag==IH_recommendConnection){
		
		return  [self recommendConnection:dic];//推荐人脉
		
	}else if (tag==IH_recommendCompany){
		
		return [self recommendCompany:dic];//推荐企业
		
	}else if (tag == IH_AskBarDetail){
		return [self getAskBarDetailModel:dic];//问吧主题详情
	}else if (tag == IH_replyProblemList){
		return [self getReplyProblemList:dic];//问吧详情问题列表
		
	}else if (tag==IH_MyQuestion || tag==IH_Question){
		return [self selectMyQuestionByUserId:dic];
		
	}else if (tag == IH_answerCommentList){
		return [self getAnswerCommentList:dic];
		
	}else if (tag == IH_SeedCloudDetail){
		return [self getSeedCloudDetail:dic];
		
	}else if (tag==IH_NurseryDetailList){
		return [self selectNurseryDetailListByPage:dic];
		
	}else if (tag==IH_MyNersery){
		
		return [self getMyNurseryInfo:dic];
		
	}else if (tag==IH_NewsSearch){
		
		return [self selectInformationBytitle:dic];
		
	}else if (tag==IH_CouponList){
		return [self selectCouponInfoList:dic];
		
	}else if (tag==IH_ScoreHistory){
		
		return [self scoreHistoryList:dic];
	}else if (tag==IH_ScoreDetail){
		
		return [self scoreDetailList:dic];
		
	}else if (tag==IH_FindCar){
		return [self selectOwnerOrderList:dic];
	}else if (tag==IH_OwnerFaBu){
		return [self selectOwnerOrderByUserId:dic];
	}else if (tag==IH_cheyuan){
		return [self selectFlowCarRouteList:dic];
	}
	return dic;
}

#pragma mark 接口
//获取验证码 type  0 注册  1找回密码
-(void)getSendRegisterSms:(NSString *)phone
					 type:(int)type
				   chanle:(int)chanle
				  success:(void (^)(NSDictionary *obj))success{
	self.tag=IH_sendRegisterSms;
	
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						phone,@"phone",
						[NSString stringWithFormat:@"%d",chanle],@"smsType",
						stringFormatInt(type),@"validateType",
						nil];
	
	[self httpRequestWithParameter:dic2 method:@"registerAndLogin/sendRegisterSms" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}


//获取登录 手机验证码
-(void)getPhoneNumCode:(NSString *)phone
			   success:(void (^)(NSDictionary *obj))success{
	self.tag=IH_init;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						phone,@"mobile",
						nil];
	
	[self httpRequestWithParameter:dic2 method:@"registerAndLogin/message" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}

//验证 验证码
-(void)getValidateCode:(NSString *)phone
				 vcode:(NSString *)vcode
			   success:(void (^)(NSDictionary *obj))success{
	self.tag=IH_ValidateCode;
	
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						phone,@"phone",
						vcode,@"code",
						nil];
	
	[self httpRequestWithParameter:dic2 method:@"registerAndLogin/validateCode" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}


//用户登录
-(void)getUserLogin:(NSString *)userName
		   passWord:(NSString *)passWord
			success:(void (^)(NSDictionary *obj))success{
	self.tag=IH_User_Login;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						userName,@"user_name",
						[IHUtility MD5Encode:[IHUtility MD5Encode:passWord]],@"password",
						nil];
	[self httpRequestWithParameter:dic2 method:@"registerAndLogin/login" success:^(NSDictionary *dic) {
		success(dic);
	}];
}

//用户短信验证码登录
-(void)getCodeNumUserLogin:(NSString *)userName
				   codeNum:(NSString *)codeNum
				   success:(void (^)(NSDictionary *obj))success{
	self.tag=IH_User_Login;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						userName,@"mobile",
						codeNum,@"code",
						nil];
	[self httpRequestWithParameter:dic2 method:@"registerAndLogin/messageLogin" success:^(NSDictionary *dic) {
		success(dic);
	}];
}

//用户注册
-(void)getuserRegister:(NSDictionary *)UserInfoParams

			   success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_Register;
	
	[self httpRequestWithParameter:UserInfoParams method:@"registerAndLogin/registUser" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}


//发布供求
-(void)getAddSupplyInfo:(NSInteger)userid
				 number:(NSInteger)number
				  price:(CGFloat)price
				  point:(CGFloat)point
			   diameter:(CGFloat)diameter
				width_s:(CGFloat)width_s
				width_e:(CGFloat)width_e
			   height_s:(CGFloat)height_s
			   height_e:(CGFloat)height_e
			  varieties:(NSString *)varieties
				selling:(NSString *)selling
			   seedling:(NSString *)seedling
			 supply_url:(NSString *)url
				address:(NSString *)address
				success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_AddSupply;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						[NSString stringWithFormat:@"%ld",(long)userid],@"user_id",
						[NSString stringWithFormat:@"%ld",(long)number],@"number",
						[NSString stringWithFormat:@"%f",price],@"unit_price",
						[NSString stringWithFormat:@"%f",point],@"branch_point",
						[NSString stringWithFormat:@"%f",diameter],@"rod_diameter",
						[NSString stringWithFormat:@"%f",width_s],@"crown_width_s",
						[NSString stringWithFormat:@"%f",width_e],@"crown_width_e",
						[NSString stringWithFormat:@"%f",height_s],@"height_s",
						[NSString stringWithFormat:@"%f",height_e],@"height_e",
						varieties,@"varieties",
						selling,@"selling_point",
						seedling,@"seedling_source_address",
						url,@"supply_url",
						stringFormatString(address),@"address",
						nil];
	
	[self httpRequestWithParameter:dic2 method:@"supply/addSupply" success:^(NSDictionary *dic) {
		success(dic);
	}];
}
//发布求购
-(void)getAddBuyInfo:(NSInteger)userId
			  number:(NSInteger)number
			   point:(CGFloat)point
			diameter:(CGFloat)diameter
			 width_s:(CGFloat)width_s
			 width_e:(CGFloat)width_e
			height_s:(CGFloat)height_s
			height_e:(CGFloat)height_e
		   varieties:(NSString *)varieties
			 selling:(NSString *)selling
payment_methods_dictionary_id:(NSInteger)paymentId
	 use_mining_area:(NSString *)use_mining_area
		 mining_area:(NSString *)mining_area
	urgency_level_id:(NSInteger)urgencyId
		want_buy_url:(NSString *)url
			 address:(NSString *)address
			 success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_AddBuy;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						[NSString stringWithFormat:@"%ld",(long)userId],@"user_id",
						[NSString stringWithFormat:@"%ld",(long)number],@"number",
						
						[NSString stringWithFormat:@"%f",point],@"branch_point",
						[NSString stringWithFormat:@"%f",diameter],@"rod_diameter",
						[NSString stringWithFormat:@"%f",width_s],@"crown_width_s",
						[NSString stringWithFormat:@"%f",width_e],@"crown_width_e",
						[NSString stringWithFormat:@"%f",height_s],@"height_s",
						[NSString stringWithFormat:@"%f",height_e],@"height_e",
						varieties,@"varieties",
						selling,@"selling_point",
						[NSString stringWithFormat:@"%ld",(long)paymentId],@"payment_methods_dictionary_id",
						use_mining_area,@"use_mining_area",
						mining_area,@"mining_area",
						[NSString stringWithFormat:@"%ld",(long)urgencyId],@"urgency_level_id",
						url,@"want_buy_url",
						stringFormatString(address),@"address",
						nil];
	[self httpRequestWithParameter:dic2 method:@"wantBuy/addWantBuy" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
	
}


//提交活动订单
-(void)getAddActivtiesOrder:(int)order_num
			  activities_id:(NSString *)activities_id
			contacts_people:(NSString *)contacts_people
			 contacts_phone:(NSString *)contacts_phone
						job:(NSString *)job
			   company_name:(NSString *)company_name
					  email:(NSString *)email
					success:(void (^)(NSDictionary *obj))success
					failure:(void (^)(NSDictionary *obj2))failure{
	self.tag=IH_AddActivties;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt([USERMODEL.userID intValue]),@"user_id",
						activities_id,@"activities_id",
						stringFormatInt(order_num),@"order_num",
						contacts_people,@"contacts_people",
						contacts_phone,@"contacts_phone",
						job,@"job",
						company_name,@"company_name",
						email,@"email",
						nil];
	[self httpRequestTagWithParameter:dic2 method:@"Activities/addOrderActivities" tag:IH_AddActivties success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
}
//发布话题
-(void)getAddTopic:(NSString *)topic_url
	 topic_content:(NSString *)topic_content
		   address:(NSString *)address
		  theme_Id:(NSString *)theme_Id
		   success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_AddTopic;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						topic_url,@"topic_url",
						topic_content,@"topic_content",
						USERMODEL.userID,@"user_id",
						stringFormatString(address),@"address",
						theme_Id,@"theme_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"Topic/addTopic" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}





//查询供应列表
-(void)getSupplyList:(int)page
		  maxResults:(int)maxResults
		  my_user_id:(int)my_user_id
seedling_source_address:(NSString *)seedling_source_address
		   varieties:(NSString *)varieties
			 success:(void (^)(NSDictionary *obj))success
			 failure:(void (^)(NSDictionary *obj2))failure
{
	self.tag=IH_QuerySupplyList;
	int userID=0;
	if (USERMODEL.isLogin) {
		userID=[USERMODEL.userID intValue];
	}
	self.ntpage=page;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(page),@"page",
						stringFormatInt(maxResults),@"num",
						stringFormatInt(userID),@"user_id",
						stringFormatInt(my_user_id),@"my_user_id",
						stringFormatString(seedling_source_address),@"seedling_source_address",
						stringFormatString(varieties),@"varieties",
						nil];
	[self httpRequestTagWithParameter:dic2 method:@"openModel/selectSupplyList" tag:IH_QuerySupplyList success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
}

//查询求购列表
-(void)getBuyList:(int)page
	   maxResults:(int)maxResults
	   my_user_id:(int)my_user_id
	  mining_area:(NSString *)mining_area
		varieties:(NSString *)varieties
		  success:(void (^)(NSDictionary *obj))success
		  failure:(void (^)(NSDictionary *obj2))failure
{
	self.tag=IH_QueryBuyList;
	int userID=0;
	if (USERMODEL.isLogin) {
		userID=[USERMODEL.userID intValue];
	}
	self.ntpage=page;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(page),@"page",
						stringFormatInt(maxResults),@"num",
						stringFormatInt(userID),@"user_id",
						stringFormatInt(my_user_id),@"my_user_id",
						stringFormatString(mining_area),@"mining_area",
						stringFormatString(varieties),@"varieties",
						nil];
	[self httpRequestTagWithParameter :dic2 method:@"openModel/selectWantBuyList" tag:IH_QueryBuyList success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
}


//查询话题列表
-(void)getTopicList:(int)page
		 maxResults:(int)maxResults
			 userID:(int)userID
			  isHot:(int)isHot  //是否热门话题
		 my_user_id:(int)my_user_id
		   theme_id:(int)theme_id
			success:(void (^)(NSDictionary *obj))success
			failure:(void (^)(NSDictionary *obj2))failure{
	
	
	if (isHot==1) {
		self.tag=IH_QueryHotTopicList;
	}else{
		self.tag=IH_QueryTopicList;
	}
	
	int userID2=0;
	if (USERMODEL.isLogin) {
		userID2=[USERMODEL.userID intValue];
	}
	self.ntpage=page;
	
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(page),@"page",
						stringFormatInt(maxResults),@"num",
						stringFormatInt(userID2),@"user_id",
						stringFormatInt(isHot),@"isHot",
						stringFormatInt(my_user_id),@"my_user_id",
						stringFormatInt(theme_id),@"theme_id",
						nil];
	
	
	[self httpRequestTagWithParameter:dic2 method:@"openModel/selectTopicList" tag:self.tag success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
}





//收藏供应列表
-(void)getSupplyCollections:(int)supply_id
					user_id:(int)user_id
					success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_CollectionSupply;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(supply_id),@"supply_id",
						stringFormatInt(user_id),@"user_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"supply/addSupplyCollection" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}

//收藏求购列表
-(void)getBuyCollections:(int)want_buy_id
				 user_id:(int)user_id
				 success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_CollectionBuy;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(want_buy_id),@"want_buy_id",
						stringFormatInt(user_id),@"user_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"wantBuy/addWantBuyCollection" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}

//收藏话题
-(void)getTopicCollection:(int)topic_id
				  user_id:(int)user_id
				  success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_CollectionTopic;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(topic_id),@"topic_id",
						stringFormatInt(user_id),@"user_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"Topic/addTopicCollection" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}


#pragma mark 查看供应评论
-(void)getQuerySupplyCommentList:(int)page
					  maxResults:(int)maxResults
						supplyID:(NSString *)supplyID
						 success:(void (^)(NSDictionary *obj))success
						 failure:(void (^)(NSDictionary *obj2))failure{
	
	NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
						  @(page),@"page",
						  @(maxResults),@"num",
						  supplyID,@"supply_id",
						  @"0",@"supply_comment_id",
						  nil];
	[self httpRequestTagWithParameter:dic2 method:@"openModel/selectSupplyCommentInfoList" tag:0 success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
		
	
}

#pragma mark 查看求购评论
-(void)getQueryWantBuyCommentList:(int)page
					   maxResults:(int)maxResults
					  want_buy_id:(NSString *)want_buy_id
						  success:(void (^)(NSDictionary *obj))success
						  failure:(void (^)(NSDictionary *obj2))failure{
	self.tag=IH_QueryWantBuyCommentList;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(page),@"page",
						stringFormatInt(maxResults),@"num",
						[NSString stringWithFormat:@"%@",want_buy_id],@"want_buy_id",
						@"0",@"supply_comment_id",
						nil];
	
	
	[self httpRequestTagWithParameter:dic2 method:@"openModel/selectWantBuyCommentList" tag:IH_QueryWantBuyCommentList success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
}
#pragma mark 活动评论列表
- (void)getActivtiesCommentList:(int)page
					 maxResults:(int)maxResults
				  activities_id:(NSString *)activities_id
						success:(void (^)(NSDictionary *obj))success
						failure:(void (^)(NSDictionary *obj2))failure{
	
	self.tag=IH_ActivtiesCommentList;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(page),@"page",
						stringFormatInt(maxResults),@"num",
						[NSString stringWithFormat:@"%@",activities_id],@"activities_id",
						@"0",@"activities_comment_id",
						nil];
	
	
	[self httpRequestTagWithParameter:dic2 method:@"Activities/selectActivitiesCommentList" tag:IH_ActivtiesCommentList success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
}
#pragma mark 资讯评论列表
- (void)getNewsCommentList:(int)page
				maxResults:(int)maxResults
				   info_id:(NSString *)info_id
				   success:(void (^)(NSDictionary *obj))success
				   failure:(void (^)(NSDictionary *obj2))failure{
	
	self.tag=IH_ActivtiesCommentList;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(page),@"page",
						stringFormatInt(maxResults),@"num",
						[NSString stringWithFormat:@"%@",info_id],@"info_id",
						@"0",@"info_comment_id",
						nil];
	
	
	[self httpRequestTagWithParameter:dic2 method:@"openModel/selectInformationCommentList" tag:IH_ActivtiesCommentList success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
}

//添加供应评论
-(void)getAddSupplyComment:(int)supply_id
				   user_id:(int)user_id     //供应主键ID,
			 reply_user_id:(int)reply_user_id   //回复用户主键ID,
		 supply_comment_id:(int)supply_comment_id ///评论 id
			reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
			supply_comment:(NSString *)supply_comment   //供应评论内容,
			  comment_type:(int)comment_type  //0:主动评论,1回复,
   reply_supply_comment_id:(int)reply_supply_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
				   success:(void (^)(NSDictionary *obj))success
{
	self.tag = IH_AddSupplyComment;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(supply_id),@"supply_id",
						stringFormatInt(user_id),@"user_id",
						stringFormatInt(reply_user_id),@"reply_user_id",
						reply_nickname,@"reply_nickname",
						stringFormatString(supply_comment),@"supply_comment",
						stringFormatInt(comment_type),@"comment_type",
						stringFormatInt(reply_supply_comment_id),@"reply_supply_comment_id",
						@(supply_comment_id),@"supply_comment_id",
						nil];
	[self httpRequestTagWithParameter:dic2 method:@"supply/addSupplyComment" tag:IH_AddSupplyComment success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		
	}];
	
	
}

//添加求购评论
-(void)getAddWantBuyComment:(int)supply_id
					user_id:(int)user_id     //供应主键ID,
			  reply_user_id:(int)reply_user_id   //回复用户主键ID,
			 reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
			 supply_comment:(NSString *)supply_comment   //供应评论内容,
			   comment_type:(int)comment_type  //0:主动评论,1回复,
	reply_supply_comment_id:(int)reply_supply_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
					success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_AddBuyComment;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(supply_id),@"want_buy_id",
						stringFormatInt(user_id),@"user_id",
						stringFormatInt(reply_user_id),@"reply_user_id",
						reply_nickname,@"reply_nickname",
						stringFormatString(supply_comment),@"want_buy_comment",
						stringFormatInt(comment_type),@"comment_type",
						stringFormatInt(reply_supply_comment_id),@"reply_want_buy_comment_id",
						@"0",@"want_buy_comment_id",
						nil];
	[self httpRequestTagWithParameter:dic2 method:@"wantBuy/addWantBuyComment" tag:IH_AddSupplyComment success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		
	}];
	
}

#pragma mark 添加话题评论
-(void)getAddTopicComment:(int)topic_id
				  user_id:(int)user_id     //供应主键ID,
			reply_user_id:(int)reply_user_id   //回复用户主键ID,
		   reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
			topic_comment:(NSString *)topic_comment   //话题评论内容,
			 comment_type:(int)comment_type  //0:主动评论,1回复,
   reply_topic_comment_id:(int)reply_topic_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
				  success:(void (^)(NSDictionary *obj))success{
	self.tag=IH_AddTopicComment;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(topic_id),@"topic_id",
						stringFormatInt(user_id),@"user_id",
						stringFormatInt(reply_user_id),@"reply_user_id",
						reply_nickname,@"reply_nickname",
						stringFormatString(topic_comment),@"topic_comment",
						stringFormatInt(comment_type),@"comment_type",
						stringFormatInt(reply_topic_comment_id),@"reply_topic_comment_id",
						@"0",@"want_buy_comment_id",
						nil];
	[self httpRequestTagWithParameter:dic2 method:@"Topic/addTopicComment" tag:IH_AddSupplyComment success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		
	}];
	
	
	
	
	
}

#pragma mark 添加活动评论
-(void)getAddActivtiesComment:(int)activities_id
					  user_id:(int)user_id     //供应主键ID,
				reply_user_id:(int)reply_user_id   //回复用户主键ID,
			   reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
		   activities_comment:(NSString *)activities_comment   //话题评论内容,
				 comment_type:(int)comment_type  //0:主动评论,1回复,
  reply_activities_comment_id:(int)reply_activities_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
					  success:(void (^)(NSDictionary *obj))success{
	self.tag=IH_AddActivtiesComment;
	NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(activities_id),@"activities_id",
						stringFormatInt(user_id),@"user_id",
						stringFormatString(activities_comment),@"activities_comment",
						stringFormatInt(reply_user_id),@"reply_user_id",stringFormatString(reply_nickname),@"reply_nickname",stringFormatInt(comment_type),@"comment_type",stringFormatInt(reply_activities_comment_id),@"reply_activities_comment_id",@"0",@"activities_comment_id",
						nil];
	[self httpRequestTagWithParameter:dic1 method:@"Activities/addActivitiesComment" tag:IH_AddActivtiesComment success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		
	}];
	
	
	
	
	
}
#pragma mark 添加资讯评论
-(void)getAddNewsComment:(int)info_id
				 user_id:(int)user_id     //供应主键ID,
		   reply_user_id:(int)reply_user_id   //回复用户主键ID,
		  reply_nickname:(NSString *)reply_nickname   //回复用户昵称,
			info_comment:(NSString *)info_comment   //话题评论内容,
			comment_type:(int)comment_type  //0:主动评论,1回复,
   reply_info_comment_id:(int)reply_info_comment_id  // 回复评论的评论ID,如果不是回复评论就默认为0
				 success:(void (^)(NSDictionary *obj))success{
	self.tag=IH_AddNewsComment;
	NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(info_id),@"info_id",
						stringFormatInt(user_id),@"user_id",
						stringFormatString(info_comment),@"info_comment",
						stringFormatInt(reply_user_id),@"reply_user_id",stringFormatString(reply_nickname),@"reply_nickname",stringFormatInt(comment_type),@"comment_type",stringFormatInt(reply_info_comment_id),@"reply_info_comment_id",@"0",@"info_comment_id",
						nil];
	[self httpRequestTagWithParameter:dic1 method:@"Information/addInformationComment" tag:IH_AddNewsComment success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		
	}];
	
	
	
	
	
}

//删除供应
-(void)getDeleteSupply:(int)supply_id
			   success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_DeleteSupply;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(supply_id),@"supply_id",stringFormatInt([USERMODEL.userID intValue]),@"user_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"supply/deleteSupply" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}
//删除求购
-(void)getDeleteBuy:(int)want_buy_id
			success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_DeleteBuy;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(want_buy_id),@"want_buy_id",
						stringFormatInt([USERMODEL.userID intValue]),@"user_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"wantBuy/deleteWantBuy" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
}
//删除话题
-(void)getDeleteTopic:(int)topic_id
			  success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_DeleteBuy;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(topic_id),@"topic_id",USERMODEL.userID,@"user_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"Topic/deleteTopic" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
	
}



//查看供应详情
-(void)getQuerySupplyComment:(NSString *)supply_id
					 success:(void (^)(NSDictionary *obj))success
					 failure:(void (^)(NSDictionary *obj2))failure {
	
	self.tag = IH_QuerySupplyComment;
	NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:supply_id,@"supply_id",
						  nil];
	[self httpRequestWithParameter:dic2 method:@"openModel/selectSupplyforId" success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
}
//查询求购详情
-(void)getQueryBuyComment:(int)want_buy_id
				  success:(void (^)(NSDictionary *obj))success
				  failure:(void (^)(NSDictionary *obj2))failure
{
	self.tag=IH_QueryBuyComment;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						
						stringFormatInt(want_buy_id),@"want_buy_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"wantBuy/selectWantBuyforId" success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
}

//查询话题详情
-(void)getQueryTopicComment:(int)topic_id
					success:(void (^)(NSDictionary *obj))success
					failure:(void (^)(NSDictionary *obj2))failure
{
	self.tag=IH_QueryTopicComment;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						
						stringFormatInt(topic_id),@"topic_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"/Topic/selectTopicforId" success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
	
}





//更新供应信息
-(void)getUpdateSupplyInfo:(int)userid
				 supply_id:(int)supply_id
					number:(NSInteger)number
					 price:(CGFloat)price
					 point:(CGFloat)point
				  diameter:(CGFloat)diameter
				   width_s:(CGFloat)width_s
				   width_e:(CGFloat)width_e
				  height_s:(CGFloat)height_s
				  height_e:(CGFloat)height_e
				 varieties:(NSString *)varieties
				   selling:(NSString *)selling
				  seedling:(NSString *)seedling
				supply_url:(NSString *)url
				   address:(NSString *)address
				   success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_UpdateSupply;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						[NSString stringWithFormat:@"%ld",(long)userid],@"user_id",
						stringFormatInt(supply_id),@"supply_id",
						[NSString stringWithFormat:@"%ld",(long)number],@"number",
						[NSString stringWithFormat:@"%f",price],@"unit_price",
						[NSString stringWithFormat:@"%f",point],@"branch_point",
						[NSString stringWithFormat:@"%f",diameter],@"rod_diameter",
						[NSString stringWithFormat:@"%f",width_s],@"crown_width_s",
						[NSString stringWithFormat:@"%f",width_e],@"crown_width_e",
						[NSString stringWithFormat:@"%f",height_s],@"height_s",
						[NSString stringWithFormat:@"%f",height_e],@"height_e",
						varieties,@"varieties",
						selling,@"selling_point",
						seedling,@"seedling_source_address",
						url,@"supply_url",
						stringFormatString(address),@"address",
						nil];
	
	[self httpRequestWithParameter:dic2 method:@"supply/updateSupply" success:^(NSDictionary *dic) {
		success(dic);
	}];
}


//更新求购列表
-(void)getUpdateBuyInfo:(int)userId
				 number:(NSInteger)number
			want_buy_id:(int)want_buy_id
				  point:(CGFloat)point
			   diameter:(CGFloat)diameter
				width_s:(CGFloat)width_s
				width_e:(CGFloat)width_e
			   height_s:(CGFloat)height_s
			   height_e:(CGFloat)height_e
			  varieties:(NSString *)varieties
				selling:(NSString *)selling
payment_methods_dictionary_id:(NSInteger)paymentId
		use_mining_area:(NSString *)use_mining_area
			mining_area:(NSString *)mining_area
	   urgency_level_id:(NSInteger)urgencyId
		   want_buy_url:(NSString *)url
				address:(NSString *)address
				success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_UpdateBuy;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(userId),@"user_id",
						[NSString stringWithFormat:@"%ld",number],@"number",
						stringFormatInt(want_buy_id),@"want_buy_id",
						[NSString stringWithFormat:@"%f",point],@"branch_point",
						[NSString stringWithFormat:@"%f",diameter],@"rod_diameter",
						[NSString stringWithFormat:@"%f",width_s],@"crown_width_s",
						[NSString stringWithFormat:@"%f",width_e],@"crown_width_e",
						[NSString stringWithFormat:@"%f",height_s],@"height_s",
						[NSString stringWithFormat:@"%f",height_e],@"height_e",
						varieties,@"varieties",
						selling,@"selling_point",
						[NSString stringWithFormat:@"%ld",paymentId],@"payment_methods_dictionary_id",
						use_mining_area,@"use_mining_area",
						mining_area,@"mining_area",
						[NSString stringWithFormat:@"%ld",urgencyId],@"urgency_level_id",
						url,@"want_buy_url",
						stringFormatString(address),@"address",
						nil];
	[self httpRequestWithParameter:dic2 method:@"wantBuy/updateWantBuy" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
	
}


//初始化
-(void)getInitsuccess:(NSString *)user_id
			longitude:(CGFloat)longitude
			 latitude:(CGFloat)latitude
			  success:(void (^)(NSDictionary *obj))success
			  failure:(void (^)(NSError *error))failure
{
    self.tag = IH_init;
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatDouble(longitude),@"longitude",
                        stringFormatDouble(latitude),@"latitude",
                        stringFormatString(user_id),@"user_id",
                        nil];
    [self httpRequestWithParameter:dic2
                            method:@"registerAndLogin/InitializationDictionary" success:^(NSDictionary *dic) {
                                success(dic);
                            } failure:^(NSError *error) {
                                failure(error);
                            }];
	
	
}

//分页查询附近用户
-(void)getNearUserInfoByUserWithlongitude:(CGFloat)longitude
								 latitude:(CGFloat)latitude
									 page:(int)page
									  num:(int)num
							 company_name:(NSString *)company_name
						 company_province:(NSString *)company_province
							 company_city:(NSString *)company_city
							   itype_List:(NSArray *)itype_List
								  user_id:(int)user_id
								  success:(void (^)(NSDictionary *obj))success
								  failure:(void (^)(NSDictionary *obj2))failure
{   self.tag=IH_QueryNearUser;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						itype_List,@"itype_List",
						stringFormatString(company_name),@"company_name",
						stringFormatString(company_province),@"company_province",
						stringFormatString(company_city),@"company_city",
						stringFormatDouble(longitude),@"longitude",
						stringFormatDouble(latitude),@"latitude",
						stringFormatInt(page),@"page",
						stringFormatInt(num),@"num",
						stringFormatInt(user_id),@"user_id",
						nil];
	[self httpRequestTagWithParameter:dic2 method:@"openModel/selectNearCompanyList" tag:IH_QueryNearUser success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
	
	
}

//分页查询附近用户
-(void)getNearUserInfoByUserWithlongitude:(CGFloat)longitude
								 latitude:(CGFloat)latitude
									 page:(int)page
									  num:(int)num
								 nickname:(NSString *)nickname
						 company_province:(NSString *)company_province
							 company_city:(NSString *)company_city
								  user_id:(int)user_id
								  success:(void (^)(NSDictionary *obj))success
								  failure:(void (^)(NSDictionary *obj2))failure{
	
	
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						
						stringFormatString(nickname),@"nickname",
						stringFormatString(company_province),@"province",
						stringFormatString(company_city),@"city",
						stringFormatDouble(longitude),@"longitude",
						stringFormatDouble(latitude),@"latitude",
						stringFormatInt(page),@"page",
						stringFormatInt(num),@"num",
						stringFormatInt(user_id),@"user_id",
						nil];
	[self httpRequestTagWithParameter:dic2 method:@"openModel/selectNearUserList" tag:IH_QueryNearUser success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
	
	
	
}



//分页查询最新用户
-(void)getNewUserInfoByUserWithpage:(int)page
								num:(int)num
							success:(void (^)(NSDictionary *obj))success
							failure:(void (^)(NSDictionary *obj2))failure
{self.tag=IH_QueryNewUser;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						
						stringFormatInt(page),@"page",
						stringFormatInt(num),@"num",
						nil];
	[self httpRequestWithParameter:dic2 method:@"user/selectNewUser" success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
	
	
}
//查询用户评论
-(void)getUserComments:(int)user_id
			   success:(void (^)(NSDictionary *obj))success
			   failure:(void (^)(NSDictionary *obj2))failure
{
	self.tag=IH_UserComment;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatInt(user_id),@"user_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"user/selectUserComments" success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
	
}
//用户地址更新
-(void)getUpdateUserAdress:(int)user_id
				   country:(NSString *)country
				  province:(NSString *)province
					  city:(NSString *)city
					  area:(NSString *)area
					street:(NSString *)street
				 longitude:(CGFloat)longitude
				  latitude:(CGFloat)latitude
				   success:(void (^)(NSDictionary *obj))success
{
	self.tag=IH_UpdateUserAdress;
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						stringFormatString(country),@"country",
						stringFormatString(province),@"province",
						stringFormatString(city),@"city",
						stringFormatString(area),@"area",
						stringFormatDouble(longitude),@"longitude",
						stringFormatDouble(latitude),@"latitude",
						stringFormatInt(user_id),@"user_id",
						nil];
	[self httpRequestWithParameter:dic2 method:@"user/updateUserAdress" success:^(NSDictionary *dic) {
		success(dic);
	}];
	
	
}

- (void)getActivtyCrowdOrder:(NSString *)user_id
			   activities_id:(NSString *)activities_id
				   order_num:(NSString *)order_num
			 contacts_people:(NSString *)contacts_people
			  contacts_phone:(NSString *)contacts_phone
						 job:(NSString *)job
				company_name:(NSString *)company_name
					   email:(NSString *)email
					  remark:(NSString *)remark
					 success:(void (^)(NSDictionary *obj))success
					 failure:(void (^)(NSDictionary *obj2))failure
{
	NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
						user_id,@"user_id",
						activities_id,@"activities_id",
						order_num,@"order_num",
						contacts_people,@"contacts_people",
						contacts_phone,@"contacts_phone",
						job,@"job",
						company_name,@"company_name",
						email,@"email",
						remark,@"remark",
						nil];
	[self httpRequestTagWithParameter:dic2 method:@"CrowdActivity/addCrowOrderActivities" tag:IH_AddCrowdActivties success:^(NSDictionary *dic) {
		success(dic);
	} failure:^(NSDictionary *dic) {
		failure(dic);
	}];
	
}

@end


