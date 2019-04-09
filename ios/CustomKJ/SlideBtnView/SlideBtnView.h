//
//  SlideBtnView.h
//  TaSayProject
//
//  Created by Mac on 15/5/13.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SegmentedBtnDelegate <NSObject>

-(void)SegmentedDelegateViewclickedWithIndex:(int)index;

@end

@interface SlideBtnView : UIScrollView
{
    UIButton *_selButton;
    NSMutableArray *_items ;
    UIImageView *_lineView;
}

@property(nonatomic)BOOL isShowline;
@property (nonatomic, assign)   NSInteger   currentItemIndex;           // current selected item's index
@property (nonatomic, strong)   NSArray     *itemTitles;
- (id)initWithFrame:(CGRect)frame setTitleArr:(NSArray *)titleArray isShowLINE:(BOOL)isShowLINE setImgArr:(NSArray *)setImgArray seletImgArray:(NSArray *)seletImgArray;
@property(nonatomic) BOOL userClickStatus;
@property(nonatomic, assign) id<SegmentedBtnDelegate> Segmenteddelegate;

-(void)scrollPage:(CGFloat)x;
@end
