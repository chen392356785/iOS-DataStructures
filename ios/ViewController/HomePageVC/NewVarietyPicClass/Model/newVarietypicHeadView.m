//
//  newVarietypicHeadView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/30.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "newVarietypicHeadView.h"

@interface newVarietypicHeadView () {
    UILabel *titlLabel;
    UILabel *moreLabel;
    UIAsyncImageView *_ContImageView;
    NewVarietyPicModel *_model;
    UIAsyncImageView *moreImgeV;
    UITapGestureRecognizer *tap;    //点击手势
}
@end

@implementation newVarietypicHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        titlLabel = [[UILabel alloc] init];
        [self addSubview:titlLabel];
        
        _ContImageView = [[UIAsyncImageView alloc] init];
        [self addSubview:_ContImageView];
        
        moreLabel = [[UILabel alloc] init];
        [self addSubview:moreLabel];
        
        [self createlayoutSubviews];
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)createlayoutSubviews {
    
    [_ContImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(12);
        make.width.mas_offset(22);
        make.height.mas_offset(22);
    }];
    
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->_ContImageView);
		make.left.mas_equalTo(self->_ContImageView.mas_right).mas_offset(2);
        make.height.mas_offset(22);
        make.width.mas_offset(200);
    }];
    titlLabel.font = sysFont(15);
    
    moreImgeV =  [[UIAsyncImageView alloc] init];
    [self addSubview:moreImgeV];
    moreImgeV.contentMode = UIViewContentModeScaleToFill;
    [moreImgeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-12);
        make.height.mas_offset(15);
        make.width.mas_offset(7);
		make.centerY.mas_equalTo(self->_ContImageView);
    }];
    moreImgeV.image = Image(@"icon_shouqi");
    
    [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->_ContImageView);
		make.right.mas_equalTo(self->moreImgeV.mas_left).mas_offset(-2);
        make.height.mas_offset(22);
        make.width.mas_offset(72);
    }];
    moreLabel.font = sysFont(15);
    moreLabel.textColor = kColor(@"#515151");
   
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = cLineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-1);
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(1);
    }];
}
- (void)setHeadViewNewVarietyPicModel:(NewVarietyPicModel *)model {
    _model = model;
    moreLabel.text = @"查看更多";
    titlLabel.text = model.nurseryTypeName;
    if (model.nurseryNewDetailList.count == 0) {
        moreLabel.hidden = YES;
    }else {
        moreLabel.hidden = NO;
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",ConfigManager.ImageUrl,model.nurseryImage];
    [_ContImageView setImageAsyncWithURL:imageUrl placeholderImage:DefaultImage_logo];
    
}
- (void) moreAction {
    self.moreBlock();
}
- (void) setHiddenChickMore {
    moreLabel.hidden = YES;
    moreImgeV.hidden = YES;
    [self removeGestureRecognizer:tap];
}
@end
