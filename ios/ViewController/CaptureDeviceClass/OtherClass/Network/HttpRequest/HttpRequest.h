//
//  HttpRequest.h
//  THFlower
//
//  Created by Tata on 2017/3/23.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

#pragma mark - 登录
+ (void)postUserLoginWithLoginType:(NSString *)loginType phone:(NSString *)phone accessToken:(NSString *)accessToken headerImage:(NSString *)headerImage Id:(NSString *)Id nick:(NSString *)nick genderType:(NSString *)genderType userName:(NSString *)userName uagent:(NSString *)uagent signature:(NSString *)signature success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 修改用户信息
+ (void)postUpdateUserInfoWith:(NSString *)Id nick:(NSString *)nick headImage:(NSString *)headImage signature:(NSString *)signature genderType:(NSString *)genderType success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 发送验证码
+ (void)postPhoneCodeWithPhoneNum:(NSString *)phoneNum withPhoneCode:(NSString *)numCode withTime:(NSString *)time success:(void(^)(NSDictionary * result))success failure:(void(^)(NSString * message))failure;

#pragma mark - 语音验证码
+ (void)postPhoneVerifyCodeWithPhoneNum:(NSString *)phoneNum andVerifyCode:(NSString *)content success:(void(^)(NSDictionary * result))success failure:(void(^)(NSString * message))failure;

#pragma mark - 识花
+ (void)getDiscernPhotoInfoWith:(NSString *)base64 cameraType:(NSInteger)cameraType success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 生成美图
+ (void)getPhotosWith:(NSString *)imageId success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 鉴定列表
+ (void)getDiscernListWithSource:(NSInteger)source page:(NSInteger)page success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 请高手鉴别
+ (void)postMasterDiscernWith:(NSString *)guid success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 评论列表
+ (void)getCommentListInfoWith:(NSString *)recogId nowPage:(NSInteger)nowPage success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 添加评论
+ (void)postAddCommentInfoWith:(NSString *)recogId content:(NSString *)content success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 是此花
+ (void)postConfirmFlowerWith:(NSString *)recogId success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

#pragma mark - 吐槽
//+ (void)postShitWith:(NSString *)feedType feedContent:(NSString *)feedContent success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;


#pragma mark - 登录
+ (void)loginDiscernFlowerSuccess:(void(^)(BOOL isSuccess))success;













@end
