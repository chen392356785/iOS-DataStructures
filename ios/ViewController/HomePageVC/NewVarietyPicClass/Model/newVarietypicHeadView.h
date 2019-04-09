//
//  newVarietypicHeadView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/30.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewVarietyPicModel.h"

typedef void(^moreActionBlock)();

@interface newVarietypicHeadView : UICollectionReusableView

@property (nonatomic, copy) moreActionBlock moreBlock;
- (void) setHeadViewNewVarietyPicModel:(NewVarietyPicModel *)model;
- (void) setHiddenChickMore;        //隐藏更多
@end
