//
//  UITableViewCell+Helper.h
//  ptcommon
//
//  Created by 李超 on 16/3/31.
//  Copyright © 2016年 PTGX. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author fangbmian, 16-04-01 08:04:49
 *
 *  UITableView扩展
 */
@interface UITableViewCell(Helper)

/**
 *  @author fangbmian, 16-04-01 08:04:24
 *
 *  注册cell
 *
 *  @param table      tableView
 *  @param identifier identifier
 *  @param xibName    cell的XibName，若该值为nil,则cell不是通过xib生成的
 */
//+ (void)registerTable:(UITableView *)table nibIdentifier:(NSString *)identifier xibName:(NSString*)xibName;

/**
 *  @author fangbmian, 16-04-01 08:04:52
 *
 *  配置cell
 *
 *  @param cell      cell
 *  @param obj       data
 *  @param indexPath indexPath
 */
//- (void)configure:(UITableViewCell *)cell customObj:(id)obj indexPath:(NSIndexPath *)indexPath;

@end

typedef NSInteger (^UITableViewNumberOfSectionsInTableViewBlock)(UITableView* tableView);
typedef NSArray* (^UITableViewSectionIndexTitlesForTableViewBlock)(UITableView* tableView);
typedef BOOL (^UITableViewCanEditRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef BOOL (^UITableViewCanMoveRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef UITableViewCell* (^UITableViewCellForRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef void (^UITableViewCommitEditingStyleBlock)(UITableView* tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath* indexPath);
typedef void (^UITableViewMoveRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* fromIndexPath, NSIndexPath* toIndexPath);
typedef NSUInteger (^UITableViewNumberOfRowsInSectionBlock)(UITableView* tableView, NSInteger section);
typedef NSInteger (^UITableViewSectionForSectionIndexTitleBlock)(UITableView* tableView, NSString* title, NSInteger index);
typedef NSString* (^UITableViewTitleForFooterInSectionBlock)(UITableView* tableView, NSInteger section);
typedef NSString* (^UITableViewTitleForHeaderInSectionBlock)(UITableView* tableView, NSInteger section);

@interface UITableView (DataSourceBlocks)

//-(id)useBlocksForDataSource;
//-(void)onNumberOfSectionsInTableView:(UITableViewNumberOfSectionsInTableViewBlock)block;
//-(void)onSectionIndexTitlesForTableView:(UITableViewSectionIndexTitlesForTableViewBlock)block;
//-(void)onCanEditRowAtIndexPath:(UITableViewCanEditRowAtIndexPathBlock)block;
//-(void)onCanMoveRowAtIndexPath:(UITableViewCanMoveRowAtIndexPathBlock)block;
//-(void)onCellForRowAtIndexPath:(UITableViewCellForRowAtIndexPathBlock)block;
//-(void)onCommitEditingStyle:(UITableViewCommitEditingStyleBlock)block;
//-(void)onMoveRowAtIndexPath:(UITableViewMoveRowAtIndexPathBlock)block;
//-(void)onNumberOfRowsInSection:(UITableViewNumberOfRowsInSectionBlock)block;
//-(void)onSectionForSectionIndexTitle:(UITableViewSectionForSectionIndexTitleBlock)block;
//-(void)onTitleForFooterInSection:(UITableViewTitleForFooterInSectionBlock)block;
//-(void)onTitleForHeaderInSection:(UITableViewTitleForHeaderInSectionBlock)block;

@end

@interface UITableViewDataSourceBlocks : NSObject <UITableViewDataSource>
{
    UITableViewNumberOfSectionsInTableViewBlock _numberOfSectionsInTableViewBlock;
    UITableViewSectionIndexTitlesForTableViewBlock _sectionIndexTitlesForTableViewBlock;
    UITableViewCanEditRowAtIndexPathBlock _canEditRowAtIndexPathBlock;
    UITableViewCanMoveRowAtIndexPathBlock _canMoveRowAtIndexPathBlock;
    UITableViewCellForRowAtIndexPathBlock _cellForRowAtIndexPathBlock;
    UITableViewCommitEditingStyleBlock _commitEditingStyleBlock;
    UITableViewMoveRowAtIndexPathBlock _moveRowAtIndexPathBlock;
    UITableViewNumberOfRowsInSectionBlock _numberOfRowsInSectionBlock;
    UITableViewSectionForSectionIndexTitleBlock _sectionForSectionIndexTitleBlock;
    UITableViewTitleForFooterInSectionBlock _titleForFooterInSectionBlock;
    UITableViewTitleForHeaderInSectionBlock _titleForHeaderInSectionBlock;
}

@property(nonatomic, copy) UITableViewNumberOfSectionsInTableViewBlock numberOfSectionsInTableViewBlock;
@property(nonatomic, copy) UITableViewSectionIndexTitlesForTableViewBlock sectionIndexTitlesForTableViewBlock;
@property(nonatomic, copy) UITableViewCanEditRowAtIndexPathBlock canEditRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewCanMoveRowAtIndexPathBlock canMoveRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewCellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewCommitEditingStyleBlock commitEditingStyleBlock;
@property(nonatomic, copy) UITableViewMoveRowAtIndexPathBlock moveRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewNumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property(nonatomic, copy) UITableViewSectionForSectionIndexTitleBlock sectionForSectionIndexTitleBlock;
@property(nonatomic, copy) UITableViewTitleForFooterInSectionBlock titleForFooterInSectionBlock;
@property(nonatomic, copy) UITableViewTitleForHeaderInSectionBlock titleForHeaderInSectionBlock;

@end

typedef void (^UITableViewAccessoryButtonTappedForRowWithIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef void (^UITableViewDidDeselectRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef void (^UITableViewDidEndEditingRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef void (^UITableViewDidSelectRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef UITableViewCellEditingStyle (^UITableViewEditingStyleForRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef CGFloat (^UITableViewHeightForFooterInSectionBlock)(UITableView* tableView, NSInteger section);
typedef CGFloat (^UITableViewHeightForHeaderInSectionBlock)(UITableView* tableView, NSInteger section);
typedef CGFloat (^UITableViewHeightForRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef BOOL (^UITableViewShouldIndentWhileEditingRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath* (^UITableViewTargetIndexPathForMoveFromRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* sourceIndexPath, NSIndexPath* proposedDestinationIndexPath);
typedef NSString* (^UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef UIView* (^UITableViewViewForFooterInSectionBlock)(UITableView* tableView, NSInteger section);
typedef UIView* (^UITableViewViewForHeaderInSectionBlock)(UITableView* tableView, NSInteger section);
typedef void (^UITableViewWillBeginEditingRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath* (^UITableViewWillDeselectRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef void (^UITableViewWillDisplayCellBlock)(UITableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);
typedef NSIndexPath* (^UITableViewWillSelectRowAtIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath);

@interface UITableView (DelegateBlocks)

-(id)useBlocksForDelegate;
-(void)onAccessoryButtonTappedForRowWithIndexPath:(UITableViewAccessoryButtonTappedForRowWithIndexPathBlock)block;
-(void)onDidDeselectRowAtIndexPath:(UITableViewDidDeselectRowAtIndexPathBlock)block;
-(void)onDidEndEditingRowAtIndexPath:(UITableViewDidEndEditingRowAtIndexPathBlock)block;
-(void)onDidSelectRowAtIndexPath:(UITableViewDidSelectRowAtIndexPathBlock)block;
-(void)onEditingStyleForRowAtIndexPath:(UITableViewEditingStyleForRowAtIndexPathBlock)block;
-(void)onHeightForFooterInSection:(UITableViewHeightForFooterInSectionBlock)block;
-(void)onHeightForHeaderInSection:(UITableViewHeightForHeaderInSectionBlock)block;
-(void)onHeightForRowAtIndexPath:(UITableViewHeightForRowAtIndexPathBlock)block;
-(void)onShouldIndentWhileEditingRowAtIndexPath:(UITableViewShouldIndentWhileEditingRowAtIndexPathBlock)block;
-(void)onTargetIndexPathForMoveFromRowAtIndexPath:(UITableViewTargetIndexPathForMoveFromRowAtIndexPathBlock)block;
-(void)onTitleForDeleteConfirmationButtonForRowAtIndexPath:(UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock)block;
-(void)onViewForFooterInSection:(UITableViewViewForFooterInSectionBlock)block;
-(void)onViewForHeaderInSection:(UITableViewViewForHeaderInSectionBlock)block;
-(void)onWillBeginEditingRowAtIndexPath:(UITableViewWillBeginEditingRowAtIndexPathBlock)block;
-(void)onWillDeselectRowAtIndexPath:(UITableViewWillDeselectRowAtIndexPathBlock)block;
-(void)onWillDisplayCell:(UITableViewWillDisplayCellBlock)block;
-(void)onWillSelectRowAtIndexPath:(UITableViewWillSelectRowAtIndexPathBlock)block;

@end

@interface UITableViewDelegateBlocks : NSObject <UITableViewDelegate> {
    UITableViewAccessoryButtonTappedForRowWithIndexPathBlock _accessoryButtonTappedForRowWithIndexPathBlock;
    UITableViewDidDeselectRowAtIndexPathBlock _didDeselectRowAtIndexPathBlock;
    UITableViewDidEndEditingRowAtIndexPathBlock _didEndEditingRowAtIndexPathBlock;
    UITableViewDidSelectRowAtIndexPathBlock _didSelectRowAtIndexPathBlock;
    UITableViewEditingStyleForRowAtIndexPathBlock _editingStyleForRowAtIndexPathBlock;
    UITableViewHeightForFooterInSectionBlock _heightForFooterInSectionBlock;
    UITableViewHeightForHeaderInSectionBlock _heightForHeaderInSectionBlock;
    UITableViewHeightForRowAtIndexPathBlock _heightForRowAtIndexPathBlock;
    UITableViewShouldIndentWhileEditingRowAtIndexPathBlock _shouldIndentWhileEditingRowAtIndexPathBlock;
    UITableViewTargetIndexPathForMoveFromRowAtIndexPathBlock _targetIndexPathForMoveFromRowAtIndexPathBlock;
    UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock _titleForDeleteConfirmationButtonForRowAtIndexPathBlock;
    UITableViewViewForFooterInSectionBlock _viewForFooterInSectionBlock;
    UITableViewViewForHeaderInSectionBlock _viewForHeaderInSectionBlock;
    UITableViewWillBeginEditingRowAtIndexPathBlock _willBeginEditingRowAtIndexPathBlock;
    UITableViewWillDeselectRowAtIndexPathBlock _willDeselectRowAtIndexPathBlock;
    UITableViewWillDisplayCellBlock _willDisplayCellBlock;
    UITableViewWillSelectRowAtIndexPathBlock _willSelectRowAtIndexPathBlock;
}

@property(nonatomic, copy) UITableViewAccessoryButtonTappedForRowWithIndexPathBlock accessoryButtonTappedForRowWithIndexPathBlock;
@property(nonatomic, copy) UITableViewDidDeselectRowAtIndexPathBlock didDeselectRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewDidEndEditingRowAtIndexPathBlock didEndEditingRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewDidSelectRowAtIndexPathBlock didSelectRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewEditingStyleForRowAtIndexPathBlock editingStyleForRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewHeightForFooterInSectionBlock heightForFooterInSectionBlock;
@property(nonatomic, copy) UITableViewHeightForHeaderInSectionBlock heightForHeaderInSectionBlock;
@property(nonatomic, copy) UITableViewHeightForRowAtIndexPathBlock heightForRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewShouldIndentWhileEditingRowAtIndexPathBlock shouldIndentWhileEditingRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewTargetIndexPathForMoveFromRowAtIndexPathBlock targetIndexPathForMoveFromRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock titleForDeleteConfirmationButtonForRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewViewForFooterInSectionBlock viewForFooterInSectionBlock;
@property(nonatomic, copy) UITableViewViewForHeaderInSectionBlock viewForHeaderInSectionBlock;
@property(nonatomic, copy) UITableViewWillBeginEditingRowAtIndexPathBlock willBeginEditingRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewWillDeselectRowAtIndexPathBlock willDeselectRowAtIndexPathBlock;
@property(nonatomic, copy) UITableViewWillDisplayCellBlock willDisplayCellBlock;
@property(nonatomic, copy) UITableViewWillSelectRowAtIndexPathBlock willSelectRowAtIndexPathBlock;

@end

