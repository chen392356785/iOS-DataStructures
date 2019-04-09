//
//  PayMentModel.h
//  MiaoTuProjectTests
//
//  Created by Neely on 2018/4/28.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <Foundation/Foundation.h>

//成功
#define CC_IRETURNCODE_OK                1

@interface PayMentModel : NSObject

@property (nonatomic,assign)int code;
@property (nonatomic,copy)NSString *data;
@property (nonatomic,copy)NSString *msg;
@property (nonatomic,assign)int type;


@end
