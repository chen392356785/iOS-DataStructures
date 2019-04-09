//
//  IHBaseUser.h
//  IHBaseProject
//
//  Created by yaoyongping on 13-1-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IHBaseUser : NSObject{
   
 
}

@property(nonatomic, strong) NSString* userID;
 
@property(nonatomic,strong) NSString * userHeadImge40;  //缩略图
@property(nonatomic,strong) NSString * userHeadImge;   //原图
@property(nonatomic,strong) NSString *token;
@property(nonatomic) BOOL isLogin;
@property(nonatomic,strong) NSString *userHeadImge80;
@property(nonatomic,strong) NSString *companyName;  //公司名称
@property(nonatomic,strong) NSString *hxPassword;   //环信密码
@property(nonatomic,strong) NSString *hxUserName;   //环信用户名
@property(nonatomic,retain)NSString *mobile;
@property(nonatomic,strong)NSString *nickName;  //昵称
@property(nonatomic) int sex;  //性别
@property (nonatomic ,assign) int auth_status;
@property(nonatomic,strong)NSString *userName ;  //手机号， 也是账号
@property(nonatomic) int hyTypeID;  //行业ID  
@property(nonatomic,strong)NSString *Url; //前半部 头像链接
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat longitude;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *province;
@property(nonatomic)int identity_key;  //用户等级
@property(nonatomic) int user_authentication;//认证
@property(nonatomic)int map_callout; //是否地图标记 0是没有标记
@property(nonatomic,copy)NSString *userHeadImgPath; //没有拼接域名的URl
@property(nonatomic)int isDue; //是否为vip  1是 0否


-(void)setUserInfo:(NSDictionary *)dic;
-(void)removeUserModel;
+(IHBaseUser*)shareUserModel;
 
@end

#define USERMODEL [IHBaseUser shareUserModel]
