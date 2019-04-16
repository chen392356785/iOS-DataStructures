//
//  FabuBuyViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "FabuBuyViewCell.h"

#import "BuyCellSubView.h"

@interface FabuBuyViewCell ()

///scrollView
@property (nonatomic,strong) UIScrollView *scrollView;
///releaseModel
@property (nonatomic,strong) FabuBuyModel *releaseModel;

@end

@implementation FabuBuyViewCell

#pragma mark - setup

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CommitNotificationBuyFabuAction:) name:NotificationBuyFabuAction object:nil];

	}
	return self;
}


- (void) createView {
	_scrollView = [[UIScrollView alloc] init];
	[self.contentView addSubview:_scrollView];
	_scrollView.delegate = self;
	[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.contentView);
	}];
	_scrollView.contentSize = CGSizeMake(iPhoneWidth*MTbuyViewTypeCount, 0);
	_scrollView.pagingEnabled = YES;
	_scrollView.backgroundColor = kColor(@"#FBFBFB");
	_scrollView.showsHorizontalScrollIndicator = NO;
	[self addScrollSubViews];
	
}



- (void)addScrollSubViews {
	//移除旧的视图 重新布局 UI
	[_scrollView removeAllSubviews];
	for (int i = 0; i < MTbuyViewTypeCount; i ++) {
		BuyCellSubView *subView = [[BuyCellSubView alloc] init];
		subView.selectCompanyNameBlock = self.selectCompanyNameBlock;
		subView.tag = i;
		subView.index = i;
		subView.fabumodel = self.releaseModel;
		[_scrollView addSubview:subView];
		[subView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.bottom.equalTo(self.contentView);
			make.width.offset(iPhoneWidth);
			make.left.offset((i*iPhoneWidth));
		}];
	}
	
}

- (FabuBuyModel *)releaseModel {
	if (!_releaseModel) {
		_releaseModel = [[FabuBuyModel alloc] init];
		_releaseModel.number = @"1";
		_releaseModel.unit = @"株";
		_releaseModel.raiseMethod = @"籽播苗";
		_releaseModel.windPoint = @"";
		_releaseModel.height = @"";
		_releaseModel.crownWidth = @"";
		_releaseModel.spec = @"";
		_releaseModel.specUnit = @"胸径";
		_releaseModel.univalent = @"";
		_releaseModel.density = @"疏";
		_releaseModel.hasTrunk = @"有";
		_releaseModel.model = @"伞形";
		_releaseModel.type = @"独杆";
		_releaseModel.culturalMethod = @"圃地苗";
		_releaseModel.soilBallDress = @"草绳";
		_releaseModel.soilBall = @"黄土";
		_releaseModel.safeguard = @"树干缠亚麻";
		_releaseModel.soilBallSize = @"";
		_releaseModel.soilThickness = @"";
		_releaseModel.soilBallShape = @"锥形";
		_releaseModel.insectPest = @"一般";
		_releaseModel.trim = @"是";
		_releaseModel.waterFertilizer = @"一般";
		_releaseModel.loadLift = @"一般水平";
		_releaseModel.roadWay = @"道路设施完善";
		_releaseModel.userId = USERMODEL.userID;
		_releaseModel.remark = @"";
	}
	return _releaseModel;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSInteger current = scrollView.contentOffset.x / iPhoneWidth;
	if (self.ContOffXBlock) {
		self.ContOffXBlock(current);
	}
}

- (void)setScrollViewContOffX:(NSInteger)index {
	[UIView animateWithDuration:0.3 animations:^{
		self->_scrollView.contentOffset = CGPointMake(index * iPhoneWidth,0);
	}];
}

#pragma mark - Function

//提交
-(void)CommitNotificationBuyFabuAction:(NSNotification *)notification {
	
	if ([self.releaseModel.varieties isEqualToString:@""]) {
		[IHUtility addSucessView:@"请输入品种" type:2];
		return;
	}
	if (self.selectcommitModelBlock) {
		self.selectcommitModelBlock(self.releaseModel);
	}
}

/// 更新公司苗圃名称
- (void) updateCompanyName:(NSString *)company companyId:(NSString *)aCompanyId {
	self.releaseModel.companyname = company;
	self.releaseModel.companyId = aCompanyId;
	BuyCellSubView *subView = [self.scrollView.subviews firstObject];
	[subView reloadData];
}



@end

