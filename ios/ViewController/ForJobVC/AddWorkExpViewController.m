//
//  AddWorkExpViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 19/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "AddWorkExpViewController.h"
//#import "JLSimplePickViewComponent.h"
#define MAX_LIMIT_NUMS   300

@interface AddWorkExpViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    PlaceholderTextView *_txtView;
    SMLabel *_sumlbl;
    IHTextField *_jobText;//工作 和 学校
    IHTextField *_companyText;//公司 和 专业
    UIView *_backView;
    UIView *_windView;
    
    SMLabel *_startTimeLbl;
    SMLabel *_endTimeLbl;
    
    NSMutableArray *_yearArr;
    NSMutableArray *monthArr;
    NSString *yearStr;//选中的年份
    NSString *monthStr;//选中的月份
    NSString *timeType;//1 为开始时间 其他未结束时间
    
    NSMutableDictionary *mainDic;
    NSMutableArray *array;
    
    NSString *startTime;
    NSString *endTime;
    
    int month;
    
}
@end

@implementation AddWorkExpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.titleStr];
    
    self.view.backgroundColor = cLineColor;
    
    _yearArr = [[NSMutableArray alloc] init];
    array = [[NSMutableArray alloc] init];
    mainDic = [[NSMutableDictionary alloc] init];
    
    //获取当前年份和月份
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int year = (int)[dateComponent year];
    month = (int)[dateComponent month];
    
    //年份显示当前年份之前的21年范围
    for (int i=0; i < 22; i++) {
        if (i<21) {
            [_yearArr addObject:stringFormatInt(year - i)];
        }else {
            [_yearArr addObject:[NSString stringWithFormat:@"%d以前",year - 20]];
        }
    }
    //当前年份显示不超过当前月份的月份数
    monthArr = [[NSMutableArray alloc] init];
    for (int i=1; i<=month; i++) {
        [monthArr addObject:stringFormatInt(i)];
    }
    
    yearStr = _yearArr[0];
    monthStr = @"1";
    
    NSArray *arr;
    if ([self.titleStr isEqualToString:@"工作经历"]) {
        arr = @[@"职位名称",@"公司名称"];
    }else {
        arr = @[@"学校",@"专业"];
    }
    for (int i = 0; i<arr.count; i++) {
        
        UIView *advantageView = [[UIView alloc] initWithFrame:CGRectMake(0, 9 + 50.7*i, WindowWith, 50)];
        advantageView.backgroundColor = [UIColor whiteColor];
        [_BaseScrollView addSubview:advantageView];
        
        CGSize size= [IHUtility GetSizeByText:arr[i] sizeOfFont:14 width:120];
        SMLabel *labl = [[SMLabel alloc] initWithFrameWith:CGRectMake(17.5, 0, size.width, 20) textColor:cBlackColor textFont:sysFont(14)];
        labl.text = arr[i];
        labl.centerY = advantageView.height/2.0;
        [advantageView addSubview:labl];
        
        IHTextField *textField = [[IHTextField alloc] initWithFrame:CGRectMake(labl.right + 8, 0, advantageView.width -labl.right-16, 20)];
        if (i==0) {
            if (self.infoDic!=nil) {
                textField.text = self.infoDic[@"job"];
            }
            _jobText = textField;
            if ([self.titleStr isEqualToString:@"工作经历"]) {
                textField.placeholder= @"填写你的职位";
            }else {
                textField.placeholder= @"填写你的毕业院校";
            }
        }else {
            if (self.infoDic!=nil) {
                textField.text = self.infoDic[@"company"];
            }
            _companyText = textField;
            if ([self.titleStr isEqualToString:@"工作经历"]) {
                textField.placeholder= @"填写公司名字";
            }else {
                textField.placeholder= @"请填写专业";
            }
        }
        textField.centerY = advantageView.height/2.0;
        textField.font = sysFont(15);
        [advantageView addSubview:textField];
    }
    
    UIView *timeView  = [[UIView alloc] initWithFrame:CGRectMake(0,110, WindowWith, 50)];
    timeView.backgroundColor = [UIColor whiteColor];
    timeView.userInteractionEnabled= YES;
    [_BaseScrollView addSubview:timeView];
    
    CGSize size= [IHUtility GetSizeByText:@"时间段" sizeOfFont:14 width:120];
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(17.5, 0, size.width, 20) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text = @"时间段";
    lbl.centerY = timeView.height/2.0;
    [timeView addSubview:lbl];
    
    //开始时间
    _startTimeLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(lbl.right +8, 0, (timeView.width - lbl.right - 38)/2.0, 20) textColor:cGrayLightColor textFont:sysFont(12)];
    _startTimeLbl.text = @"";
    //编辑已有经历显示时间
    if (self.infoDic!=nil) {
        _startTimeLbl.text = self.infoDic[@"startTime"];
        startTime = [_startTimeLbl.text stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    }
    _startTimeLbl.textAlignment = NSTextAlignmentRight;
    _startTimeLbl.centerY = timeView.height/2.0;
    //    _startTimeLbl = lbl;
    _startTimeLbl.userInteractionEnabled = YES;
    [timeView addSubview:_startTimeLbl];
    
    UITapGestureRecognizer *tapTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTime:)];
    tapTime.numberOfTapsRequired = 1;
    tapTime.numberOfTouchesRequired = 1;
    [_startTimeLbl addGestureRecognizer:tapTime];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(_startTimeLbl.right + 10, 0, 14, 20) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text = @"至";
    lbl.centerY = timeView.height/2.0;
    [timeView addSubview:lbl];
    
    //结束时间
    _endTimeLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(lbl.right + 10, 0, _startTimeLbl.width, 20) textColor:cGrayLightColor textFont:sysFont(12)];
    _endTimeLbl.text = @"";
    if (self.infoDic!=nil) {
        _endTimeLbl.text = self.infoDic[@"endTime"];
        endTime = [_endTimeLbl.text stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    }
    _endTimeLbl.centerY = timeView.height/2.0;
    //    _endTimeLbl = lbl;
    _endTimeLbl.userInteractionEnabled = YES;
    [timeView addSubview:_endTimeLbl];
    
    UITapGestureRecognizer *tapTime1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTime:)];
    tapTime1.numberOfTapsRequired = 1;
    tapTime1.numberOfTouchesRequired = 1;
    [_endTimeLbl addGestureRecognizer:tapTime1];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(18, timeView.bottom + 15, WindowWith - 36, 19) textColor:cBlackColor textFont:sysFont(13)];
    lbl.backgroundColor =  [UIColor clearColor];
    [_BaseScrollView addSubview:lbl];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, lbl.bottom + 8, WindowWith, 300)];
    view.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:view];
    
    PlaceholderTextView *textView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(12, 0, WindowWith -24, 260)];
    textView.placeholderFont=sysFont(14);
    textView.font = sysFont(14);
    textView.delegate=self;
    _txtView = textView;
    textView.placeholderColor = cGrayLightColor;
    [view addSubview:textView];
    
    if ([self.titleStr isEqualToString:@"工作经历"]) {
        lbl.text = @"工作职责";
        textView.placeholder = @"请填写您的工作内容...";
    }else {
        lbl.text = @"在校经历";
        textView.placeholder = @"请填写您的在校经历...";
    }
    if (self.infoDic!=nil) {
        textView.text = self.infoDic[@"content"];
        textView.placeholderLbl.hidden = YES;
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, textView.bottom + 5, WindowWith, 1)];
    lineView.backgroundColor = cLineColor;
    [view addSubview:lineView];
    
    SMLabel *sumlbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, lineView.bottom , WindowWith-12, 23) textColor: [IHUtility colorWithHexString:@"#bbbbbb"] textFont:sysFont(13)];
    sumlbl.textAlignment=NSTextAlignmentRight;
    _sumlbl = sumlbl;
    sumlbl.text=stringFormatInt(MAX_LIMIT_NUMS);
    [view addSubview:sumlbl];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(18, view.bottom + 35, WindowWith - 36, 38)];
    [btn setTitle:@"保  存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 20.0;
    btn.backgroundColor = cGreenColor;
    btn.titleLabel.font = sysFont(15);
    [btn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [_BaseScrollView addSubview:btn];
    
    _BaseScrollView.contentSize = CGSizeMake(WindowWith, btn.bottom + 50);
    
    UIView *windView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
    windView.backgroundColor = RGBA(0, 0, 0, 0.3);
    windView.alpha = 0;
    _windView = windView;
    
    //时间选择器
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 270)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.top = windView.height;
    _backView = backView;
    [windView addSubview:backView];
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.frame=CGRectMake(0, 0, 60, 40);
    [rightButton setTitleColor:RGB(189, 189, 189) forState:UIControlStateNormal];
    rightButton.titleLabel.font=sysFont(15);
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(doCacle) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightButton];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftButton.frame=CGRectMake(_deviceSize.width-60, 0, 60, 40);
    [leftButton setTitleColor:cBlackColor forState:UIControlStateNormal];
    leftButton.titleLabel.font=sysFont(15);
    [leftButton setTitle:@"完成" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:leftButton];
    
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _deviceSize.width, 40)];
    titleLbl.textAlignment=NSTextAlignmentCenter;
    titleLbl.text=@"时间段";
    titleLbl.font=sysFont(17);
    [backView addSubview:titleLbl];
    
    UIPickerView *m_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40, WindowWith, backView.height-40)];
    m_pickerView.dataSource = self;
    m_pickerView.delegate = self;
    m_pickerView.backgroundColor=[UIColor whiteColor];
    m_pickerView.showsSelectionIndicator = YES;
    [backView addSubview:m_pickerView];
    
}
- (void)tapTime:(UITapGestureRecognizer *)tap
{
    [_BaseScrollView endEditing:YES];
    [self.view.window addSubview:_windView];
    [UIView animateWithDuration:.1 animations:^{
		self->_windView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
			self->_backView.top = self->_windView.height - 270;
        }];
    }];
    //判断是选择开始时间还是结束时间
    if (tap.view == _startTimeLbl) {
        timeType = @"1";
    }else {
        timeType =@"2";
    }
}
- (void)doCacle
{
    [UIView animateWithDuration:.3 animations:^{
		self->_backView.top = self->_windView.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
			self->_windView.alpha = 0;
        }];
    }];
}
- (void)done
{
    if ([timeType isEqualToString:@"1"]) {
        _startTimeLbl.text = [NSString stringWithFormat:@"%@.%@",yearStr,monthStr];
        startTime = [NSString stringWithFormat:@"%@-%@",yearStr,monthStr];
        if ([yearStr rangeOfString:@"以前"].location != NSNotFound) {
            _startTimeLbl.text = [NSString stringWithFormat:@"%@",yearStr];
            startTime = [NSString stringWithFormat:@"%@",yearStr];
        }
        
    }else{
        _endTimeLbl.text = [NSString stringWithFormat:@"%@.%@",yearStr,monthStr];
        endTime = [NSString stringWithFormat:@"%@-%@",yearStr,monthStr];
        if ([yearStr rangeOfString:@"以前"].location != NSNotFound) {
            _endTimeLbl.text = [NSString stringWithFormat:@"%@",yearStr];
            endTime = [NSString stringWithFormat:@"%@",yearStr];
        }
    }
    
    [UIView animateWithDuration:.3 animations:^{
        self->_backView.top = self->_windView.height;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
            self->_windView.alpha = 0;
        }];
    }];
}
-(void)submit:(UIButton *)sender{
    
    if (_jobText.text.length==0) {
        if ([self.titleStr isEqualToString:@"工作经历"]) {
            [IHUtility addSucessView:@"职位名未填" type:2];
        }else{
            [IHUtility addSucessView:@"学校名未填" type:2];
        }
        return;
    }
    if ([self.titleStr isEqualToString:@"教育经历"]) {
        if (_jobText.text.length>24) {
            [IHUtility addSucessView:@"学校名不能超过24字" type:2];
            return;
        }
    }
    
    if (_companyText.text.length==0) {
        if ([self.titleStr isEqualToString:@"工作经历"]) {
            [IHUtility addSucessView:@"公司名未填" type:2];
        }else{
            [IHUtility addSucessView:@"专业名未填" type:2];
        }
        return;
    }
    
    if ([self.titleStr isEqualToString:@"教育经历"]) {
        if (_companyText.text.length>16) {
            [IHUtility addSucessView:@"专业名不能超过16字" type:2];
            return;
        }
    }
    
    if (![IHUtility compareDate:startTime withDate:endTime]) {
        if ([startTime rangeOfString:@"以前"].location == NSNotFound){
            [IHUtility addSucessView:@"工作结束日期必须在开始日期之后" type:2];
            return;
        }
    }
    
    if (_txtView.text.length==0) {
        [IHUtility addSucessView:@"经历描述未填" type:2];
        return;
    }
    
    if (_txtView.text.length>300) {
        [IHUtility addSucessView:@"字数不能超过300哦" type:2];
        return;
    }
    
    //获取填写内容保存
    [mainDic setObject:_companyText.text forKey:@"company"];
    [mainDic setObject:_startTimeLbl.text forKey:@"startTime"];
    [mainDic setObject:_jobText.text forKey:@"job"];
    [mainDic setObject:_endTimeLbl.text forKey:@"endTime"];
    [mainDic setObject:_txtView.text forKey:@"content"];
    
    if ([self.titleStr isEqualToString:@"工作经历"]) {
        NSArray *Arr = [IHUtility getUserdefalutsList:kJobExprience];
        if (self.infoDic==nil){
            [array addObjectsFromArray:Arr];
        }
        [array addObject:mainDic];
        
        [IHUtility saveUserDefaluts:array key:kJobExprience];
    }else {
        //添加学习经历
        NSArray *Arr = [IHUtility getUserdefalutsList:kStudyExprience];
        if (self.infoDic==nil){
            [array addObjectsFromArray:Arr];
        }
        [array addObject:mainDic];
        
        [IHUtility saveUserDefaluts:array key:kStudyExprience];
    }
    
    if ([self.titleStr isEqualToString:@"工作经历"]) {
        [self.delegate disPalyAddExprience:@"1"];
    }else {
        [self.delegate disPalyAddExprience:@"2"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _yearArr.count;
    }else{
        return monthArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        if (row == _yearArr.count-1) {
            return [NSString stringWithFormat:@"%@",_yearArr[row]];
        }
        return [NSString stringWithFormat:@"%@年",_yearArr[row]];
    }else {
        return [NSString stringWithFormat:@"%@月",monthArr[row]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component==0) {
        yearStr = _yearArr[row];
        if (row == 21) {
            //选择多少年以前的不显示月份选择
            [monthArr removeAllObjects];
            monthStr= @"";
        }else{
            if ([monthStr isEqualToString:@""]) {
                monthStr=@"1";
            }
            [monthArr removeAllObjects];
            if (row == 0) {
                //当前年份只显示不超过当前月份的选择项
                for (int i=1; i<=month; i++) {
                    [monthArr addObject:stringFormatInt(i)];
                }
            }else {
                for (int i=1; i<13; i++) {
                    [monthArr addObject:stringFormatInt(i)];
                }
            }
        }
        [pickerView reloadComponent:1];
    }else {
        monthStr = monthArr[row];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _sumlbl.text=stringFormatInt(MAX_LIMIT_NUMS);
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self submit:nil];
        return YES;
    }
    
    if (text.length==0) {
        return YES;
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            _sumlbl.text = [NSString stringWithFormat:@"%d",0];
        }
        return NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数 口口日
    _sumlbl.text = [NSString stringWithFormat:@"%ld",MAX(0,MAX_LIMIT_NUMS - existTextNum)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
