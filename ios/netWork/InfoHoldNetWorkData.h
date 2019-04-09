//
//  InfoHoldNetWorkData.h
//  MinshengBank_Richness
//
//  Created by li xiangji on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.

#import <Foundation/Foundation.h>
#import "GJNetWorkData.h"
 
#import "NSObject+YAJL.h"
#import "GJEncode.h"
#import "JLUainfo.h"
@interface InfoHoldNetWorkData : GJNetWorkData
{
    id data;
    NSDictionary* m_processedResultDic;
}

@property(nonatomic,retain) id data;
@property(nonatomic)BOOL isStandardIterface;
@property(nonatomic,retain)NSString *serverPath;
@property(nonatomic,assign)NSObject *attribute;
@property(nonatomic,retain) NSDictionary* m_processedResultDic;


-(void)httpRequestWithParameter:(NSDictionary *)mutableDic method:(NSString *)method;
-(void)parseResult:(NSDictionary*)dic;

//-(NSString *)getRequestURL:(NSDictionary *)dic;
-(NSDictionary *)ResolveData:(NSData *)d;


//-(void)httpRequestWithURL:(NSString *)url param:(NSDictionary*)dic;


//base  接口
//-(void)pushIOSString:(NSString*)msg;
@end

