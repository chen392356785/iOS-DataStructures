//
//  DatePickerView.h
//  MiaoTuProject
//
//  Created by Zmh on 1/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"

typedef void(^timeBlock) (NSString *year,NSString *month,NSString *day,NSString *hour,NSString *minute);

@interface DatePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *_backView;
    NSString *_year;
    NSString *_monthStr;
    NSString *_dayStr;
    NSString *_hourStr;
    NSString *_minuteStr;
    int index;
}
@property (nonatomic,copy) timeBlock block;
@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组
@property(nonatomic ,strong) CalendarLogic *Logic;
@property (nonatomic,strong) UIPickerView *startTimePick;
@property (nonatomic,strong) NSArray *monthArr;
@property (nonatomic,strong) NSArray *dayArr;
@property (nonatomic,strong) NSArray *yearArr;
- (id)initWithFrame:(CGRect)frame day:(int)day;
@end
