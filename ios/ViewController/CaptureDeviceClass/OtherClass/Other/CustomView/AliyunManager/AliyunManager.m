//
//  AliyunManager.m
//  TH
//
//  Created by 羊圈科技 on 16/4/25.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import "AliyunManager.h"

NSString * const AccessKey1 = @"FzI4GnM077O1ekXe";
NSString * const SecretKey1 = @"yLgrdEILOrklzXNYrdUHIdNg9Pp7VE";
NSString * const endPoint1  = @"http://oss-cn-beijing.aliyuncs.com";
NSString * const bucketName= @"tinghua";

@implementation AliyunManager

-(instancetype)init
{
    self = [super init];
    if (self) {
		//-Wdeprecated-declarations
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
		id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey1 secretKey:SecretKey1];
#pragma clang diagnostic pop
		OSSClientConfiguration * conf = [OSSClientConfiguration new];
		conf.maxRetryCount = 2;
		conf.timeoutIntervalForRequest = 30;
		conf.timeoutIntervalForResource = 24 * 60 * 60;
		client = [[OSSClient alloc] initWithEndpoint:endPoint1 credentialProvider:credential clientConfiguration:conf];
    }
    return self;
}

-(NSString *)createImageName
{
    NSString * howeSecond=[NSString stringWithFormat:@"%ld",[[DFTool time_DateConversionHoweSeconds:[NSDate date]]integerValue]];
    NSString * suijishu  =[NSString stringWithFormat:@"%d" ,[DFTool math_getRandomNumber:10000 to:99999]];
    NSString * sub       =[NSString stringWithFormat:@"%@%@%@",howeSecond,suijishu,UserModel.Id];
    return [DFTool md5:sub];
}

- (void)uploadObject:(NSString *)str withData:(NSData *)imageData withCallBack:(void(^)(OSSTask *response))callBack
{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = bucketName;
    put.objectKey  = str;
    put.uploadingData = imageData;
    
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task)
    {
        if (!task.error)
        {
            callBack(task);
        }
        else
        {
//            [TFTool showLetter:TFUploadError];
//            callBack();
        }
        return nil;
    }];
}

@end
