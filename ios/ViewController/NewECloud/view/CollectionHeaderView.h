//
//  CollectionHeaderView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionHeaderView : UICollectionReusableView
{
    UIImageView *_imageView;
    SMLabel *_lbl;
}
-(void)setDataWith:(NSString *)img title:(NSString *)title;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@end
