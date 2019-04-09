//
//  TableViewWithBlock.m
//  ptcommon
//
//  Created by 李超 on 16/7/8.
//  Copyright © 2016年 PTGX. All rights reserved.
//

#import "TableViewWithBlock.h"

@implementation TableViewWithBlock

#pragma mark-- public method --
/**
 *  @author fangbmian, 16-07-08 10:07:42
 *
 *  初始化
 *
 *  @param numOfRowsBlock        cell数目
 *  @param cellForIndexPathBlock cell样式
 *  @param didSelectRowBlock     cell点击
 */
- (void)initTableViewDataSourceAndDelegate:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock
{
    
    self.numberOfRowsInSectionBlock = numOfRowsBlock;
    self.cellForRowAtIndexPath = cellForIndexPathBlock;
    self.didDeselectRowAtIndexPathBlock = didSelectRowBlock;
    self.dataSource = self;
    self.delegate = self;
}

#pragma mark-- tableDelegate --
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return self.cellForRowAtIndexPath(tableView, indexPath);
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberOfRowsInSectionBlock(tableView, section);
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    return self.didDeselectRowAtIndexPathBlock(tableView, indexPath);
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        return cell.frame.size.height;
    }
    return 0;
}
@end
