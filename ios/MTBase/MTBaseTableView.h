//
//  MTBaseTableView.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IHBaseTableView.h"

@interface MTBaseTableView : IHBaseTableView
@property(nonatomic)ContactType type2;
@property(nonatomic)CollecgtionType type;
@property(nonatomic)PersonType personType;
@property(nonatomic)buyType buyType;
@property(nonatomic,assign)NSInteger i;//用来判断是否有未回复消息
@property(nonatomic,assign)MyJobType Mytype;
@property (nonatomic,strong)NSString *actvType;
-(void)setupData:(NSArray *)data index:(int)index;
@property(nonatomic)BOOL isMe;
@end
