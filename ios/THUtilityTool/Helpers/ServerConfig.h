//
//  ServerConfig.h
//  Owner
//
//  Created by Neely on 2018/3/26.
//

#import <Foundation/Foundation.h>

#define TG_HTTP_IMAGE_URL @"http://yz.91thd.com/"

@interface ServerConfig : NSObject

/*
上传图片域名
*/
//+ (NSString *)HttpsUploadServer;

// 普通HTTP API_URL
+ (NSString *)HTTPServer;


+ (void)setHTTPServer:(NSString *)HTTPServer;

//重设服务器
//+(void)reSetTestHttp;


//切换服务器选择项
+(NSString *)getDevelopHTTP;

+(NSString *)getTestHTTP;

+(NSString*)getHTTP;



@end
