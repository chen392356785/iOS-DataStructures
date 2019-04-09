//
//  UrlString.m
//  THFlower
//
//  Created by Tata on 2017/3/23.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "UrlString.h"

@implementation UrlString

//+ (NSString *)rootUrl{
//    return RootUrl;
//}

#pragma mark - 登录
+ (NSString *)loginUrl {
    return [RootUrl stringByAppendingString:@"/UserInfo/Login"];
}

#pragma mark - 识花
+ (NSString *)discernPhotoUrl {
    return [RootUrl stringByAppendingString:@"/Recog/Recog"];
}

#pragma mark - 生成美图
+ (NSString *)creatPhotosUrl {
    return [RootUrl stringByAppendingString:@"/Recog/GetFlowerCardApp"];
}

#pragma mark - 鉴定列表
+ (NSString *)discernListUrl {
    return [RootUrl stringByAppendingString:@"/OtherRecog/List"];
}

#pragma mark - 请高手鉴别
+ (NSString *)masterDiscernUrl {
    return [RootUrl stringByAppendingString:@"/Recog/NoRecoged"];
}

#pragma mark - 修改个人信息
+ (NSString *)updateUserInfoUrl {
    return [RootUrl stringByAppendingString:@"/UserInfo/UpdateUserInfoAsync"];
}

#pragma mark - 评论列表
+ (NSString *)commentListUrl {
    return [RootUrl stringByAppendingString:@"/Comment/CommentList"];
}

#pragma mark - 添加评论
+ (NSString *)addCommentInfoUrl {
    return [RootUrl stringByAppendingString:@"/Comment/AddComment"];
}

#pragma mark - 是此花
+ (NSString *)isThisFlowerUrl {
    return [RootUrl stringByAppendingString:@"/Recog/ThisFlower"];
}

#pragma mark - 吐槽
+ (NSString *)shitUrl {
    return [RootUrl stringByAppendingString:@"/Feedback/AddFeedback"];
}


@end
