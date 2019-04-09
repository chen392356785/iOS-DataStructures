//
//  ActivityTypeModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/1.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"

@interface ActivityTypeModel : JSONModel

@property (nonatomic, copy) NSString <Optional> * typeId;
@property (nonatomic, copy) NSString <Optional> * typePic;
@property (nonatomic, copy) NSString <Optional> * pic_height;
@property (nonatomic, copy) NSString <Optional> * pic_width;
@property (nonatomic, copy) NSString <Optional> * contentPic;
@property (nonatomic, copy) NSString <Optional> * sort;
@property (nonatomic, copy) NSString <Optional> * deleted;
@property (nonatomic, copy) NSString <Optional> * tyeName;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * updateTime;
@property (nonatomic, copy) NSString <Optional> * weiactivitiesCount;
@property (nonatomic, copy) NSString <Optional> * zhongactivitiesCount;
@property (nonatomic, strong) NSMutableArray <Optional> * imgList;
@end
