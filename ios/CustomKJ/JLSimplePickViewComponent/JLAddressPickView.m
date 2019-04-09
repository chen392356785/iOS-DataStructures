//
//  JLAddressPickView.m
//  MiaoTuProject
//
//  Created by Zmh on 11/10/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "JLAddressPickView.h"

static CGFloat kTransitionDuration = 0.3f;

//static NSMutableArray*  gActionSheetStack = nil;
static UIWindow* gMaskWindow = nil;
static UIWindow* gPreviouseKeyWindow = nil;

@interface JLAddressPickView (priveteMethods)
+ (void)presentMaskWindow;
+ (void)addActionSheetwOnMaskWindow:(JLAddressPickView *)sheet;
+ (void)removeActionSheetFormMaskWindow:(JLAddressPickView *)sheet;
+ (void)dismissMaskWindow;

@end

@interface JLAdressDatePickView (priveteMethods)
+ (void)presentMaskWindow;
+ (void)addActionSheetwOnMaskWindow:(JLAdressDatePickView *)sheet;
+ (void)removeActionSheetFormMaskWindow:(JLAdressDatePickView *)sheet;
+ (void)dismissMaskWindow;

@end


@implementation JLAddressPickView



@synthesize Pro_DataArray;
@synthesize ProInfo_DataArray;
@synthesize City_DataArray;
@synthesize pickerView = G_pickerView;
@synthesize ActionSheetDelegate;

#pragma mark --
#pragma mark UIPickerViewDelegate
#pragma mark UIPickerViewDataSource
#pragma mark --

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 2;
}
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component ==0) {
        return [Pro_DataArray count];
    }else {
        return [City_DataArray count];
    }
    
}
// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component ==0) {
        return [Pro_DataArray objectAtIndex:row];
    }else {
        return [City_DataArray objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if (component== 0) {
        Pro_SelectedStr = [Pro_DataArray objectAtIndex:row];
        //排除row为0的时候ProInfo_DataArray数组越界
        NSDictionary *dic = [[NSDictionary alloc] init];
//        NSDictionary *dic = [ProInfo_DataArray objectAtIndex:row];
        if (self.type == 0) {
            if (!row) {
                row = 0;
            }
            if (row >=0 ) {
                dic = [ProInfo_DataArray objectAtIndex:row];
            }else{
                dic = @{};
            }
        }
        NSArray *CityArr =  [self getDataBaseWithName:[NSString stringWithFormat:@"select * from T_City where ProID=%@",dic[@"privoceID"]]];
        NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
        
        for (NSDictionary *Dic in CityArr) {
            [cityNameArr addObject:Dic[@"cityName"]];
        }
        self.City_DataArray = cityNameArr;
        [G_pickerView reloadComponent:1];
        
    }else{
        City_SelectedStr = [City_DataArray objectAtIndex:row];
    }
   }


-(CGSize)sizeThatFits:(CGSize)size{
    return self.view.frame.size;
}

-(id)initWithView:(UIView *)view WithSheetTitle:(NSString*)title;
{
    //height = 84, 134, 184, 234, 284, 334, 384, 434, 484
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.view = view;
        self.view.autoresizesSubviews = YES;
        [self addSubview:self.view];
    }
    return self;
}


