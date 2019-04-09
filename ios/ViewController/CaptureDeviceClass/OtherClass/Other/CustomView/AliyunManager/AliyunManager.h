//
//  AliyunManager.h
//  TH
//
//  Created by 羊圈科技 on 16/4/25.
//  Copyright © 2016年 羊圈科技. All rights reserved.

//上传管理类
#import <Foundation/Foundation.h>
#import "OSSService.h"
#import "OSSCompat.h"

@interface AliyunManager : NSObject
{
    OSSClient * client;
}

/**
 *  创建图片姓名
 *
 *  @return 创建图片姓名
 */
-(NSString *)createImageName;

/**
 *  异步上传图片
 *
 *  @param str  objectKey
 *  @param path 图片路径
 */
- (void)uploadObject:(NSString *)str withData:(NSData *)imageData withCallBack:(void(^)(OSSTask *response))callBack;
@end
