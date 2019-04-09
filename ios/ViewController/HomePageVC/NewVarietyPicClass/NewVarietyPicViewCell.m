//
//  NewVarietyPicViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/30.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "NewVarietyPicViewCell.h"

@interface NewVarietyPicViewCell () {
    UIAsyncImageView *_ContImageView;
    UIView *backView;
    UILabel *PinZLabel;
    UILabel *GuiGLabel;
    UILabel *phoneLabel;
    UILabel *picLabel;
    
    UIImageView *imageView;//没有搜索内容时候默认的提示
    SMLabel *lbl;       //提示文字
}
@end

@implementation NewVarietyPicViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _ContImageView = [[UIAsyncImageView alloc] init];
        /* UIViewContentModeCenter */
        _ContImageView.contentMode = UIViewContentModeScaleAspectFill;
        _ContImageView.layer.cornerRadius = 5;
        [self addSubview:_ContImageView];
        
        backView = [[UIView alloc] init];
        [_ContImageView addSubview:backView];
        
        [self setlayoutSubviews];
    }
    return self;
}
- (void)setlayoutSubviews {
    [_ContImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.bottom.mas_equalTo(self);
    }];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self->_ContImageView);
		make.bottom.mas_equalTo(self->_ContImageView);
        make.height.mas_offset(kWidth(81));
    }];
    
    [self layoutIfNeeded];
    UIRectCorner rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight ;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:backView.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    backView.layer.mask = shapeLayer;
    backView.backgroundColor = [UIColor whiteColor];
    backView.alpha = 0.7;
    
    picLabel = [[UILabel alloc] init];
    [backView addSubview:picLabel];
    [picLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self->backView).mas_offset(kWidth(-8));
		make.top.mas_equalTo(self->backView).mas_offset(kWidth(6));
        make.height.mas_offset(kWidth(15));
		make.left.mas_equalTo(self->backView);
    }];
    picLabel.textColor = kColor(@"#f20b0b");
    picLabel.textAlignment = NSTextAlignmentRight;
    
    PinZLabel = [[UILabel alloc] init];
    [backView addSubview:PinZLabel];
    [PinZLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self->backView);
		make.top.mas_equalTo(self->picLabel.mas_bottom).mas_offset(kWidth(2));
        make.height.mas_offset(kWidth(15));
		make.left.mas_equalTo(self->backView).mas_offset(4);
    }];
    PinZLabel.textColor = kColor(@"#070707");
    
    
    GuiGLabel = [[UILabel alloc] init];
    [backView addSubview:GuiGLabel];
    [GuiGLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self->backView);
		make.top.mas_equalTo(self->PinZLabel.mas_bottom).mas_offset(kWidth(4));
        make.height.mas_offset(kWidth(15));
		make.left.mas_equalTo(self->PinZLabel);
    }];
    GuiGLabel.textColor = kColor(@"#070707");
    
    phoneLabel = [[UILabel alloc] init];
    [backView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self->backView);
		make.top.mas_equalTo(self->GuiGLabel.mas_bottom).mas_offset(kWidth(4));
        make.height.mas_offset(kWidth(15));
		make.left.mas_equalTo(self->PinZLabel);
    }];
    phoneLabel.textColor = kColor(@"#070707");
    
    
    UIImage *img=Image(@"kuku.png");
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    imageView.image=img;
    imageView.centerX=self.centerX;
//    imageView.centerY=self.centerY-10;
    [self addSubview:imageView];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+20, WindowWith, 17) textColor:cGrayLightColor textFont:sysFont(17)];
    lbl.centerX=imageView.centerX;
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.text = @"还没有人发布该品种哦";
    [self addSubview:lbl];
    
}
- (void)setConternImag:(nurseryNewDetailListModel *)picModel {
    imageView.hidden = YES;
    lbl.hidden = YES;
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",ConfigManager.ImageUrl,picModel.src_pic];
    [_ContImageView setImageAsyncWithURL:imageUrl placeholderImage:DefaultImage_logo];
    if (![picModel.loadingPrice isEqualToString:@""]) {
         picLabel.text = [NSString stringWithFormat:@"￥ %@",picModel.loadingPrice];
    }
    picLabel.font = sysFont(14);
    
    if (![picModel.plantTitle isEqualToString:@""]) {
        PinZLabel.text = [NSString stringWithFormat:@"品种: %@",picModel.plantTitle];
    }
    PinZLabel.font = sysFont(12);
    
    if (![picModel.remark isEqualToString:@""]) {
        GuiGLabel.text = [NSString stringWithFormat:@"规格: %@",picModel.remark];
    }
    GuiGLabel.font = sysFont(12);
    
    if (![picModel.mobile isEqualToString:@""]) {
        phoneLabel.text = [NSString stringWithFormat:@"联系方式: %@",picModel.mobile];
    }
    phoneLabel.font = sysFont(12);
}
- (void) setBackgNoContent {
    _ContImageView.hidden = YES;
    backView.hidden = YES;
    lbl.hidden = NO;
    imageView.hidden = NO;
}
@end
