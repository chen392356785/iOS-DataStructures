//
//  DFBaseView.h
//  DF
//
//  Created by Tata on 2017/11/25.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@interface DFBaseView : SHPAbstractView

@property (nonatomic , readonly)DFNavigationView *navigationView;

- (void)creatViews;

- (void)applyStyles;

@end
