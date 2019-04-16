//
//  SimplePickViewComponent.h
//  MinshengBank_Richness
//
//  Created by infohold infohold_Mac3 on 11-12-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


/*
 封装包换一个滚轮的ActionSheetView
 */


#import <Foundation/Foundation.h>


@class JLSimplePickViewComponent;

@protocol JLActionSheetDelegate<NSObject>
@optional
-(void)ActionSheetDoneHandler;
-(void)ActionSheetCancelHandler;
//-(void)ActionSheetDoneHandleRetureWithSelectedData:(NSString *)SelectedStr;
-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedData:(NSString *)SelectedStr;

-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedIndex:(NSInteger)index;
@end



@interface JLSimplePickViewComponent : UIView
<
UIPickerViewDelegate,
UIPickerViewDataSource
>
{
//    UIView *ActionView;
    NSArray *m_DataArray;
    //  UIPickerView *G_pickerView;
    NSString* m_SelectedStr;
}


@property(nonatomic,assign) id<JLActionSheetDelegate> ActionSheetDelegate;
//@property(nonatomic,assign) UIView *ActionView;
@property(nonatomic, strong) NSArray *m_DataArray;

@property(nonatomic, strong) NSArray *ProInfo_DataArray;
@property(nonatomic, strong) NSArray *City_DataArray;

@property(nonatomic, assign) UIPickerView *pickerView;
@property(nonatomic,strong)UIView* view;

-(id)initWithParams:(NSString *)actionTitle withData:(NSArray *)arrayData;



-(void)show;
- (void)showInView:(UIView *)view;
-(void)dismissSheet;
@end


@class JLDatePickView;

@protocol JLDatePickViewDelegate<NSObject>
@optional
-(void)datePickViewCance:(JLDatePickView *)datePickView;
-(void)datePickViewDone:(JLDatePickView *)datePickView;
@end

@interface JLDatePickView : UIView

@property(nonatomic,weak) id<JLDatePickViewDelegate> pickDelegate;
@property(nonatomic,strong) UIDatePicker *datePicker;
-(id)initWithParams:(NSString *)actionTitle;
-(void)show;
- (void)showInView:(UIView *)view;
-(void)dismissSheet;

@end
