

#import "GJHttpConnect.h"
#import "YAJL.h"
//#import "zlib.h"

//#define GZipBufferLength 1024*10
//unsigned char outBuffer[GZipBufferLength];

@interface GJHttpConnect()
- (id)jsonEncodeFromData:(NSData*)data;
- (BOOL)startJsonDecode;
- (BOOL)jsonDecodeWithData:(NSData*)data;
- (id)endJsonDecode;

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
@end



@implementation GJHttpConnect
@synthesize delegate,jsonEncode,gzipEncode , errorCode, longConnect;
- (id)init
{
    self = [super init];
	if( self )
	{
        longConnect = NO;
	}
	return self;
}

- (void)dealloc
{
	[self endConnection];
	self.delegate = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Pre Setting
- (void)setTarget:(id)target1 withSuccessAction:(SEL)action1 withFailedAction:(SEL)action2 withTimeOutAction:(SEL)action3
{
	target = target1;
	successAction = action1;
	failedAction = action2;
	timeoutAction = action3;

}

- (void)preCreateConnectRequestWithURL:(NSString *)urlString
{
	[self cancelConnection];
	if( downloadURL )[downloadURL release];
	downloadURL = [urlString retain];
	
	NSURL *url = [NSURL URLWithString:urlString ];
	
	connectionRequest = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
}

- (void)setHttpBody:(NSData*)postData
{
	[connectionRequest setHTTPBody:postData];
}

- (void)setHttpMethod:(NSString*)methodString
{
	[connectionRequest setHTTPMethod:methodString];
}

- (void)setHttpHeader:(NSDictionary*)allHeadInfo
{
	[connectionRequest setAllHTTPHeaderFields:allHeadInfo];
}






#pragma mark Http Connection 
- (void)startCreatedConnectWithFurtherInfo:(void*)exterInfo
{
    //no use
//	if( !connectionRequest )
//		return FALSE;
	
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
	furtherInfo = exterInfo;
	
	urlConnection = [[NSURLConnection alloc] initWithRequest:connectionRequest delegate:self startImmediately:YES];
	
	[connectionRequest release];
	connectionRequest = nil;


    //NSLog(@"startCreatedConnectWithFurtherInfo");
    
    [self performSelector:@selector(requestTimeOut) withObject:nil afterDelay:20];
    
	//lixj no use
//    if (!urlConnection)
//	{
//		[self endConnection];
//		return FALSE;
//	}
//	
//	return TRUE;
}

//lixj no use
//- (BOOL)startConnection:(NSString *)urlString withFurtherInfo:(void*)exterInfo
//{
//	[self cancelConnection];
//	
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
//	
//	if( downloadURL )[downloadURL release];
//	downloadURL = [urlString retain];
//	furtherInfo = exterInfo;
//	
//	NSURL *url = [NSURL URLWithString:urlString ];
//	
//	connectionRequest = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0];
//	urlConnection = [[NSURLConnection alloc] initWithRequest:connectionRequest delegate:self startImmediately:YES];
//	
//	[connectionRequest release];
//	connectionRequest = nil;
//	
//    if (!urlConnection)
//	{
//		[self endConnection];
//		return FALSE;
//	}
//	
//	return TRUE;
//}

- (void)endConnection
{
	if( urlConnection != nil )
	{
		[urlConnection release];
		urlConnection = nil;
	}
	if( connectionData != nil )
	{
		[connectionData release];
		connectionData = nil;
	}
	
	if( responseHttpHeaderFields )
	{
		[responseHttpHeaderFields release];
		responseHttpHeaderFields = nil;
	}
	
	[downloadURL release];
	downloadURL = nil;
}

- (void)cancelConnection
{
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestTimeOut) object:nil];
	if(urlConnection)[urlConnection cancel];
	
	[self endConnection];
}

#pragma mark Http Final Data Info
//lixj no use
//- (NSData*)getUrlFinalData
//{
//	return connectionData;
//}

- (NSString*)reponseHeadInfoWithField:(NSString*)field
{
	return [responseHttpHeaderFields valueForKey:field];
}

- (NSInteger)reponseStatusCode
{
	return responseStatusCode;
}

