//
//  AdvantageViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 14/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol advantageBackDelegate <NSObject>

- (void)disPalyAdvantageContent:(NSString *)content;

@end

@interface AdvantageViewController : SMBaseCustomViewController
@property (nonatomic,strong)SMLabel *lbl;
@property (nonatomic,strong) id<advantageBackDelegate>delegate;
@property (nonatomic,copy) NSString *content;
@end
