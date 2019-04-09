//
//  DFDiscernFlowerModel.h
//  DF
//
//  Created by Tata on 2017/11/24.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFDiscernFlowerModel : NSObject

@property (nonatomic, copy) NSString *Id;
//植物别名
@property (nonatomic, copy) NSString *AliasName;
//所属科名
@property (nonatomic, copy) NSString *Family;
//所属属名
@property (nonatomic, copy) NSString *Genus;
//植物例图
@property (nonatomic, copy) NSString *ImageUrl;
//植物拉丁名
@property (nonatomic, copy) NSString *LatinName;
//植物名称
@property (nonatomic, copy) NSString *Name;
//可能性百分率
@property (nonatomic, copy) NSString *Score;

@property (nonatomic, copy) NSString *GoodsImageUrl;

@property (nonatomic, copy) NSString *HtmlUrl;

@property (nonatomic, copy) NSString *ShareTitle;

@property (nonatomic, copy) NSString *ShareTitleSub;

@property (nonatomic, copy) NSString *ShareImgUrl;

@property (nonatomic, copy) NSDictionary *iOSLocation;

@end
