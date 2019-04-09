//
//  AddMiaoBiView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/12.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMiaoBiView : UIView{
    UIView *BgView;
}
@property (nonatomic ,copy) DidSelectBlock cancelBack;

- (void) setAddNumMiaoBi:(NSString *)numStr;

@end
