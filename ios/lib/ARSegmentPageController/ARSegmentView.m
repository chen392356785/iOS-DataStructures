//
//  ARSegmentView.m
//  ARSegmentPager
//
//  Created by August on 15/3/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARSegmentView.h"
#define ViewHeigh  43
#define  defX  25
@implementation ARSegmentView

{
    UIImageView *_bottomLine;
}

#pragma mark - init methods

-(instancetype)initWithTitleArray:(NSMutableArray *)titleArray
{
    self = [super init];
    if (self) {
       // self.translucent = NO;
      
        UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
        lineview.backgroundColor=cLineColor;
        [self addSubview:lineview];
        
        self.backgroundColor=[UIColor whiteColor];
        float width=(WindowWith-defX*2)/titleArray.count;
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            NSString *title=[titleArray objectAtIndex:i];
            btn.frame=CGRectMake(defX+i*width, 0, width, ViewHeigh);
            [btn setTitle:title forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=i+100;
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            [btn setTitleColor:cBlackColor forState:UIControlStateHighlighted];
            [btn setTitleColor:cGreenColor forState:UIControlStateSelected];
            btn.titleLabel.font=sysFont(14);
            [self addSubview:btn];
            if (i>0) {
                UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(defX+i*width, ViewHeigh/2-4, 1, 8)];
                lineView.backgroundColor=RGB(226, 226, 226);
                [self addSubview:lineView];
            }
            
            if (i==0) {
                _currBtn=btn;
                btn.selected=YES;
                
            }
        }
        
      
        _bottomLine=[[UIImageView alloc]initWithFrame:CGRectMake(defX+10, ViewHeigh-1.7, width-20, 1.7)];
        _bottomLine.backgroundColor=cGreenColor;
        [self addSubview:_bottomLine];

    }
    return self;
}


-(void)setTitle:(NSMutableArray *)titleArray{
   
    
    for (NSInteger i=0; i<titleArray.count; i++) {
         UIButton *btn=[self viewWithTag:100+i];
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
    }
}


-(void)segmentClick:(UIButton *)sender{
    
    _currBtn.selected=NO;
    
    sender.selected=YES;
    _currBtn=sender;
    
    
    [UIView animateWithDuration:0.2 animations:^
     {
		 [self->_bottomLine setFrame:CGRectMake(sender.origin.x+10, self->_bottomLine.frame.origin.y, self->_bottomLine.frame.size.width, self->_bottomLine.frame.size.height)];
     }completion:nil];
    
    if ([self.delegate respondsToSelector:@selector(didSegmentViewClickedButtonAtIndex:)]) {
        [self.delegate didSegmentViewClickedButtonAtIndex:sender.tag-100];
    }
    
}
#pragma mark - private methods

//-(void)_baseConfigs
//{
//    
//    
//    /*
//    
//    _segmentControl = [[UISegmentedControl alloc] init];
//    _segmentControl.selectedSegmentIndex = 0;
//    [self addSubview:self.segmentControl];
//    
//    _bottomLine = [[UIView alloc] init];
//    _bottomLine.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:_bottomLine];
//
//    self.segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:-14]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:-16]];
//    
//    _bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
//    [_bottomLine addConstraint:[NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:1]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
//     
//     */
//}

@end
