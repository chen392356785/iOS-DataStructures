//
//  HeadButton.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadButton : UIView
{
    UIImageView *_imgView;
}

@property(nonatomic,strong)UIButton *headBtn;

-(void)setHeadImageUrl:(NSString *)url type:(int)type;

@end
