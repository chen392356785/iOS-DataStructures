//
//  MTHomePopView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTHomePopView.h"

@interface MTHomePopView () {
    UIImageView *imageView;
    UILabel *lineLabel;
    
    UIButton *cancelBut;
}
@end

@implementation MTHomePopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = kWidth(7);
        [self addlayoutSubView];
    }
    return self;
}
- (void) addlayoutSubView {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, kWidth(333))];
    [self addSubview:imageView];
    
    cancelBut = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBut.frame = CGRectMake(self.width - kWidth(28), 0, kWidth(28), kWidth(26));
    [cancelBut setBackgroundImage:kImage(@"guanbi") forState:UIControlStateNormal];
    [cancelBut addTarget:self action:@selector(CancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBut];
    
    lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom, self.width, 1)];
    lineLabel.backgroundColor = kColor(@"#eeeeee");
    [self addSubview:lineLabel];
}
- (void)setMiaoTuHomePopViewModel:(MTHomePopModel *)Model {
    NSURL *headUrl = [NSURL URLWithString:Model.advPic];
    [imageView sd_setImageWithURL:headUrl placeholderImage:kImage(@"Garden-bj")];
    
    
    if (Model.advButtonList.count == 1) {
        advButtonModel *ButtonModel = Model.advButtonList[0];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kWidth(32), lineLabel.bottom + kWidth(7) , self.width - kWidth(64), kWidth(30));
        [button setTitleColor:[IHUtility colorWithRGBString:ButtonModel.buttonColor alph:1] forState:UIControlStateNormal];
//        button.backgroundColor = [IHUtility colorWithRGBString:ButtonModel.buttonColor alph:1];
        [button setTitle:ButtonModel.buttonName forState:UIControlStateNormal];
        button.tag = 100;
        [button addTarget:self action:@selector(SelectionButtonTag:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = button.height/2.;
        [self addSubview:button];
    }else {
        for (int i = 0; i < Model.advButtonList.count ; i ++) {
            advButtonModel *ButtonModel = Model.advButtonList[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(i * self.width/2., lineLabel.bottom +1 , self.width/2., kWidth(45));
//            [button setTitleColor:kColor(@"#fefefe") forState:UIControlStateNormal];
            [button setTitleColor:[IHUtility colorWithRGBString:ButtonModel.buttonColor alph:1] forState:UIControlStateNormal];
//            button.backgroundColor = [IHUtility colorWithRGBString:ButtonModel.buttonColor alph:1];
            [button setTitle:ButtonModel.buttonName forState:UIControlStateNormal];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(SelectionButtonTag:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
}
- (void) CancelAction {
    if (self.CancelBlock) {
        self.CancelBlock();
    }
}
- (void) SelectionButtonTag:(UIButton *)but {
    if (self.SelettBut) {
        self.SelettBut(but.tag);
    }
}
@end
