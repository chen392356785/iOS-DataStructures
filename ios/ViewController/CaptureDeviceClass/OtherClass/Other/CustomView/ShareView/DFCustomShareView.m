//
//  DFCustomShareView.m
//  DF
//
//  Created by Tata on 2017/11/29.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFCustomShareView.h"
//#import "DFShareView.h"

@interface DFCustomShareView ()

@property (nonatomic, strong) DFShareView *shareView;

@end

@implementation DFCustomShareView

- (void)addSubviews {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    [self creatViews];
    
    [self addSubview:self.shareView];
}

- (void)defineLayout {
    
    [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_offset(kWidth(175));
    }];
}

- (void)creatViews {
    
    self.shareView = [[DFShareView alloc]init];
    self.shareView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"shareView_X" : @"shareView";
}

#pragma mark - 点击隐藏
- (void)tapAction:(UITapGestureRecognizer *)gesture {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

//- (void)hideCustomShareView {
//    
//    [self tapAction:nil];
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
