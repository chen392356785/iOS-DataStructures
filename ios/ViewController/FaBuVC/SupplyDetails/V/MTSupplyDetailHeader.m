//
//  MTSupplyDetailHeader.m
//  MiaoTuProject
//
//  Created by dzb on 2019/4/11.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SDPhotoBrowser.h"
#import "MTSupplyDetailsModel.h"
#import "MTSupplyDetailHeader.h"

@interface MTSupplyDetailHeader () <SDPhotoBrowserDelegate>
{
    CGFloat _viewWidth;
    __weak UIView *_contactIconView;
	UIView *_imageViewContainer;
    __weak UIView *_companyNameIconView;
    __weak UIView *_companyAddressIconView;
    __weak UIView *_baseInfoView; //苗木基本信息
    __weak UIView *_plantShapeView; //苗木形态信息
    __weak UIView *_plantTechnologyView; ///技术措施信息
    __weak UIView *_riskControlView; ///风险控制视图
    __weak UILabel *_remarkLabel; //备注
    
    UILabel *_specLabel; //规格 label
    UILabel *_numbersLabel; //数量 label
    UILabel *_heightLabel; ///高度 label
    UILabel *_crownWidthLabel; ///冠幅label
    UILabel *_branchPointLabel; //支点 label
    UILabel *_unitPriceLabel; //单价label
    UILabel *_plantThickLabel; //茂密程度
    UILabel *_plantPoleLabel; //有无明显主杆
    UILabel *_plantTypeLabel; //种类
    UILabel *_plantModelling; //造型
    UILabel *_plantCultivationType; //栽培方式
    UILabel *_soilBallDressLabel; ///包扎技术
    UILabel *_soilBallLabel; //土质
    UILabel *_culturalMethodLabel; //培养方式
    UILabel *_safeguardLabel; //保护措施
    UILabel *_soilBallSizeLabel; ///直径
    UILabel *_soilThicknessLabel; ///厚度
    UILabel *_soilBallShapeLabel; ///形状
    UILabel *_insectPestLabel; //有无病虫害
    UILabel *_trimLabel; //收枝修剪
    UILabel *_waterFertilizerLabel; //水肥
    UILabel *_loadLiftLabel; //吊装技术
    UILabel *_roadWayLabel; //转运方便
}
///headImageView
@property (nonatomic,strong) UIImageView *headImageView;
///nicknameLabel
@property (nonatomic,strong) UILabel *nicknameLabel;
///timeLabel
@property (nonatomic,strong) UILabel *timeLabel;
///jobTitle
@property (nonatomic,strong) UILabel *jobTitle;
///titleLabel
@property (nonatomic,strong) UILabel *titleLabel;
///priceLabel
@property (nonatomic,strong) UILabel *priceLabel;
///配图数组
@property (nonatomic,strong) NSMutableArray <UIButton *>*imageButtonArray;

@end

@implementation MTSupplyDetailHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		//顶部信息
		[self _addTopView];
		//公司信息视图
		[self _addCompanyInfoView];
		//供应内容基本信息
		[self _addBaseInfoView];
		//苗木形态信息
		[self _addPlantShapeInfo];
		//技术措施
		[self _addPlantTechnologyView];
		//风险控制
		[self _addRiskControlView];
		//备注
		[self _addRemarkView];
    }
    return self;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 21.0f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
		label.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
		label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 16];
        _nicknameLabel = label;
    }
    return _nicknameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
		label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 13];
		label.textColor = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)jobTitle {
    if (!_jobTitle) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
		label.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
		label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _jobTitle = label;
    }
    return _jobTitle;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(13,387.5,33,16);
        label.numberOfLines = 0;
		label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
		label.textColor = UIColor.redColor;
        _priceLabel = label;
    }
    return _priceLabel;
}

