//
//  HttpRequest.m
//  THFlower
//
//  Created by Tata on 2017/3/23.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "HttpRequest.h"
#import "NetworkAdaptor.h"
#import "UrlString.h"
#import "DFConstant.h"
#import "HttpConstant.h"

@implementation HttpRequest

#pragma mark - 登录
+ (void)postUserLoginWithLoginType:(NSString *)loginType phone:(NSString *)phone accessToken:(NSString *)accessToken headerImage:(NSString *)headerImage Id:(NSString *)Id nick:(NSString *)nick genderType:(NSString *)genderType userName:(NSString *)userName uagent:(NSString *)uagent signature:(NSString *)signature success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    NSString *url = [UrlString loginUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpLoginType] = loginType;
    param[HttpPhone] = phone;
    param[HttpToken] = accessToken;
    param[HttpId] = Id;
    param[HttpNick] = nick;
    param[HttpGenderType] = genderType;
    param[HttpUAgent] = uagent;
    param[HttpSignature] = signature;
    param[HttpHeadImage] = headerImage;
    param[HttpUAgentType] = @"3";
    
    [NetworkAdaptor postWithUrl:url parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 修改用户信息
+ (void)postUpdateUserInfoWith:(NSString *)Id nick:(NSString *)nick headImage:(NSString *)headImage signature:(NSString *)signature genderType:(NSString *)genderType success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    NSString *url = [UrlString updateUserInfoUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpId] = Id;
    param[HttpNick] = nick;
    param[HttpHeadImage] = headImage;
    param[HttpSignature] = signature;
    param[HttpGenderType] = genderType;
    
    [NetworkAdaptor postWithUrl:url parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/*发送验证码*/
+ (void)postPhoneCodeWithPhoneNum:(NSString *)phoneNum withPhoneCode:(NSString *)numCode withTime:(NSString *)time success:(void(^)(NSDictionary * result))success failure:(void(^)(NSString * message))failure
{
    //ip格式如下，不需要带https://
    CCPRestSDK * ccpRestSdk = [[CCPRestSDK alloc] initWithServerIP:@"sandboxapp.cloopen.com" andserverPort:8883];
    //创建的应用ID
    [ccpRestSdk setApp_ID:CCPRestSDKAppId];
    //是否打印Log
    [ccpRestSdk enableLog:YES];
    //账户的ID和Token
    [ccpRestSdk setAccountWithAccountSid: CCPRestSDKAccountSid andAccountToken:CCPRestSDKAccountToken];
    //设置包体类型
    [ccpRestSdk setBodyType:EType_JSON];
    
    NSArray *arr = [NSArray arrayWithObjects:numCode,time,nil];
    
    NSMutableDictionary * dict = [ccpRestSdk sendTemplateSMSWithTo:phoneNum andTemplateId:CCPRestSDKModelId andDatas:arr];
    if (![[dict objectForKey:@"statusCode"]isEqualToString:@"000000"])
    {
        failure([dict objectForKey:@"statusMsg"]);
    }
    else
    {
        success(dict);
    }
}
//语音验证码
+ (void)postPhoneVerifyCodeWithPhoneNum:(NSString *)phoneNum andVerifyCode:(NSString *)content success:(void(^)(NSDictionary * result))success failure:(void(^)(NSString * message))failure
{
    //ip格式如下，不需要带https://
    CCPRestSDK * ccpRestSdk = [[CCPRestSDK alloc] initWithServerIP:@"app.cloopen.com" andserverPort:8883];
    //创建的应用ID
    [ccpRestSdk setApp_ID:CCPRestSDKAppId];
    //是否打印Log
    [ccpRestSdk enableLog:YES];
    //账户的ID和Token
    [ccpRestSdk setAccountWithAccountSid: CCPRestSDKAccountSid andAccountToken:CCPRestSDKAccountToken];
    //设置包体类型
    [ccpRestSdk setBodyType:EType_JSON];
    NSMutableDictionary * dict = [ccpRestSdk voiceVerifyWithVerifyCode:content andTo:phoneNum andDisplayNum:nil andPlayTimes:3 andRespUrl:nil];
    if (![[dict objectForKey:@"statusCode"]isEqualToString:@"000000"])
    {
        failure([dict objectForKey:@"statusMsg"]);
    }
    else
    {
        success(dict);
    }
}


#pragma mark - 识别图片
+ (void)getDiscernPhotoInfoWith:(NSString *)base64 cameraType:(NSInteger)cameraType success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {

    NSString *url = [UrlString discernPhotoUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpImageData] = base64;
    param[HttpCameraType] = @(cameraType);
    param[HttpFilePath] = @"";
    
    [NetworkAdaptor postWithUrl:url parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 生成美图
+ (void)getPhotosWith:(NSString *)imageId success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    NSString *url = [UrlString creatPhotosUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpGecogId] = imageId;
    
    [NetworkAdaptor getWithUrl:url parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 鉴定列表
+ (void)getDiscernListWithSource:(NSInteger)source page:(NSInteger)page success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    NSString *url = [UrlString discernListUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpPageNum] = @(page);
    param[HttpSource] = @(source);
    param[HttpUserId] = USERMODEL.userID;
    
    [NetworkAdaptor getWithUrl:url parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 请高手鉴别
+ (void)postMasterDiscernWith:(NSString *)guid success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    
    NSString *url = [UrlString masterDiscernUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpGuid] = guid;
    NSString *urla = [url stringByAppendingString:[NSString stringWithFormat:@"?guid=%@",guid]];
    
    [NetworkAdaptor postWithUrl:urla parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 评论列表
+ (void)getCommentListInfoWith:(NSString *)recogId nowPage:(NSInteger)nowPage success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    NSString *url = [UrlString commentListUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpRecogId] = recogId;
    param[HttpNowPage] = @(nowPage);
    
    [NetworkAdaptor getWithUrl:url parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 添加评论
+ (void)postAddCommentInfoWith:(NSString *)recogId content:(NSString *)content success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    NSString *url = [UrlString addCommentInfoUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpRecogId] = recogId;
    param[HttpContent] = content;
    
    [NetworkAdaptor postWithUrl:url parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 是此花
+ (void)postConfirmFlowerWith:(NSString *)recogId success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    NSString *url = [UrlString isThisFlowerUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"recogId"] = recogId;
    
    NSString *urla = [url stringByAppendingString:[NSString stringWithFormat:@"?recogId=%@",recogId]];
    
    [NetworkAdaptor postWithUrl:urla parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 吐槽
+ (void)postShitWith:(NSString *)feedType feedContent:(NSString *)feedContent success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure {
    NSString *url = [UrlString shitUrl];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[HttpFeedType] = feedType;
    param[HttpFeedContent] = feedContent;
    
    [NetworkAdaptor postWithUrl:url parameter:param success:^(NSDictionary *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//识花登录
+ (void)loginDiscernFlowerSuccess:(void(^)(BOOL isSuccess))success {
    NSString *userId = [NSString stringWithFormat:@"0000%@",USERMODEL.userID];
    [HttpRequest postUserLoginWithLoginType:@"2" phone:USERMODEL.mobile accessToken:userId headerImage:USERMODEL.userHeadImge Id:@"" nick:USERMODEL.nickName genderType:@"" userName:@"" uagent:@"" signature:@"" success:^(NSDictionary * result) {
        
        if ([result[DFErrCode]integerValue] == 200) {
            NSDictionary *dic = result[DFData];
            if (dic==nil || ![dic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            [IHUtility setUserDefalutsKey:[dic objectForKey:@"Id"] key:@"DFID"];
            success(YES);
        }else {
            success(NO);
        }
        
    } failure:^(NSError *error) {
        success(NO);
    }];
}

@end
