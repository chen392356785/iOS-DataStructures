//
//  InputFaBuBuyViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FabuCuttom.h"
#import "NumberCalculate.h"

@interface InputFaBuBuyViewCell : UITableViewCell

@property (nonatomic, strong) IHTextField *textField;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong)NumberCalculate *numberView;

@property (nonatomic, strong) UIButton *unitBut;
@property (nonatomic, strong) UILabel *DetaiLab;

@property (nonatomic, strong) UISwitch *systemSwitch;
@property (nonatomic, strong) NSArray *emergencyArr;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray *payTypeArr;

@property (nonatomic, strong) FabuCuttom *fabuCuttView;




@property (nonatomic, copy) DidSelectStrBlock inputBlock;
@property (nonatomic, copy) DidSelectBtnBlock SegmentSelbloack;
@end


