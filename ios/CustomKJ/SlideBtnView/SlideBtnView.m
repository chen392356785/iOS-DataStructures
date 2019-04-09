//
//  SlideBtnView.m
//  TaSayProject
//
//  Created by Mac on 15/5/13.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "SlideBtnView.h"

@implementation SlideBtnView
@synthesize userClickStatus = _userClickStatus;
//@synthesize delegate = _delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)btnClick:(UIButton *)sender{
    
    if (self.userClickStatus == YES)
    {
        if ([_selButton isEqual:sender])
        {
            return;
        }
        _selButton.titleLabel.font=sysFont(15);
        _selButton.selected = NO;
        _selButton = sender;
        _selButton.selected = YES;
        _selButton.titleLabel.font=sysFont(16);
    }
    
	
    UIButton* button = (UIButton*)sender;
    int index = (int)button.tag-20;
    
    [UIView animateWithDuration:0.3 animations:^{
		CGRect rect=self->_lineView.frame;
		rect.origin.x=button.frame.origin.x;
		self->_lineView.frame=rect;
    }];
    
    if ([self.Segmenteddelegate respondsToSelector:@selector(SegmentedDelegateViewclickedWithIndex:)]) {
        [self.Segmenteddelegate SegmentedDelegateViewclickedWithIndex:index];
    }
}

- (id)initWithFrame:(CGRect)frame setTitleArr:(NSArray *)titleArray isShowLINE:(BOOL)isShowLINE setImgArr:(NSArray *)setImgArray seletImgArray:(NSArray *)seletImgArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
         self.backgroundColor=RGB(255, 255, 255);
        CGFloat w=WindowWith/titleArray.count;
        _items = [[NSMutableArray alloc]init];
        
        for (int i=0; i<titleArray.count ; i++) {
            NSString *name=[titleArray objectAtIndex:i];
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:name forState:UIControlStateNormal];
            [btn setImage:[Image(setImgArray[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
              [btn setImage:[Image(seletImgArray[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=20+i;
            
            btn.frame=CGRectMake(i*w, 0, w, frame.size.height);
            [btn setTitleColor:RGB(189, 202, 219) forState:UIControlStateNormal];
            [btn setTitleColor:cGreenColor forState:UIControlStateSelected];
            [btn setTitleColor:RGB(134, 134, 134) forState:UIControlStateHighlighted];
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 3, 0, 0);
         
            btn.titleLabel.font=sysFont(15);
            self.userClickStatus=YES;
            if (i==0) {
                if (self.userClickStatus == YES) {
                    _selButton=btn;
                    _selButton.titleLabel.font=sysFont(16);
                    _selButton.selected=YES;
                }
                
            }
            
            if (isShowLINE==YES) {
                if (i>0) {
                    UIImageView *LINEIMG=[[UIImageView alloc]initWithFrame:CGRectMake(i*w-0.5, 9.5, 1, 23)];
                    LINEIMG.image=[IHUtility imageWithColor:cLineColor andSize:CGSizeMake(1, 6)];
                    [self addSubview:LINEIMG];
                }
            }
            [self addSubview:btn];
            self.showsHorizontalScrollIndicator=NO;
            
            [_items addObject:btn];

        }
        
        
        UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height-2, w , 2)];
        lineView.image=[IHUtility imageWithColor:cGreenColor andSize:CGSizeMake(w, 2)];
        _lineView=lineView;
        [self addSubview:lineView];
        
     //   self.contentSize=CGSizeMake(titleArray.count*80, frame.size.height);
        
    }
    return self;
}

-(void)scrollPage:(CGFloat)x{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=self->_lineView.frame;
        rect.origin.x=x;
        self->_lineView.frame=rect;
    }];
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    UIButton *button = _items[currentItemIndex];
    
    [self btnClick:button];
    
}

@end
