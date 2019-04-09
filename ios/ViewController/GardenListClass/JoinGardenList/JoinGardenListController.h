//
//  JoinGardenListController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

typedef void (^inPutblock)(NSString *inputResult);

@interface JoinGardenListController : SMBaseViewController

@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图

@property (nonatomic, copy) NSString *successImg;    //加入成功弹框背景图片地址
@property (nonatomic, copy) NSString *titleStr;     //title
@end



@interface JoinGardenListCell : UITableViewCell

@property (nonatomic, copy) inPutblock inputBlock;

@property (nonatomic, strong) IHTextField *textField;
@property (nonatomic, strong) UILabel *lineLabel;
@end
