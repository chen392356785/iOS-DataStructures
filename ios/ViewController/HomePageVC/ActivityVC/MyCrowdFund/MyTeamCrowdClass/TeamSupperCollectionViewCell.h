//
//  TeamSupperCollectionViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^huifuBlock)(NSInteger index);

@interface TeamSupperCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy)huifuBlock huifuAction;

- (void) setTeamSupperActioviesModel:(zcouListModelModel *)model;

@end
