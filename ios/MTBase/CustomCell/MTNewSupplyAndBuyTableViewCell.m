//
//  MTNewSupplyAndBuyTableViewCell.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNewSupplyAndBuyTableViewCell.h"

@implementation MTNewSupplyAndBuyTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        
        MTNewSupplyAndBuyView *SBView=[[MTNewSupplyAndBuyView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 460)];
        [self.contentView addSubview:SBView];
        
        
        
        
    }
 return self;

}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
