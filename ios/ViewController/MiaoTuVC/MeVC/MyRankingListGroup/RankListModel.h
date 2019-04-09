//
//  RankListModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/18.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"

@interface RankListModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *followUserCount;
@property (nonatomic, copy) NSString <Optional> *nickname;
@property (nonatomic, copy) NSString <Optional> *sumPoint;
@property (nonatomic, copy) NSString <Optional> *orderNumber;
@end
