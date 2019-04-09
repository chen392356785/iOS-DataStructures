//
//  DFDiscernResultView.h
//  DF
//
//  Created by Tata on 2017/11/27.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFBaseView.h"
@class DFDiscernFailureView, DFDiscernSuccessView, DFDiscernWaitingView;

@interface DFDiscernResultView : DFBaseView

@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UIView *maskView;
@property (nonatomic, readonly) UIImageView *moveLineIcon;

@property (nonatomic, readonly) DFDiscernWaitingView *waitingView;
@property (nonatomic, readonly) DFDiscernSuccessView *successView;
@property (nonatomic, readonly) DFDiscernFailureView *failureView;

@end
