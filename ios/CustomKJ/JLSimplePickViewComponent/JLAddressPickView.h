//
//  JLAddressPickView.h
//  MiaoTuProject
//
//  Created by Zmh on 11/10/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "FMDatabase.h"
#import <Foundation/Foundation.h>

@class JLAddressPickView;

@protocol JLAddressActionSheetDelegate<NSObject>
@optional
-(void)AdressActionSheetDoneHandler;
-(void)AdressActionSheetCancelHandler;
//-(void)ActionSheetDoneHandleRetureWithSelectedData:(NSString *)SelectedStr;
-(void)ActionSheetDoneHandle:(JLAddressPickView*)pickViewComponent selectedProData:(NSString *)SelectedStr selectedCityData:(NSString *)SelectedCityStr;

-(void)ActionSheetDoneHandle:(JLAddressPickView*)pickViewComponent selectedProIndex:(NSInteger)index selectedCityIndex:(NSInteger)cityIndex;
@end

@interface JLAddressPickView : UIView
<
UIPickerViewDelegate,
UIPickerViewDataSource
>
{
//    UIView *ActionView;
    NSArray *Pro_DataArray;
    NSArray *City_DataArray;
    NSArray *ProInfo_DataArray;
    NSString* Pro_SelectedStr;
    NSString* City_SelectedStr;
    FMDatabase *db;
}


@property(nonatomic,assign) id<JLAddressActionSheetDelegate> ActionSheetDelegate;
//@property(nonatomic,assign) UIView *ActionView;
@property(nonatomic, strong) NSArray *Pro_DataArray;
@property(nonatomic, strong) NSArray *ProInfo_DataArray;
@property(nonatomic, strong) NSArray *City_DataArray;
@property(nonatomic, assign) UIPickerView *pickerView;
@property(nonatomic,strong)UIView* view;
@property(nonatomic,assign)int type;        //1代表只有省级单排，2省市选择
-(id)initWithParams:(NSString *)actionTitle type:(int)type;



-(void)show;
- (void)showInView:(UIView *)view;
-(void)dismissSheet;
@end


@class JLAdressDatePickView;

@protocol JLAdressDatePickViewDelegate<NSObject>
@optional
-(void)adressdatePickViewCance:(JLAdressDatePickView *)datePickView;
-(void)adressdatePickViewDone:(JLAdressDatePickView *)datePickView;
@end

@interface JLAdressDatePickView : UIView
{
    //	UIView *ActionView;
//    UIDatePicker *_datePicker;
}

@property(nonatomic,weak) id<JLAdressDatePickViewDelegate> pickDelegate;
//@property(nonatomic,assign) UIView *ActionView;

@property(nonatomic, strong) UIDatePicker *datePicker;


-(id)initWithParams:(NSString *)actionTitle;
-(void)show;
- (void)showInView:(UIView *)view;
-(void)dismissSheet;

@end

