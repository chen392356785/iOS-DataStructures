//
//  MTHomeSectionTitleView.m
//  MiaoTuProject
//
//  Created by 苏浩楠 on 2017/6/19.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "MTHomeSectionTitleView.h"

//#import "Masonry.h"

@interface MTHomeSectionTitleView ()

/**背景View*/
@property (nonatomic,assign) UIView *bgView;
/**顶部分隔栏*/
@property (nonatomic,assign) UIView *topLineView;
/**标题文字*/
@property (nonatomic,assign) SMLabel *nameLab;
/**描述*/
@property (nonatomic,assign) SMLabel *detailLab;
/**左边图片*/
@property (nonatomic,assign) UIImageView *leftImgView;
/**右边图片*/
@property (nonatomic,assign) UIImageView *rightImgView;

/**右边Lable*/
@property (nonatomic,assign) UIImageView *MoreLab;

@end

@implementation MTHomeSectionTitleView


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        [ self createCustomUI2];
//        [self createCustomUI];  //V2.9.10前
    }
    
    return self;
}
- (void) createCustomUI2 {
    WS(weakSelf);
    //背景
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    //约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
        
    }];
    //左边图片
    UIImageView *leftImgView = [[UIImageView alloc] init];
    self.leftImgView = leftImgView;
    [bgView addSubview:leftImgView];
    [leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).offset(@(20));
        make.centerY.equalTo(weakSelf.bgView.mas_centerY).mas_offset(13);
        make.width.equalTo(@(5));
        make.height.equalTo(@(19));
    }];
//    leftImgView.backgroundColor = kColor(@"#57C9C8");
    
    UIImageView *moreLab = [[UIImageView alloc] init];
    self.MoreLab = moreLab;
    [bgView addSubview:moreLab];
    [moreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.leftImgView.mas_centerY);
        make.height.equalTo(@19);
        make.right.equalTo(weakSelf.mas_right).offset(@(-15));
        make.width.equalTo(@(23));
    }];
    moreLab.image = kImage(@"more_home_more");
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeMoreAction)];
    moreLab.userInteractionEnabled = YES;
    [moreLab addGestureRecognizer:tap];
    
    //名称
    SMLabel *nameLab = [[SMLabel alloc] init];
    self.nameLab = nameLab;
    nameLab.font = boldFont(17);
    nameLab.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.leftImgView.mas_centerY);
        make.height.equalTo(@19);
        make.left.equalTo(weakSelf.bgView.mas_left).offset(@(14));
        make.right.equalTo(moreLab.mas_left).offset(@(-10));
    }];
    
    
}
//首页更多模块
- (void) homeMoreAction {
    if (self.HomeMoreBlock) {
        self.HomeMoreBlock();
    }
}
#pragma mark --创建View-
- (void)createCustomUI {

    WS(weakSelf);
    //背景
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    //约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.right.top.bottom.equalTo(@0);
        
    }];
    
    //顶部分隔栏
    UIView *topLineView = [[UIView alloc] init];
    self.topLineView = topLineView;
    topLineView.backgroundColor = RGB(247, 248, 250);
    [bgView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.height.equalTo(@10);
        
    }];
    //名称
    SMLabel *nameLab = [[SMLabel alloc] init];
    self.nameLab = nameLab;
    nameLab.font = boldFont(17);
    nameLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(@12);
        make.height.equalTo(@22);
    }];
    //左边图片
    UIImageView *leftImgView = [[UIImageView alloc] init];
    self.leftImgView = leftImgView;
    leftImgView.image = Image(@"hp_tbleft.png");
    [bgView addSubview:leftImgView];
    [leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.nameLab.mas_left).offset(@(-10));
        make.centerY.equalTo(weakSelf.nameLab.mas_centerY);
        make.size.equalTo(leftImgView.image.size);
        
    }];
    //右边图片
    UIImageView *rightImgView = [[UIImageView alloc] init];
    self.rightImgView = rightImgView;
    rightImgView.image=Image(@"hp_tbright.png");
    [bgView addSubview:rightImgView];
    [rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.nameLab.mas_right).offset(@10);
        make.centerY.equalTo(weakSelf.nameLab.mas_centerY);
        make.size.equalTo(rightImgView.image.size);
    }];
    //描述
    SMLabel *detailLab = [[SMLabel alloc] init];
    self.detailLab = detailLab;
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.font = sysFont(14);
    detailLab.textColor = RGB(156, 157, 157);
    [bgView addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.nameLab.mas_bottom).offset(@5);
        make.centerX.equalTo(weakSelf.nameLab.mas_centerX);
        
    }];
    
    
    
}
#pragma mark --设置数据--
- (void)setDataDic:(NSDictionary *)dataDic {

    _dataDic = dataDic;
    
//    _MoreLab.text = @"更多";
    
    NSString *name = dataDic[@"title"];
    
    self.nameLab.text = name;
    
    NSString *detail = dataDic[@"detail"];
    
    self.detailLab.text = detail;

}


@end
