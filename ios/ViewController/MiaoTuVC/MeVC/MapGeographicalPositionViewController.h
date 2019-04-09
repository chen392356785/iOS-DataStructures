//
//  MapGeographicalPositionViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/29.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "EditInformationDelegate.h"
@interface MapGeographicalPositionViewController : SMBaseCustomViewController
@property (nonatomic, weak) id<EditInformationDelegate> delegate;
@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)DidSelectPilotBlock selectPilotBlock;
@property(nonatomic,strong)DidSelectJobAdressBlock selectAdressBlock;
@property(nonatomic)BtnType type;
@end
