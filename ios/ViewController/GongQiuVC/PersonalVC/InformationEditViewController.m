//
//  InformationEditViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/24.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "InformationEditViewController.h"
//#import <QuartzCore/QuartzCore.h>
#import "MTEailTextField.h"
@interface InformationEditViewController()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    // IHTextField *_textField;
    PlaceholderTextView *_placeholderTextView;
//    UIBarButtonItem *item1;
    SMLabel *_lbl;
    NSMutableArray *_dataArr;
    UITableView *commTableView;
    MTEailTextField *_textField;
}
@end
@implementation InformationEditViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //  self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _dataArr = [[NSMutableArray alloc] init];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.titl];
    self.view.backgroundColor=RGBA(239,239,244,1);
    
    rightbutton.hidden=NO;
    
    [self setRightButtonImage:Image(@"right.png") forState:UIControlStateNormal];
    
    [self setLeftButtonImage:Image(@"close2.png") forState:UIControlStateNormal];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0,5 , WindowWith-20, 15) textColor:cGrayLightColor textFont:sysFont(15)];
    lbl.text=@"0/30";
    lbl.textAlignment=NSTextAlignmentRight;
    lbl.hidden=YES;
    _lbl=lbl;
    [self.view addSubview:lbl];
    
    _placeholderTextView=[[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 30, WindowWith, 40)];
    _placeholderTextView.text=self.text;
    //    _placeholderTextView.placeholder= self.text;
    if ([_placeholderTextView.text isEqualToString:@"尚未填写"] ||[_placeholderTextView.text isEqualToString:@"选填"] ||[_placeholderTextView.text isEqualToString:@"必填"]) {
        _placeholderTextView.text=@"";
    }
    _placeholderTextView.backgroundColor=[UIColor whiteColor];
    _placeholderTextView.font=sysFont(16);
    _placeholderTextView.delegate=self;
    [_placeholderTextView setPlaceholderColor:cGrayLightColor];
    [_placeholderTextView becomeFirstResponder];
    if (self.isLongString) {
        _placeholderTextView.size=CGSizeMake(WindowWith, 100);
    }
    
    if (self.type==SelectPhoneBlock) {
        _placeholderTextView.keyboardType=UIKeyboardTypeNumberPad;
    }else if (self.type==SelectLandBlock){
        _placeholderTextView.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    }
    if (self.type==SelectPositionIntroductionBlock) {
        _placeholderTextView.placeholder=@"填写岗位职位及工作内容";
    }
    
    [self.view addSubview:_placeholderTextView];
    
    if (self.type==SelectCompanyNameBlock) {
        UIImage *photoimg=Image(@"redstar.png");
        UIImageView *photoImgView=[[UIImageView alloc]initWithImage:photoimg];
        photoImgView.frame=CGRectMake(20,_placeholderTextView.bottom+20, photoimg.size.width, photoimg.size.height);
        [self.view addSubview:photoImgView];
        
        _lbl.hidden=NO;
        
        CGSize size=[IHUtility GetSizeByText:@"公司全称是您所在公司的营业执照或组织机构代码证上的公司名称，请确保您的填写完全匹配，如果填写了分支机构的名称将视为新的企业。" sizeOfFont:14 width:WindowWith-photoImgView.right-15-15];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(photoImgView.right+15, photoImgView.top, size.width, size.height) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.numberOfLines=0;
        
        lbl.text=@"公司全称是您所在公司的营业执照或组织机构代码证上的公司名称，请确保您的填写完全匹配，如果填写了分支机构的名称将视为新的企业。";
        [self.view addSubview:lbl];
        
        UIImage *img=Image(@"EP_zhizhao.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, lbl.bottom+15, img.size.width, img.size.height)];
        imageView.centerX=self.view.centerX;
        imageView.image=img;
        [self.view addSubview:imageView];
        _placeholderTextView.placeholder=@"请输入公司全称";
        
        _placeholderTextView.placeholderLbl.centerY =  _placeholderTextView.height/2.0;
        if (![_placeholderTextView.text isEqualToString:@""]) {
            _placeholderTextView.placeholder=@"";
        }
    }
    
    commTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _placeholderTextView.bottom, WindowWith, WindowHeight - _placeholderTextView.bottom) style:UITableViewStylePlain];
    
    commTableView.dataSource=self;
    commTableView.delegate=self;
    //    [commTableView setupData:_dataArr index:38];
    commTableView.backgroundColor = cLineColor;
    commTableView.backgroundView = nil;
    commTableView.hidden = YES;
    [self setExtraCellLineHidden:commTableView];
    [self.view addSubview:commTableView];
    
    
    if (self.type==SelectEmailBlock) {
        _placeholderTextView.hidden=YES;
        _textField=[[MTEailTextField alloc]initWithFrame:_placeholderTextView.frame fontSize:16];
        _textField.placeholder = @"输入邮箱地址";
        _textField.text=self.text;
        _textField.mailTypeArray = [NSMutableArray arrayWithObjects:@"@qq.com",@"@163.com",@"@126.com",@"@yahoo.com",@"@139.com",@"@henu.com", nil];
        _textField.backgroundColor=[UIColor whiteColor];
        //_textField.mailMatchColor = [UIColor redColor];
        _textField.didPressedReturnCompletion = ^(UITextField * textField){
            NSLog(@"textFieldText%@",textField);
        };
        [self.view addSubview:_textField];
        
    }
}

- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    //    [view release];
}
-(void)home:(id)sender
{
    //    SelectNameBlock
    
    if (self.type==SelectNameBlock) {
        
        if (_placeholderTextView.text.length <= 0) {
            [self addSucessView:@"请输入真实名字" type:2];
            return;
        }
        
        if (_placeholderTextView.text.length > 4) {
            [self addSucessView:@"名字不能超过4个字" type:2];
            return;
        }

        if (![self isChinese:_placeholderTextView.text]) {
            [self addSucessView:@"输入名字只能是汉字" type:2];
            return;
        }
    }
    
    if(self.type==SelectPhoneBlock){
        if (![IHUtility checkPhoneValidate:_placeholderTextView.text]) {
            return;
        }
        
    }
//    else
//    {
//        if (_placeholderTextView.text.length==0) {
//            return;
//        }
//    }
    if (self.type==SelectCompanyBlock) {
        if ([self verifiTest:_placeholderTextView.text]) {
            [self addSucessView:@"请输入汉字" type:2];
            return;
        }
    }
    
    if (self.type==SelectEmailBlock) {
        if (![IHUtility validateEmail:_textField.text]) {
            [self addSucessView:@"请输入正确的邮箱" type:2];
            return;
        }
    }
    
    
    if (self.type==SelectCompanyWebBlock) {
        if (![IHUtility validateWeb:_placeholderTextView.text]) {
            [self addSucessView:@"请输入正确的网址" type:2];
            return;
        }
    }
    
    if (self.type==SelectPositionNameBlock) {
        if (_placeholderTextView.text.length==0) {
            return;
        }
    }
    
    if (self.type==SelectEmailBlock){
        [self.delegate displayTiyle:_textField.text type:self.type];
    }else{
        [self.delegate displayTiyle:_placeholderTextView.text type:self.type];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.type==SelectCompanyNameBlock)
    {
        if (_placeholderTextView.text.length > 0) {
            commTableView.hidden = NO;
            [self searchCompanyName:_placeholderTextView.text];
        }else {
            commTableView.hidden = YES;
        }
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    if(![self isEmpty:_placeholderTextView.text])
    {
        self.navigationItem.rightBarButtonItem.enabled=YES;
    }else
    {
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }
    
    if (self.type==SelectNameBlock) {
        if (_placeholderTextView.text.length>12) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:12];
        }
    }
    
    if (self.type==SelectCompanyAbbreviationNameBlock) {
        if (_placeholderTextView.text.length>12) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:12];
        }
    }
    
    if (self.type==SelectLandBlock) {
        if (_placeholderTextView.text.length>12) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:12];
        }
    }
    
    if (self.type==SelectCompanyBlock) {
        if (_placeholderTextView.text.length>20) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:20];
        }
    }
    
    if (self.type==SelectaBbreviationBlock ||self.type==SelectPositionNameBlock) {
        if (_placeholderTextView.text.length>12) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:12];
        }
        
    }
    if (self.type==SelectDepartmentBlock) {
        if (_placeholderTextView.text.length>14) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:14];
        }
        
    }
    
    if (self.type==SelectZhuyingBlock) {
        if (_placeholderTextView.text.length>50) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:50];
        }
    }
    
    if (self.type==SelectCompanyIntroduceBlock||self.type==SelectPositionIntroductionBlock) {
        if (_placeholderTextView.text.length>500) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:500];
        }
    }
    
    
    if (self.type==SelectCompanyNameBlock) {
        
        if (_placeholderTextView.text.length>30) {
            _placeholderTextView.text=[_placeholderTextView.text substringToIndex:30];
            
        }else{
            _lbl.text=[NSString stringWithFormat:@"%ld/30",(unsigned long)textView.text.length];
        }
        
        
        if (_placeholderTextView.text.length > 0) {
            commTableView.hidden = NO;
            [self searchCompanyName:_placeholderTextView.text];
        }else {
            commTableView.hidden = YES;
        }
    }
    
}
- (void)searchCompanyName:(NSString *)text
{
    
    [network searchCompanyList:text success:^(NSDictionary *obj) {
        NSArray *Arr = obj[@"content"];
        [self->_dataArr removeAllObjects];
        
        [self->_dataArr addObjectsFromArray:Arr];
        [self->commTableView reloadData];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@" "]) {
        return NO;
    }
    
    return YES;
}


-(BOOL)isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
//公司汉字验证
-(BOOL)verifiTest:(NSString *)str
{
    
    NSString *match = @"(^[u4e00-u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}
//判断字符串是否为纯汉字，汉字所占字节数为3 只要判断字符串中是否有字节数不为3的
-( BOOL )isChinese:( NSString *)c{
    
    for (int i=0;i<c.length;i++){
        
        NSRange range=NSMakeRange(i,1);
        NSString *subString=[c substringWithRange:range];
        const char *cString=[subString UTF8String];
        
        if (strlen(cString)!=3){
            
            return NO;
        }
    }
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identify=@"TableViewCell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor = cLineColor;
    }
    
    EPCloudCompanyModel *model=_dataArr[indexPath.row];
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSString *str=[NSString stringWithFormat:@"%@%@",@"<meta charset=\"UTF-8\" >",model.company_name_html];//:@"%@%@",@"<meta charset=\"UTF-8\">",model.content];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                                    options:options documentAttributes:nil error:nil];
    cell.textLabel.attributedText = attrString;
    cell.textLabel.font = sysFont(16);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_placeholderTextView resignFirstResponder];
    EPCloudCompanyModel *model = _dataArr[indexPath.row];
    _placeholderTextView.text= model.company_name;
    _lbl.text=[NSString stringWithFormat:@"%ld/30",(unsigned long)_placeholderTextView.text.length];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_placeholderTextView resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // [_placeholderTextView resignFirstResponder];
}
@end
