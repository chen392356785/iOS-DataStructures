//
//  ClassSourceReusableView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/12.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassroomModel.h"

typedef void(^MoreSelectBlock)();

@interface ClassSourceReusableView : UICollectionReusableView {
    UILabel *_titleLabel;
    UIImageView *_imageView;
    UILabel *_moreLabel;
}
@property (nonatomic, copy) MoreSelectBlock  moreClackBlock;
- (void) setClassListModel:(studyLableListModel*)model;
@end
