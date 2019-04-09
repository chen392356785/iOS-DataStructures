//
//  DFShitViewController.m
//  DF
//
//  Created by Tata on 2017/12/5.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFShitViewController.h"

#define MAXTEXTNUMBER   300
@interface DFShitViewController ()<UITextViewDelegate>
/**提交按钮*/
@property (nonatomic,weak) UIButton *rightButton;
/**背景scrollview*/
@property (nonatomic,weak) UIScrollView *bgScrollView;
/**文本输入框*/
@property (nonatomic,weak) UITextView *textView;
/**标记输入文字数量*/
@property (nonatomic,weak) UILabel *numLab;

@end

@implementation DFShitViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
//    [self createView];
//    [self setUpNav];
    
}
/*
#pragma mark --设置导航栏--
- (void)setUpNav
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, DFStatusHeight, 40, 40);
    [backButton setImage:kImage(BackArrowGreen) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWidth - 200)/2, DFStatusHeight, 200, 40)];
    titleLabel.text = DFShitString();
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:PingFangLightFont() size:18 * TTUIScale()];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, DFNavigationBar - 0.5, kWidth, 0.5)];
    lineView.backgroundColor = THLineColor;
    [self.view addSubview:lineView];
    //提交按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton = rightButton;
    rightButton.frame = CGRectMake(kWidth - 60, DFStatusHeight, 50, 40);
    rightButton.titleLabel.font= [UIFont fontWithName:PingFangLightFont() size:16 * TTUIScale()];
    [rightButton setTitle:DFSubmitString() forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton setTitleColor:THBtnBackgroundColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(gotoShit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
}

#pragma mark --创建子视图--
-(void)createView
{
    UIScrollView *bgScrollView = [[UIScrollView alloc] init];
    CGFloat bgScrollViewX = 0;
    CGFloat bgScrollViewY = 0;
    CGFloat bgScrollViewW = kWidth;
    CGFloat bgScrollViewH = kHeight;
    bgScrollView.frame = CGRectMake(bgScrollViewX, bgScrollViewY, bgScrollViewW, bgScrollViewH);
    [self.view addSubview:bgScrollView];
    
    //输入背景框
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(16, DFNavigationBar+20, kWidth-32,(kHeight-DFNavigationBar-40)/2)];
    view.layer.borderColor=THBaseLightGray.CGColor;
    view.layer.borderWidth=0.5;
    [bgScrollView addSubview:view];
    //文本输入框
    UITextView *textView = [[UITextView alloc] init];
    self.textView = textView;
    CGFloat textViewX = 0;
    CGFloat textViewY = 0;
    CGFloat textViewW = view.width - 30;
    CGFloat textViewH = view.height;
    textView.frame = CGRectMake(textViewX, textViewY, textViewW, textViewH);
    [textView addPlaceHolder:DFShitPlaceholderString()];
    textView.delegate = self;
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = kLightFont(14);
    [view addSubview:textView];
    
    //输入文字数量
    UILabel *numLab = [[UILabel alloc] init];
    self.numLab = numLab;
    CGFloat numLabX = view.width - 40;
    CGFloat numLabY = view.height - 23;
    CGFloat numLabW = 40;
    CGFloat numLabH = 20;
    numLab.frame = CGRectMake(numLabX, numLabY, numLabW, numLabH);
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.font = kLightFont(14);
    numLab.text = [NSString stringWithFormat:@"%d",MAXTEXTNUMBER];
    numLab.textColor = THBaseGray;
    numLab.backgroundColor = [UIColor clearColor];
    [view addSubview:numLab];
    
}
#pragma mark TextViewDeleagte
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.placeHolderTextView.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text && [textView.text isEqualToString:@""])
    {
        textView.placeHolderTextView.hidden = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger textLength = [textView getInputLengthWithText:textView.text]/2;
    if (textLength > MAXTEXTNUMBER)
    {
        if ([textView.text isEqualToString:@""])
        {
            return ;
        }
        [DFTool showTips:DFShitNumLimitString()];
        _textView.text=[_textView.text substringWithRange:NSMakeRange(0, MAXTEXTNUMBER)];
        return;
    }
    self.numLab.text=[NSString stringWithFormat:@"%ld",MAXTEXTNUMBER-textLength];
    [self.rightButton setTitleColor:THBaseColor forState:UIControlStateNormal];
    self.rightButton.userInteractionEnabled = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [touches.anyObject locationInView:self.view];
    if (!CGRectContainsPoint(_textView.frame, touchLoc))
    {
        [_textView resignFirstResponder];
    }
}


#pragma mark --去吐槽--
- (void)gotoShit {
    
    [self.view endEditing:YES];
    
    [DFTool addWaitingView:self.view];
    [HttpRequest postShitWith:@"1" feedContent:_textView.text success:^(NSDictionary *result) {
        [DFTool removeWaitingView:self.view];
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            [DFTool showTips:result[DFErrMsg]];
        }
        [self backAction];
        
    } failure:^(NSError *error) {
        
        [DFTool removeWaitingView:self.view];
        
    }];
}

- (void)backAction {
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
