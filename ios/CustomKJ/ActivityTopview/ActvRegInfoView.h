//
//  ActvRegInfoView.h
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActvRegInfoView : UIView
{
    SMLabel *_nameLabel;
    SMLabel *_phoneLbl;
    SMLabel *_companyLbl;
    SMLabel *_jobLbl;
    UIView *_lineView;

}

//立即报名页面YES 支付页面NO
- (id)initWithFrame:(CGRect)frame;

- (void)setdata:(NSString *)people phone:(NSString *)phone company:(NSString *)company jobStr:(NSString *)jobStr;

@end
