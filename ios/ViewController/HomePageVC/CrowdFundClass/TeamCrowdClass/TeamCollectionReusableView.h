//
//  TeamCollectionReusableView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/17.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SpokesmanBlock)();
typedef void(^CowdFundBlock)();
typedef void(^SuperBlock)();

@interface TeamCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) SpokesmanBlock  SpokesmanAction;
@property (nonatomic, copy) CowdFundBlock   CowdFundAction;
@property (nonatomic, copy) SuperBlock   SuperAction;



- (void) setTeamActioviesModel:(ActivitiesListModel *)model;
@end
