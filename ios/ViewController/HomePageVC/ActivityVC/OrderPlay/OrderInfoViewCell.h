//
//  OrderInfoViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/27.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInfoViewCell : UITableViewCell

@property (nonatomic,strong)IHTextField *textFied;

-(void)setTitleContent:(NSString *)text;

@end
