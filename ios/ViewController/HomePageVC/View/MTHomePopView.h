//
//  MTHomePopView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MTHomePopModel.h"

typedef void (^CancelButBut) ();
typedef void (^SelectButtonTag) (NSInteger tag);
@interface MTHomePopView : UIView

@property(nonatomic,copy) CancelButBut CancelBlock;
@property(nonatomic,copy) SelectButtonTag SelettBut;

- (void) setMiaoTuHomePopViewModel:(MTHomePopModel *)Model;
@end
