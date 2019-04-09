//
//  EPCloudFeedbackViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 13/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory2.h"
#import "EPCloudFeedbackViewController.h"

@interface EPCloudFeedbackViewController ()<UITextViewDelegate>
{
    NSMutableArray *strArr;
    UITextView *_textview;
}
@end

@implementation EPCloudFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"用户反馈"];
    
    [self initViews];
}
- (void)initViews
{
    __weak EPCloudFeedbackViewController *weakSelf = self;
    strArr = [NSMutableArray array];
    self.view.backgroundColor = cLineColor;
    NSString *str = @"     我们在采集录入企业时，可能会因为人工错误误导致信息的偏差，欢迎你为我们反馈和指正这些不实信息，我们真诚的对您表示感谢。";
    CGSize size = [IHUtility GetSizeByText:str sizeOfFont:14 width:WindowWith-60];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(30, 30, WindowWith-60, size.height) textColor:cBlackColor textFont:sysFont(14)];
    label.text= str;
    label.numberOfLines =0 ;
    [backView addSubview:label];
    
    NSArray *titleArr = @[@"描述信息不正确",@"联系方式不正确",@"企业已经更名",@"企业已注销"];
    
    for (int i=0; i<titleArr.count; i++) {
        
        UIImage *img = Image(@"anonymous.png");
        UIImage *selectImg = Image(@"anonymous_selected.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(30+ ((WindowWith- 70)/2.0 + 10)*(i%2) , label.bottom + 25 + 40 *(i/2), (WindowWith- 70)/2.0, 25);
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = sysFont(13);
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
        btn.imageEdgeInsets=UIEdgeInsetsMake(0, 3, 0, 0);
        [btn setTitleColor:RGBA(135, 134, 140, 1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(feedBackAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
    }
    
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(30, label.bottom + (titleArr.count-1)/2*40 + 80 , WindowWith-60, 125)];
    textview.layer.borderColor = cLineColor.CGColor;
    textview.layer.borderWidth = 1.0;
    textview.text = @"请写下反馈详情";
    textview.delegate = self;
    textview.textColor = cGrayLightColor;
    _textview = textview;
    [backView addSubview:textview];
    
    
    SMLabel *phoneLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, textview.bottom + 30, 200, 17) textColor:cGrayLightColor textFont:sysFont(14)];
    phoneLbl.text = [NSString stringWithFormat: @"客服热线：%@",KTelNum];
    phoneLbl.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributStr = [IHUtility changePartTextColor:phoneLbl.text range:NSMakeRange(5, phoneLbl.text.length - 5) value:RGBA(6, 193, 174, 1)];
    phoneLbl.attributedText = attributStr;
    [backView addSubview:phoneLbl];
    phoneLbl.centerX = backView.width /2.0;
    backView.height = phoneLbl.bottom + 30;
    
    
    NSArray *titlArr = @[@"提交反馈"];
    NSArray *imageArr = @[@""];
    EPCloudListBottonView *bottomView = [[EPCloudListBottonView alloc] initWithFrame:CGRectMake(0, WindowHeight-49, WindowWith, 49) btnTitle:titlArr images:imageArr];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.selectBlock = ^(NSInteger index){
        //反馈
        NSLog(@"++++%@",self->strArr);
        [weakSelf addFeedBack];

    };
    [self.view addSubview:bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)feedBackAction:(UIButton *)button
{
    [_textview resignFirstResponder];
    button.selected = !button.selected;
    if (button.selected) {
        if (![strArr containsObject:button.titleLabel.text]) {
            [strArr addObject:button.titleLabel.text];
        }
        [button setTintColor:[UIColor clearColor]];
        [button setTitleColor:cBlackColor forState:UIControlStateSelected];
    }else {
        if ([strArr containsObject:button.titleLabel.text]) {
            [strArr removeObject:button.titleLabel.text];
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{

    if ([textView.text isEqualToString:@"请写下反馈详情"]) {
        textView.text = nil;
    }
    textView.textColor = cBlackColor;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请写下反馈详情";
        textView.textColor = cGrayLightColor;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textview resignFirstResponder];
    
}

- (void)addFeedBack
{
    if ([_textview.text isEqualToString:@""]||[_textview.text isEqualToString:@"请写下反馈详情"]) {
        if (strArr.count ==0) {
            [self addSucessView:@"请填写反馈信息" type:2];
            return;
        }
    }
    [self addWaitingView];
    
    NSString *str = @"";
    if (strArr.count > 0) {
        for (NSString *string in strArr) {
            str= [NSString stringWithFormat:@"%@%@",str,string];
        }
    }
    
    if (![_textview.text isEqualToString:@""]&&![_textview.text isEqualToString:@"请写下反馈详情"])
    {
        str = [NSString stringWithFormat:@"%@%@",str,_textview.text];
    }
    
    [network addCompanyFeedBack:USERMODEL.userID companyId:(int)self.model.company_id content:str success:^(NSDictionary *obj) {
        [self removeWaitingView];
        
        [self addSucessView:@"反馈成功" type:1];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
