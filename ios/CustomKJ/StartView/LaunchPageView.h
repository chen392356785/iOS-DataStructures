//
//  LaunchPageView.h
//  MiaoTuProject
//
//  Created by Zmh on 3/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectBtnBlock) (NSInteger index);

@interface LaunchPageView : UIView
{
    UIImageView *_topImageView;
    UIImageView *_titleImageView;
    NSArray *_images;
}
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@property (nonatomic,assign,getter=isClickPass) BOOL clickPass;
- (id)initWithFrame:(CGRect)frame images:(NSArray *)images;
@end
