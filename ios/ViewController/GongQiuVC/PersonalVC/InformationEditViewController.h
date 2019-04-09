//
//  InformationEditViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/24.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "EditInformationDelegate.h"

@interface InformationEditViewController : SMBaseViewController
@property(nonatomic,strong)NSString *titl;
@property(nonatomic,strong)NSString *text;
@property (nonatomic, weak) id<EditInformationDelegate> delegate;
@property(nonatomic)EditBlock type;
@property(nonatomic)BOOL isLongString;
@property(nonatomic)BOOL isNumberKeybord;
@end
