//
//  AliyunOSSUpload.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//
#import "OSSService.h"
//#import "OSSCompat.h"
//#import "AliyunOSSUpload.h"
#import "ServerConfig.h"


NSString * const AccessKey = @"IaXh2fPzhJbK5d3b";
NSString * const SecretKey = @"3Fj6E8ZuvfTHsUPm8DlST01CzIXNlK";
NSString * const endPoint = @"https://oss-cn-beijing.aliyuncs.com";
NSString * const multipartUploadKey = @"multipartUploadObject";

//NSString * const imgUrl = @"http://miaotu1.oss-cn-beijing.aliyuncs.com";
NSString * const imgUrl =@"http://miaotu1.img-cn-beijing.aliyuncs.com";
OSSClient * client;
@implementation AliyunOSSUpload

{
    int blockStarNum;
    // 设置初始记录量为0
    NSInteger count ;
    NSInteger upcount ;
    // 设置初始值为NO
    BOOL isUploadPictures;
}
static AliyunOSSUpload *_config;

//+(AliyunOSSUpload *)aliyunInit{
//    @synchronized(self){
//        if (_config==nil) {
//            _config=[[AliyunOSSUpload alloc] init];
//            id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
//          client = [[OSSClient alloc] initWithEndpoint:ConfigManager.uploadImgUrl credentialProvider:credential];
//        }
//    }
//    return _config;
//}

- (instancetype)init{
    if (self = [super init]) {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
		id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
#pragma clang diagnostic pop
		client = [[OSSClient alloc] initWithEndpoint:ConfigManager.uploadImgUrl credentialProvider:credential];
    }
    return self;
}

+ (instancetype)create
{
    return [[[self class] alloc] init];
}

//-(void)uploadImage1:(NSArray*)imgArr FileDirectory:(FileType)type success:(void (^)(NSString *obj))successBlock{
//
//    NSMutableArray *imgArray=[NSMutableArray new];
//    NSMutableArray *mArr = [NSMutableArray new];
//    for (int i=0; i<imgArr.count; i++) {
//        NSData* data;
//        UIImage *image1=[imgArr objectAtIndex:i];
//        UIImage *image=[IHUtility rotateAndScaleImage:image1 maxResolution:WindowWith*2];
//        OSSPutObjectRequest * put = [OSSPutObjectRequest new];
//        put.contentType=@"image/jpeg";
//        put.bucketName = @"miaotu1";
//        NSString *imgName;
//        NSString *str=[IHUtility getTransactionID];
//        if (type==ENT_fileImageHeader) {
//            NSData *data1=UIImageJPEGRepresentation(image, 1);
//            float length1 = [data1 length]/1024;
//            NSLog(@"length1==%fKB",length1);
//
//            if (length1<600) {
//                data = UIImageJPEGRepresentation(image, 1);
//            }else{
//                if ([IHUtility IsEnableWIFI]) {
//                    data = UIImageJPEGRepresentation(image, 0.6);
//                }else{
//                    data = UIImageJPEGRepresentation(image, 0.5);
//                }
//            }
//            imgName=[NSString stringWithFormat:@"header/header_%@.jpg",str];
//
//        }else if (type==ENT_fileImageBody || type == ENT_fileImageCont || type == ENT_fileImagesAdd){
//
//            NSData *data1=UIImageJPEGRepresentation(image, 1);
//            float length1 = [data1 length]/1024;
//            if (length1<600) {
//                data = UIImageJPEGRepresentation(image, 1);
//            }else{
//                data = UIImageJPEGRepresentation(image, 0.5);
//
//            }
//            if (type == ENT_fileImageCont || type == ENT_fileImagesAdd) {
//                imgName=[NSString stringWithFormat:@"content/content_%@.jpg",str];
//            }else {
//                imgName=[NSString stringWithFormat:@"content/body_%@.jpg",str];
//            }
//
//        }
//
//        put.objectKey = imgName;
//        put.uploadingData = data; // 直接上传NSData
//
//        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
//        };
//
//        NSString *imgWidth;
//        NSString *imgHeigh;
//        if (type==ENT_fileImageHeader) {
//            imgWidth=[NSString stringWithFormat:@"%d",WindowWith];
//            imgHeigh=[NSString stringWithFormat:@"%d",WindowWith];
//
//        }
//        else if (type==ENT_fileImageBody || type == ENT_fileImageCont){
//            imgWidth=[NSString stringWithFormat:@"%lf",image.size.width];
//            imgHeigh=[NSString stringWithFormat:@"%lf",image.size.height];
//        }
//
//        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"/%@",imgName],@"t_url",
//                           imgWidth,@"t_width",
//                           imgHeigh,@"t_height",
//                           nil];
//        [imgArray addObject:dic];
//
//        [mArr addObject:[NSString stringWithFormat:@"%@/%@",@"http://8yyq8.com",imgName]];
//
//        OSSTask * putTask = [client putObject:put];
//        //        [putTask continueWithBlock:^id(OSSTask *task) {
//        if (!putTask.error) {
//            blockStarNum++;
//            NSLog(@"upload object success!");
//            if (type==ENT_fileImageHeader) {
//                NSString *str=[NSString stringWithFormat:@"/%@",imgName];
//                successBlock(str);
//            }
//            else if (type==ENT_fileImageBody || type == ENT_fileImageCont || type == ENT_fileImagesAdd){
//
//                if (blockStarNum==imgArr.count) {
//                    NSString *str;
//                    if (type == ENT_fileImageCont) {
//                        str = [NSString stringWithFormat:@"/%@",imgName];
//                    }else if (type == ENT_fileImagesAdd) {
//                        str = [mArr componentsJoinedByString:@","];
//                    }else {
//                        str = [imgArray mj_JSONString];
//                    }
//                    successBlock(str);
//                    blockStarNum=0;
//                }
//            }
//        } else{
//            [IHUtility addSucessView:@"图片上传失败,请重试" type:2];
//            DLog(@"upload object failed, error: %@" , putTask.error);
//        }
//        //            return putTask;
//        //        }];
//    }
//}