#pragma mark - 头部信息
- (void) _addTopView {
	
	self.clipsToBounds = YES;
	self.backgroundColor =  UIColor.whiteColor;
	_viewWidth = iPhoneWidth-26.0f;
	
    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    [self addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(6.0f);
    }];
    
    //头像
    [self addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13.0f);
        make.top.equalTo(self.mas_top).offset(17.0f);
        make.size.mas_equalTo(CGSizeMake(42.0f,42.0f));
    }];
    
    //昵称
    [self addSubview:self.nicknameLabel];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(21.0f);
        make.left.equalTo(self.headImageView.mas_right).offset(8.0f);
        make.size.mas_equalTo(CGSizeMake(200.0f,16.0f));
    }];
    
    //日期
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel);
        make.top.equalTo(self.nicknameLabel.mas_bottom).offset(8.0f);
        make.height.mas_equalTo(12.0f);
    }];
    
    //职称
    [self addSubview:self.jobTitle];
    [self.jobTitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.timeLabel.mas_right).offset(13.0f);
		make.centerY.equalTo(self.timeLabel);
		make.size.mas_equalTo(CGSizeMake(150.0f,14.0f));
    }];
    
    // 供应图片视图
    [self _addImagesContainerView];
    
    // 品种名称
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView);
        make.top.equalTo(self->_imageViewContainer.mas_bottom).offset(20.0f);
        make.size.mas_equalTo(CGSizeMake(200.0,16.0f));
    }];
    
    //价格
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(14.0f);
        make.left.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(150.0f, 18.0f));
    }];
}

#pragma mark - 公司信息

- (void) _addCompanyInfoView {
    
    //公司名称
    UIView *companyNameIconView = [self companyInfoViewWithIcon:@"company_icon_image" title:@""];
    [self addSubview:companyNameIconView];
    [companyNameIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(17.0f);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth, 14.0f));
    }];
    _companyNameIconView = companyNameIconView;
    
    //公司地址
    UIView *companyAddressIconView = [self companyInfoViewWithIcon:@"company_address_icon" title:@""];
    [self addSubview:companyAddressIconView];
    [companyAddressIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(companyNameIconView);
        make.top.equalTo(companyNameIconView.mas_bottom).offset(14.0f);
        make.size.equalTo(self->_companyNameIconView);
    }];
    _companyAddressIconView = companyAddressIconView;
    
    //联系方式
    UIView *contactIconView = [self companyInfoViewWithIcon:@"contact_icon_image" title:@""];
    [self addSubview:contactIconView];
    [contactIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(companyAddressIconView);
        make.top.equalTo(companyAddressIconView.mas_bottom).offset(14.0f);
        make.size.equalTo(self->_companyNameIconView);
    }];
    _contactIconView = contactIconView;
    
}

- (UIView *) companyInfoViewWithIcon:(NSString *)icon title:(NSString *)title {
    
    UIView *view = [[UIView alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:icon]];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(14.0f, 14.0f));
    }];
    
    UILabel *label = [[UILabel alloc] init];
	label.tag = 100;
	label.font = [UIFont systemFontOfSize:14.0f];
	label.textColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1.0];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(view);
        make.left.equalTo(imageView.mas_right).offset(10.0f);
    }];
    
    return view;
}

#pragma mark - 苗木基本信息

- (void) _addBaseInfoView {
    
    UIView *baseInfoView = [[UIView alloc] init];
    baseInfoView.backgroundColor = UIColor.whiteColor;
    [self addSubview:baseInfoView];
    [baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13.0f);
        make.top.equalTo(self->_contactIconView.mas_bottom).offset(31.0f);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth,74.0f));
    }];
    _baseInfoView = baseInfoView;
    
    _specLabel = [self _getBaseInfoLabel:@"规格："];
    _numbersLabel = [self _getBaseInfoLabel:@"数量："];
    _heightLabel = [self _getBaseInfoLabel:@"高度："];
    _crownWidthLabel = [self _getBaseInfoLabel:@"冠幅："];
    _branchPointLabel = [self _getBaseInfoLabel:@"分支点："];
    _unitPriceLabel = [self _getBaseInfoLabel:@"单价：0元"];
    [baseInfoView addSubview:_specLabel];
    [baseInfoView addSubview:_numbersLabel];
    [baseInfoView addSubview:_heightLabel];
    [baseInfoView addSubview:_crownWidthLabel];
    [baseInfoView addSubview:_branchPointLabel];
    [baseInfoView addSubview:_unitPriceLabel];
    
    [_specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(baseInfoView);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth*0.5f,13.0f));
    }];
    
    [_numbersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(baseInfoView);
        make.size.equalTo(self->_specLabel);
    }];
    
    [_heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_specLabel);
        make.top.equalTo(self->_specLabel.mas_bottom).offset(17.0f);
        make.size.equalTo(self->_specLabel);
    }];
    
    [_crownWidthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_numbersLabel);
        make.top.equalTo(self->_numbersLabel.mas_bottom).offset(17.0f);
        make.size.equalTo(self->_specLabel);
    }];
    
    [_branchPointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_heightLabel);
        make.top.equalTo(self->_heightLabel.mas_bottom).offset(17.0f);
        make.size.equalTo(self->_specLabel);
    }];
    
    [_unitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_crownWidthLabel);
        make.top.equalTo(self->_crownWidthLabel.mas_bottom).offset(17.0f);
        make.size.equalTo(self->_specLabel);
    }];
    
    [self _addLineViewWithTopView:self->_baseInfoView];
    
}

