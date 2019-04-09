//
//  MJPopView.h
//  MoJieProject
//
//  Created by Zmh on 4/4/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
 typedef void  (^DidSelectViewBlock) (NSInteger index);

@interface MJPopView : UIView

{
    UIImageView *_imageView;
}
-(id)initWithOrgin:(CGFloat)y x:(CGFloat)x arr:(NSArray *)arr i:(int)i img:(UIImage *)img;
@property (nonatomic,copy) DidSelectViewBlock selectBlock;
@property (nonatomic ,weak) UIButton *topBtn;
@property(nonatomic,strong)NSArray *arr;

@end
