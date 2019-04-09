//
//  FabuCuttom.m
//  绘制
//
//  Created by Tomorrow on 2019/3/31.
//  Copyright © 2019 Tomorrow. All rights reserved.
//

#import "FabuCuttom.h"

@interface FabuCuttom () {
    UIButton *_leftBut;
    UIButton *_rightBut;
}

@end

@implementation FabuCuttom

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self createSubView];
    }
    return self;
}
- (void) createSubView{
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:5/255.0 green:193/255.0 blue:176/255.0 alpha:1.0].CGColor;
    
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBut.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
    [leftBut setBackgroundImage:[UIImage imageNamed:@"03.png"] forState:UIControlStateNormal];
    leftBut.adjustsImageWhenDisabled = NO;
    [self addSubview:leftBut];
    _leftBut = leftBut;
    leftBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBut addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBut setAdjustsImageWhenHighlighted:NO];
    
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBut.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
    [rightBut setBackgroundImage:[UIImage imageNamed:@"04.png"] forState:UIControlStateNormal];
    rightBut.adjustsImageWhenDisabled = NO;
    [self addSubview:rightBut];
    _rightBut = rightBut;
    [rightBut addTarget:self action:@selector(righttAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBut.adjustsImageWhenDisabled = NO;
    rightBut.titleLabel.font = [UIFont systemFontOfSize:14];
}
- (void) leftAction:(UIButton *)but {
    [_leftBut setBackgroundImage:[UIImage imageNamed:@"fabu_07.png"] forState:UIControlStateNormal];
    [_rightBut setBackgroundImage:[UIImage imageNamed:@"fabu_08.png"] forState:UIControlStateNormal];
    
    [_leftBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectStr = _leftBut.titleLabel.text;
    if (self.selectStrBlock) {
        self.selectStrBlock(self.selectStr);
    }
}
- (void) righttAction:(UIButton *)but {
    [_leftBut setBackgroundImage:[UIImage imageNamed:@"fabu_03.png"] forState:UIControlStateNormal];
    [_rightBut setBackgroundImage:[UIImage imageNamed:@"fabu_04.png"] forState:UIControlStateNormal];
    
    [_leftBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectStr = _rightBut.titleLabel.text;
    if (self.selectStrBlock) {
        self.selectStrBlock(self.selectStr);
    }
    
}
- (void)setLefttStr:(NSString *)lefttStr {
    [_leftBut setTitle:lefttStr forState:UIControlStateNormal];
}
- (void)setRightStr:(NSString *)rightStr {
    [_rightBut setTitle:rightStr forState:UIControlStateNormal];
}
- (void)setIsRightSelect:(BOOL)isRightSelect {
    if (isRightSelect) {
        [_leftBut setBackgroundImage:[UIImage imageNamed:@"fabu_03.png"] forState:UIControlStateNormal];
        [_rightBut setBackgroundImage:[UIImage imageNamed:@"fabu_04.png"] forState:UIControlStateNormal];
        [_leftBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        [_leftBut setBackgroundImage:[UIImage imageNamed:@"fabu_07.png"] forState:UIControlStateNormal];
        [_rightBut setBackgroundImage:[UIImage imageNamed:@"fabu_08.png"] forState:UIControlStateNormal];
        
        [_leftBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

@end
