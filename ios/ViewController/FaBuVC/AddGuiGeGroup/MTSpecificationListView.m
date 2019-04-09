//
//  MTSpecificationListView.m
//  PopList
//
//  Created by dzb on 2019/4/3.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#import "MTSpecificationListView.h"

@interface MTSpecificationListView () <UITableViewDelegate,UITableViewDataSource>
{
	NSInteger _selectIndex;
	CGFloat _rowHeight;
	UITableView *_tableView;
	NSArray <NSString *> *_dataSoure;
}
@end

@implementation MTSpecificationListView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)items {
	return [self initWithFrame:frame titleArray:items selectIndex:0];
}

- (instancetype)initWithFrame:(CGRect)frame
				   titleArray:(NSArray<NSString *> *)items
				  selectIndex:(NSInteger)index {
	if (self = [super initWithFrame:frame]) {
		_tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.separatorInset = UIEdgeInsetsZero;
		_tableView.separatorColor = [UIColor colorWithRed:5/255.0f green:193.0f/255.0f blue:176.0f/255.0f alpha:1.0f];
		_tableView.layer.borderWidth = 1.0f;
		_tableView.layer.borderColor = [UIColor colorWithRed:5/255.0f green:193.0f/255.0f blue:176.0f/255.0f alpha:1.0f].CGColor;
		_dataSoure = [items copy];
		[self addSubview:_tableView];
		self.backgroundColor = UIColor.redColor;
		_rowHeight = frame.size.height/items.count;
		_selectIndex = index;
        _tableView.scrollEnabled = NO;
	}
	
	return self;
}


#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCellIdentifier"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kCellIdentifier"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		UIImageView *selectImageView = [[UIImageView alloc] init];
		selectImageView.image = [UIImage imageNamed:@"specification_bottom"];
		selectImageView.tag = 100;
		CGFloat viewW = CGRectGetWidth(self.frame) - 13.0f;
		CGFloat viewH = _rowHeight - 12.0f;
		selectImageView.frame = CGRectMake(viewW,viewH, 13.0f,12.0f);
		[cell.contentView addSubview:selectImageView];
	}
	UIImageView *selectImageView = [cell.contentView viewWithTag:100];
	selectImageView.hidden = indexPath.row != _dataSoure.count - 1;
	cell.textLabel.text = _dataSoure[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = sysFont(12);
    [cell.textLabel sizeToFit];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _dataSoure.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return _rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	_selectIndex = indexPath.row;
	[_tableView reloadData];
	if ([self.delegate respondsToSelector:@selector(specificationListView:didSelectItemAtIndex:withTitle:)]) {
		[self.delegate specificationListView:self didSelectItemAtIndex:_selectIndex withTitle:_dataSoure[_selectIndex]];
	}
	[self removeFromSuperview];
}


@end
