//
//  GJNetWorkData.h
//  HouseRent
//
//  Created by GanJi on 10-7-8.
//  Copyright 2010 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "GJHttpConnect.h"

#import "IHUtility.h"

#define NetWorkCancleHTTPConnection				@"NetWorkCancleHTTPConnection"

#define kErrorCode	@"ErrorCode"
#define kData		@"Data"

#define ErrorTip_Default	@"亲，网络开小差了o(>﹏<)o"
#define ErrorTip_Error		@"亲，网络开小差了o(>﹏<)o"
#define ErrorTip_TimeOut	@"亲，网络开小差了(@﹏@)~ "
#define ErrorTip_Server		@"抱歉，服务器正在维护，请您稍后重试。"
#define ErrorTip_Login      @"账号在其他设备上登录！"
//#define ErrorTip_Data		@"抱歉，您的网络无法连通，请您检查网络设置后重试。"


//GJNetWorkDataDelegate协议中success的可能值
#define Network_Success		1
#define Network_Error		0
#define Network_TimeOut		-1
#define Network_NoNet		-2
#define Network_DataError	-3
#define Network_ErrorWithTip -4
#define Network_Cancel       -5


#define GJData_Version	@"1.0"

#define NoNullString(x) (x?x:@"")



//enum functionTag
//{
//    IH_Active = 1000,
//    
//    //ih.base.user
//    
//    IH_Register,
//    IH_BankAccountAuth,
//    IH_ProfileAuth,
//    
//    IH_SetProfile,
//    IH_GetProfile,
//    IH_GetCaptcha,
//    IH_CheckCaptcha,
//    IH_GetSmsAuthCode,
//    IH_CheckSmsAuthCode,
//    
//    
//    
//    IH_GetSmsAuthCodeBySession,
//    
//    IH_SetPassword,
//    IH_ModifyPassword,
//    IH_ModifyAuthPhone,
//    //ih.base.user
//    
//    
//    
//    //
//    
//};
//

typedef enum{
    
    IH_Init=1000,//初始化
    IH_Logoff,//用户注销
    IH_CheckVersion,//版本检测
    IH_Auth,
    IH_Register,
    IH_Base_User_ModifyPwd,
    IH_auth_setPassword,
    
    
	//物流管理接口
	IH_BASE_getMailingAddress,
	IH_BASE_addMailingAddress,
	IH_BASE_modifyMailingAddress,
	IH_BASE_delMailingAddress,
	IH_BASE_setDefaultMailingAddress,
	
	//发票管理接口
	IH_BASE_getInvoice,
	IH_BASE_modifyInvoice,
	IH_BASE_delInvoice,
	IH_BASE_addInvoice,
    
        //notice
    IH_IOSGetToken,
    IH_IOSPushMessage,
    
    //短信验证
    IH_CheckSmsAuthCode,
    IH_GetSmsAuthCode,
	
}IH_BASE_Method;

@class GJNetWorkData;
@protocol GJNetWorkDataDelegate<NSObject>
@required
- (void)networkData:(GJNetWorkData*)networkData successful:(signed char)success statusString:(NSString*)status;
@optional
- (void)httpConnect:(GJNetWorkData *)httpConnect didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

-(BOOL)handleNetworkData:(GJNetWorkData*)networkData successful:(signed char)success statusString:(NSObject*)status;
@end

//GJNetWorkData作为所有网络请求类的基类，提供一般的操作
@interface GJNetWorkData : NSObject <UIAlertViewDelegate>{
	id<GJNetWorkDataDelegate> delegate;
	GJHttpConnect* httpRequest;
	
	BOOL beenRetained;
    int returnCode;
    
    int tag;
    NSString* tempTransactionID;    
}

@property(nonatomic, retain) NSString* tempTransactionID;
@property(nonatomic,assign) int tag;
@property(nonatomic,retain) NSDictionary* resultDic;
@property (nonatomic,assign) id<GJNetWorkDataDelegate> delegate;
@property (nonatomic,assign) GJHttpConnect* httpRequest;


- (void)setHttpConnectFinishedMethod:(GJHttpConnect*)httpconnect;
- (void)cancelHttpConnect;
- (void)cancelHttpConnectMenutal;

- (NSDictionary*)setStatisticInfoInHeadField:(NSDictionary*)headField;

- (void)finishHttpConnect;
- (void)failedwithFutherInfo:(void*)info;
- (void)successData:(id)data withFutherInfo:(void*)info;
- (void)timeoutwithFutherInfo:(void*)info;

-(void)handleErrorWithTip:(NSString*)tip;

-(void)handleErrorWithTip:(NSString*)tip returnCode:(int)code;
- (NSInteger)getErrorCode;

@end


