//
//  FabuCuttom.h
//  绘制
//
//  Created by Tomorrow on 2019/3/31.
//  Copyright © 2019 Tomorrow. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FabuCuttom : UIView
@property (nonatomic, copy) NSString *rightStr;
@property (nonatomic, copy) NSString *lefttStr;

@property (nonatomic, assign) BOOL isRightSelect;
@property (nonatomic, copy) NSString *selectStr;


@property (nonatomic, copy) DidSelectStrBlock selectStrBlock;
@end

NS_ASSUME_NONNULL_END
