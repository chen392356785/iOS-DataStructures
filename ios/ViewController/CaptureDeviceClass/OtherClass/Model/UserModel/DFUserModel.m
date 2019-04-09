//
//  DFUserModel.m
//  DF
//
//  Created by Tata on 2017/12/4.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFUserModel.h"

@implementation DFUserModel

static DFUserModel * userModel = nil;

+ (DFUserModel *)shareUserModel {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        userModel = [[DFUserModel alloc]init];
    });
    return userModel;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        self.Id =[userDefaults objectForKey:@"Id"] == nil ? @"" : [userDefaults objectForKey:@"Id"];
        self.Nick =[userDefaults objectForKey:@"Nick"] ==nil?@"":[userDefaults objectForKey:@"Nick"];
        self.GenderType =[userDefaults objectForKey:@"GenderType"]   ==nil?@"":[userDefaults objectForKey:@"GenderType"];
        self.UserName  =[userDefaults objectForKey:@"UserName"] ==nil?@"":[userDefaults objectForKey:@"UserName"];
        self.UAgent =[userDefaults objectForKey:@"UAgent"]==nil?@"":[userDefaults objectForKey:@"UAgent"];
        self.LoginType =[userDefaults objectForKey:@"LoginType"]==nil?@"":[userDefaults objectForKey:@"LoginType"];
        self.Signature =[userDefaults objectForKey:@"Signature"]==nil?@"":[userDefaults objectForKey:@"Signature"];
        self.HeadImage = [userDefaults objectForKey:@"HeadImage"]==nil?@"":[userDefaults objectForKey:@"HeadImage"];
        self.isLogin       =[userDefaults boolForKey:@"login"];
        
        if ([self.Id isEqualToString:@"(null)"] || self.Id == nil) {
            [self setDefault];
        }
    }
    return self;
}
//
//-(void)clearUserInfo {
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults removeObjectForKey:@"Id"];
//    [userDefaults removeObjectForKey:@"Nick"];
//    [userDefaults removeObjectForKey:@"GenderType"];
//    [userDefaults removeObjectForKey:@"UserName"];
//    [userDefaults removeObjectForKey:@"UAgent"];
//    [userDefaults removeObjectForKey:@"Signature"];
//    [userDefaults removeObjectForKey:@"LoginType"];
//    [userDefaults removeObjectForKey:@"HeadImage"];
//    [userDefaults removeObjectForKey:@"login"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    
//    [self setDefault];
//}

- (void)setDefault {
    self.Id          =@"";
    self.Nick    =@"";
    self.GenderType      =@"";
    self.UserName    =@"";
    self.UAgent   =@"";
    self.Signature   =@"";
    self.LoginType =@"";
    self.HeadImage = @"";
    self.isLogin         =NO;
}

@end
