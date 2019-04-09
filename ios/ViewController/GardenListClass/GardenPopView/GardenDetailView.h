//
//  GardenDetailView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/23.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GardenModel.h"

typedef void (^DidSkrBackBut) ();
typedef void (^CancelButBut) ();
typedef void (^CallPhoneButBut) ();
typedef void (^ShareButBut) ();

@interface GardenDetailView : UIView

//- (void)setYuanbangModel:(yuanbangModel *)yuanbangModel andPicUrl:(NSString *)picUrl;

//刷新
- (void) upSubViewDataModel:(yuanbangModel *)yuanbangModel;

@property(nonatomic,copy) DidSkrBackBut SkrBlock;
@property(nonatomic,copy) CancelButBut CancelBlock;
@property(nonatomic,copy) CallPhoneButBut PhoneActionBlock;
@property(nonatomic,copy) ShareButBut ShareActionBlock;
@end
