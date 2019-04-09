//
//  calendarView.h
//  MiaoTuProject
//
//  Created by Zmh on 26/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"

//回掉代码块
typedef void (^CalendarBlock)(CalendarDayModel *model);

@interface calendarView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组

@property(nonatomic ,strong) CalendarLogic *Logic;
@property(nonatomic ,strong) UIButton *unlimitedBtn;
@property (nonatomic, copy) CalendarBlock calendarblock;//回调

- (id)initWithFrame:(CGRect)frame day:(int)day;
@end