#pragma mark -
#pragma mark  URLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
	
	if( responseHttpHeaderFields )
	{
		[responseHttpHeaderFields release];
		responseHttpHeaderFields = nil;
	}
	
	if( [response isKindOfClass:[NSHTTPURLResponse class]] )
	{
		NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
		responseStatusCode = [httpResponse statusCode];
		responseHttpHeaderFields = [[httpResponse allHeaderFields]retain];
	}
	
	httpConnectExpectedSize = [response expectedContentLength];
	if( httpConnectExpectedSize == NSURLResponseUnknownLength )
		httpConnectExpectedSize = 0;
	
	if (connectionData)
	{
		[connectionData setLength:0];
	}
	else 
	{
		connectionData = [[NSMutableData alloc]initWithCapacity:httpConnectExpectedSize];
		if( jsonEncode && !gzipEncode )
		{
			if( [self startJsonDecode]==FALSE )
			{
				[self cancelConnection];
				[self connection:connection didFailWithError:nil];
			}
		}
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //lixj 这个不是真正意义的长连接
//    if (longConnect)
//    {
//        NSString* tmp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        if( target && [target respondsToSelector:successAction] )
//            [target performSelector:successAction withObject:tmp withObject:furtherInfo];
//        [tmp release];
//    }
//    else
    {
        NSData* newData = data;
        
        if (connectionData)[connectionData appendData:newData];
        
        if( jsonEncode && !gzipEncode )
        {
            if( [self jsonDecodeWithData:newData] == FALSE )
            {
                [self cancelConnection];
                [self connection:connection didFailWithError:nil];
            }
        }
        
        if ([(NSObject*)delegate respondsToSelector:@selector(httpConnect:downloadedSize:expectedSize:)])
            [delegate httpConnect:self downloadedSize:[connectionData length] expectedSize:httpConnectExpectedSize];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    [NSObject cancelPreviousPerformRequestsWithTarget:self];    
	
	id downloadObject = nil;
	if( jsonEncode && !gzipEncode )
		downloadObject = [self endJsonDecode];
	else if( jsonEncode && gzipEncode )
	{
		downloadObject = [self jsonEncodeFromData:connectionData];
	}
	else
		downloadObject = connectionData;
	
	if( target && [target respondsToSelector:successAction] )
		[target performSelector:successAction withObject:downloadObject withObject:furtherInfo];
	
    //lixj no use
	//[delegate httpConnect:self successDownloadData:downloadObject withFutherInfo:furtherInfo];
	
	[self endConnection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    NSLog(@"%@",[error localizedDescription]);
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
	
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
	if( jsonEncode && !gzipEncode ) [self endJsonDecode];
	
	[self endConnection];
    
    errorCode = [error code];
	
	if( [error code] == NSURLErrorTimedOut )
	{
		if( target && [target respondsToSelector:timeoutAction] )
			[target performSelector:timeoutAction withObject:furtherInfo];
		//no use
		//[delegate httpConnectDownloadDataTimeOut:self withFutherInfo:furtherInfo];
	}
	else
	{
		if( target && [target respondsToSelector:failedAction] ){
			
			//[target performSelector:failedAction withObject:furtherInfo];
			/* 低版本情况下无网络的情况下 crash*/
			[target performSelector:failedAction withObject:furtherInfo afterDelay:0];
	
		}
		//lixj no use
		//[delegate httpConnectDownloadDataFailed:self withFutherInfo:furtherInfo];
	}

}

-(void)requestTimeOut
{
   // NSLog(@"requestTimeOut");
    [self cancelConnection];
    if( target && [target respondsToSelector:timeoutAction] )
        [target performSelector:timeoutAction withObject:furtherInfo];
}




- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if ([(NSObject*)delegate respondsToSelector:@selector(httpConnect:didSendBodyData:totalBytesWritten:totalBytesExpectedToWrite:)])
        [delegate httpConnect:self didSendBodyData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
} 


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {    
    NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
} 

#pragma mark  JSON Decode
- (id)jsonEncodeFromData:(NSData*)data
{
	if( [data isKindOfClass:[NSData class]] == FALSE )
		return nil;
	
	NSError *error = nil;
	document = [[YAJLDocument alloc] initWithData:data parserOptions:YAJLParserOptionsNone error:&error];
	id root = [document.root retain];
	[document release];
	document = nil;
	return [root autorelease];
}

- (BOOL)startJsonDecode
{
	if( jsonDecodeStarted )[self endJsonDecode];

	jsonDecodeFinished = false;
	jsonDecodeStarted = true;
	NSError *error = nil;
	document = [[YAJLDocument alloc] initWithParserOptions:YAJLParserOptionsNone];
	if( YAJLParserStatusOK == [document readyParse:&error] )
		return TRUE;
	else
	{
		[document release];
		document = nil;
		return FALSE;
	}
	
}

- (BOOL)jsonDecodeWithData:(NSData*)data
{
	NSError *error = nil;
	YAJLParserStatus decodeStatus = [document startParse:data error:&error];
	if( decodeStatus == YAJLParserStatusOK )
	{
		jsonDecodeFinished = true;
		return TRUE;
	}
	else if( decodeStatus == YAJLParserStatusInsufficientData )
	{
		jsonDecodeFinished = false;
		return TRUE;
	}
	else
	{
		[document release];
		document = nil;
		return FALSE;
	}
}

- (id)endJsonDecode
{
	jsonDecodeStarted = false;
	
	if( jsonDecodeFinished )
	{
		id root = [document.root retain];
		[document release];
		document = nil;
		return [root autorelease];
	}
	else
	{
		[document release];
		document = nil;
		return nil;
	}
}


@end
