//
//  NSString+AES.m
//  MiaoTuProjectTests
//
//  Created by Neely on 2018/4/28.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import "NSString+AES.h"
//#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

static NSString *const PSW_AES_KEY = @"sdfghhrdfgfdsaw:";
static NSString *const AES_IV_PARAMETER = @"1234567890123456";

@implementation NSString (AES)

- (NSString*)aci_encryptWithAES {
	
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSData *AESData = [self AES128operation:kCCEncrypt
									   data:data
										key:PSW_AES_KEY
										 iv:AES_IV_PARAMETER];
	NSString *baseStr_GTM = [AESData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

	if ([baseStr_GTM containsString:@"\\"]) {
		baseStr_GTM = [baseStr_GTM stringByReplacingOccurrencesOfString:@"\\" withString:@""];//去掉+号
	}
	
	NSLog(@"*****************\nGTMBase:%@\n*****************",baseStr_GTM);

	return baseStr_GTM;
}

- (NSString*)aci_decryptWithAES {
	
	NSData *baseData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];

	NSData *AESData = [self AES128operation:kCCDecrypt
									   data:baseData
										key:PSW_AES_KEY
										 iv:AES_IV_PARAMETER];
	
	NSString *decStr = [[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding];
	
	NSLog(@"*****************\niOSCode:%@\n*****************", decStr);
	
	return decStr;
}

/**
 *  AES加解密算法
 *
 *  @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 *  @param data      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 *
 *  @return
 */
- (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
	char keyPtr[kCCKeySizeAES128 + 1];
	bzero(keyPtr, sizeof(keyPtr));
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	// IV
	char ivPtr[kCCBlockSizeAES128 + 1];
	bzero(ivPtr, sizeof(ivPtr));
	[iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
	
	size_t bufferSize = [data length] + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	size_t numBytesEncrypted = 0;
	
	CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding|kCCOptionECBMode,
											keyPtr, kCCKeySizeAES128,
											ivPtr,
											[data bytes], [data length],
											buffer, bufferSize,
											&numBytesEncrypted);
	
	if(cryptorStatus == kCCSuccess) {
		NSLog(@"Success");
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
		
	} else {
		NSLog(@"Error");
	}
	
	free(buffer);
	return nil;
}

//    /**< GTMBase64编码 */
//- (NSString*)encodeBase64Data:(NSData *)data {
////    data = [GTMBase64 encodeData:data];
//	NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
////    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    return base64String;
//}

//    /**< GTMBase64解码 */
//- (NSData*)decodeBase64Data:(NSData *)data {
//    data = [GTMBase64 decodeData:data];
//    return data;
//}

@end

