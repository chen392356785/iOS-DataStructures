//
//  CustomView+category5.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/10.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "CustomView.h"

@interface CustomView (category5)

@end

@interface HuoWuTypeView : CustomView
{
    NSArray *_arr;
}

@property(nonatomic,copy)DidSelectCityBlock selectBtn;

-(CGFloat)setDataWith:(NSArray *)arr;

@end
