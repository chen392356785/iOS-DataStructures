//
//  AliyunOSSUpload.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

#define AliyunUpload				[AliyunOSSUpload create]
typedef enum{
    ENT_fileImageHeader,//头像
    ENT_fileImageBody,//个人图片
    ENT_fileImageCont, //新品种上传图片
    ENT_fileImagesAdd, //上传多张图片 “，”号分割
}FileType;
@interface AliyunOSSUpload : NSObject


+ (instancetype)create;

- (void)uploadImage:(NSArray*)imgArr
	  FileDirectory:(FileType)type
			success:(void (^)(NSString *obj))successBlock
			failure:(void(^)(NSError *error))failBlock;

@end
