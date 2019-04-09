//
//  UITableViewCell+Helper.m
//  ptcommon
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 PTGX. All rights reserved.
//

#import "UITableViewCell+Helper.h"
//#import <objc/runtime.h>

static NSString* UITableViewDataSourceBlocksKey = @"UITableViewDataSourceBlocksKey";

static NSString* UITableViewDelegateBlocksKey = @"UITableViewDelegateBlocksKey";

/**
 *  @author fangbmian, 16-04-01 08:04:49
 *
 *  UITableView扩展
 */
@implementation UITableViewCell (Helper)

/**
 *  @author fangbmian, 16-04-01 08:04:24
 *
 *  注册cell
 *
 *  @param table      tableView
 *  @param identifier identifier
 *  @param xibName    cell的XibName，若该值为nil,则cell不是通过xib生成的
 */
//+ (void)registerTable:(UITableView*)table nibIdentifier:(NSString*)identifier xibName:(NSString*)xibName
//{
//    if (xibName && [xibName length] > 0)
//        [table registerNib:[UINib nibWithNibName:xibName bundle:nil] forCellReuseIdentifier:identifier];
//    else
//        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
//}

/**
 *  @author fangbmian, 16-04-01 08:04:52
 *
 *  配置cell
 *
 *  @param cell      cell
 *  @param obj       data
 *  @param indexPath indexPath
 */
//- (void)configure:(UITableViewCell*)cell customObj:(id)obj indexPath:(NSIndexPath*)indexPath
//{
//    // Rewrite this func in SubClass
//}
@end

@implementation UITableView (DataSourceBlocks)

//- (id)useBlocksForDataSource
//{
//    UITableViewDataSourceBlocks* dataSource = [[UITableViewDataSourceBlocks alloc] init];
//    objc_setAssociatedObject(self, &UITableViewDataSourceBlocksKey, dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    self.dataSource = dataSource;
//    return self;
//}
//
//- (void)onNumberOfSectionsInTableView:(UITableViewNumberOfSectionsInTableViewBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setNumberOfSectionsInTableViewBlock:block];
//}

//- (void)onSectionIndexTitlesForTableView:(UITableViewSectionIndexTitlesForTableViewBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setSectionIndexTitlesForTableViewBlock:block];
//}
//
////- (void)onCanEditRowAtIndexPath:(UITableViewCanEditRowAtIndexPathBlock)block
////{
////    [((UITableViewDataSourceBlocks*)self.dataSource)setCanEditRowAtIndexPathBlock:block];
////}
//
//- (void)onCanMoveRowAtIndexPath:(UITableViewCanMoveRowAtIndexPathBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setCanMoveRowAtIndexPathBlock:block];
//}
//
//- (void)onCellForRowAtIndexPath:(UITableViewCellForRowAtIndexPathBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setCellForRowAtIndexPathBlock:block];
//}
//
//- (void)onCommitEditingStyle:(UITableViewCommitEditingStyleBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setCommitEditingStyleBlock:block];
//}
//
//- (void)onMoveRowAtIndexPath:(UITableViewMoveRowAtIndexPathBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setMoveRowAtIndexPathBlock:block];
//}
//
//- (void)onNumberOfRowsInSection:(UITableViewNumberOfRowsInSectionBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setNumberOfRowsInSectionBlock:block];
//}
//
//- (void)onSectionForSectionIndexTitle:(UITableViewSectionForSectionIndexTitleBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setSectionForSectionIndexTitleBlock:block];
//}
//
//- (void)onTitleForFooterInSection:(UITableViewTitleForFooterInSectionBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setTitleForFooterInSectionBlock:block];
//}
//
//- (void)onTitleForHeaderInSection:(UITableViewTitleForHeaderInSectionBlock)block
//{
//    [((UITableViewDataSourceBlocks*)self.dataSource)setTitleForHeaderInSectionBlock:block];
//}

@end

@implementation UITableViewDataSourceBlocks

@synthesize numberOfSectionsInTableViewBlock = _numberOfSectionsInTableViewBlock;
@synthesize sectionIndexTitlesForTableViewBlock = _sectionIndexTitlesForTableViewBlock;
@synthesize canEditRowAtIndexPathBlock = _canEditRowAtIndexPathBlock;
@synthesize canMoveRowAtIndexPathBlock = _canMoveRowAtIndexPathBlock;
@synthesize cellForRowAtIndexPathBlock = _cellForRowAtIndexPathBlock;
@synthesize commitEditingStyleBlock = _commitEditingStyleBlock;
@synthesize moveRowAtIndexPathBlock = _moveRowAtIndexPathBlock;
@synthesize numberOfRowsInSectionBlock = _numberOfRowsInSectionBlock;
@synthesize sectionForSectionIndexTitleBlock = _sectionForSectionIndexTitleBlock;
@synthesize titleForFooterInSectionBlock = _titleForFooterInSectionBlock;
@synthesize titleForHeaderInSectionBlock = _titleForHeaderInSectionBlock;

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    UITableViewNumberOfSectionsInTableViewBlock block = [self.numberOfSectionsInTableViewBlock copy];
    NSInteger result = block(tableView);
    return result;
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    UITableViewSectionIndexTitlesForTableViewBlock block = [self.sectionIndexTitlesForTableViewBlock copy];
    NSArray* result = block(tableView);
    return result;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCanEditRowAtIndexPathBlock block = [self.canEditRowAtIndexPathBlock copy];
    BOOL result = block(tableView, indexPath);
    return result;
}

