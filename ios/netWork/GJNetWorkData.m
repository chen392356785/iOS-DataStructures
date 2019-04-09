//
//  GJNetWorkData.m
//  HouseRent
//
//  Created by GanJi on 10-7-8.
//  Copyright 2010 ganji.com. All rights reserved.
//

#import "GJNetWorkData.h"

//#import "MinshengBank_RichnessAppDelegate.h"


@implementation GJNetWorkData

@synthesize delegate, httpRequest, tag, resultDic;

@synthesize tempTransactionID;

- (id)init
{
    self = [super init];
	if( self )
	{
		httpRequest = [[GJHttpConnect alloc]init];
		
	}
	return self;
}

- (void)dealloc
{
	self.delegate = nil;
	[self cancelHttpConnect];
	[httpRequest release];
	[super dealloc];
}

- (void)successData:(id)data withFutherInfo:(void*)info
{
	[delegate networkData:self successful:Network_Success statusString:nil];
	
	[self finishHttpConnect];
}



- (void)failedwithFutherInfo:(void*)info
{
    [self handleErrorWithTip:ErrorTip_Default];
}

-(void)handleErrorWithTip:(NSString*)tip
{
    if ([delegate respondsToSelector:@selector(removeWaitingView)]) {
        [delegate performSelector:@selector(removeWaitingView)];
    }
    
    //lixj 如果是长连接,则不弹出提示框
    if (httpRequest.longConnect == YES) {
        [self performSelector:@selector(handleErrorForLongConnect) withObject:nil];
        return;
    }
    
    if (self.tag == IH_Init) {
        [IHUtility AlertMessage:@"" message:tip delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"重试" tag:3888]; 
    }
    else
    {
        
        [delegate networkData:self successful:Network_Error statusString:tip];
        [IHUtility addSucessView:tip type:2];
        //[IHUtility AlertMessage:@"" message:tip delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil tag:3872];
    }
}

-(void)handleErrorForLongConnect
{
    [delegate networkData:self successful:Network_Error statusString:ErrorTip_Error];
    [self finishHttpConnect];
}

-(void)handleErrorWithTip:(NSString*)tip returnCode:(int)code
{
    returnCode = code;
    
    if ([delegate respondsToSelector:@selector(removeWaitingView)]) {
        [delegate performSelector:@selector(removeWaitingView)];
    }
    
    if (httpRequest.longConnect == YES) {
        [self performSelector:@selector(handleErrorForLongConnect) withObject:nil];
        return;
    }
    
    if (self.tag == IH_Init) {
        [IHUtility AlertMessage:@"" message:tip delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"重试" tag:3888]; 
    }
    else
    {
        
        if (code == -112004) {
            [IHUtility AlertMessage:@"" message:tip delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil tag:2973];
        }else if(code==600){
            [delegate networkData:self successful:Network_Error statusString:ErrorTip_Error];
             [self finishHttpConnect];
        }
        else {
            [IHUtility AlertMessage:@"" message:tip delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil tag:3872];
        }
    }    
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 3888) {
        if (buttonIndex == 0) {
            exit(0);
            return;
        }
    }
    
    if (returnCode == -212037)
        [delegate networkData:self successful:Network_Success statusString:nil];
    else
        [delegate networkData:self successful:Network_Error statusString:ErrorTip_Error];
    
    if (returnCode == -112004 || returnCode == -250003 || returnCode == -211006 ||returnCode == -100005 || returnCode == -100001) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"handleLogin" object:nil];
    }
    
    [self finishHttpConnect];
}



- (void)timeoutwithFutherInfo:(void*)info
{
    
    //超市算异常
    if ([delegate respondsToSelector:@selector(handleNetworkData:successful:statusString:)]) {
        if ([delegate handleNetworkData:self successful:Network_TimeOut statusString:nil]){
            [self finishHttpConnect];
            return;
        }
    }
    
    
    [self handleErrorWithTip:ErrorTip_TimeOut];
    //超市算异常
 
	 
}

- (void)setHttpConnectFinishedMethod:(GJHttpConnect*)httpconnect
{
	if( beenRetained == FALSE && delegate != nil )
	{
        beenRetained = TRUE;
		[(NSObject*)delegate retain];
	}
	
	[httpconnect setTarget:self withSuccessAction:@selector(successData:withFutherInfo:) withFailedAction:@selector(failedwithFutherInfo:) withTimeOutAction:@selector(timeoutwithFutherInfo:)];
}

- (void)finishHttpConnect
{
	if( beenRetained )
    {
        beenRetained = FALSE;
        [(NSObject*)delegate release];
    }
}


- (void)cancelHttpConnectMenutal
{
    [httpRequest cancelConnection]; 
    [delegate networkData:self successful:Network_Cancel statusString:nil]; 
	//[self finishHttpConnect];   
}


- (void)cancelHttpConnect
{
	[self finishHttpConnect];
	[httpRequest cancelConnection];
}

- (NSDictionary*)setStatisticInfoInHeadField:(NSDictionary*)headField
{
	NSMutableDictionary* newDic = [NSMutableDictionary dictionaryWithCapacity:[headField count]+3];
	
	[newDic addEntriesFromDictionary:headField];
	
	[newDic setObject:@"gzip" forKey:@"Accept-Encoding"];
	//[newDic setObject:[GJSystemUtil dateString:[NSDate date] withFormat:@"yyyy-M-d H:m"] forKey:@"ClientTimeStamp"];

	return newDic;
}


- (NSInteger)getErrorCode
{
    return httpRequest.errorCode;
}

@end
