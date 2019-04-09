//
//  InputFaBuBuyViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "InputFaBuBuyViewCell.h"


@implementation InputFaBuBuyViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createText];
        //  添加输入完成会回调通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanging:) name:UITextFieldTextDidChangeNotification object:self.textField];
        [self crateNumCalcuLate];
        [self addSwitchView];
        [self createFabuCuttView];
        
    }
    return self;
}

- (void) createText{
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(13), kWidth(15), iPhoneWidth/2 - kWidth(13), kWidth(19))];
	_titleLabel.font = sysFont(font(14));
	[self.contentView addSubview:_titleLabel];
	_textField = [[IHTextField alloc] initWithFrame:CGRectMake(_titleLabel.right, 0, _titleLabel.width, _titleLabel.height)];
	[self.contentView addSubview:_textField];
	_textField.textAlignment = NSTextAlignmentRight;
	_textField.centerY = _titleLabel.centerY;
	UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(46), iPhoneWidth, 1)];
	line.backgroundColor = cLineColor;
	[self.contentView addSubview:line];
	self.lineLabel = line;
	_textField.font = sysFont(font(15));
}


- (void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
    NSString * firstStr = [titleStr substringToIndex:1];
    if ([firstStr isEqualToString:@"*"]) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#FF1010") range:NSMakeRange(0, 1)];
        _titleLabel.attributedText = attributedStr;
    }else{
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#FF1010") range:NSMakeRange(0, 0)];
        _titleLabel.attributedText = attributedStr;
    }
    [_titleLabel sizeToFit];
    _textField.size = CGSizeMake(iPhoneWidth - _titleLabel.width - kWidth(40), _textField.height);
    _textField.origin = CGPointMake(_titleLabel.right + kWidth(5), _titleLabel.top);
    
}

