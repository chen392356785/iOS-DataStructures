//
//  OAuainfo.m
//  testOA
//
//  Created by Li xuechuan on 10-10-30.
//  Copyright 2010 hurray. All rights reserved.
//

#import "JLUainfo.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

//#import "smsType.h"


static JLUainfo *ua = nil;

@implementation JLUainfo

//@synthesize brand;
//@synthesize xinghao;
//
//
//@synthesize systemVersion;
//@synthesize osVersion;
//@synthesize oaVersion;
//@synthesize IMSI;
//@synthesize IMEI;
//@synthesize phoneNum;
//@synthesize carrier;
//@synthesize cellID;
//
//
@synthesize version;
//@synthesize resolution;
//@synthesize osName;
//@synthesize clientVersion;


//- (NSString*)getSystemVersion
//{
//	return systemVersion;
//	
//}


- (NSString*)getCarrier
{
	
	CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
	CTCarrier *carrier2 = info.subscriberCellularProvider;
	
#pragma mark 标记没卡的情况
	
	NSLog(@"carrier:%@", [carrier2 description] );
	NSLog(@"%@ \n", [carrier2 carrierName]);
	
	if([carrier2 description] == nil)return @"";
	
	if([[carrier2 carrierName] isEqualToString:@"中国移动"]) //107  -->1
	{
		return CMCARRIER;
	}
	else if([[carrier2 carrierName] isEqualToString:@"中国联通"]){
		
		return CUCARRIER;
	}
	else {
		return CTCARRIER;
	}
	
	
}


//-(int)getUA:(NSString**)UA
//{
//	if(*UA)
//	{
//		[*UA release];
//	}
//	
//	
//	*UA = [[NSString alloc] initWithFormat:@"%@/%@/%@/%@/%@/%@/%@/%@/%@/%@",brand,xinghao,osVersion, systemVersion,oaVersion,IMSI,IMEI,phoneNum,carrier,cellID];
//	
//	
//	return 1;
//	
//}


- (NSString*)getUA
{
    
   // return @"htccn_chs_ct^HTC S710d^Android^2.3.4^A100000D91BA8B^460030131133098^9";
    
    
	NSString *str = [[NSString alloc] initWithFormat:@"%@^%@^%@^%@^%@^%@^%@",brand,xinghao,osVersion, systemVersion,IMEI,IMSI, VERSION];
	
	NSLog(@"getUA = %@ \n",str);
	
	return str;
	
}
+(NSString*)deviceModel
{
	UIDevice* device = [UIDevice currentDevice];
	
	NSLog(@"%@ \n", [device model]);
	
#pragma mark 不一定准确
	//return @"iPhone";
	return [device model];
}

+(int)canSendSms
{
	UIDevice* device = [UIDevice currentDevice];
	int vv = [[device systemVersion] intValue];
	if(vv >=4 && [[device model] isEqualToString:@"iPhone"])
		return 0;
	
	return 1;
}


+(int)sdkVersion
{
	UIDevice* device = [UIDevice currentDevice];
	int vv = [[device systemVersion] intValue];
	return vv;	
}


+(JLUainfo*)getInstance
{
	if(ua == nil)
	{
		ua = [[JLUainfo alloc] init];
	}
	return ua;
	
}



- (id)init{
	
	if(self = [super init])
	{
		
		UIDevice* device = [UIDevice currentDevice];
		
		systemVersion = [[NSString alloc] initWithString:[device systemVersion]];
		version = [systemVersion intValue];
		
		brand = [[NSString alloc] initWithString:@"Apple Computer, Inc."];
		xinghao= [[NSString alloc] initWithString:[device systemName]];
		
		xinghao = [xinghao stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
		
		osVersion = [[NSString alloc] initWithString:[device systemVersion]];
		
		osVersion = [osVersion stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
		
		oaVersion = [[NSString alloc] initWithString:@"2.1"];
		IMSI = [[IHUtility getIMSI] retain];
        //[[NSString alloc] initWithString:@""];
		IMEI = [[IHUtility getIMEI] retain];
        //[[NSString alloc] initWithString:[device uniqueIdentifier]];
		phoneNum = [[NSString alloc]initWithString:@""];//[[DataStorage getInstance] getPhoneNum]];
		carrier = [[NSString alloc]initWithString:[self getCarrier]];//[[NSString alloc] initWithFormat:@""];//@"%d", [smsType getType]];
		//carrier = [[NSString alloc]initWithString:@""];
		cellID = [[NSString alloc] initWithString:@""];
		
		CGRect rect = [UIScreen mainScreen].bounds;
		
		CGFloat fscale = [UIScreen mainScreen].scale;
		
		resolution = [[NSString alloc] initWithFormat:@"%d|%d", (NSInteger)(rect.size.width*fscale), (NSInteger)(rect.size.height*fscale)];
		clientVersion =[[NSString alloc] initWithString:@""];
		osName = [[NSString alloc] initWithString:@"2"];
		
	}
	return self;
}

- (void)dealloc
{
	
	[systemVersion release];
	[brand release];
	[xinghao release];
	[osVersion release];
	[oaVersion release];
	[IMSI release];
	[IMEI release];
	[phoneNum release];
	[carrier release];
	[cellID release];
	
	[resolution release];
	[clientVersion release];
	[osName release];
	
	
	[super dealloc];
}


@end
