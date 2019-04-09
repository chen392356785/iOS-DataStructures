//
//  AddresModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/1.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddresModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *userId;
@property (nonatomic, copy) NSString <Optional> *address;
@property (nonatomic, copy) NSString <Optional> *contactsMobile;
@property (nonatomic, copy) NSString <Optional> *companyArea;
@property (nonatomic, copy) NSString <Optional> *isDelete;
@property (nonatomic, copy) NSString <Optional> *contacts;
@property (nonatomic, copy) NSString <Optional> *companyName;
@property (nonatomic, copy) NSString <Optional> *updateTime;
@property (nonatomic, copy) NSString <Optional> *companyAddress;
@property (nonatomic, copy) NSString <Optional> *createTime;
@property (nonatomic, copy) NSString <Optional> *jid;

@property (nonatomic, copy) NSString <Optional> *titleName;               //
@property (nonatomic, copy) NSString <Optional> *textvaluestr;      //保存输入的内容
@property (nonatomic, copy) NSString <Optional> *key;               //
@end

NS_ASSUME_NONNULL_END
