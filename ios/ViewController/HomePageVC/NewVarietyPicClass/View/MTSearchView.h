//
//  MTSearchView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/30.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearBlock)();

@interface MTSearchView : UIView

@property (nonatomic, strong) IHTextField *searBar;
@property (nonatomic, strong) UIButton  *searBut;

@property (nonatomic, copy) SearBlock searchBlock;
@property(nonatomic, assign) CGSize intrinsicContentSize; 
@end
