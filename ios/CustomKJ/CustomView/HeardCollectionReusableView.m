//
//  HeardCollectionReusableView.m
//  MiaoTuProject
//
//  Created by Zmh on 22/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "HeardCollectionReusableView.h"

@implementation HeardCollectionReusableView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        ActivityVoteTopView *view =[[ActivityVoteTopView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, WindowWith*0.453 + 59)];
        ActivityVoteTopView *view =[[ActivityVoteTopView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, WindowWith*0.453 + 59)];
        
        topView = view;
        [view.btn addTarget:self action:@selector(viewBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:view];
    }
    
    return self;
}
- (void)setTopData:(NSString *)title time:(NSString *)time totlNum:(NSString *)totleNum imgUrl:(NSString *)url
{
    [topView setTopData:title time:time totlNum:totleNum imgUrl:url];
}

- (void)viewBtn:(UIButton *)button
{
    self.selectBtnBlock(SelectBtnBlock);
}
@end
