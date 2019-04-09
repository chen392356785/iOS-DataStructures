//
//  DFBaseView.m
//  DF
//
//  Created by Tata on 2017/11/25.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFBaseView.h"

@interface DFBaseView()

@property (nonatomic , strong)DFNavigationView *navigationView;

@end

@implementation DFBaseView

- (void)addSubviews{
    [self creatViews];
    [self applyStyles];
    
    [self addSubview:self.navigationView];
}

- (void)defineLayout{
    if (self.navigationView.cas_styleClass) {
        [self.navigationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(self.navigationView.cas_marginLeft));
            make.right.equalTo(@(self.navigationView.cas_marginRight));
            make.top.equalTo(@(self.navigationView.cas_marginTop));
            make.height.equalTo(@(self.navigationView.cas_sizeHeight / TTUIScale()));
        }];
        
    }
}

- (void)creatViews{
    self.navigationView = [[DFNavigationView alloc]init];
    if (iPhoneHeight == kHeightX) {
        self.navigationView.cas_styleClass = @"navigation_view_X";
        self.navigationView.backgroundView.cas_styleClass = @"navigation_backgroundView_X";
    }else {
        self.navigationView.cas_styleClass = @"navigation_view";
        self.navigationView.backgroundView.cas_styleClass = @"navigation_backgroundView";
    }
    
}

- (void)applyStyles {
    // 抽象类不指定样式
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
