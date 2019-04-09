//
//  DFFailureView.h
//  DF
//
//  Created by Tata on 2017/11/24.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFDiscernFailureDelegate <NSObject>

- (void)retakePhotos;

@end

@interface DFDiscernFailureView : SHPAbstractView

@property (nonatomic, weak) id <DFDiscernFailureDelegate> delegate;

@end
