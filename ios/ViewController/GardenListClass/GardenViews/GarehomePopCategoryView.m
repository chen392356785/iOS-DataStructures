//
//  GarehomePopCategoryView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/10.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "GarehomePopCategoryView.h"
#import "GardenModel.h"

@implementation GarehomePopCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
- (void) createView {
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction:)];
    // 允许用户交互
    [self addGestureRecognizer:tapGes];
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(kWidth(9), 140, iPhoneWidth - kWidth(18), kWidth(102))];
    BgView = view;
    [self addSubview:view];
}
- (void)setGardenCategoryArr:(NSArray *)arr andPointY:(NSInteger)pointY {
    BgView.backgroundColor = kColor(@"#FFFFFF");
    BgView.origin = CGPointMake(kWidth(9), pointY);
    BgView.layer.cornerRadius = kWidth(6);
    
   NSArray *modeArr = arr[0];
    if (modeArr.count <= 0) {
        return;}
    CGFloat lastMaxX = kWidth(20);
    CGFloat lastMaxY = kWidth(20);
    for (int i = 0; i <modeArr.count; i ++) {
        biaoqianModel *model = modeArr[i];
        UILabel *lab = [[UILabel alloc] init];
        lab.text = model.cateName;
        lab.font = darkFont(font(16));
        lab.textColor = kColor(@"#4A4A4A");
        [lab sizeToFit];
        
        if (lastMaxX + lab.size.width > BgView.width) {
            lastMaxX = kWidth(20);
            lastMaxY = lastMaxY + kWidth(10) + kWidth(22);
        }
        lab.frame = CGRectMake(lastMaxX, lastMaxY, lab.width + kWidth(10), kWidth(22));
        [BgView addSubview:lab];
        lab.tag = i + 100;
        UITapGestureRecognizer *labGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectButAction:)];
        // 允许用户交互
        lab.userInteractionEnabled = YES;
        [lab addGestureRecognizer:labGes];
        lastMaxX = lab.right + kWidth(30);

    }
    if (lastMaxY > BgView.height) {
        BgView.size = CGSizeMake(BgView.width, lastMaxY + kWidth(40));
    }
    if (BgView.bottom > iPhoneHeight) {
        BgView.size = CGSizeMake(BgView.width, iPhoneHeight - KTabSpace - pointY - kWidth(10));
        BgView.contentSize = CGSizeMake(0, lastMaxY + kWidth(40));
    }
}

-(void)selectButAction:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UILabel *titleLab = (UILabel*)tap.view;
    NSInteger tag = titleLab.tag - 100;
    if (self.SelectIndexBack) {
        self.SelectIndexBack(tag);
    }
}
-(void)cancelAction:(UITapGestureRecognizer *)sender{
    if (self.cancelBack) {
        self.cancelBack();
    }
}
@end