- (void) _addLineViewWithTopView:(UIView *)topView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(17.0f);
        make.left.equalTo(self.mas_left).offset(10.0f);
        make.size.mas_equalTo(CGSizeMake(iPhoneWidth-20.0f,1.0f));
    }];
}

- (UILabel *) _getBaseInfoLabel:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(13,548.5,158,13);
    label.text = title;
    label.textColor = RGB(143.0f, 143.0f, 143.0f);
    label.font = [UIFont systemFontOfSize:13.0f];
    return label;
}

#pragma mark - 苗木形态

- (void) _addPlantShapeInfo {
    
    UIView *plantShapeView = [[UIView alloc] init];
    plantShapeView.backgroundColor = UIColor.whiteColor;
    [self addSubview:plantShapeView];
    _plantShapeView = plantShapeView;
    [_plantShapeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_baseInfoView.mas_bottom).offset(33.0f);
        make.left.right.height.equalTo(self->_baseInfoView);
    }];
    
    _plantThickLabel = [self _getBaseInfoLabel:@"枝叶茂密程度："];
    _plantPoleLabel = [self _getBaseInfoLabel:@"有无明显主杆："];
    _plantTypeLabel = [self _getBaseInfoLabel:@"种类："];
    _plantModelling = [self _getBaseInfoLabel:@"造型："];
    _plantCultivationType = [self _getBaseInfoLabel:@"栽培方式："];
    
    [plantShapeView addSubview:_plantThickLabel];
    [plantShapeView addSubview:_plantPoleLabel];
    [plantShapeView addSubview:_plantTypeLabel];
    [plantShapeView addSubview:_plantModelling];
    [plantShapeView addSubview:_plantCultivationType];
    
    [_plantThickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(plantShapeView);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth*0.5f,13.0f));
    }];
    
    [_plantPoleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(plantShapeView);
        make.size.equalTo(self->_plantThickLabel);
    }];
    
    [_plantTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_plantThickLabel);
        make.top.equalTo(self->_plantThickLabel.mas_bottom).offset(17.0f);
        make.size.equalTo(self->_plantThickLabel);
    }];
    
    [_plantModelling mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_plantPoleLabel);
        make.top.equalTo(self->_plantPoleLabel.mas_bottom).offset(17.0f);
        make.size.equalTo(self->_plantThickLabel);
    }];
    
    [_plantCultivationType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_plantTypeLabel);
        make.top.equalTo(self->_plantTypeLabel.mas_bottom).offset(17.0f);
        make.size.equalTo(self->_plantThickLabel);
    }];
    
    [self _addLineViewWithTopView:self->_plantShapeView];
    
}

