//
//  MyMessageModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/25.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "JSONModel.h"


@protocol MessageContentModel <NSObject>

@end

@interface MessageContentModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * updateTime;
@property (nonatomic, copy) NSString <Optional> * sendTime;
@property (nonatomic, copy) NSString <Optional> * receiveId;
@property (nonatomic, copy) NSString <Optional> * type;
@property (nonatomic, copy) NSString <Optional> * isDeleted;
@property (nonatomic, copy) NSString <Optional> * isLook;
@property (nonatomic, copy) NSString <Optional> * heedImageUrl;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * isMe;
@property (nonatomic, copy) NSString <Optional> * sendId;
@property (nonatomic, copy) NSString <Optional> * nickname;
@property (nonatomic, copy) NSString <Optional> * messageContent;
@property (nonatomic, copy) NSString <Optional> * parentId;
@end


@interface MessageTailsModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * name;
@property (nonatomic, copy) NSString <Optional> * userId;
@property (nonatomic, strong)NSMutableArray <Optional,MessageContentModel> *message;
@end

@interface MyMessageModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * updateTime;
@property (nonatomic, copy) NSString <Optional> * sendTime;
@property (nonatomic, copy) NSString <Optional> * pageSize;
@property (nonatomic, copy) NSString <Optional> * pageNumStr;
@property (nonatomic, copy) NSString <Optional> * look;
@property (nonatomic, copy) NSString <Optional> * receiveId;
@property (nonatomic, copy) NSString <Optional> * type;
@property (nonatomic, copy) NSString <Optional> * isDeleted;
@property (nonatomic, copy) NSString <Optional> * isLook;
@property (nonatomic, copy) NSString <Optional> * heedImageUrl;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * sendTimeString;
@property (nonatomic, copy) NSString <Optional> * sendId;
@property (nonatomic, copy) NSString <Optional> * nickname;
@property (nonatomic, copy) NSString <Optional> * messageContent;
@property (nonatomic, copy) NSString <Optional> * parentId;
@property (nonatomic, strong) MessageTailsModel <Optional> * tails;
@end