- (BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCanMoveRowAtIndexPathBlock block = [self.canMoveRowAtIndexPathBlock copy];
    BOOL result = block(tableView, indexPath);
    return result;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCellForRowAtIndexPathBlock block = [self.cellForRowAtIndexPathBlock copy];
    UITableViewCell* result = block(tableView, indexPath);
    return result;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCommitEditingStyleBlock block = [self.commitEditingStyleBlock copy];
    block(tableView, editingStyle, indexPath);
}

- (void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
    UITableViewMoveRowAtIndexPathBlock block = [self.moveRowAtIndexPathBlock copy];
    block(tableView, fromIndexPath, toIndexPath);
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    UITableViewNumberOfRowsInSectionBlock block = [self.numberOfRowsInSectionBlock copy];
    NSInteger result = block(tableView, section);
    return result;
}

- (NSInteger)tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
{
    UITableViewSectionForSectionIndexTitleBlock block = [self.sectionForSectionIndexTitleBlock copy];
    NSInteger result = block(tableView, title, index);
    return result;
}

- (NSString*)tableView:(UITableView*)tableView titleForFooterInSection:(NSInteger)section
{
    UITableViewTitleForFooterInSectionBlock block = [self.titleForFooterInSectionBlock copy];
    NSString* result = block(tableView, section);
    return result;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    UITableViewTitleForHeaderInSectionBlock block = [self.titleForHeaderInSectionBlock copy];
    NSString* result = block(tableView, section);
    return result;
}

@end

@implementation UITableView (DelegateBlocks)

- (id)useBlocksForDelegate
{
    UITableViewDelegateBlocks* delegate = [[UITableViewDelegateBlocks alloc] init];
    objc_setAssociatedObject(self, &UITableViewDelegateBlocksKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = delegate;
    return self;
}

- (void)onAccessoryButtonTappedForRowWithIndexPath:(UITableViewAccessoryButtonTappedForRowWithIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setAccessoryButtonTappedForRowWithIndexPathBlock:block];
}

- (void)onDidDeselectRowAtIndexPath:(UITableViewDidDeselectRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setDidDeselectRowAtIndexPathBlock:block];
}

- (void)onDidEndEditingRowAtIndexPath:(UITableViewDidEndEditingRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setDidEndEditingRowAtIndexPathBlock:block];
}

- (void)onDidSelectRowAtIndexPath:(UITableViewDidSelectRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setDidSelectRowAtIndexPathBlock:block];
}

- (void)onEditingStyleForRowAtIndexPath:(UITableViewEditingStyleForRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setEditingStyleForRowAtIndexPathBlock:block];
}

- (void)onHeightForFooterInSection:(UITableViewHeightForFooterInSectionBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setHeightForFooterInSectionBlock:block];
}

- (void)onHeightForHeaderInSection:(UITableViewHeightForHeaderInSectionBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setHeightForHeaderInSectionBlock:block];
}

- (void)onHeightForRowAtIndexPath:(UITableViewHeightForRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setHeightForRowAtIndexPathBlock:block];
}

- (void)onShouldIndentWhileEditingRowAtIndexPath:(UITableViewShouldIndentWhileEditingRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setShouldIndentWhileEditingRowAtIndexPathBlock:block];
}

- (void)onTargetIndexPathForMoveFromRowAtIndexPath:(UITableViewTargetIndexPathForMoveFromRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setTargetIndexPathForMoveFromRowAtIndexPathBlock:block];
}

- (void)onTitleForDeleteConfirmationButtonForRowAtIndexPath:(UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setTitleForDeleteConfirmationButtonForRowAtIndexPathBlock:block];
}

- (void)onViewForFooterInSection:(UITableViewViewForFooterInSectionBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setViewForFooterInSectionBlock:block];
}

- (void)onViewForHeaderInSection:(UITableViewViewForHeaderInSectionBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setViewForHeaderInSectionBlock:block];
}

- (void)onWillBeginEditingRowAtIndexPath:(UITableViewWillBeginEditingRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setWillBeginEditingRowAtIndexPathBlock:block];
}

- (void)onWillDeselectRowAtIndexPath:(UITableViewWillDeselectRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setWillDeselectRowAtIndexPathBlock:block];
}

- (void)onWillDisplayCell:(UITableViewWillDisplayCellBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setWillDisplayCellBlock:block];
}

- (void)onWillSelectRowAtIndexPath:(UITableViewWillSelectRowAtIndexPathBlock)block
{
    [((UITableViewDelegateBlocks*)self.delegate)setWillSelectRowAtIndexPathBlock:block];
}

@end

@implementation UITableViewDelegateBlocks