-(id)initWithParams:(NSString *)actionTitle type:(int)type
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.type = type;
        self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _deviceSize.width, _deviceHeight)];
        
        int ActionHeight =   ActionHeight = 230+44;;
      //  int theight = ActionHeight - 44;
        //int btnnum = theight/50;
        
        self.view.autoresizesSubviews = YES;
        
        
        UIView *toolBar=[[UIView alloc]initWithFrame:CGRectMake(0, _deviceHeight-ActionHeight, _deviceSize.width, 44)];
        toolBar.backgroundColor=[UIColor whiteColor];
        
        UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        rightButton.frame=CGRectMake(0, 0, 60, 44);
        [rightButton setTitleColor:RGB(189, 189, 189) forState:UIControlStateNormal];
        rightButton.titleLabel.font=sysFont(15);
        [rightButton setTitle:@"取消" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(doCacle) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:rightButton];
        
        UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        leftButton.frame=CGRectMake(_deviceSize.width-60, 0, 60, 44);
        [leftButton setTitleColor:cBlackColor forState:UIControlStateNormal];
        leftButton.titleLabel.font=sysFont(15);
        [leftButton setTitle:@"完成" forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:leftButton];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _deviceSize.width, 44)];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=actionTitle;
        lbl.font=sysFont(17);
        [toolBar addSubview:lbl];
		
        
        //   UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, _deviceHeight-ActionHeight+30, _deviceSize.width, 44)];
        
        //   toolBar.barStyle = UIBarStyleBlackOpaque;
        [self.view addSubview:toolBar];
		
        NSArray *ProvinceArr =  [self getDataBaseWithName:@"SELECT * FROM T_Province"];
        self.ProInfo_DataArray = ProvinceArr;
        NSMutableArray *ProNameArr = [NSMutableArray array];
        if (type == 1) {
            [ProNameArr addObject:@"不限"];
        }
        for (NSDictionary *Dic in ProvinceArr) {
            [ProNameArr addObject:Dic[@"ProName"]];
        }
        
        NSArray *CityArr =  [self getDataBaseWithName:@"select * from T_City where ProID=1"];
        NSMutableArray *cityNameArr = [NSMutableArray array];
        for (NSDictionary *dic in CityArr) {
            [cityNameArr addObject:dic[@"cityName"]];
        }
        
        
        UIPickerView *m_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(toolBar.frame), _deviceSize.width, ActionHeight-44)];
        m_pickerView.dataSource = self;
        m_pickerView.delegate = self;
        m_pickerView.backgroundColor=[UIColor whiteColor];
        m_pickerView.showsSelectionIndicator = YES;
        self.Pro_DataArray = ProNameArr;
        self.City_DataArray = cityNameArr;
        if (type == 1) {
            self.City_DataArray = @[];
        }
        G_pickerView =m_pickerView;
        [self.view addSubview:m_pickerView];
        
        [self addSubview:self.view];
        
    }
    
    return self;
}

-(NSArray *)getDataBaseWithName:(NSString *)tableName{
    NSString *dbPath = @"address.sqlite";
    NSString *srcDbFile=[[[NSBundle mainBundle] resourcePath]
                         stringByAppendingPathComponent:dbPath];
    if (db ==nil) {
        db = [FMDatabase databaseWithPath:srcDbFile];
        [db open];
    }
    db = [FMDatabase databaseWithPath:srcDbFile];
    [db open];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSString *sql = [NSString stringWithFormat:
                     @"%@",tableName];
    
    FMResultSet *rs = [db executeQuery:sql];
    //[tableName isEqualToString:@"SELECT * FROM T_Province"]||[tableName isEqualToString:@"select * from T_Province where ProSort=18"]
    while ([rs next]) {
        if ([tableName rangeOfString:@"SELECT * FROM T_Province"].location != NSNotFound) {
            int privoceID= [rs intForColumn:@"ProSort"];
            NSString *ProName=[rs stringForColumn:@"ProName"];
            ;
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                               [NSString stringWithFormat:@"%d",privoceID],@"privoceID",
                               ProName,@"ProName",
                               nil];
            [arr addObject:dic];
        }else{
            int cityID= [rs intForColumn:@"CitySort"];
            int privoceID = [rs intForColumn:@"ProID"];
            NSString *cityName=[rs stringForColumn:@"CityName"];
            ;
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                               [NSString stringWithFormat:@"%d",cityID],@"cityID",
                               [NSString stringWithFormat:@"%d",privoceID],@"privoceID",
                               cityName,@"cityName",
                               nil];
            [arr addObject:dic];
        }
        
    }
    
    [rs close];
    return arr;
}

