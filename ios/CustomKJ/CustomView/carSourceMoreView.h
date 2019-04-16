//
//  carSourceMoreView.h
//  MiaoTuProject
//
//  Created by Zmh on 27/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carSourceMoreView : UIView
{
    float topY;
    NSMutableArray *_arr;
//    NSArray *_classArr;
    NSDictionary *_dic;
//    UIView *_classView;
}
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *referBtn;
@property(nonatomic,copy)DicSelectTypdeBlock selectBlock;
- (id)initWithFrame:(CGRect)frame dic:(NSDictionary *)dic;

- (void)hiddenBottomView;
@end