@synthesize accessoryButtonTappedForRowWithIndexPathBlock = _accessoryButtonTappedForRowWithIndexPathBlock;
@synthesize didDeselectRowAtIndexPathBlock = _didDeselectRowAtIndexPathBlock;
@synthesize didEndEditingRowAtIndexPathBlock = _didEndEditingRowAtIndexPathBlock;
@synthesize didSelectRowAtIndexPathBlock = _didSelectRowAtIndexPathBlock;
@synthesize editingStyleForRowAtIndexPathBlock = _editingStyleForRowAtIndexPathBlock;
@synthesize heightForFooterInSectionBlock = _heightForFooterInSectionBlock;
@synthesize heightForHeaderInSectionBlock = _heightForHeaderInSectionBlock;
@synthesize heightForRowAtIndexPathBlock = _heightForRowAtIndexPathBlock;
@synthesize shouldIndentWhileEditingRowAtIndexPathBlock = _shouldIndentWhileEditingRowAtIndexPathBlock;
@synthesize targetIndexPathForMoveFromRowAtIndexPathBlock = _targetIndexPathForMoveFromRowAtIndexPathBlock;
@synthesize titleForDeleteConfirmationButtonForRowAtIndexPathBlock = _titleForDeleteConfirmationButtonForRowAtIndexPathBlock;
@synthesize viewForFooterInSectionBlock = _viewForFooterInSectionBlock;
@synthesize viewForHeaderInSectionBlock = _viewForHeaderInSectionBlock;
@synthesize willBeginEditingRowAtIndexPathBlock = _willBeginEditingRowAtIndexPathBlock;
@synthesize willDeselectRowAtIndexPathBlock = _willDeselectRowAtIndexPathBlock;
@synthesize willDisplayCellBlock = _willDisplayCellBlock;
@synthesize willSelectRowAtIndexPathBlock = _willSelectRowAtIndexPathBlock;

- (void)tableView:(UITableView*)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath
{
    UITableViewAccessoryButtonTappedForRowWithIndexPathBlock block = [self.accessoryButtonTappedForRowWithIndexPathBlock copy];
    block(tableView, indexPath);
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewDidDeselectRowAtIndexPathBlock block = [self.didDeselectRowAtIndexPathBlock copy];
    block(tableView, indexPath);
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewDidEndEditingRowAtIndexPathBlock block = [self.didEndEditingRowAtIndexPathBlock copy];
    block(tableView, indexPath);
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewDidSelectRowAtIndexPathBlock block = [self.didSelectRowAtIndexPathBlock copy];
    block(tableView, indexPath);
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewEditingStyleForRowAtIndexPathBlock block = [self.editingStyleForRowAtIndexPathBlock copy];
    UITableViewCellEditingStyle result = block(tableView, indexPath);
    return result;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    UITableViewHeightForFooterInSectionBlock block = [self.heightForFooterInSectionBlock copy];
    CGFloat result = block(tableView, section);
    return result;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    UITableViewHeightForHeaderInSectionBlock block = [self.heightForHeaderInSectionBlock copy];
    CGFloat result = block(tableView, section);
    return result;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewHeightForRowAtIndexPathBlock block = [self.heightForRowAtIndexPathBlock copy];
    CGFloat result = block(tableView, indexPath);
    return result;
}

- (BOOL)tableView:(UITableView*)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewShouldIndentWhileEditingRowAtIndexPathBlock block = [self.shouldIndentWhileEditingRowAtIndexPathBlock copy];
    BOOL result = block(tableView, indexPath);
    return result;
}

- (NSIndexPath*)tableView:(UITableView*)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath*)sourceIndexPath toProposedIndexPath:(NSIndexPath*)proposedDestinationIndexPath
{
    UITableViewTargetIndexPathForMoveFromRowAtIndexPathBlock block = [self.targetIndexPathForMoveFromRowAtIndexPathBlock copy];
    NSIndexPath* result = block(tableView, sourceIndexPath, proposedDestinationIndexPath);
    return result;
}

- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock block = [self.titleForDeleteConfirmationButtonForRowAtIndexPathBlock copy];
    NSString* result = block(tableView, indexPath);
    return result;
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewViewForFooterInSectionBlock block = [self.viewForFooterInSectionBlock copy];
    UIView* result = block(tableView, section);
    return result;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewViewForHeaderInSectionBlock block = [self.viewForHeaderInSectionBlock copy];
    UIView* result = block(tableView, section);
    return result;
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewWillBeginEditingRowAtIndexPathBlock block = [self.willBeginEditingRowAtIndexPathBlock copy];
    block(tableView, indexPath);
}

- (NSIndexPath*)tableView:(UITableView*)tableView willDeselectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewWillDeselectRowAtIndexPathBlock block = [self.willDeselectRowAtIndexPathBlock copy];
    NSIndexPath* result = block(tableView, indexPath);
    return result;
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewWillDisplayCellBlock block = [self.willDisplayCellBlock copy];
    block(tableView, cell, indexPath);
}

- (NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewWillSelectRowAtIndexPathBlock block = [self.willSelectRowAtIndexPathBlock copy];
    NSIndexPath* result = block(tableView, indexPath);
    return result;
}

@end
