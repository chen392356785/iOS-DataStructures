//
//  NetworkAdaptor.h
//  THFlower
//
//  Created by Tata on 2017/3/23.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkAdaptor : NSObject

+ (void)getWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

+ (void)postWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

@end
