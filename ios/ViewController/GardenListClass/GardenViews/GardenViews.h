//
//  GardenViews.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GardenModel.h"

@interface GardenViews : UIView

@end


@interface GardenTabHeadViews : UIView {
    UIScrollView *_topScrollview;
}
@property (nonatomic ,copy) DidSelectBtnBlock seleckBack;
- (void) updataCreateSubViews:(NSMutableArray *) marr;
@end
