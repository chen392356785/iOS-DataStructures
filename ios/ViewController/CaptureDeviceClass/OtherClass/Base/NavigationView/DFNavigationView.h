//
//  DFNavigationView.h
//  DF
//
//  Created by Tata on 2017/11/25.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@interface DFNavigationView : SHPAbstractView

@property (nonatomic, readonly) UIView *backgroundView;
@property (nonatomic, readonly) UIButton *backButton;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UIButton *forwardButton;
@property (nonatomic, readonly) UIView *lineView;

@end
