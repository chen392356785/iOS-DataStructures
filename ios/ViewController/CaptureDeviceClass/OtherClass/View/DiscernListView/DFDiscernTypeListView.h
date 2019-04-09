//
//  DFDiscernTypeListView.h
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFDiscernTypeListViewDelegate <NSObject>

- (void)selectDiscernTypeWith:(NSInteger)index;

@end

@interface DFDiscernTypeListView : SHPAbstractView

@property (nonatomic, weak) id <DFDiscernTypeListViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentSource;

@end
