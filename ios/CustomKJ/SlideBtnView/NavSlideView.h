//
//  NavSlideView.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/22.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavSlideView : UIView
{
    UIView *_selView;
    UIButton *_selButton;
    UIImageView *_redImageView;
    NSArray *_arr;
}

@property(nonatomic) NSInteger navSlideWidth;
@property(nonatomic) NSInteger  Count;
@property(nonatomic) NSInteger currIndex;
- (id)initWithFrame:(CGRect)frame setTitleArr:(NSArray *)titleArray isPoint:(BOOL)isPoint integer:(NSInteger)integer;
-(void)slideScroll:(CGFloat) x;
-(void)slideSelectedIndex:(NSInteger)index;
-(void)setPointNum:(int)num;
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
@end
