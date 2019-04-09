//
//  FirstView.h
//  QiDongYe
//
//  Created by Zmh on 27/4/16.
//  Copyright © 2016年 Zmh. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FirstView : UIImageView
{
    CGFloat imgWidth;
    CGFloat imgHeight;
    CGFloat imgTop;
    NSMutableArray *array;

}
@property (nonatomic,strong)UIImageView *topImageView;
@property (nonatomic,strong)UIButton *startAppBtu;
//index为页面码  top为上方大图离顶端的距离  zoomsize表示相对缩放的比例
- (id)initWithFrame:(CGRect)frame images:(NSArray *)images index:(int)index top:(CGFloat)imageTop zoomSize:(CGFloat)zoomSize;


@end
