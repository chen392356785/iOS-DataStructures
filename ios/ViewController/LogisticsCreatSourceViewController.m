//
//  LogisticsCreatSourceViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 30/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "LogisticsCreatSourceViewController.h"
//#import "CustomView+CustomCategory.h"
#import "AddressPickView.h"
#import "JLSimplePickViewComponent.h"
#import "InformationEditViewController.h"
#import "DatePickerView.h"
@interface LogisticsCreatSourceViewController ()<UITextFieldDelegate,JLActionSheetDelegate,EditInformationDelegate>
{
    SourceAdressView *_adressView;
    CarTypeView *_typeView;
    IHTextField *_textFiled;
    NSString *textfliedtag;
    CGFloat longitude;//出发地经度
    CGFloat latitude;//出发地纬度
    
    int filedTag;
    UIView *superView;
}
@end

@implementation LogisticsCreatSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.type isEqualToString:@"1"]) {
        self.title = @"发布车源";
    }else {
        self.title = @"发布货源";
    }
    
    _BaseScrollView.backgroundColor = RGB(233, 239, 239);
    
    NSArray *arr = @[@"发货时间"];
    CarStartTimeView *timeView = [[CarStartTimeView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 46) array:arr];
    timeView.clipsToBounds = YES;
    if ([self.type isEqualToString:@"1"]) {
        timeView.height = 0;
    }
    timeView.textfiled.delegate = self;
    [_BaseScrollView addSubview:timeView];
    
    SourceAdressView *adressView = [[SourceAdressView alloc] initWithFrame:CGRectMake(0, timeView.bottom, kScreenWidth, 183)];
    adressView.clipsToBounds = YES;
    adressView.startAdressText.delegate = self;
    adressView.endAdressText.delegate = self;
    adressView.goodNameText.delegate = self;
    adressView.goodsNumText.delegate = self;
    _adressView = adressView;
    
    if ([self.type isEqualToString:@"1"]) {
        adressView.height = 91;
    }
    [_BaseScrollView addSubview:adressView];
    
    SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(28, adressView.bottom, kScreenWidth - 28, 25) textColor:RGB(108, 123, 138) textFont:sysFont(13)];
    label.text = @"车辆要求";
    if ([self.type isEqualToString:@"1"]) {
        label.height = 5;
        label.text= @"";
    }
    label.backgroundColor = [UIColor clearColor];
    [_BaseScrollView addSubview:label];
    
    CarTypeView *typeView = [[CarTypeView alloc] initWithFrame:CGRectMake(0, label.bottom, kScreenWidth, 183)];
    typeView.clipsToBounds = YES;
    typeView.carTypeText.delegate = self;
    typeView.carNumText.delegate = self;
    typeView.bearVolumeText.delegate = self;
    typeView.bearWeightText.delegate = self;
    _typeView = typeView;
    if ([self.type isEqualToString:@"1"]) {
        typeView.height = 137;
    }
    [_BaseScrollView addSubview:typeView];
    NSArray *arrWay;
    if ([self.type isEqualToString:@"1"]) {
        arrWay = @[@"发车时间"];
    }else{
        arrWay = @[@"运费方式"];
    }
    
    CarStartTimeView *carWayView = [[CarStartTimeView alloc] initWithFrame:CGRectMake(0, typeView.bottom + 5, kScreenWidth, 45) array:arrWay];
    carWayView.clipsToBounds = YES;
    carWayView.textfiled.delegate = self;
    [_BaseScrollView addSubview:carWayView];
    
    NSArray *array;
    if ([self.type isEqualToString:@"1"]) {
        array = @[@"业务介绍"];
    }else{
        array = @[@"备注"];
    }
    CarStartTimeView *remarkView = [[CarStartTimeView alloc] initWithFrame:CGRectMake(0, carWayView.bottom + 5, kScreenWidth, 45) array:array];
    remarkView.clipsToBounds = YES;
    remarkView.textfiled.delegate = self;
    [_BaseScrollView addSubview:remarkView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(25, remarkView.bottom + 30, kScreenWidth - 50, 40)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = RGB(72, 192, 186);
    button.layer.cornerRadius = 20.0;
    [_BaseScrollView addSubview:button];
    
    _BaseScrollView.contentSize = CGSizeMake(kScreenWidth, button.bottom + 30 + 64);
    
    //监听键盘的升起和隐藏事件,需要用到通知中心  ****IQKeyboard
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
//    监听隐藏:UIKeyboardWillHideNotification
//    [center addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textFiled = (IHTextField *)textField;
    if (textField.tag ==20||textField.tag == 21) {
        [textField resignFirstResponder];
        [self selectedStartAddress:textField];
        
    }else if (textField.tag == 40){
        
        [textField resignFirstResponder];
        UIView *view = textField.superview;
        CarStartTimeView *timeView = (CarStartTimeView *)view.superview;
        if ([timeView.titlelabel.text isEqualToString:@"运费方式"]) {
            NSArray *arr = @[@"面议",@"装车预付",@"货到付款"];
            [self showPicViewWithArr:arr :@"运费方式" :textField.tag];
            
        }else if ([timeView.titlelabel.text isEqualToString:@"业务介绍"]||[timeView.titlelabel.text isEqualToString:@"备注"]){
            InformationEditViewController *inforVC  =[[InformationEditViewController alloc] init];
            inforVC.delegate = self;
            inforVC.type = SelectIntroductionBlock;
            [self pushViewController:inforVC];
        }else {
            [self creatDataPickerViewWith:textField];
        }
    }else if(textField.tag == 31){
        textField.text = nil;
    }
    filedTag = (int)textField.tag;
    superView = textField.superview;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 31) {
        if (![textField.text isEqualToString:@""]) {
            textField.text = [NSString stringWithFormat:@"%@吨",textField.text];
        }
    }
}

