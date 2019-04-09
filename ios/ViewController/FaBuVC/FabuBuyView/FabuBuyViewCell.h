//
//  FabuBuyViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FabuBuyModel.h"

typedef void (^DidSelectlabBlock) (UILabel *lab);

typedef void (^DidSelectModelBlock) (FabuBuyModel *model);

typedef NS_ENUM(NSInteger , buyViewType) {
    MTInformation =0,            //基本信息
    MTMorphology,                //苗木形态
    MTTechnicalMeasures,         //技术措施
    MTRiskControl,               //风险控制
    MTbuyViewTypeCount,          //个数
};

@interface FabuBuyViewCell : UITableViewCell <UIScrollViewDelegate>{
    UIScrollView *_scroll;
    NSMutableArray *marr;
}

@property (nonatomic, copy) DidSelectBtnBlock ContOffXBlock;
@property (nonatomic, copy) DidSelectlabBlock selectGuigeBlock;
@property (nonatomic, copy) DidSelectlabBlock selectCompanyNameBlock;

@property (nonatomic, copy) DidSelectlabBlock selectMoneyBlock;

@property (nonatomic, copy) DidSelectlabBlock selectPinZhongBlock;

@property (nonatomic, copy) DidSelectModelBlock selectcommitModelBlock;
- (void) setScrollViewContOffX:(NSInteger ) index;

@end

