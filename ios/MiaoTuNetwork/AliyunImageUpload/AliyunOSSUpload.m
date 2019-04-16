//
//  AliyunOSSUpload.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ServerConfig.h"
#import "AliyunOSSUpload.h"

@implementation AliyunOSSUpload

{
	// 设置初始记录量为0
	NSInteger _count ;
//	NSInteger _upcount;
	// 设置初始值为NO
	BOOL isUploadPictures;
}

+ (instancetype)create
{
	return [[[self class] alloc] init];
}

- (void)uploadImage:(NSArray*)imgArr
	  FileDirectory:(FileType)type
			success:(void (^)(NSString *obj))successBlock
			failure:(void(^)(NSError *error))failBlock {
	
	//	NSMutableArray *imgArray=[NSMutableArray new];
	NSMutableArray *mArr = [NSMutableArray new];
	NSMutableArray *dataArr = [NSMutableArray new];
	
	for (int i=0; i<imgArr.count; i++) {
		NSData* data;
		UIImage *image1=[imgArr objectAtIndex:i];
		UIImage *image=[IHUtility rotateAndScaleImage:image1 maxResolution:WindowWith*2];
		NSString *imgName = [IHUtility getTransactionID];
		
		if (type==ENT_fileImageHeader) {
			NSData *data1=UIImageJPEGRepresentation(image, 1);
			float length1 = [data1 length]/1024;
			//			NSLog(@"length1==%fKB",length1);
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
		
		[mArr addObject:[NSString stringWithFormat:@"%@/%@.png",ConfigManager.ImageUrl,imgName]];
	}
	
	// 设置初始记录量为0
	_count = 0;
//	_upcount = 0;
	// 设置初始值为NO
	isUploadPictures = NO;
	NSMutableArray <NSDictionary *>*uploadImgArr = [NSMutableArray new];
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
	NSDictionary * parameter = @{@"data"  : [NSNumber numberWithInt:typeTag]};
	// 循环上传图片
	NSInteger i = 0;
	for (NSString *obj in mArr) {
		NSString *fileName = [obj lastPathComponent];
		NSData *data = [dataArr objectAtIndex:i];
		i ++;
		if (data == nil) {
			return ;
		}
		NSString *service = [NSString stringWithFormat:@"%@%@", [ServerConfig HTTPServer],@"upload/image"];
		[manager POST:service parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
			[formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
		} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
			//			NSLog(@"%@", task);

			NSLog(@"%@", responseObject);
			self->_count ++;
			// 如果所有的照片上传完成, 则将_isUploadPictures改为yes
			if (self->_count == mArr.count) {
				self->isUploadPictures = YES;
			}
			// 将 图片 的地址 添加到数组
			if (type == ENT_fileImageCont || type == ENT_fileImageHeader) {
				[uploadImgArr addObject:responseObject[@"content"]];
			} else if (type == ENT_fileImagesAdd) {
				[uploadImgArr addObject:responseObject[@"content"]];
			} else {
				NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"/%@",responseObject[@"content"]],@"t_url",
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
					NSData *data = [NSJSONSerialization dataWithJSONObject:uploadImgArr options:NSJSONWritingPrettyPrinted error:NULL];
					str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
				}
				successBlock(str);
			}
		} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
			if (error) {
				[IHUtility addSucessView:@"图片上传失败,请重试" type:2];
			}
			!failBlock ?: failBlock(error);
		}];
		
	}
	
}

@end




