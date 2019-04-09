//
//  SimplePickViewComponent.m
//  MinshengBank_Richness
//
//  Created by infohold infohold_Mac3 on 11-12-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JLSimplePickViewComponent.h"


static CGFloat kTransitionDuration = 0.3f;

//static NSMutableArray*  gActionSheetStack = nil;
static UIWindow* gMaskWindow = nil;
static UIWindow* gPreviouseKeyWindow = nil;

@interface JLSimplePickViewComponent (priveteMethods)
+ (void)presentMaskWindow;
+ (void)addActionSheetwOnMaskWindow:(JLSimplePickViewComponent *)sheet;
+ (void)removeActionSheetFormMaskWindow:(JLSimplePickViewComponent *)sheet;
+ (void)dismissMaskWindow;

@end

@interface JLDatePickView (priveteMethods)
+ (void)presentMaskWindow;
+ (void)addActionSheetwOnMaskWindow:(JLDatePickView *)sheet;
+ (void)removeActionSheetFormMaskWindow:(JLDatePickView *)sheet;
+ (void)dismissMaskWindow;

@end


@implementation JLSimplePickViewComponent


@synthesize m_DataArray;
@synthesize pickerView = G_pickerView;
@synthesize ActionSheetDelegate;

#pragma mark --
#pragma mark UIPickerViewDelegate
#pragma mark UIPickerViewDataSource
#pragma mark --

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [m_DataArray count];
}
// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [m_DataArray objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    m_SelectedStr = [m_DataArray objectAtIndex:row];
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


-(id)initWithParams:(NSString *)actionTitle withData:(NSArray *)arrayData
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _deviceSize.width, _deviceHeight)];
        
        int ActionHeight =   ActionHeight = 230+44;;
        //int theight = ActionHeight - 44;
       // int btnnum = theight/50;
        
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
		
        
        UIPickerView *m_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(toolBar.frame), _deviceSize.width, ActionHeight-44)];
        m_pickerView.dataSource = self;
        m_pickerView.delegate = self;
        m_pickerView.backgroundColor=[UIColor whiteColor];
        m_pickerView.showsSelectionIndicator = YES;
        self.m_DataArray =arrayData;
        G_pickerView =m_pickerView;
        [self.view addSubview:m_pickerView];
		
        
        [self addSubview:self.view];
        
    }
    
    return self;
}


-(void)done
{
    
    NSInteger m_SelectedIndex = [G_pickerView selectedRowInComponent:0];
    NSString *m_selectedStr = [m_DataArray objectAtIndex:m_SelectedIndex];
    [self dismissSheet];
    //[ActionSheetDelegate ActionSheetDoneHandleRetureWithSelectedData:m_selectedStr];
    if ([ActionSheetDelegate respondsToSelector:@selector(ActionSheetDoneHandle:selectedData:)]) {
        [ActionSheetDelegate ActionSheetDoneHandle:self selectedData:m_selectedStr];
    }
    
    if ([ActionSheetDelegate respondsToSelector:@selector(ActionSheetDoneHandle:selectedIndex:)]) {
        [ActionSheetDelegate ActionSheetDoneHandle:self selectedIndex:m_SelectedIndex];
    }
    
}

-(void)doCacle
{
   // [self removeFromSuperview];
    
    [self dismissSheet];
    if ([ActionSheetDelegate respondsToSelector:@selector(ActionSheetCancelHandler)]) {
        [ActionSheetDelegate ActionSheetCancelHandler];
    }
    
}



- (void)show
{
    [JLSimplePickViewComponent presentMaskWindow];
    [self sizeToFitOrientation];
    [JLSimplePickViewComponent addActionSheetwOnMaskWindow:self];
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
    [JLSimplePickViewComponent removeActionSheetFormMaskWindow:self];
    [JLSimplePickViewComponent dismissMaskWindow];
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

@implementation JLSimplePickViewComponent (priveteMethods)
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

+ (void)addActionSheetwOnMaskWindow:(JLSimplePickViewComponent *)sheet
{
    [gMaskWindow addSubview:sheet];
    sheet.hidden = NO;
    
}

+(void)removeActionSheetFormMaskWindow:(JLSimplePickViewComponent*)actionSheep
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




@implementation JLDatePickView
@synthesize pickDelegate;

@synthesize datePicker = _datePicker;

-(void)done
{
    [self dismissSheet];
    if ([pickDelegate respondsToSelector:@selector(datePickViewDone:)]) {
        [pickDelegate datePickViewDone:self];
    }
    
}

-(void)doCacle
{
    [self dismissSheet];
    if ([pickDelegate respondsToSelector:@selector(datePickViewCance:)]) {
        [pickDelegate datePickViewCance:self];
    }
    
}


-(id)initWithParams:(NSString *)actionTitle
{
	self=[super initWithFrame:CGRectZero];
	if (self)
	{
        self.frame = CGRectMake(0, 0, _deviceSize.width, _deviceHeight);
		int ActionHeight = 256;
		//int theight = ActionHeight - 40;
		//int btnnum = theight/50;
		
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
    [JLDatePickView presentMaskWindow];
    [self sizeToFitOrientation];
    [JLDatePickView addActionSheetwOnMaskWindow:self];
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
    [JLDatePickView removeActionSheetFormMaskWindow:self];
    [JLDatePickView dismissMaskWindow];
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

@implementation JLDatePickView (priveteMethods)
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

+ (void)addActionSheetwOnMaskWindow:(JLDatePickView *)sheet
{
    [gMaskWindow addSubview:sheet];
    sheet.hidden = NO;
    
}

+(void)removeActionSheetFormMaskWindow:(JLDatePickView*)actionSheep
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
