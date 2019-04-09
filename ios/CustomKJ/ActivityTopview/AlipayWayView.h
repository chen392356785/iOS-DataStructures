//
//  AlipayWayView.h
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlipayWayView : UIView
{
    UIImageView *_titleImage;
    UILabel *_wayName;
}
@property (nonatomic,strong)UIButton *selectedBtu;
- (id)initWithFrame:(CGRect)frame;
-(void)setDataImage:(NSString *)imageName name:(NSString *)name;
@end
