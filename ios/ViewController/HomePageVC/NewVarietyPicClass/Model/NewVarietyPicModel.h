//
//  NewVarietyPicModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/30.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"



@protocol nurseryNewDetailListModel

@end

@interface nurseryNewDetailListModel :JSONModel
@property (nonatomic, copy) NSString <Optional>* userId;
@property (nonatomic, copy) NSString <Optional>* plantType;
@property (nonatomic, copy) NSString <Optional>* plantName;
@property (nonatomic, copy) NSString <Optional>* plantTitle;
@property (nonatomic, copy) NSString <Optional>* num;
@property (nonatomic, copy) NSString <Optional>* src_pic;
@property (nonatomic, copy) NSString <Optional>* Pid;
@property (nonatomic, copy) NSString <Optional>* showPic;
@property (nonatomic, copy) NSString <Optional>* loadingPrice;
@property (nonatomic, copy) NSString <Optional>* remark;
@property (nonatomic, copy) NSString <Optional>* nurseryAddress;
@property (nonatomic, copy) NSString <Optional>* location;
@property (nonatomic, copy) NSString <Optional>* status;
@property (nonatomic, copy) NSString <Optional>* mobile;
@property (nonatomic, copy) NSString <Optional>* istop;
@property (nonatomic, copy) NSString <Optional>* createTime;
@property (nonatomic, copy) NSString <Optional>* updateTime;

@end

@protocol NewVarietyPicModel
@end

@interface NewVarietyPicModel : JSONModel
@property (nonatomic, copy) NSString <Optional>* nursery_type_id;
@property (nonatomic, copy) NSString <Optional>* nurseryTypeName;
@property (nonatomic, copy) NSString <Optional>* nurseryImage;
@property (nonatomic, copy) NSString <Optional>* units;
@property (nonatomic, copy) NSString <Optional>* indexSort;
@property (nonatomic, copy) NSString <Optional>* status;
@property (nonatomic, strong)NSMutableArray <nurseryNewDetailListModel, Optional> *nurseryNewDetailList;
@end


@protocol NewMobileListModel

@end
@interface NewMobileListModel :JSONModel
@property (nonatomic, copy) NSString <Optional>* mobile;
@property (nonatomic, copy) NSString <Optional>* status;
@property (nonatomic, copy) NSString <Optional>* user_id;

@end

@interface NewVarietyPicContentModel : JSONModel
@property (nonatomic, strong)NSMutableArray <NewVarietyPicModel, Optional> *nurseryNewTypeList;
@property (nonatomic, strong)NSMutableArray <NewMobileListModel, Optional> *mobileList;

@end

@interface NewVarietyPicConModel : JSONModel
@property (nonatomic, copy) NSString <Optional>* errorContent;
@property (nonatomic, copy) NSString <Optional>* errorNo;

@property (nonatomic, strong)NSMutableArray <NewVarietyPicModel, Optional> *content;
@end




