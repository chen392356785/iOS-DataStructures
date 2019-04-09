//
//  OAuainfo.h
//  testOA
//
//  Created by Li xuechuan on 10-10-30.
//  Copyright 2010 hurray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>
#import "IHBaseConfig.h"
#import "IHUtility.h"
#define CMCARRIER	@"1"
#define CUCARRIER	@"2"
#define CTCARRIER	@"3"


@interface JLUainfo : NSObject {
	
	NSString			*brand ; //品牌								//手机生产商
	NSString			*xinghao; //型号								//手机型号			
	NSString			*osVersion; //3gs							//操作系统
	NSString			*systemVersion; //固件版本 4.0.2				//固件版本
	NSString			*oaVersion;									//OA版本
	NSString			*IMSI;//
	NSString			*IMEI;//
	NSString			*phoneNum;									//手机号
	NSString			*carrier;									//运营商
	NSString			*cellID;									//cellID
	NSString			*resolution;								//分辨率
	NSString			*clientVersion;								//客户端版本号
	NSString			*osName;									//手机平台编号  iPhone为2
	int					version;
}
//@property (nonatomic, retain) NSString *brand;
//
//@property (nonatomic, retain) NSString *xinghao;
//
//@property (nonatomic, retain) NSString *systemVersion;
//
//@property (nonatomic, retain) NSString *osVersion;
//
//@property (nonatomic, retain) NSString *oaVersion;
//@property (nonatomic, retain) NSString *IMSI;
//@property (nonatomic, retain) NSString *IMEI;
//@property (nonatomic, retain) NSString *phoneNum;
//@property (nonatomic, retain) NSString *carrier;
//@property (nonatomic, retain) NSString *cellID;
//@property (nonatomic, retain) NSString *resolution;
//@property (nonatomic, retain) NSString *clientVersion;
//@property (nonatomic, retain) NSString *osName;

@property int version;



+(JLUainfo*)getInstance;
-(NSString*)getUA;
+(int)sdkVersion;
+(NSString*)deviceModel;
-(int)getUA:(NSString**)UA;
+(int)canSendSms;

//- (NSString*)getSystemVersion;


@end
