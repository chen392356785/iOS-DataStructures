//
//  CustomScrollCell.h
//  JXScrollCell
//
//  Created by jiaxin on 15/12/14.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "ParallaxCell.h"

@interface CustomScrollCell : ParallaxCell
{
    UIAsyncImageView *_imgView;
}
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) SMLabel *nameLabel;
@property (nonatomic, strong) SMLabel *detailLabel;
+ (CGFloat)getHeight;
-(void)setData;
 @property(nonatomic,strong)ThemeListModel *model;
@end
