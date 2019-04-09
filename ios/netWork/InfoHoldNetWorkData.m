//
//  InfoHoldNetWorkData.m
//  MinshengBank_Richness
//
//  Created by li xiangji on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoHoldNetWorkData.h"
 
//#define  APP_KEY_CampusWallet           @"600016"
//#define  APP_SECRET_CampusWallet       @"0Lcs8743SDLoUu0LM3fI6AF7y9MbB"


#define  APP_KEY_CampusWallet           @"600026"
#define  APP_SECRET_CampusWallet       @"u8c3J4dS5LeUu8PAZaHe9U3OI67y9Me"
 

//NSString* APP_KEY = @"600026";
//NSString* APP_SECRET = @"u8c3J4dS5LeUu8PAZaHe9U3OI67y9Me";


@implementation InfoHoldNetWorkData

@synthesize data,isStandardIterface,serverPath,attribute,m_processedResultDic;
//base接口

-(id)init{
    self=[super init];
    if (self) {
        self.isStandardIterface=YES;
        self.serverPath=serverURL;
    }
    
    return  self;
}
 
  
 
 
#pragma mark apns--
 
 
-(void)httpRequestWithParameter:(NSDictionary *)mutableDic method:(NSString *)method{
    
    
    NSString* parameter = [IHUtility getParameterString:mutableDic];
 
   // parameter= [IHUtility getParameterString:parameter];
//	NSString *service = @"http://12306.php10086.com/yupiao.php";
    
   
   
	NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"json2",@"contentformat",
                                 @"gzip" ,@"Accept-Encoding",
                                 nil];
 
    //  NSString *service = @"http://gezhonglunta.oicp.net:8080/ZhongJinShu/api?param=";
    NSString *service = [NSString stringWithFormat:@"%@%@?", serverURL,method];
     NSLog(@"total url:  %@%@", service, parameter);
    
   // parameter=[NSString stringWithFormat:@"param=%@", parameter];
	[httpRequest preCreateConnectRequestWithURL:service];
	[httpRequest setHttpHeader:dict];
    
    
    [httpRequest setHttpBody:[parameter dataUsingEncoding:NSUTF8StringEncoding]];
    
    [httpRequest setHttpMethod:@"POST"];
    
	    //NSString* postStr = [NSString stringWithFormat:@"%@", parameter];
    
    
    
  //  [httpRequest setHttpBody:[parameter dataUsingEncoding:NSUTF8StringEncoding]];
	[self setHttpConnectFinishedMethod:httpRequest];
	[httpRequest startCreatedConnectWithFurtherInfo:nil];
}
 
-(void)successData:(id)paraData withFutherInfo:(void*)info
{
    
    if([httpRequest reponseStatusCode] != 200)
	{
        NSLog(@"responsStatusCode :%d", [httpRequest reponseStatusCode]);
        [self handleErrorWithTip:ErrorTip_Server];
		return;
	}
    
    self.data = paraData;
    
    NSError *error;
    
    NSDictionary* dict = [paraData yajl_JSON:&error];
    self.m_processedResultDic = dict;
    NSLog(@"dic=%@", dict);
    int  code=[[dict objectForKey:@"code"]intValue];
    NSString *errorMessage=[dict objectForKey:@"message"];
    NSLog(@"return_message=%@",errorMessage);
    if(dict == nil)
    {
        if ([delegate respondsToSelector:@selector(handleNetworkData:successful:statusString:)])
        {
            if([delegate handleNetworkData:self successful:Network_TimeOut statusString:nil])
            {
                [self finishHttpConnect];
                return;
            }
            
        }
        
        [self handleErrorWithTip:ErrorTip_Server];
    }
    else if(code==600 || code ==602){
        [self parseResult:dict];
        [delegate networkData:self successful:Network_Error statusString:ErrorTip_Error];
        [self finishHttpConnect];
    }else if (code==-101){
       [IHUtility addSucessView:ErrorTip_Login type:2];
        //        return;
    }else if (code==0){
        [self parseResult:dict];
        [delegate networkData:self successful:Network_Success statusString:nil];
        [self finishHttpConnect];

    }
    else
    {
        if ([delegate respondsToSelector:@selector(handleNetworkData:successful:statusString:)])
        {
            [self parseResult:dict];
            if([delegate handleNetworkData:self successful:Network_Error statusString:dict])
            {
                
                [self finishHttpConnect];
                return;
            }
            
        }
   
        [self parseResult:dict];
        [self handleErrorWithTip:errorMessage];
    }
    
    
}


-(NSDictionary *)ResolveData:(NSData *)d{
    NSError *error;
    NSDictionary* dict = [d yajl_JSON:&error];
    NSLog(@"dic=%@",dict);
    NSString* return_code = [dict objectForKey:@"code"];
    int code = [return_code intValue];
    if (code==0) {
        return dict;
    }
    else {
        NSString* message = [dict objectForKey:@"message"];
        
        message = [NSString stringWithFormat:@"%d %@",code, message];
        
        NSLog(@"return_message:%@  and return Code =%d", message,code);
        
        [self handleErrorWithTip:message returnCode:code];
        return nil;
    }
}

-(void)parseResult:(NSDictionary*)dic
{
  	
    self.resultDic = dic;
}

-(void)dealloc
{
    self.data = nil;
    [serverPath release];
    [super dealloc];
}




@end
