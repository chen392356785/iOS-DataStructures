//
//  MeMainViewController.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

/**我的界面*/
#import "SMBaseViewController.h"

@interface MeMainViewController : SMBaseViewController
{
    MTTopView *_topView;
}

@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图

@end