#pragma mark - 技术措施
- (void) _addPlantTechnologyView {
    
    UIView *plantTechnologyView = [[UIView alloc] init];
    plantTechnologyView.backgroundColor = UIColor.whiteColor;
    [self addSubview:plantTechnologyView];
    _plantTechnologyView = plantTechnologyView;
    [_plantTechnologyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_plantShapeView.mas_bottom).offset(32.0f);
        make.left.right.equalTo(self->_plantShapeView);
        make.height.mas_equalTo(104.0f);
    }];
    
    _soilBallDressLabel = [self _getBaseInfoLabel:@"土球起挖包扎技术及包扎材质："];
    _soilBallLabel = [self _getBaseInfoLabel:@"土球土质："];
    _culturalMethodLabel = [self _getBaseInfoLabel:@"培育方式："];
    _safeguardLabel = [self _getBaseInfoLabel:@"保护措施："];
    _soilBallSizeLabel = [self _getBaseInfoLabel:@"直径：0cm"];
    _soilThicknessLabel = [self _getBaseInfoLabel:@"厚度：0cm"];
    _soilBallShapeLabel = [self _getBaseInfoLabel:@"形状："];
    
    [_plantTechnologyView addSubview:_soilBallDressLabel];
    [_plantTechnologyView addSubview:_soilBallLabel];
    [_plantTechnologyView addSubview:_culturalMethodLabel];
    [_plantTechnologyView addSubview:_safeguardLabel];
    [_plantTechnologyView addSubview:_soilBallSizeLabel];
    [_plantTechnologyView addSubview:_soilThicknessLabel];
    [_plantTechnologyView addSubview:_soilBallShapeLabel];
    
    [_soilBallDressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self->_plantTechnologyView);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth,13.0f));
    }];
    
    [_soilBallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_soilBallDressLabel.mas_bottom).offset(16.0f);
        make.left.equalTo(self->_soilBallDressLabel);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth*0.5f,13.0f));
    }];
    
    [_culturalMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_plantTechnologyView);
        make.top.equalTo(self->_soilBallLabel);
        make.size.equalTo(self->_soilBallLabel);
    }];
    
    [_safeguardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_soilBallLabel);
        make.top.equalTo(self->_soilBallLabel.mas_bottom).offset(16.0f);
        make.size.equalTo(self->_soilBallLabel);
    }];
    
    [_soilBallSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_culturalMethodLabel);
        make.top.equalTo(self->_safeguardLabel);
        make.size.equalTo(self->_soilBallLabel);
    }];
    
    [_soilThicknessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_safeguardLabel);
        make.top.equalTo(self->_safeguardLabel.mas_bottom).offset(16.0f);
        make.size.equalTo(self->_soilBallLabel);
    }];
    
    [_soilBallShapeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_soilBallSizeLabel);
        make.top.equalTo(self->_soilThicknessLabel);
        make.size.equalTo(self->_soilBallLabel);
    }];
    
    [self _addLineViewWithTopView:self->_plantTechnologyView];
    
}

#pragma mark - 风险控制

- (void) _addRiskControlView {
    
    UIView *riskControlView = [[UIView alloc] init];
    riskControlView.backgroundColor = UIColor.whiteColor;
    [self addSubview:riskControlView];
    _riskControlView = riskControlView;
    [_riskControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_plantTechnologyView.mas_bottom).offset(32.0f);
        make.left.right.equalTo(self->_plantTechnologyView);
        make.height.mas_equalTo(104.0f);
    }];
    
    _insectPestLabel = [self _getBaseInfoLabel:@"是否有病虫害："];
    _trimLabel = [self _getBaseInfoLabel:@"育苗期是否做过收支的修剪："];
    _waterFertilizerLabel = [self _getBaseInfoLabel:@"水肥："];
    _loadLiftLabel = [self _getBaseInfoLabel:@"装车起吊、技术："];
    _roadWayLabel = [self _getBaseInfoLabel:@"苗圃运转方便程度："];
    
    [_riskControlView addSubview:_insectPestLabel];
    [_riskControlView addSubview:_trimLabel];
    [_riskControlView addSubview:_waterFertilizerLabel];
    [_riskControlView addSubview:_loadLiftLabel];
    [_riskControlView addSubview:_roadWayLabel];
    
    [_insectPestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self->_riskControlView);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth,13.0f));
    }];
    
    [_trimLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_insectPestLabel.mas_bottom).offset(16.0f);
        make.left.equalTo(self->_soilBallDressLabel);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth,13.0f));
    }];
    
    [_waterFertilizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_trimLabel);
        make.top.equalTo(self->_trimLabel.mas_bottom).offset(16.0f);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth*0.5f,13.0f));
    }];
    
    [_loadLiftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_trimLabel);
        make.top.equalTo(self->_waterFertilizerLabel);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth*0.5f,13.0f));
    }];
    
    [_roadWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_waterFertilizerLabel);
        make.top.equalTo(self->_waterFertilizerLabel.mas_bottom).offset(16.0f);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth,13.0f));
    }];
    
    [self _addLineViewWithTopView:self->_riskControlView];
    
}

