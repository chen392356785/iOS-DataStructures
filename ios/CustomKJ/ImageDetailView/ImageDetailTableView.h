//
//  ImageDetailTableView.h
//  MyMovie
//
//  Created by zsm on 14-8-22.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NewsDataSourceDelegate.h"

@interface ImageDetailTableView : UITableView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,retain)NSArray *dataList;
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
//@property (nonatomic,strong)id<ImageScrollDelegate>imgDelegate;

@end
