//
//  DFShareView.h
//  DF
//
//  Created by Tata on 2017/11/29.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFShareViewDelegate <NSObject>

@optional

- (void)shareViewTypeWith:(NSInteger)index;

@end

@interface DFShareView : SHPAbstractView

@property (nonatomic, weak) id<DFShareViewDelegate> delegate;

@end
