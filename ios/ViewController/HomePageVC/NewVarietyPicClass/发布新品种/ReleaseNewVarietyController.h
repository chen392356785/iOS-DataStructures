//
//  ReleaseNewVarietyController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/31.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

@interface ReleaseNewVarietyController : SMBaseViewController

@property (nonatomic,strong) UIImage *pic_imag;
@property (nonatomic,assign) BOOL isComeraDeviceRelease;        //YES 首页相机拍照上传

@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图
@end
