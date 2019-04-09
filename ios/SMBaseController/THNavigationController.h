//
//  THNavigationController.h
//  MiaoTuProjectTests
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ShowCompleteBlock)(void);

@interface THNavigationController : UINavigationController
    
@property (nonatomic, assign) BOOL statusBarHidden;
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(ShowCompleteBlock)completion;

@end

