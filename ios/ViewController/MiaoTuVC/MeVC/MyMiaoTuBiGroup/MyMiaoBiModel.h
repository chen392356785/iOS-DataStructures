//
//  MyMiaoBiModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/15.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"



@interface headModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> * score;
@property (nonatomic, copy)   NSString <Optional> * rule_name;
@property (nonatomic, copy)   NSString <Optional> * month;
@property (nonatomic, copy)   NSString <Optional> * rule_code;
@property (nonatomic, copy)   NSString <Optional> * baifenbi;   //百度比例
@end


@protocol pointsRecordsModel
@end

@interface pointsRecordsModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> * userId;
@property (nonatomic, copy)   NSString <Optional> * ruleName;
@property (nonatomic, copy)   NSString <Optional> * jid;
@property (nonatomic, copy)   NSString <Optional> * ruleCode;
@property (nonatomic, copy)   NSString <Optional> * updateTime;
@property (nonatomic, copy)   NSString <Optional> * addOrReduce;
@property (nonatomic, copy)   NSString <Optional> * type;
@property (nonatomic, copy)   NSString <Optional> * createTime;
@end

@interface MyMiaoBiModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> *month;     //月份
@property (nonatomic, copy)   NSString <Optional> *getScore;  //获取
@property (nonatomic, copy)   NSString <Optional> *useScore;  //使用
@property (nonatomic, strong) NSMutableArray <Optional,pointsRecordsModel> *pointsRecords;  //记录
@end
