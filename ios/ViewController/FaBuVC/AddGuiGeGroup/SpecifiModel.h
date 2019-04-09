//
//  SpecifiModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/2.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpecifiModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *specifications;    //规格
@property (nonatomic, copy) NSString <Optional> *speciType;         //类型
@property (nonatomic, copy) NSString <Optional> *moneyStr;          //单价
@end

NS_ASSUME_NONNULL_END
