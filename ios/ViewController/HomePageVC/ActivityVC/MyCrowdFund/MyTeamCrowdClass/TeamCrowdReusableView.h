//
//  TeamCrowdReusableView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TheTeamBlock)();
typedef void(^TeamPeopleBlock)();
typedef void(^SuperBlock)();

@interface TeamCrowdReusableView : UICollectionReusableView

@property (nonatomic, copy) TheTeamBlock      TheTeamAction;
@property (nonatomic, copy) TeamPeopleBlock   TeamPeopleAction;
@property (nonatomic, copy) SuperBlock   SuperAction;

@property (nonatomic, copy) NSString *selectIndex;

- (void) setTeamActioviesModel:(ActivitiesListModel *)model;

@end
