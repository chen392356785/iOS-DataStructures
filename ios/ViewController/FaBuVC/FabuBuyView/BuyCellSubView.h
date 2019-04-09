//
//  BuyCellSubView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuyCellSubView.h"
#import "FabuBuyModel.h"

typedef void (^DidSelectCellBlock) (UILabel *lab);

@interface BuyCellSubView : UIView <UITableViewDelegate,UITableViewDataSource> {
    NSArray *_infoArr;
    NSArray *_xingTaiArr;
    NSArray *_technicalArr;
    NSArray *_riskControloArr;
    NSArray *_headTitleArr;
}
@property (nonatomic, copy) DidSelectCellBlock selectGuigeBlock;
@property (nonatomic, copy) DidSelectCellBlock selectCompanyNameBlock;
@property (nonatomic, copy) DidSelectCellBlock selectMoneyBlock;

@property (nonatomic, copy) DidSelectCellBlock selectPinZBlock;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) FabuBuyModel *fabumodel;      //

@property (nonatomic, copy) DidSelectBlock commmitselectBlock;

@end


