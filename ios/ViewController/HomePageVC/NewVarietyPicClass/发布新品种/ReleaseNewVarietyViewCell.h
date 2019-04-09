//
//  ReleaseNewVarietyViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/31.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseNewVarietyViewCell : UITableViewCell

@property (nonatomic, strong) IHTextField *textField;
@property (nonatomic, strong) UILabel *lineLabel;
@end



@interface ReleaseNewVarietyTypeCell : UITableViewCell

- (void) setTitle:(NSString *)title andImageStr:(NSString *)imgStr;

@end
