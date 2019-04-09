//
//  NetworkAdaptor.m
//  THFlower
//
//  Created by Tata on 2017/3/23.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "NetworkAdaptor.h"
//#import "HYBNetWorking.h"

@implementation NetworkAdaptor

+ (void)getWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    [HYBNetworking enableInterfaceDebug:YES];
    //设置公共请求头
    NSString *DFID = [IHUtility getUserDefalutsKey:@"DFID"];
    [HYBNetworking configCommonHttpHeaders:@{@"Authorization" : [NSString stringWithFormat:@"userId %@",DFID], @"Source" : @"2",@"lat" : @"", @"lng" : @""}];
    // 配置请求和响应类型，由于部分的服务器不接收JSON传过去，现在默认值改成了plainText
    [HYBNetworking configRequestType:kHYBRequestTypePlainText
                        responseType:kHYBResponseTypeJSON
                 shouldAutoEncodeUrl:YES
             callbackOnCancelRequest:NO];
    [HYBNetworking getWithUrl:url refreshCache:YES params:parameter success:^(id response) {
        success(response);
    } fail:^(NSError *error) {
        failure(error);
    }];
    
}

+ (void)postWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    [HYBNetworking enableInterfaceDebug:YES];
    //设置公共请求头
//    [HYBNetworking configCommonHttpHeaders:@{@"Authorization" : [NSString stringWithFormat:@"userId %@",UserModel.Id], @"lat" : @"", @"lng" : @""}];
     NSLog(@"%@ -- ",[NSString stringWithFormat:@"userId %@",UserModel.Id]);
     NSString *DFID = [IHUtility getUserDefalutsKey:@"DFID"];
     [HYBNetworking configCommonHttpHeaders:@{@"Authorization" : [NSString stringWithFormat:@"userId %@",DFID], @"Source" : @"2", @"lat" : @"", @"lng" : @""}];
    
    // 配置请求和响应类型，由于部分的服务器不接收JSON传过去，现在默认值改成了plainText
    [HYBNetworking configRequestType:kHYBRequestTypePlainText
                        responseType:kHYBResponseTypeJSON
                 shouldAutoEncodeUrl:YES
             callbackOnCancelRequest:NO];
    [HYBNetworking postWithUrl:url refreshCache:YES params:parameter success:^(NSDictionary *response) {
         success(response);
     } fail:^(NSError *error) {
         failure(error);
     }];
}



@end
