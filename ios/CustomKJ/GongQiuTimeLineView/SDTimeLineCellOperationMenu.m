//
//  SDTimeLineCellOperationMenu.m
//  GSD_WeiXin(wechat)
//
//  Created by aier on 16/4/2.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "SDTimeLineCellOperationMenu.h"
//#import "UIView+SDAutoLayout.h"


@implementation SDTimeLineCellOperationMenu
{
	__weak UIImageView *_backgroundView;
	UIButton *_likeButton;
	UIButton *_commentButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self setup];
	}
	return self;
}

- (void)setup
{
	self.clipsToBounds = YES;
	UIImageView *backgroundView = [[UIImageView alloc] init];
	backgroundView.image = [UIImage imageNamed:@"comment_background"];
	[self addSubview:backgroundView];
	_backgroundView = backgroundView;
	
	_likeButton = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"bai_zan"] selImage:nil target:self selector:@selector(likeButtonClicked)];
	_commentButton = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"bai_pinglun"] selImage:nil target:self selector:@selector(commentButtonClicked)];
//
//	UIView *centerLine = [UIView new];
//	centerLine.backgroundColor =SDColor(181, 230,228, 1);
//
	[self sd_addSubviews:@[_likeButton, _commentButton]];
	
	CGFloat margin = 5;
	
	_likeButton.sd_layout
	.leftSpaceToView(self, margin)
	.topEqualToView(self)
	.bottomEqualToView(self)
	.widthIs(80);
//
//	centerLine.sd_layout
//	.leftSpaceToView(_likeButton, margin)
//	.topSpaceToView(self, margin)
//	.bottomSpaceToView(self, margin)
//	.widthIs(0.5);
	
	_commentButton.sd_layout
	.leftSpaceToView(_likeButton, margin)
	.topEqualToView(_likeButton)
	.bottomEqualToView(_likeButton)
	.widthRatioToView(_likeButton, 1);
	
}

- (void)layoutSubviews {
	[super layoutSubviews];
	_backgroundView.frame = self.bounds;
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel
{
	UIButton *btn = [UIButton new];
	[btn setTitle:title forState:UIControlStateNormal];
	[btn setImage:image forState:UIControlStateNormal];
	[btn setImage:selImage forState:UIControlStateSelected];
	[btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
	btn.titleLabel.font = sysFont(14);
	btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
	return btn;
}

- (void)likeButtonClicked
{
	if (self.likeButtonClickedOperation) {
		self.likeButtonClickedOperation();
	}
	self.show = NO;
}

-(void)setLike:(BOOL)isLike{
	if (isLike) {
		[_likeButton setTitle:@"取消" forState:UIControlStateNormal];
	} else {
		[_likeButton setTitle:@"赞" forState:UIControlStateNormal];
	}
}

- (void)commentButtonClicked
{
	if (self.commentButtonClickedOperation) {
		self.commentButtonClickedOperation();
	}
	self.show = NO;
}

- (void)setShow:(BOOL)show
{
	_show = show;
	
	[UIView animateWithDuration:0.2 animations:^{
		if (!show) {
			[self clearAutoWidthSettings];
			self.sd_layout
			.widthIs(0);
		} else {
			self.fixedWidth = nil;
			[self setupAutoWidthWithRightView:self->_commentButton rightMargin:5];
		}
		[self updateLayoutWithCellContentView:self.superview];
	}];
}

@end

