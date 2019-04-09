//
//  GardenListViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GardenModel.h"

@interface GardenListViewCell : UITableViewCell

typedef void (^DidSkrCellBackBut) (NSInteger i);        //0没有点过赞

@property (nonatomic, strong) UILabel *rankingLabel;

@property(nonatomic,copy) DidSkrCellBackBut SkrBlock;
@property(nonatomic,copy) DidSelectBlock pinlunBlock;
- (void)setYuanbangModel:(yuanbangModel *)yuanbangModel andBgImage:(NSString *)image;
@end
