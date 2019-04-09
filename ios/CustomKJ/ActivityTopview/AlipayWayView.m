//
//  AlipayWayView.m
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "AlipayWayView.h"

@implementation AlipayWayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, (self.height - 24)/2.0, 24, 24)];
        _titleImage = imageView;
        [self addSubview:imageView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 19, (self.height - 21)/2.0, 75, 21)];
        nameLabel.textColor = RGB(108, 123, 138);
        nameLabel.font = sysFont(15);
        _wayName = nameLabel;
        [self addSubview:nameLabel];
        
        UIButton *selectedBtu = [[UIButton alloc] initWithFrame:CGRectMake(0, (self.height - 20)/2.0, 20, 20)];
        selectedBtu.right = self.width - 18;
        [selectedBtu setImage:[UIImage imageNamed:@"alipay_right.png"] forState:UIControlStateNormal];
        [selectedBtu setImage:[UIImage imageNamed:@"alipay_rightSelected.png"] forState:UIControlStateSelected];
        _selectedBtu = selectedBtu;
        [self addSubview:selectedBtu];
        
    }
    
    return self;
}

-(void)setDataImage:(NSString *)imageName name:(NSString *)name
{
    _titleImage.image = [UIImage imageNamed:imageName];
    _wayName.text = name;
    
}


@end
