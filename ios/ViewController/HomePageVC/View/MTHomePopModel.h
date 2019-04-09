//
//  MTHomePopModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"


@protocol advButtonModel
@end
@interface advButtonModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * advId;
@property (nonatomic, copy) NSString <Optional> * buttonName;
@property (nonatomic, copy) NSString <Optional> * buttonColor;
@property (nonatomic, copy) NSString <Optional> * buttonCode;
@property (nonatomic, copy) NSString <Optional> * isJump;               //0 不跳转 1 跳转到功能 2 跳转到链接
@property (nonatomic, copy) NSString <Optional> * jumpUrl;
@property (nonatomic, copy) NSString <Optional> * isDeleted;
@property (nonatomic, copy) NSString <Optional> * sort;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * updateTime;
@end


@interface MTHomePopModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * advName;
@property (nonatomic, copy) NSString <Optional> * advPic;
@property (nonatomic, copy) NSString <Optional> * isShow;
@property (nonatomic, copy) NSString <Optional> * isDeleted;
@property (nonatomic, copy) NSString <Optional> * isButton ;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * updateTime;
@property (nonatomic, strong) NSMutableArray <Optional,advButtonModel> * advButtonList;
@end
