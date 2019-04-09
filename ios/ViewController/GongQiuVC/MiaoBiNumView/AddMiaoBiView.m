//
//  AddMiaoBiView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/12.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "AddMiaoBiView.h"

@interface AddMiaoBiView () {
    UIView *MbiView;
    UILabel *_numLab;
    UILabel *_addNumInfoLab;
}
@end

@implementation AddMiaoBiView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
- (void) createView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kWidth(200) + KStatusBarHeight, kWidth(275), kWidth(192))];
    BgView = view;
    view.centerX = self.width/2.;
    view.layer.cornerRadius = kWidth(7);
    view.backgroundColor = kColor(@"#FFFFFF");
    [self addSubview:view];
    
    UIButton *cancelBut = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBut.frame = CGRectMake(view.width - kWidth(25), 2, kWidth(24), kWidth(24));
    [cancelBut setBackgroundImage:kImage(@"Pop_mioabi_guanbi") forState:UIControlStateNormal];
    [cancelBut addTarget:self action:@selector(CancelAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBut];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(31), kWidth(92), kWidth(83))];
    topImageView.image = kImage(@"fabu_success");
    [view addSubview:topImageView];
    topImageView.centerX = view.width/2.;
    [view addSubview:topImageView];
    
    UILabel *fabuTypeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, topImageView.bottom + kWidth(10), view.width, kWidth(16))];
    fabuTypeLab.textColor = kColor(@"#1CD1BB");
    fabuTypeLab.text = @"发布成功";
    fabuTypeLab.font = darkFont(font(16));
    fabuTypeLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:fabuTypeLab];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, fabuTypeLab.bottom + kWidth(3), fabuTypeLab.width, fabuTypeLab.height)];
    lab.textColor = kColor(@"#636363");
    lab.font = darkFont(font(12));
    lab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lab];
    _addNumInfoLab = lab;
    
    
    MbiView = [[UIView alloc] initWithFrame:CGRectMake(0, BgView.top - kWidth(50) , kWidth(60), kWidth(27))];
    MbiView.centerX = BgView.centerX;
    [self addSubview:MbiView];
    MbiView.alpha = 0;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(27), kWidth(27))];
    imageView.image = kImage(@"miaotubi");
    [MbiView addSubview:imageView];
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + kWidth(5), 0, MbiView.width - imageView.right - kWidth(5), imageView.height)];
    [MbiView addSubview:numLab];
    numLab.textColor = kColor(@"#FFBA00");
    numLab.font = darkFont(font(19));
    _numLab = numLab;
}

- (void)setAddNumMiaoBi:(NSString *)numStr {
    _numLab.text = numStr;
    [_numLab sizeToFit];
    MbiView.width = _numLab.right + kWidth(4);
    [UIView animateWithDuration:1 animations:^{
         self->MbiView.alpha = 1;
    } completion:^(BOOL finished) {
        sleep(1);
        [UIView animateWithDuration:1.5 animations:^{
            self->MbiView.alpha = 0;
        }];
    }];
    if ([numStr intValue] < 0) {
        int num = abs([numStr intValue]);
         _addNumInfoLab.text = [NSString stringWithFormat:@"消耗%d个苗途币",num];
    }else {
         _addNumInfoLab.text = [NSString stringWithFormat:@"增加%d个苗途币",[numStr intValue]];;
    }
   
    
}
- (void) CancelAction {
    MbiView.alpha = 0;
    if (self.cancelBack) {
        self.cancelBack();
    }
}
@end
