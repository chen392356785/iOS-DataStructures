//
//  ActivityTypeCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/1.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityTypeModel.h"

typedef void (^DidSelectBut) ();

@interface ActivityTypeCell : UITableViewCell

@property (nonatomic, copy) DidSelectBut luxianContenBlock;
@property (nonatomic, copy) DidSelectBut selectActivityBlock;

- (void) setActivityTypeCellDate:(ActivityTypeModel *) model;
@end
