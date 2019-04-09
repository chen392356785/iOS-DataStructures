//
//  DFUserModel.h
//  DF
//
//  Created by Tata on 2017/12/4.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserModel [DFUserModel shareUserModel]

@interface DFUserModel : NSObject

//用户ID
@property (nonatomic, copy) NSString * Id;
//用户昵称
@property (nonatomic, copy) NSString * Nick;
//
@property (nonatomic, copy) NSString *GenderType;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *UAgent;

@property (nonatomic, copy) NSString *LoginType;

@property (nonatomic, copy) NSString *Signature;

@property (nonatomic, copy) NSString *HeadImage;


//是否登录
@property(nonatomic, assign)BOOL isLogin;
//是否绑定微信
@property(nonatomic, assign)BOOL isBindWX;

+ (DFUserModel *)shareUserModel;
/**
 *  清空用户信息
 */
//-(void)clearUserInfo;

@end
