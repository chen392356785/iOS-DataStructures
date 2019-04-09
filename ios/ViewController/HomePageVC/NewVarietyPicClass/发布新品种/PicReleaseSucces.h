//
//  PicReleaseSucces.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/27.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelActionBlock)();
typedef void(^TryAgainActionBlock)();

@interface PicReleaseSucces : UIView

@property (nonatomic, strong) UIButton *TryBut;     //再发布一个
@property (nonatomic, strong) UIButton *CancelBut;     //取消
@property (nonatomic, copy)   CancelActionBlock CancelBlock;
@property (nonatomic, copy)   TryAgainActionBlock TryAgainBlock;
@end
