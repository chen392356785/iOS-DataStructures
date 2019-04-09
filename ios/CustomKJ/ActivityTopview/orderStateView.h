//
//  orderStateView.h
//  MiaoTuProject
//
//  Created by Zmh on 11/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderStateView : UIView
{
    
    UIAsyncImageView *_titleImage;
    SMLabel *_titleLbl;
    SMLabel *_timeLbl;
    SMLabel *_adressLbl;
    
    
}
@property (nonatomic,strong)SMLabel *priceLbl;
- (id)initWithFrame:(CGRect)frame;
- (void)setActivtiesData:(ActivitiesListModel *)model;
@end
