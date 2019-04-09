//
//  partenerModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/19.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "JSONModel.h"

@interface userPartner  : JSONModel
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * parterMobile;
@property (nonatomic, copy) NSString <Optional> * parterAddress;
@property (nonatomic, copy) NSString <Optional> * partnerName;
@property (nonatomic, copy) NSString <Optional> * parterCompany;
@property (nonatomic, copy) NSString <Optional> * userId;
@property (nonatomic, copy) NSString <Optional> * parterCompanyContent;
@property (nonatomic, copy) NSString <Optional> * remark;
@property (nonatomic, copy) NSString <Optional> * parterName;
@property (nonatomic, copy) NSString <Optional> * nickName;
@property (nonatomic, copy) NSString <Optional> * heedImageUrl;
@property (nonatomic, copy) NSString <Optional> * auditStatus;
@end

@protocol partnerList
@end

@interface partnerList  : JSONModel
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * parterMobile;
@property (nonatomic, copy) NSString <Optional> * parterAddress;
@property (nonatomic, copy) NSString <Optional> * partnerName;
@property (nonatomic, copy) NSString <Optional> * parterCompany;
@property (nonatomic, copy) NSString <Optional> * userId;
@property (nonatomic, copy) NSString <Optional> * parterCompanyContent;
@property (nonatomic, copy) NSString <Optional> * remark;
@property (nonatomic, copy) NSString <Optional> * parterName;
@property (nonatomic, copy) NSString <Optional> * nickName;
@property (nonatomic, copy) NSString <Optional> * heedImageUrl;
@property (nonatomic, copy) NSString <Optional> * auditStatus;
@end


@interface partenerModel  : JSONModel
@property (nonatomic, strong) userPartner <Optional> * userPartner;
@property (nonatomic, strong) NSMutableArray <Optional,partnerList> *partnerList;
@end