-(void)textFieldChanging:(id)sender{
    if (self.inputBlock) {
        self.inputBlock(self.textField.text);
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void) crateNumCalcuLate{
    NumberCalculate *number=[[NumberCalculate alloc]initWithFrame:CGRectMake(kWidth(86), 0, kWidth(110), kWidth(27))];
    number.baseNum=@"1";
    number.multipleNum=1;//数值增减基数（倍数增减） 默认1的倍数增减
    number.minNum=1;
    number.maxNum = 99999;//最大值
    number.hidden = YES;
    [self addSubview:number];
    number.centerY = _textField.centerY;
    _numberView = number;
    number.numborderColor = kColor(@"#05C1B0");
    number.buttonColor = kColor(@"#05C1B0");
    number.buttonTextColor = kColor(@"#FFFFFF");
    
    
    _unitBut = [UIButton buttonWithType:UIButtonTypeSystem];
    _unitBut.frame = CGRectMake(iPhoneWidth - kWidth(20) - kWidth(56), 0,kWidth(56), 27);
    _unitBut.titleLabel.font = sysFont(font(14));
    _unitBut.centerY = _textField.centerY;
    _unitBut.layer.borderColor = kColor(@"#05C1B0").CGColor;
    _unitBut.hidden = YES;
    _unitBut.layer.borderWidth = 1;
    _unitBut.titleLabel.font = sysFont(13);
    [_unitBut setTitleColor:kColor(@"#252525") forState:UIControlStateNormal];
    [self.contentView addSubview:_unitBut];
    
    UIImageView *selectImageView = [[UIImageView alloc] init];
    selectImageView.image = [UIImage imageNamed:@"specification_bottom"];
    [_unitBut addSubview:selectImageView];
    selectImageView.frame = CGRectMake(_unitBut.width - 13,_unitBut.height - 12, 13.0f,12.0f);
    
    
    
    _DetaiLab = [[UILabel alloc] initWithFrame:CGRectMake(_unitBut.left - 90, 0,kWidth(80), kWidth(27))];
    _DetaiLab.font = sysFont(font(14));
    _DetaiLab.textColor = kColor(@"#828282");
    _DetaiLab.centerY = _textField.centerY;
    _DetaiLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_DetaiLab];
    _DetaiLab.hidden = YES;

}
- (void) addSwitchView {
    
    UISwitch *systemSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(iPhoneWidth - kWidth(20) - kWidth(46), 0, kWidth(46), kWidth(22))];
    systemSwitch.hidden = YES;
    systemSwitch.centerY = _titleLabel.centerY;
    self.systemSwitch = systemSwitch;
    [self.contentView addSubview:systemSwitch];
    systemSwitch.on = YES;
    systemSwitch.onTintColor = kColor(@"#05C1B0");
    systemSwitch.tintColor = kColor(@"#DCDCDC");
    [systemSwitch addTarget:self action:@selector(systemSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [systemSwitch setBackgroundColor:kColor(@"#DCDCDC")];
    systemSwitch.layer.cornerRadius = systemSwitch.height/2.;
    systemSwitch.layer.masksToBounds = YES;
}

/** UISwitch valuedChanged */
- (void)systemSwitchValueChanged:(UISwitch *)sender {
    if (sender.isOn) {
        if (self.inputBlock) {
            self.inputBlock(@"有");
        }
    }else{
        if (self.inputBlock) {
            self.inputBlock(@"无");
        }
    }
    NSLog(@"UISwitch状态：%@", sender.isOn ? @"开启" : @"关闭");
}
- (void) setEmergencyArr:(NSArray *)emergencyArr {
    if (self.segmentedControl != nil) {
        return;
    }
    UISegmentedControl *segmentedControl = [self retureSegment:emergencyArr];
    self.segmentedControl = segmentedControl;
    segmentedControl.frame = CGRectMake(iPhoneWidth - kWidth(20) - kWidth(61)*emergencyArr.count, 0, kWidth(61)*emergencyArr.count, kWidth(26));
    segmentedControl.centerY = _titleLabel.centerY;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
}




-(void)change:(UISegmentedControl*)seg{
    if (self.SegmentSelbloack) {
        self.SegmentSelbloack(seg.selectedSegmentIndex);
    }
    switch (seg.selectedSegmentIndex) {
        case 0:
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
}

- (UISegmentedControl*) retureSegment:(NSArray *)arr {
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:arr];
    self.segmentedControl = segmentedControl;
    segmentedControl.centerY = _titleLabel.centerY;
    segmentedControl.frame = CGRectMake(iPhoneWidth - kWidth(20) - kWidth(61)*arr.count, 0, kWidth(61)*arr.count, kWidth(26));
    segmentedControl.tintColor = kColor(@"#05C1B0");
    [self.contentView addSubview:segmentedControl];
    segmentedControl.layer.cornerRadius = 0;
    NSDictionary *dic = @{
                          //1.设置字体样式:例如黑体,和字体大小
                          NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:12],
                          //2.字体颜色
                          NSForegroundColorAttributeName:kColor(@"#5E5E5E")
                          };
    [segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
//    segmentedControl.apportionsSegmentWidthsByContent = YES;
    return segmentedControl;
}

//付款方式
- (void)setPayTypeArr:(NSArray *)payTypeArr {
    if (self.segmentedControl != nil) {
        return;
    }
    UISegmentedControl *segmentedControl = [self retureSegment:payTypeArr];
    segmentedControl.centerY = _titleLabel.centerY;
    segmentedControl.selectedSegmentIndex = 0;
}



- (void) createFabuCuttView{
    self.fabuCuttView = [[FabuCuttom alloc] initWithFrame:CGRectMake(iPhoneWidth - kWidth(20) - kWidth(138), 0, kWidth(138), kWidth(26))];
    self.fabuCuttView.centerY = _titleLabel.centerY;
    self.fabuCuttView.hidden = YES;
    [self addSubview:self.fabuCuttView];
    WS(weakSelf);
    self.fabuCuttView.selectStrBlock = ^(NSString *str1) {
        weakSelf.inputBlock(str1);
    };
}
@end
