//
//  TableViewWithBlock.h
//  ptcommon
//
//  Created by 李超 on 16/7/8.
//  Copyright © 2016年 PTGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+Helper.h"

/**
 *  @author fangbmian, 16-07-08 10:07:08
 *
 *  tableView
 */
@interface TableViewWithBlock : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) UITableViewCellForRowAtIndexPathBlock cellForRowAtIndexPath;

@property (nonatomic, copy) UITableViewNumberOfRowsInSectionBlock numberOfRowsInSectionBlock;

@property (nonatomic, copy) UITableViewDidDeselectRowAtIndexPathBlock didDeselectRowAtIndexPathBlock;

/**
 *  @author fangbmian, 16-07-08 10:07:42
 *
 *  初始化
 *
 *  @param numOfRowsBlock        cell数目
 *  @param cellForIndexPathBlock cell样式
 *  @param didSelectRowBlock     cell点击
 */
- (void)initTableViewDataSourceAndDelegate:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock;
@end
