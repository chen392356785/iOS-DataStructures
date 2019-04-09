//
//  ServerConfig.m
//  Owner
//
//  Created by Neely on 2018/3/26.
//

#import "ServerConfig.h"

#if defined(DEBUG)||defined(_DEBUG)

static NSString *_HttpService = @"http://101.201.31.194:18083/zmh/"; //开发
static NSString *_HttpOnlineService = @"https://www.miaoto.net/zmh/"; //正式
static NSString *_HttpTestService = @"http://192.168.1.138:8199/zmh/"; //测试

//static NSString *_currentHttp = @"http://192.168.1.138:8199/zmh/"; //正式 朱琪
//static NSString *_currentHttp  = @"https://www.miaoto.net/zmh/"; // 默认正式;
static NSString *_currentHttp = @"http://101.201.31.194:18083/zmh/"; //开发
#else

static NSString *_HttpService = @"http://192.168.1.168:8080/zmh/"; //开发
static NSString *_HttpOnlineService = @"https://www.miaoto.net/zmh/"; //正式
static NSString *_HttpTestService = @"http://101.201.31.194:18083/zmh/"; //测试

static NSString *_currentHttp  = @"https://www.miaoto.net/zmh/"; // 默认正式;
//static NSString *_currentHttp = @"http://192.168.1.138:8199/zmh/"; //正式 朱琪
#endif

/**********************************************************/

@implementation ServerConfig 

// 普通HTTP API_URL
+ (NSString *)HTTPServer
{
    return _currentHttp;
}


+(NSString*)getDevelopHTTP
{
    return _HttpService;
}

+(NSString *)getTestHTTP{
    return _HttpTestService;
}

+(NSString *)getHTTP{
    return _HttpOnlineService;
}

+ (void)setHTTPServer:(NSString *)HTTPServer
{
    _currentHttp = HTTPServer;
}

@end
