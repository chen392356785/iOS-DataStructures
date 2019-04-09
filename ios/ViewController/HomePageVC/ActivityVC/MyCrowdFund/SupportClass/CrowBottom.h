//
//  CrowBottom.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCrowdListDetailController.h"

typedef void(^selfCrowActionBlock)();
typedef void(^heleMeActionBlock)();
typedef void(^myCrowDetailBlock)();

@interface CrowBottom : UIView

- (instancetype)initWithFrame:(CGRect)frame CrowType:(CrowdFundType)crowType;

@property (nonatomic, copy) selfCrowActionBlock selfCrowBlock;
@property (nonatomic, copy) heleMeActionBlock  helpMeCrowBlock;
@property (nonatomic, copy) myCrowDetailBlock  myCrowDetailBlock;

- (void)setActivies:(ActivitiesListModel *)ActiModel;
@end