-(void)done
{
    
    NSInteger m_SelectedIndex = [G_pickerView selectedRowInComponent:0];
    NSString *pro_selectedStr = [Pro_DataArray objectAtIndex:m_SelectedIndex];
    NSInteger city_SelectedIndex = [G_pickerView selectedRowInComponent:1];
    NSString *city_selectedStr;
    NSDictionary *dic;
    if (self.type == 1&&m_SelectedIndex==0) {
        dic = @{};
        city_selectedStr = @"";
    }else {
        dic = [ProInfo_DataArray objectAtIndex:m_SelectedIndex];
        city_selectedStr = [City_DataArray objectAtIndex:city_SelectedIndex];
    }
    NSArray *CityArr =  [self getDataBaseWithName:[NSString stringWithFormat:@"select * from T_City where ProID=%@",dic[@"privoceID"]]];
    NSDictionary *cityDic;
    if (CityArr.count == 0) {
        cityDic = @{};
    }else{
        cityDic = [CityArr objectAtIndex:city_SelectedIndex];
    }

    [self dismissSheet];

    if ([ActionSheetDelegate respondsToSelector:@selector(ActionSheetDoneHandle:selectedProData:selectedCityData:)]) {
        [ActionSheetDelegate ActionSheetDoneHandle:self selectedProData:pro_selectedStr selectedCityData:city_selectedStr];
    }
    
    if ([ActionSheetDelegate respondsToSelector:@selector(ActionSheetDoneHandle:selectedProIndex:selectedCityIndex:)]) {
        [ActionSheetDelegate ActionSheetDoneHandle:self selectedProIndex:[dic[@"privoceID"] integerValue] selectedCityIndex:[cityDic[@"cityID"] integerValue]];
    }
    
}

-(void)doCacle
{
    // [self removeFromSuperview];
    
    [self dismissSheet];
    if ([ActionSheetDelegate respondsToSelector:@selector(AdressActionSheetCancelHandler)]) {
        [ActionSheetDelegate AdressActionSheetCancelHandler];
    }
    
}



- (void)show
{
    [JLAddressPickView presentMaskWindow];
    [self sizeToFitOrientation];
    [JLAddressPickView addActionSheetwOnMaskWindow:self];
    [self bounce0Animation];
}

- (void)showInView:(UIView *)view{
    [self show];
}

-(void)dismissSheet
{
    [self dismissAlertViewWithAnimated:YES];
}

-(void)dismissAlertViewWithAnimated:(BOOL)animated
{
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration/1.5f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dismissAlertView)];
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        [self setCenter:CGPointMake(screenSize.width/2, screenSize.height + self.view.frame.size.height / 2)];
        [UIView commitAnimations];
    }
    else
    {
        [self dismissAlertView];
    }
}

- (void)dismissAlertView
{
    [JLAddressPickView removeActionSheetFormMaskWindow:self];
    [JLAddressPickView dismissMaskWindow];
}

- (void)bounce0Animation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5f];
    [UIView setAnimationDelegate:self];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setCenter:CGPointMake(screenSize.width/2, screenSize.height - self.view.frame.size.height / 2)];
    [UIView commitAnimations];
}

- (void)sizeToFitOrientation
{
    [self sizeToFit];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setCenter:CGPointMake(screenSize.width/2, screenSize.height + self.view.frame.size.height / 2)];
}

@end

@implementation JLAddressPickView (priveteMethods)
+ (void)presentMaskWindow
{
    if (!gMaskWindow)
    {
        gMaskWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //   gMaskWindow.windowLevel = UIWindowLevelStatusBar + 1;
        gMaskWindow.backgroundColor = [UIColor clearColor];
        gMaskWindow.hidden = YES;
        [gMaskWindow setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.65f]];
        // FIXME: window at index 0 is not awalys previous key window.
        gPreviouseKeyWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        [gMaskWindow makeKeyAndVisible];
        // Fade in background
        gMaskWindow.alpha = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        gMaskWindow.alpha = 1;
        [UIView commitAnimations];
    }
    else{
        gMaskWindow.hidden = NO;
    }
}

+ (void)addActionSheetwOnMaskWindow:(JLAddressPickView *)sheet
{
    [gMaskWindow addSubview:sheet];
    sheet.hidden = NO;
    
}

+(void)removeActionSheetFormMaskWindow:(JLAddressPickView*)actionSheep
{
    if (!gMaskWindow||![gMaskWindow.subviews containsObject:actionSheep])
    {
        return;
    }
    [actionSheep removeFromSuperview];
    actionSheep.hidden = YES;
}

+ (void)dismissMaskWindow
{
    if (gMaskWindow) {
        gMaskWindow.hidden = YES;
        [gPreviouseKeyWindow makeKeyAndVisible];
        gPreviouseKeyWindow = nil;
        gMaskWindow = nil;
    }
}

@end




@implementation JLAdressDatePickView
@synthesize pickDelegate;

@synthesize datePicker = _datePicker;

-(void)done
{
    [self dismissSheet];
    if ([pickDelegate respondsToSelector:@selector(adressdatePickViewDone:)]) {
        [pickDelegate adressdatePickViewDone:self];
    }
    
}

