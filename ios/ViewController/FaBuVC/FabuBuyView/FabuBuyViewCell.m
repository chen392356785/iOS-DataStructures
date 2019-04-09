//
//  FabuBuyViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "FabuBuyViewCell.h"

#import "BuyCellSubView.h"

@interface FabuBuyViewCell () {
    FabuBuyModel *model;
}

@end

@implementation FabuBuyViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        model = [[FabuBuyModel alloc] init];
    }
    return self;
}

//- (void)layoutSubviews {
//	[super layoutSubviews];
//}

- (void) createView {
    _scroll = [[UIScrollView alloc] init];
    [self.contentView addSubview:_scroll];
    marr = [[NSMutableArray alloc] init];
    _scroll.delegate = self;
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
    _scroll.contentSize = CGSizeMake(iPhoneWidth*MTbuyViewTypeCount, 0);
    _scroll.pagingEnabled = YES;
    _scroll.backgroundColor = kColor(@"#FBFBFB");
    _scroll.showsHorizontalScrollIndicator = NO;
    [self addScrollSubViews];
}

- (void)addScrollSubViews {
    [_scroll removeAllSubviews];
    WS(weakSelf);
    [_scroll setNeedsLayout];
    for (int i = 0; i < MTbuyViewTypeCount; i ++) {
        BuyCellSubView *subView = [[BuyCellSubView alloc] init];
        subView.selectGuigeBlock = ^(UILabel *lab) {
            self.selectGuigeBlock(lab);
        };
        subView.selectMoneyBlock = ^(UILabel *lab) {
            self.selectMoneyBlock(lab);
        };
        subView.selectCompanyNameBlock = ^(UILabel *lab) {
            self.selectCompanyNameBlock(lab);
        };
        subView.selectPinZBlock = ^(UILabel *lab) {
            self.selectPinZhongBlock(lab);
        };
        subView.tag = i;
        subView.index = i;
        subView.fabumodel = [[FabuBuyModel alloc] init];
        [marr addObject:subView.fabumodel];
//        subView.scrollSubView = _scroll;
        subView.commmitselectBlock = ^{
            [weakSelf commitData];
        };
        [_scroll addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.offset(iPhoneWidth);
            make.left.offset((i*iPhoneWidth));
        }];
    }

}
- (void) commitData {
    for (int i = 0; i < MTbuyViewTypeCount; i ++) {
       FabuBuyModel *tempModel = marr[i];
        if (i == 0) {
            if (tempModel.height == nil || tempModel.height.length < 1) {
                [IHUtility addSucessView:@"请输入高度" type:2];
                return;
            }
            if (tempModel.crownWidth == nil || tempModel.crownWidth.length < 1) {
                [IHUtility addSucessView:@"请输入冠幅" type:2];
                return;
            }
            if (tempModel.windPoint == nil || tempModel.windPoint.length < 1) {
                [IHUtility addSucessView:@"请输入分支点" type:2];
                return;
            }
            model.height = tempModel.height;
            model.crownWidth = tempModel.crownWidth;
            model.windPoint = tempModel.windPoint;
            model.number = tempModel.number;
            model.raiseMethod = tempModel.raiseMethod;
            model.unit = tempModel.unit;
            
        }else if (i == 1){
            model.density = tempModel.density;
            model.hasTrunk = tempModel.hasTrunk;
            model.type = tempModel.type;
            model.model = tempModel.model;
            model.culturalMethod = tempModel.culturalMethod;
        }else if (i == 2){
            model.soilBallDress = tempModel.soilBallDress;
            model.soilBall = tempModel.soilBall;
            model.safeguard = tempModel.safeguard;
            model.soilBallSize = tempModel.soilBallSize;
            model.soilThickness = tempModel.soilThickness;
            model.soilBallShape = tempModel.soilBallShape;
        }else if (i == 3){
            model.insectPest = tempModel.insectPest;
            model.trim = tempModel.trim;
            model.waterFertilizer = tempModel.waterFertilizer;
            model.loadLift = tempModel.loadLift;
            model.roadWay = tempModel.roadWay;
        }
    }
    if (self.selectcommitModelBlock) {
        self.selectcommitModelBlock(model);
    }
//    NSLog(@"subbiewModel = %@",model);
}
- (void)setScrollViewContOffX:(NSInteger)index {
    [UIView animateWithDuration:0.3 animations:^{
		self->_scroll.contentOffset = CGPointMake(index * iPhoneWidth, 0);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger current = scrollView.contentOffset.x / iPhoneWidth;
    if (self.ContOffXBlock) {
        self.ContOffXBlock(current);
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
        
    } else {
        return YES;
        
    }
}



@end
