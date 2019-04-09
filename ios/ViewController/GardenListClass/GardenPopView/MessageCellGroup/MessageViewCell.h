//
//  MessageViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/3.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GardenModel.h"



@interface MessageViewCell : UITableViewCell

@property (nonatomic, copy)void(^TapTextBlock)(UILabel *desLabel);

@property (nonatomic, strong) GardenCommentListModel *model;
@property (nonatomic, strong) UILabel *lineLab;

@property (nonatomic, copy) DidSelectBlock deleBlock;
@property (nonatomic, copy) DidSelectBlock huifuBlock;
@property (nonatomic, copy) DidSelectBlock jubaoBlock;
@property (nonatomic, copy) DidSelectBtnBlock huifuOhterBlock;
@end