-(void)doCacle
{
    [self dismissSheet];
    if ([pickDelegate respondsToSelector:@selector(adressdatePickViewCance:)]) {
        [pickDelegate adressdatePickViewCance:self];
    }
    
}


-(id)initWithParams:(NSString *)actionTitle
{
    self=[super initWithFrame:CGRectZero];
    if (self)
    {
        self.frame = CGRectMake(0, 0, _deviceSize.width, _deviceHeight);
        int ActionHeight = 256;
       // int theight = ActionHeight - 40;
       // int btnnum = theight/50;
        
        //		for(int i=0; i<btnnum; i++)
        //		{
        //			[self addButtonWithTitle:@" "];
        //		}
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, _deviceHeight-ActionHeight+30, 320, 44)];
        toolBar.barStyle = UIBarStyleDefault;
        
        UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:actionTitle style: UIBarButtonItemStylePlain target: nil action: nil];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style: UIBarButtonItemStyleDone target: self action: @selector(done)];
        UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: UIBarButtonItemStylePlain target: self action: @selector(doCacle)];
        UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
        NSArray *array = [[NSArray alloc] initWithObjects: leftButton,fixedButton, titleButton,fixedButton, rightButton, nil];
        [toolBar setItems: array];

        [self addSubview:toolBar];
		
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,toolBar.frame.origin.y, 320, _deviceHeight-toolBar.frame.origin.y)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        [self sendSubviewToBack:view];

		
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(toolBar.frame), 320, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:_datePicker];
    }
    
    return self;
}

- (void)show
{
    [JLAdressDatePickView presentMaskWindow];
    [self sizeToFitOrientation];
    [JLAdressDatePickView addActionSheetwOnMaskWindow:self];
    [self bounce0Animation];
}

- (void)showInView:(UIView *)view{
    [self show];
}

-(void)dismissSheet
{
    [self dismissAlertViewWithAnimated:YES];
}

-(void)dismissAlertViewWithAnimated:(BOOL)animated
{
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration/1.5f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dismissAlertView)];
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        [self setCenter:CGPointMake(screenSize.width/2, screenSize.height + self.frame.size.height / 2)];
        [UIView commitAnimations];
    }
    else
    {
        [self dismissAlertView];
    }
}

- (void)dismissAlertView
{
    [JLAdressDatePickView removeActionSheetFormMaskWindow:self];
    [JLAdressDatePickView dismissMaskWindow];
}

- (void)bounce0Animation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5f];
    [UIView setAnimationDelegate:self];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setCenter:CGPointMake(screenSize.width/2, screenSize.height - self.frame.size.height / 2)];
    [UIView commitAnimations];
}

- (void)sizeToFitOrientation
{
    [self sizeToFit];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setCenter:CGPointMake(screenSize.width/2, screenSize.height + self.frame.size.height / 2)];
}


@end

@implementation JLAdressDatePickView (priveteMethods)
+ (void)presentMaskWindow
{
    if (!gMaskWindow)
    {
        gMaskWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //   gMaskWindow.windowLevel = UIWindowLevelStatusBar + 1;
        gMaskWindow.backgroundColor = [UIColor clearColor];
        gMaskWindow.hidden = YES;
        [gMaskWindow setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.65f]];
        // FIXME: window at index 0 is not awalys previous key window.
        gPreviouseKeyWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        [gMaskWindow makeKeyAndVisible];
        // Fade in background
        gMaskWindow.alpha = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        gMaskWindow.alpha = 1;
        [UIView commitAnimations];
    }
    else{
        gMaskWindow.hidden = NO;
    }
}

+ (void)addActionSheetwOnMaskWindow:(JLAdressDatePickView *)sheet
{
    [gMaskWindow addSubview:sheet];
    sheet.hidden = NO;
    
}

+(void)removeActionSheetFormMaskWindow:(JLAdressDatePickView*)actionSheep
{
    if (!gMaskWindow||![gMaskWindow.subviews containsObject:actionSheep])
    {
        return;
    }
    [actionSheep removeFromSuperview];
    actionSheep.hidden = YES;
}

+ (void)dismissMaskWindow
{
    if (gMaskWindow) {
        gMaskWindow.hidden = YES;
        [gPreviouseKeyWindow makeKeyAndVisible];
        gPreviouseKeyWindow = nil;
        gMaskWindow = nil;
    }
}

@end
