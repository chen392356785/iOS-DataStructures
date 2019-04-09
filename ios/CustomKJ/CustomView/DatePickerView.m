//
//  DatePickerView.m
//  MiaoTuProject
//
//  Created by Zmh on 1/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "DatePickerView.h"
#import "CalendarDayModel.h"
#define buttonWidth 60.0f
#define navigationViewHeight 35.0f

@implementation DatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame day:(int)day
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor= RGBA(0, 0, 0, 0.4);
        
        self.calendarMonth = [self getMonthArrayOfDayNumber:day ToDateforString:nil];
        NSMutableArray *Marray = [NSMutableArray array];
        NSMutableArray *Darray = [NSMutableArray array];
        NSMutableArray *Yarray = [NSMutableArray array];
        for (int i=0; i<self.calendarMonth.count; i++) {
 
            NSMutableArray *array = [NSMutableArray array];
            NSArray *arr= self.calendarMonth[i];
            for (CalendarDayModel *model in arr) {
                if (model.style == CellDayTypeFutur||model.style == CellDayTypeClick||model.style == CellDayTypeWeek) {
                    [array addObject:[NSString  stringWithFormat:@"%d",(int)model.day]];
                    
                    if (![Marray containsObject:[NSString stringWithFormat:@"%d",(int)model.month]]) {
                        [Marray addObject:[NSString stringWithFormat:@"%d",(int)model.month]];
                    }
                    
                    if (![Yarray containsObject:[NSString stringWithFormat:@"%d",(int)model.year]]) {
                        [Yarray addObject:[NSString stringWithFormat:@"%d",(int)model.year]];
                    }

                }
                
              }
            [Darray addObject:array];
        }
        self.monthArr = Marray;
        self.dayArr = Darray;
        self.yearArr = Yarray;
        
        index = 0;
        _year = self.yearArr[0];
        _monthStr = self.monthArr[0];
        _dayStr = self.dayArr[0][0];
        _hourStr = @"00";
        _minuteStr = @"00";
        [self initViews];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initViews
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    view.bottom = self.height;
    view.backgroundColor = [UIColor whiteColor];
    _backView = view;
    [self addSubview:view];
    
    NSArray *buttonTitleArray = @[@"取消",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*(kScreenWidth-buttonWidth), 0, buttonWidth, navigationViewHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [view addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];    
    }

    
    _startTimePick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 35, view.width, view.height - 35)];
    _startTimePick.dataSource =self;
    _startTimePick.delegate =self;
    [view addSubview:_startTimePick];
    
    [self addSubview:view];
    
    
}

//-(void)showBottomView
//{
//    self.backgroundColor = [UIColor clearColor];
//    [UIView animateWithDuration:0.3 animations:^{
//        self->_startTimePick.top = kScreenHeight-250;
//        self.backgroundColor = windowColor;
//    } completion:^(BOOL finished) {
//        
//    }];
//}
- (void)tapButton:(UIButton *)button{
    
    if (button.tag == 1) {

        self.block(_year,_monthStr,_dayStr,_hourStr,_minuteStr);
    }
    [self hiddenBottomView];
}
-(void)hiddenBottomView
{

    [UIView animateWithDuration:0.3 animations:^{
        self->_backView.top = kScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}
//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate
{
    
    NSDate *date = [NSDate date];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    self.Logic = [[CalendarLogic alloc]init];
    
    return [self.Logic reloadCalendarView:date selectDate:selectdate  needDays:day];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArr.count;
    }else if (component == 1) {
        return self.monthArr.count;
    }else if (component == 2){
        NSArray *arr = self.dayArr[index];
        return arr.count;
    }else if (component == 3){
        return 24;
    }else if (component == 4){
        return 6;
    }
    
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [NSString stringWithFormat:@"%@",[self.yearArr objectAtIndex:row]];
    }else if (component == 1) {
        return [NSString stringWithFormat:@"%@月",[self.monthArr objectAtIndex:row]];
    }else if (component == 2){
        _dayStr = self.dayArr[index][0];
         NSArray *arr = self.dayArr[index];
        return [NSString stringWithFormat:@"%@日",[arr objectAtIndex:row]];
    }else if (component == 3){
        NSString *str = [NSString stringWithFormat:@"%d",(int)row];
        if (str.length<=1) {
            return [NSString stringWithFormat:@"0%d时",(int)row];
        }else {
            return [NSString stringWithFormat:@"%d时",(int)row];
        }
    }else if (component == 4){
        if (row== 0) {
            return [NSString stringWithFormat:@"0%d分",(int)row*10];
        }else{
            return [NSString stringWithFormat:@"%d分",(int)row*10];
        }
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _year = [self.yearArr objectAtIndex:row];
    }else if (component == 1) {
        index = (int)row;
        _monthStr = [self.monthArr objectAtIndex:row];
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 2){
         NSArray *arr = self.dayArr[index];
        _dayStr = [arr objectAtIndex:row];
    }else if (component == 3){
        NSString *str = [NSString stringWithFormat:@"%d",(int)row];
        if (str.length<=1) {
           _hourStr = [NSString stringWithFormat:@"0%d",(int)row];
        }else {
            _hourStr = [NSString stringWithFormat:@"%d",(int)row];
        }
        
    }else if (component == 4){
        if (row == 0) {
            _minuteStr = [NSString stringWithFormat:@"0%d",(int)row*10];

        }else {
           _minuteStr = [NSString stringWithFormat:@"%d",(int)row*10];
        }
    }


}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    if (self.yearArr.count<= 1) {
//        return 0;
//    }else {
//        return kScreenWidth/5.0;
//    }
//}

@end
