//
//  MHDrawCircleButton.h
//  待会儿
//
//  Created by 胡伟 on 16/8/26.
//  Copyright © 2016年 胡伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^drawCircleProgressBlock)(void);


@interface MHDrawCircleButton : UIButton


@property (nonatomic,strong)UIColor    *trackColor;


@property (nonatomic,strong)UIColor    *progressColor;


@property (nonatomic,strong)UIColor    *fillColor;


@property (nonatomic,assign)CGFloat    lineWidth;


@property (nonatomic,assign)CGFloat    animationDuration;

- (void)startAnimationDuration:(CGFloat)duration withBlock:(drawCircleProgressBlock )block;

@end