- (void)creatDataPickerViewWith:(UITextField *)textFiled
{
    DatePickerView *datePick = [[DatePickerView alloc] initWithFrame:self.view.bounds day:30];
    [self.view addSubview:datePick];
    datePick.block = ^(NSString *year,NSString *month,NSString *day,NSString *hour,NSString *minute){
        textFiled.text = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
    };
}
- (void)selectedStartAddress:(UITextField *)textFiled
{
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        
        textFiled.text = [NSString stringWithFormat:@"%@%@%@",province,city,town] ;
        
        NSString *oreillyAddress=[NSString stringWithFormat:@"%@%@%@",province,city,town];
        CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
        [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] > 0 && error == nil)
            {
                NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
                CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
                NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
                
            }
            else if ([placemarks count] == 0 && error == nil)
            {
                NSLog(@"Found no placemarks.");
            }
            else if (error != nil)
            {
                NSLog(@"An error occurred = %@", error);
            }
        }];
    };
}

- (void)keyBoardWillShow:(NSNotification *)notification
{
//    //获取键盘的相关属性(包括键盘位置,高度...)
//    NSDictionary *userInfo = notification.userInfo;
//    
//    //获取键盘的位置和大小
//    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue /*将对象转换为CGRect结构体*/];
//    CGFloat keyHeight = rect.size.height;
    
    //键盘升起的时候
    //    if (height >= rect.origin.y) {
    //
    //        [_BaseScrollView setContentOffset:CGPointMake(0, height - rect.origin.y) animated:YES];
    //    }
}

- (void)keyBoardWillHide
{
    //键盘隐藏的时候
    [_BaseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)showPicViewWithArr:(NSArray *)arr :(NSString *)title :(NSInteger)tag
{
    //    JLSimplePickViewComponent *pickView =(JLSimplePickViewComponent*)[self.view viewWithTag:tag];
    JLSimplePickViewComponent *pickView = [[JLSimplePickViewComponent alloc] initWithParams:title withData:arr];
    pickView.tag=tag;
    pickView.ActionSheetDelegate = self;
    
    [pickView show];
    
}

-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedData:(NSString *)SelectedStr
{
    if (pickViewComponent.tag==40) {
        NSLog(@"%@",SelectedStr);
        _textFiled.text = SelectedStr;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)displayTiyle:(NSString *)title type:(EditBlock)type
{
    _textFiled.text = title;
}

@end
