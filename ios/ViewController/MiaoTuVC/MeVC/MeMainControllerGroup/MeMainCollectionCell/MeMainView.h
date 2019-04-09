//
//  MeMainView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/15.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeMainView : UIView

@end

@interface MeMainKefuView : UIView {
    UILabel *titleLab;
    UIView *_dashedView;
    UILabel *infoLab;
    UILabel *numLab;
    UIButton *copyBut;
}
@property(nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic, copy) DidSelectBlock CancelBlock;               //取消

- (void) setkefuNum:(NSString *)kefuStr;
@end
