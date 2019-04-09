//
//  JLPickView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/9.
//  Copyright © 2017年 xubin. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface JLPickView : UIView
<
UIPickerViewDelegate,
UIPickerViewDataSource
>
/**
 *  存放数据的数组
 */
@property (nonatomic,strong)NSArray *citiesArray;

/**
 *  pickerview
 */
@property (strong, nonatomic) UIPickerView *pickerView;

/**
 *  省市 城市名称 文本
 */
@property (strong, nonatomic) UILabel *lbProCityName;

/**
 *  省市 城市名称
 */
@property (copy, nonatomic) NSString *proCityName;

@property (copy, nonatomic) NSString *CityName;
/**
 *  省模型
 */
@property (nonatomic,strong)NSArray * selecletProArr;

/**
 *  取消按钮
 */
@property (strong, nonatomic) UIButton *cancelBtn;

/**
 *  确定按钮
 */
@property (strong, nonatomic) UIButton *confirmBtn;

/**
 *  删除视图
 */
-(void)disMiss;

@property (nonatomic,copy) void(^SelectBlock)(NSString *str1,NSString *str2);
-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;
@end
