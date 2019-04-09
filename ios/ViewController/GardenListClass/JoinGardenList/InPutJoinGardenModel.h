//
//  InPutJoinGardenModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"


@interface buttonJsonModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *isBiTian;      //1必填
@property (nonatomic, copy) NSString <Optional> *isLook;        //1显示
@property (nonatomic, copy) NSString <Optional> *name;          //1名字
@property (nonatomic, copy) NSString <Optional> *sort;          //
@property (nonatomic, copy) NSString <Optional> *key;           //
@property (nonatomic, copy) NSString <Optional> *valueStr;      //保存输入的内容
@end




@protocol gardensubListsModel
@end

@interface gardensubListsModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *jid;
@property (nonatomic, copy) NSString <Optional> *isShow;
@property (nonatomic, copy) NSString <Optional> *bgUrl;
@property (nonatomic, copy) NSString <Optional> *indexUrl;
@property (nonatomic, copy) NSString <Optional> *picUrl;
@property (nonatomic, copy) NSString <Optional> *isSpec;
@property (nonatomic, copy) NSString <Optional> *listUuid;
@property (nonatomic, copy) NSString <Optional> *posterUrl;
@property (nonatomic, copy) NSString <Optional> *okUrl;
@property (nonatomic, copy) NSString <Optional> *createTime;
@property (nonatomic, copy) NSString <Optional> *detailUrl;
@property (nonatomic, copy) NSString <Optional> *cateId;
@property (nonatomic, copy) NSString <Optional> *sort;
@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, copy) NSString <Optional> *updateTime;
@end


@interface InPutJoinGardenModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *jid;
@property (nonatomic, copy) NSString <Optional> *updateTime;
@property (nonatomic, copy) NSString <Optional> *buttonJson;
@property (nonatomic, copy) NSString <Optional> *cateName;
@property (nonatomic, copy) NSString <Optional> *fillW;
@property (nonatomic, strong) NSMutableArray <gardensubListsModel,Optional> *gardenLists;

@end