/**
 备注视图
 */
- (void) _addRemarkView {
    
    UILabel *remarkLabel = [[UILabel alloc] init];
	remarkLabel.numberOfLines = 0;
	remarkLabel.font = [UIFont systemFontOfSize:13.0f];
    _remarkLabel = remarkLabel;
    [self addSubview:remarkLabel];
    [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_riskControlView.mas_bottom).offset(37.0f);
        make.left.right.equalTo(self->_riskControlView);
        make.bottom.equalTo(self.mas_bottom).offset(-34.0f);
    }];
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_offset(10.0f);
    }];
    
}

// 219 110
- (NSMutableArray<UIButton *> *)imageButtonArray {
    if (!_imageButtonArray) {
        _imageButtonArray = [NSMutableArray array];
    }
    return _imageButtonArray;
}
/**
  详情配图视图
 */
- (void) _addImagesContainerView {
    
    UIView *containerView = [[UIView alloc] init];
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(12.0f);
        make.left.equalTo(self.mas_left).offset(13.0f);
        make.size.mas_equalTo(CGSizeMake(self->_viewWidth,0.0f));
    }];
    for (int i = 0; i < 9; i++) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[containerView addSubview:button];
		button.tag = i + 100;
		[button addTarget:self action:@selector(tapImageView:) forControlEvents:UIControlEventTouchUpInside];
		[self.imageButtonArray addObject:button];
    }
	_imageViewContainer = containerView;

}