////字典转json格式字符串：
//- (NSString*)dictionaryToJson:(NSDictionary *)dic
//{
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//}

- (void)uploadImage:(NSArray*)imgArr FileDirectory:(FileType)type success:(void (^)(NSString *obj))successBlock{
    
    NSMutableArray *imgArray=[NSMutableArray new];
    NSMutableArray *mArr = [NSMutableArray new];
    NSMutableArray *dataArr = [NSMutableArray new];
    NSMutableArray *uploadImgArr = [NSMutableArray new];

    for (int i=0; i<imgArr.count; i++) {
        NSData* data;
        UIImage *image1=[imgArr objectAtIndex:i];
        UIImage *image=[IHUtility rotateAndScaleImage:image1 maxResolution:WindowWith*2];
        NSString *imgName = [IHUtility getTransactionID];
        
        if (type==ENT_fileImageHeader) {
            NSData *data1=UIImageJPEGRepresentation(image, 1);
            float length1 = [data1 length]/1024;
            NSLog(@"length1==%fKB",length1);
            if (length1<600) {
                data = UIImageJPEGRepresentation(image, 1);
            }else{
                if ([IHUtility IsEnableWIFI]) {
                    data = UIImageJPEGRepresentation(image, 0.6);
                }else{
                    data = UIImageJPEGRepresentation(image, 0.5);
                }
            }
        }else if (type==ENT_fileImageBody || type == ENT_fileImageCont || type == ENT_fileImagesAdd){
            NSData *data1=UIImageJPEGRepresentation(image, 1);
            float length1 = [data1 length]/1024;
            if (length1<600) {
                data = UIImageJPEGRepresentation(image, 1);
            }else{
                data = UIImageJPEGRepresentation(image, 0.5);
            }
        }
        
        [dataArr addObject:data];
        NSString *imgWidth;
        NSString *imgHeigh;
        if (type==ENT_fileImageHeader) {
            imgWidth=[NSString stringWithFormat:@"%d",WindowWith];
            imgHeigh=[NSString stringWithFormat:@"%d",WindowWith];
            
        }
        else if (type==ENT_fileImageBody || type == ENT_fileImageCont){
            imgWidth=[NSString stringWithFormat:@"%lf",image.size.width];
            imgHeigh=[NSString stringWithFormat:@"%lf",image.size.height];
        }
        
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"/%@",imgName],@"t_url",
                           imgWidth,@"t_width",
                           imgHeigh,@"t_height",
                           nil];
        [imgArray addObject:dic];
        
        [mArr addObject:[NSString stringWithFormat:@"%@/%@",ConfigManager.ImageUrl,imgName]];
    }
    
    // 设置初始记录量为0
     count = 0;
     upcount = 0;
    // 设置初始值为NO
     isUploadPictures = NO;
    // 获得网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求参数
    int typeTag = 0;
    if (type==ENT_fileImageHeader) {
       typeTag = 2;
    }else if (type==ENT_fileImageBody || type == ENT_fileImageCont || type == ENT_fileImagesAdd){
        if (type == ENT_fileImagesAdd || type == ENT_fileImageBody) {
            typeTag = 3;
        }else if (type == ENT_fileImageCont) {
            typeTag = 4;
        }else {
            typeTag = 1;
        }
    }
    NSDictionary * parameter = @{
                                 @"data"  : [NSNumber numberWithInt:typeTag]
                                 };
    // 循环上传图片
    NSInteger i = 0;
    for (NSString *obj in mArr) {
        NSString *fileName = [obj lastPathComponent];
        NSData *data = [dataArr objectAtIndex:i];
        i ++;
        if (data == nil) {
            return ;
        }
        NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],@"upload/imageUpload"];
        [manager POST:service parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
//            NSLog(@"%@", uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@", task);
                // 返回结果
                NSLog(@"%@", responseObject);
                self->count ++;
                // 如果所有的照片上传完成, 则将_isUploadPictures改为yes
                if (self->count == mArr.count) {
                    self->isUploadPictures = YES;
                }
                // 将 图片 的地址 添加到数组
            if (type == ENT_fileImageCont || type == ENT_fileImageHeader) {
               [uploadImgArr addObject:responseObject[@"data"]];
            }else if (type == ENT_fileImagesAdd) {
                [uploadImgArr addObject:responseObject[@"data"]];
            }else {
//                 NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"/%@",responseObject[@"data"]],@"t_url",nil];
                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"/%@",responseObject[@"data"]],@"t_url",
                                   @"228",@"t_width",
                                   @"228",@"t_height",
                                   nil];
                
                [uploadImgArr addObject:dic];
            }
           
 
