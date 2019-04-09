//
//  PositionChooseView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"

@interface PositionChooseView : CustomView
{
    UIView *_view;
}
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *Array;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)DidSelectCityBlock selectBlock;
- (id)initWithFrame:(CGRect)frame dic:(NSDictionary *)dic;
-(void)submitClick:(UIButton *)sender;
@end