- (void)setDetailsModel:(MTSupplyDetailsModel *)detailsModel {
	_detailsModel = detailsModel;
	if (!_detailsModel) return;
	
	self.nicknameLabel.text = _detailsModel.userChildrenInfo.nickname;
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:_detailsModel.userChildrenInfo.heedImageUrl] placeholderImage:defalutHeadImage];
	self.timeLabel.text = _detailsModel.uploadtime;
	self.jobTitle.text = _detailsModel.userChildrenInfo.position;
	self.titleLabel.text = _detailsModel.varieties;
	self.priceLabel.text = [NSString stringWithFormat:@"%.1f/%@",_detailsModel.unitPrice,_detailsModel.unit];
	UILabel *companyNameLabel = (UILabel *)[self->_companyNameIconView viewWithTag:100];
	companyNameLabel.text = _detailsModel.companyName;
	UILabel *companyAddressLabel = (UILabel *)[self->_companyAddressIconView viewWithTag:100];
	companyAddressLabel.text = _detailsModel.companyAddress;
	UILabel *contactLabel = (UILabel *)[self->_contactIconView viewWithTag:100];
	contactLabel.text = [NSString stringWithFormat:@"%@  %@",_detailsModel.contacts,_detailsModel.contactsMobile];
	//基本信息
	NSString *specUnitString = [_detailsModel.spec isEqualToString:@""] ? @"" : [NSString stringWithFormat:@"%@cm %@",_detailsModel.spec,_detailsModel.specUnit];
	self->_specLabel.attributedText = [self attributedsWithHighlighted:specUnitString normalString:@"规格："];
	self->_numbersLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%zd %@",_detailsModel.number,_detailsModel.unit] normalString:@"数量："];
	self->_heightLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%zd/m-%zd/m",_detailsModel.heightE,_detailsModel.heightS] normalString:@"高度："];
	self->_crownWidthLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%zd/m-%zd/m",_detailsModel.crownWidthE,_detailsModel.crownWidthS] normalString:@"冠幅："];
	self->_branchPointLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%zd/m",_detailsModel.branchPoint] normalString:@"分支点："];
	self->_unitPriceLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%.1f元",_detailsModel.unitPrice] normalString:@"单价："];
	//苗木形态
	self->_plantThickLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.density] normalString:@"枝叶茂密程度："];
	self->_plantPoleLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.hasTrunk] normalString:@"有无明显主杆："];
	self->_plantTypeLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.type] normalString:@"种类："];
	self->_plantModelling.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.model] normalString:@"造型："];
	self->_plantCultivationType.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.culturalMethod] normalString:@"栽培方式："];
	//技术措施
	self->_soilBallDressLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.soilBallDress] normalString:@"土球起挖包扎技术及包扎材质："];
	self->_soilBallLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.soilBall] normalString:@"土球土质："];
	self->_culturalMethodLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.raiseMethod] normalString:@"培育方式："];
	self->_safeguardLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.safeguard] normalString:@"保护措施："];
	NSString *soilBallDress = [_detailsModel.soilBallDress isEqualToString:@""] ? @"" : [NSString stringWithFormat:@"%@cm",_detailsModel.soilBallSize];
	self->_soilBallSizeLabel.attributedText = [self attributedsWithHighlighted:soilBallDress normalString:@"直径："];
	NSString *soilThickness = [_detailsModel.soilThickness isEqualToString:@""] ? @"" : [NSString stringWithFormat:@"%@cm",_detailsModel.soilThickness];
	self->_soilThicknessLabel.attributedText = [self attributedsWithHighlighted:soilThickness normalString:@"厚度："];
	self->_soilBallShapeLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.soilBallShape] normalString:@"形状："];
	//风险控制
	self->_insectPestLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.insectPest] normalString:@"是否有病虫害："];
	self->_trimLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.trim] normalString:@"育苗期是否做过收支的修剪："];
	self->_waterFertilizerLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.waterFertilizer] normalString:@"水肥："];
	self->_loadLiftLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.loadLift] normalString:@"装车起吊、技术："];
	self->_roadWayLabel.attributedText = [self attributedsWithHighlighted:[NSString stringWithFormat:@"%@",_detailsModel.roadWay] normalString:@"苗圃运转方便程度："];
	//beizhu
	self->_remarkLabel.attributedText = [self attributedsWithHighlighted:_detailsModel.remark normalString:@"备注："];
	//tupian 
	for (int idx = 0; idx < 9; idx++) {
		UIButton *button = self.imageButtonArray[idx];
		if (idx < self->_detailsModel.imageArray.count) {
			NSString *imageURL = [NSString stringWithFormat:@"%@%@?x-oss-process=style/thumb_288_288",ConfigManager.ImageUrl,[_detailsModel.imageArray objectAtIndex:idx]];
			button.hidden = NO;
			button.frame = _detailsModel.imageButtonFrames[idx];
			[button sd_setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal placeholderImage:DefaultSquareImage];
		} else {
			button.hidden = YES;
		}
	}

	[self->_imageViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.headImageView.mas_bottom).offset(12.0f);
		make.left.equalTo(self.mas_left).offset(13.0f);
		make.size.mas_equalTo(CGSizeMake(self->_viewWidth,self->_detailsModel.imageContainerHeight));
	}];
	
}

- (NSAttributedString *) attributedsWithHighlighted:(NSString *)highlighted normalString:(NSString *)string {
	NSString *totalString = [NSString stringWithFormat:@"%@%@",string,highlighted];
	NSRange range = [totalString rangeOfString:@"："];
	NSMutableAttributedString *attributedsString = [[NSMutableAttributedString alloc] initWithString:totalString attributes:@{NSForegroundColorAttributeName : RGB(143.0f, 143.0f, 143.0f), NSFontAttributeName :sysFont(13.0f)}];
	if (range.location != NSNotFound) {
		NSUInteger loc = range.location+1;
		NSUInteger len = totalString.length - loc;
		[attributedsString setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1.0]} range:NSMakeRange(loc, len)];
	}
	return attributedsString;
}


#pragma mark

- (void)tapImageView:(UIButton *)button {
	SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
	browser.currentImageIndex = (int)button.tag-100;
	browser.sourceImagesContainerView = self->_imageViewContainer;
	browser.imageCount = self.detailsModel.imageArray.count;
	browser.delegate = self;
	[browser show];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
	UIButton *button = [self.imageButtonArray objectAtIndex:index];
	return button.currentImage;
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
	NSString *imageURL = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[_detailsModel.imageArray objectAtIndex:index]];
	return [NSURL URLWithString:imageURL];
}

//- (void)dealloc
//{
//	NSLog(@" MTSupplyDetailHeader  dealloc ");
//}

@end