/*
    [{"t_url":"\/\/activities\/1553678050392.jpg"},{"t_url":"\/\/activities\/1553678051458.jpg"}]
    [{"t_url":"\/\/activities\/1553679145500.jpg"}]
 */
            if (self->isUploadPictures) {
                // TODO 执行其他的操作
                NSString *str;
                if (type == ENT_fileImageCont || type == ENT_fileImageHeader) {
                     str = [uploadImgArr componentsJoinedByString:@","];
                }else if (type == ENT_fileImagesAdd) {
                    str = [uploadImgArr componentsJoinedByString:@","];
                }else {
                    str = [uploadImgArr mj_JSONString];
                }
                NSLog(@"%@",str);
                successBlock(str);
            }
            }
            
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (error) {
                 [IHUtility addSucessView:@"图片上传失败,请重试" type:2];
             }
       }];
    }
}

//- (void)uploadImage2:(NSArray*)imgArr FileDirectory:(FileType)type success:(void (^)(NSString *obj))successBlock{
//
//    NSMutableArray *dataArr = [NSMutableArray new];
//    NSMutableArray *imgArray=[NSMutableArray new];
//    NSMutableArray *mArr = [NSMutableArray new];
//    for (int i=0; i<imgArr.count; i++) {
//        NSData* data;
//        UIImage *image1=[imgArr objectAtIndex:i];
//        UIImage *image=[IHUtility rotateAndScaleImage:image1 maxResolution:WindowWith*2];
//        OSSPutObjectRequest * put = [OSSPutObjectRequest new];
//        put.contentType=@"image/jpeg";
//        put.bucketName = @"miaotu1";
//        NSString *imgName;
//        NSString *str=[IHUtility getTransactionID];
//        if (type==ENT_fileImageHeader) {
//            NSData *data1=UIImageJPEGRepresentation(image, 1);
//            float length1 = [data1 length]/1024;
//            NSLog(@"length1==%fKB",length1);
//
//            if (length1<600) {
//                data = UIImageJPEGRepresentation(image, 1);
//            }else{
//                if ([IHUtility IsEnableWIFI]) {
//                    data = UIImageJPEGRepresentation(image, 0.6);
//                }else{
//                    data = UIImageJPEGRepresentation(image, 0.5);
//                }
//            }
//            imgName=[NSString stringWithFormat:@"header/header_%@.jpg",str];
//
//        }else if (type==ENT_fileImageBody || type == ENT_fileImageCont || type == ENT_fileImagesAdd){
//
//            NSData *data1=UIImageJPEGRepresentation(image, 1);
//            float length1 = [data1 length]/1024;
//            if (length1<600) {
//                data = UIImageJPEGRepresentation(image, 1);
//            }else{
//                data = UIImageJPEGRepresentation(image, 0.5);
//
//            }
//            if (type == ENT_fileImageCont || type == ENT_fileImagesAdd) {
//                imgName=[NSString stringWithFormat:@"content/content_%@.jpg",str];
//            }else {
//                imgName=[NSString stringWithFormat:@"content/body_%@.jpg",str];
//            }
//
//        }
//        [dataArr addObject:data];
//        NSString *imgWidth;
//        NSString *imgHeigh;
//        if (type==ENT_fileImageHeader) {
//            imgWidth=[NSString stringWithFormat:@"%d",WindowWith];
//            imgHeigh=[NSString stringWithFormat:@"%d",WindowWith];
//
//        }
//        else if (type==ENT_fileImageBody || type == ENT_fileImageCont){
//            imgWidth=[NSString stringWithFormat:@"%lf",image.size.width];
//            imgHeigh=[NSString stringWithFormat:@"%lf",image.size.height];
//        }
//
//        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"/%@",imgName],@"t_url",
//                           imgWidth,@"t_width",
//                           imgHeigh,@"t_height",
//                           nil];
//        [imgArray addObject:dic];
//
//        [mArr addObject:[NSString stringWithFormat:@"%@/%@",ConfigManager.ImageUrl,imgName]];
//    }
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 设置请求参数
//    int typeTag = 0;
//    if (type==ENT_fileImageHeader) {
//        typeTag = 2;
//    }else if (type == ENT_fileImageBody || type == ENT_fileImageCont || type == ENT_fileImagesAdd){
//        if (type == ENT_fileImageCont || type == ENT_fileImagesAdd) {
//            typeTag = 3;
//        }else {
//            typeTag = 1;
//        }
//    }
//    NSDictionary * parameter = @{
//                                 @"data"  : [NSNumber numberWithInt:typeTag]
//                                 };
//    NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],@"upload/imageUpload"];
//    [manager POST:service parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        // 循环上传图片
//        NSInteger i = 0;
//        for (NSString *obj in mArr) {
//            NSString *fileName = [obj lastPathComponent];
//            NSData *data = [dataArr objectAtIndex:i];
//            i ++;
//            [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:@"image/png"];
//        }
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        //            NSLog(@"%@", uploadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"==== %@", dict);
//        [IHUtility addSucessView:@"图片上传失败,请重试" type:2];
//    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (error) {
//                  [IHUtility addSucessView:@"图片上传失败,请重试" type:2];
//            }
//     }];
//
//}




@end
