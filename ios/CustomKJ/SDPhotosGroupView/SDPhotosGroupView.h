//
//  SDPhotosGroupView.h
//  TaSayProject
//
//  Created by Mac on 15/6/10.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIButton+WebCache.h"
#import "SDPhotoBrowser.h"
@protocol SDPhotosGroupViewDelegate<NSObject>
@optional
-(void)PhotosGroupArray:(NSMutableArray *)photos index:(int)index;
@end

@interface SDPhotosGroupView : UIView <SDPhotoBrowserDelegate>
@property (nonatomic, strong) NSArray *photoItemArray;

@property(nonatomic,strong)NSArray *imagesCellArray;
@property(nonatomic,assign)id<SDPhotosGroupViewDelegate>delegate;
@property(nonatomic,strong)NSArray *imageSelectZanArray;
-(id)initWithFrame:(CGRect)frame withTableViewCell:(BOOL)isTableViewCell;
@end
