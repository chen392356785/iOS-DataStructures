//
//  NewNoticeView.m
//  NewsBannerDemo
//
//  Created by sunhao－iOS on 16/4/28.
//  Copyright © 2016年 ssyzh. All rights reserved.
//

#import "NewsBanner.h"


@implementation NewsBanner

static int countInt=0;


- (void)setNoticeList:(NSArray *)noticeList
{

    if (_noticeList != noticeList) {
        _noticeList=[[NSArray alloc]init];
        _noticeList = noticeList;
        if (_noticeList.count != 0) {
            _notice.text = _noticeList[0];
        }
        
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.clipsToBounds = YES;
        self.notice = [UILabel new];
        
        self.notice.font = sysFont(16);
        self.notice.textColor = cBlackColor;
        self.notice.userInteractionEnabled = YES;
        self.notice.frame=CGRectMake(0,(frame.size.height-16)/2.0 , frame.size.width, 15);
        [self addSubview:self.notice];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self.notice addGestureRecognizer:tap];
        
    }
    
    return self;
}



- (void)layoutSubviews{
    


}

-(void)displayNews{
    countInt++;
 
    if (countInt >= [self.noticeList count])
        countInt=0;
    CATransition *animation = [CATransition animation];
    animation.delegate = (id<CAAnimationDelegate>)self;
    animation.duration = 0.5f ;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self.notice.layer addAnimation:animation forKey:@"animationID"];
    self.notice.text = self.noticeList[countInt];

}
- (void)tap:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(NewsBanner:didSelectIndex:)]) {
        
        [_delegate NewsBanner:self didSelectIndex:countInt];
        
    }

}
- (void)star
{
    if (self.noticeList.count != 0) {
      [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(displayNews) userInfo:nil repeats:YES];  
    }
    
}
@end
