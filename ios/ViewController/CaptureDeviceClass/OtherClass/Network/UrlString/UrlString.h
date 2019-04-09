//
//  UrlString.h
//  THFlower
//
//  Created by Tata on 2017/3/23.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlString : NSObject

#pragma mark - 登录
+ (NSString *)loginUrl;

#pragma mark - 识花
+ (NSString *)discernPhotoUrl;

#pragma mark - 生成美图
+ (NSString *)creatPhotosUrl;

#pragma mark - 鉴定列表
+ (NSString *)discernListUrl;

#pragma mark - 请高手鉴别
+ (NSString *)masterDiscernUrl;

#pragma mark - 修改个人信息
+ (NSString *)updateUserInfoUrl;

#pragma mark - 评论列表
+ (NSString *)commentListUrl;

#pragma mark - 添加评论
+ (NSString *)addCommentInfoUrl;

#pragma mark - 是此花
+ (NSString *)isThisFlowerUrl;

#pragma mark - 吐槽
+ (NSString *)shitUrl;







@end
