//
//  GarehomePopCategoryView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/10.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GarehomePopCategoryView : UIView {
    UIScrollView *BgView;
}
@property (nonatomic ,copy) DidSelectBlock cancelBack;
@property (nonatomic ,copy) DidSelectBtnBlock SelectIndexBack;

- (void) setGardenCategoryArr:(NSArray *)arr andPointY:(NSInteger )pointY;
@end
