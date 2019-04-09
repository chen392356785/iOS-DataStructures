//
//  LaunchPageView.m
//  MiaoTuProject
//
//  Created by Zmh on 3/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "LaunchPageView.h"
#import "MHDrawCircleButton.h"
#define zoomSize (kScreenHeight/667.0)
@implementation LaunchPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame images:(NSArray *)images
{
    
    self= [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _images = images;
        
        NSDictionary *UserDefaultDic = [IHUtility getUserDefalutDic:kUserDefalutInit];
        NSDictionary *imgDic = UserDefaultDic[@"startupImage"];
        NSString *imgUrl = imgDic[@"activities_pic"];
        
        UIImageView *topImageV = [[UIImageView alloc] init];
        topImageV.frame = self.bounds;
        [topImageV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:Image(@"Bar.png")];
        topImageV.hidden = YES;
        _topImageView = topImageV;
//        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.contentMode =  UIViewContentModeScaleToFill;
        topImageV.userInteractionEnabled = YES;
        [self addSubview:topImageV];
        
        UITapGestureRecognizer *tapImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageDetail:)];
        tapImg.numberOfTapsRequired=1;
        tapImg.numberOfTouchesRequired=1;
        [topImageV addGestureRecognizer:tapImg];
        
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",images[0]]];
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [titleImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:Image(@"Bar.png")];
        titleImageView.center = self.center;
    
        _titleImageView = titleImageView;
        [self performSelector:@selector(moveCoordinate) withObject:nil afterDelay:0.0];
        [self addSubview:titleImageView];
        
    }
    
    return self;
}

- (void)moveCoordinate
{
    NSDictionary *UserDefaultDic = [IHUtility getUserDefalutDic:kUserDefalutInit];
    NSDictionary *imgDic = UserDefaultDic[@"startupImage"];
    NSString *imgUrl = imgDic[@"activities_pic"];
    NSInteger DelayTime = 1;
    if ([imgDic[@"model"] integerValue] == 0) {
        DelayTime = 1;
    }else {
        DelayTime = 5;
    }
    
    if (imgUrl.length >0) {
            [UIView animateWithDuration:0.0 animations:^{
//                _titleImageView.bottom = kScreenHeight-69*zoomSize;
//                _titleImageView.alpha=0;

            } completion:^(BOOL finished) {

                
       #ifdef APP_MiaoTu
                self->_titleImageView.hidden=YES;
                self->_topImageView.hidden = NO;
//                _topImageView.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                   self->_topImageView.alpha = 1;
                    MHDrawCircleButton *circleBtn = [[MHDrawCircleButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 55, 30, 40, 40)];
                    circleBtn.lineWidth = 2;
                    circleBtn.progressColor = cGreenColor;
                    [circleBtn setTitle:@"跳过" forState:UIControlStateNormal];
                    [circleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    circleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [circleBtn addTarget:self action:@selector(removeSelfView) forControlEvents:UIControlEventTouchUpInside];
                    
                    [circleBtn startAnimationDuration:DelayTime withBlock:^{
                        
                        if (!self.isClickPass) {
                            [self removeSelfView];
                            
                        }
                    }];
                    
                    [self addSubview:circleBtn];
                    
                }];
                
                [self performSelector:@selector(removeSelfView) withObject:nil afterDelay:DelayTime];
      #elif defined APP_YiLiang
              [self removeSelfView];
                
     #endif                
               
            }];
    }else {
        [UIView animateWithDuration:1.0 animations:^{
            self->_titleImageView.bottom = kScreenHeight-69*zoomSize;
            self->_titleImageView.alpha=0;
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
             [self removeFromSuperview];
        }];
    }
}

- (void)tapImageDetail:(UITapGestureRecognizer *)tap
{
    self.selectBtnBlock(SelectBtnBlock);
    [self removeSelfView];
}
- (void)removeSelfView
{   self.clickPass = YES;
    self.transform = CGAffineTransformMakeScale(1, 1);
    self.alpha = 1;
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha = 0.05;
        self.transform = CGAffineTransformMakeScale(5, 5);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.1];
        
         [[NSNotificationCenter defaultCenter]postNotificationName:KPopHomeView object:nil];
    }];

}
@end
