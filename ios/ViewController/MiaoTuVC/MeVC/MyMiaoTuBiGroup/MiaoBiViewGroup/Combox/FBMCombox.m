//
//  FBMCombox.m
//  ptcommon
//
//  Created by 李超 on 16/7/8.
//  Copyright © 2016年 PTGX. All rights reserved.
//

#import "FBMCombox.h"
//#import "Masonry.h"

//#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;

@interface CustomButton : UIButton

@property (nonatomic) CGRect imageFrame;

- (CGRect)imageRectForContentRect:(CGRect)bounds;

@end

@implementation CustomButton

- (CGRect)imageRectForContentRect:(CGRect)bounds
{
    return _imageFrame;
}

@end

@interface FBMCombox () {
    BOOL isOpened;
    CGFloat m_cellHeight;
}

@property (nonatomic, strong) TableViewWithBlock* tableView;
@property (strong, nonatomic) NSArray* selectItems;
@property (nonatomic, strong) CustomButton* openButton;
@end

@implementation FBMCombox

#pragma mark-- public method --
/**
 *  @author fangbmian, 16-07-08 10:07:30
 *
 *  初始化
 *
 *  @param items item
 *  @param rect  frame
 *
 *  @return self
 */
- (id)initWithItems:(NSArray*)items withFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        _selectItems = items;
        m_cellHeight = rect.size.height;
        [self initLayout];
    }
    return self;
}

/**
 *  @author fangbmian, 16-07-08 10:07:56
 *
 *  隐藏方法
 */
//- (void)hideDropMenu
//{
//    if (isOpened) {
//        [_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
//    }
//}

#pragma mark-- private method --

/**
 *  @author fangbmian, 16-07-08 10:07:36
 *
 *  页面初始化
 */
- (void)initLayout
{
    UITextField* inputTextField = [UITextField new];
    inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    inputTextField.font = [UIFont systemFontOfSize:14];
    inputTextField.enabled = NO;
    inputTextField.text = _selectItems[0];
    [self addSubview:inputTextField];
    [inputTextField mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
    }];
    
    _openButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    _openButton.imageFrame = CGRectMake(self.frame.size.width - m_cellHeight + 2, 0, m_cellHeight - 4, m_cellHeight - 4);
    [_openButton setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [_openButton addTarget:self action:@selector(changeOpenStatus:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_openButton];
    [_openButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    WS(weakSelf);
    _tableView = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(0, m_cellHeight, self.bounds.size.width, 1)];
    [_tableView initTableViewDataSourceAndDelegate:^(UITableView* tableView, NSInteger section) {
        return self->_selectItems.count;
    } setCellForIndexPathBlock:^(UITableView* tableView, NSIndexPath* indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectionCell"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (self.textFont) {
             cell.textLabel.font = [UIFont systemFontOfSize:self.textFont];
        }else {
             cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        [cell.textLabel setText:self->_selectItems[indexPath.row]];
        CGFloat cellWidth = cell.bounds.size.width;
        cell.bounds = CGRectMake(0, 0, cellWidth, self->m_cellHeight);
        return cell;
    } setDidSelectRowBlock:^(UITableView* tableView, NSIndexPath* indexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        inputTextField.text = cell.textLabel.text;
        [self->_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(combox:didSelectItem:)]) {
            [weakSelf.delegate combox:weakSelf didSelectItem:cell.textLabel.text];
        }
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView.layer setBorderColor:[UIColor grayColor].CGColor];
    [_tableView.layer setBorderWidth:1];
    _tableView.layer.cornerRadius = 5;
    _tableView.layer.masksToBounds = YES;
    _tableView.hidden = YES;
    [self addSubview:_tableView];
}

/**
 *  @author fangbmian, 16-07-08 10:07:36
 *
 *  状态改变方法
 *
 *  @param sender button
 */
- (void)changeOpenStatus:(id)sender
{
    if (isOpened) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuWillHide:)]) {
            [self.delegate dropMenuWillHide:self];
        }
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage = [UIImage imageNamed:@"dropdown.png"];
            [self->_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame = self->_tableView.frame;
            
            frame.size.height = 1;
            [self->_tableView setFrame:frame];
            self->_tableView.hidden = YES;
            
        } completion:^(BOOL finished) {
            self->isOpened = NO;
            if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuDidHide:)]) {
                [self.delegate dropMenuDidHide:self];
            }
        }];
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuWillShow:)]) {
            [self.delegate dropMenuWillShow:self];
        }
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage = [UIImage imageNamed:@"dropup.png"];
            [self->_openButton setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame = self->_tableView.frame;
            frame.size.height = self->m_cellHeight * self->_selectItems.count;
            [self->_tableView setFrame:frame];
            self->_tableView.hidden = NO;
        } completion:^(BOOL finished) {
            self->isOpened = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuDidShow:)]) {
                [self.delegate dropMenuDidShow:self];
            }
        }];
    }
}

#pragma mark-- Override Methods --

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect tbFrame = _tableView.frame;
    
    if (CGRectContainsPoint(tbFrame, point)) {
        return _tableView;
    }
    return [super hitTest:point withEvent:event];
}

@end
