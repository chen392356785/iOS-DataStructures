//
//  MTSpecificationListView.h
//  PopList
//
//  Created by dzb on 2019/4/3.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTSpecificationListView;

@protocol MTSpecificationListViewDelegate <NSObject>

@optional

- (void) specificationListView:(MTSpecificationListView *_Nullable)specificationView
		  didSelectItemAtIndex:(NSInteger)index
					 withTitle:(NSString *_Nullable)title;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MTSpecificationListView : UIView


- (instancetype)initWithFrame:(CGRect)frame
				   titleArray:(NSArray *)items;

- (instancetype)initWithFrame:(CGRect)frame
				   titleArray:(NSArray <NSString *> *)items
				  selectIndex:(NSInteger)index;

///delegate
@property (nonatomic,weak) id<MTSpecificationListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
