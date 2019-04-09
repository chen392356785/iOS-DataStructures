//
//  UserInfoModel.m
//  YouzaniOSDemo
//
//  Created by youzan on 15/11/6.
//  Copyright (c) 2015年 youzan. All rights reserved.
//

//#import "IHBaseUser.h"
#import "CacheUserInfo.h"

@implementation CacheUserInfo

#pragma mark - Public Method

+ (instancetype)sharedManage {
    static CacheUserInfo *shareManage = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareManage = [[self alloc] init];
        
        [shareManage resetUserValue];
    });
    return shareManage;
}

- (void)resetUserValue {
    
    
    NSString *gender=[NSString stringWithFormat:@"%d",USERMODEL.sex];
     [self setProperty:@"gender" Value:gender];
    [self setProperty:@"userId" Value:USERMODEL.userID];//买家的唯一标示
    [self setProperty:@"name" Value:USERMODEL.nickName];
    [self setProperty:@"telephone" Value:USERMODEL.mobile];
    [self setProperty:@"avatar" Value:@""];
//    NSString *isLogin = [NSString stringWithFormat:@"%zd",UserIsLogin];
    [self setProperty:@"isLogined" Value:@"YES"];
}

- (void)setUser:(IHBaseUser *)user{
    
    [self setProperty:@"gender" Value:[NSString stringWithFormat:@"%d",USERMODEL.sex]]; //性别
    
    [self setProperty:@"userId" Value:user.userID];//买家的唯一标示
    
    [self setProperty:@"name" Value:user.userName];
    
    [self setProperty:@"telephone" Value:user.mobile];
    
    [self setProperty:@"isLogined" Value:@"YES"];
    
    [self setProperty:@"avatar" Value:@""];
    
}

//+ (YZUserModel *) getYZUserModelFromCacheUserModel:(CacheUserInfo *)cacheModel {
//    
//    YZUserModel *userModel = [[YZUserModel alloc] init];
//    userModel.userID = cacheModel.userId;
//    userModel.userName = cacheModel.name;
//    userModel.nickName = cacheModel.name;
//    userModel.gender = cacheModel.gender;
//    userModel.avatar = cacheModel.avatar;
//    userModel.telePhone = cacheModel.telephone;
//    return userModel;
//}

#pragma mark - Private Method

- (void)setProperty:(NSString *)key Value:(NSString *)value {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Setter And Getter

- (void)setUserId:(NSString *)userId {
    [self setProperty:@"userId" Value:userId];
}

- (void)setGender:(NSString *)gender {
    [self setProperty:@"gender" Value:gender];
}

- (void)setName:(NSString *)name {
    [self setProperty:@"name" Value:name];
}

- (void)setTelephone:(NSString *)telephone {
    [self setProperty:@"telephone" Value:telephone];
}

- (void)setAvatar:(NSString *)avatar {
    [self setProperty:@"avatar" Value:avatar];
}

- (void)setIsLogined:(BOOL)isLogined {
    if(isLogined) {
        [self setProperty:@"isLogined" Value:@"YES"];
    } else {
        [self setProperty:@"isLogined" Value:@"NO"];
    }
}

- (NSString *)userId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
}

- (NSString *)gender {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"gender"];
}

- (NSString *)name {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
}

- (NSString *)telephone {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"telephone"];
}

- (NSString *)avatar {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
}

- (BOOL) isLogined {
    
    NSString *isLogined = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
    if(isLogined == nil || isLogined.length == 0) {
        return NO;
    }
    return [isLogined isEqualToString:@"YES"];
}

@end
