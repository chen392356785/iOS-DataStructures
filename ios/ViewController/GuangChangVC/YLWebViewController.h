//
//  YLWebViewController.h
//  YouLookGood
//
//  Created by Mac on 15/6/3.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
 
@interface YLWebViewController : SMBaseViewController
{
    BOOL isFinish;
}
@property(nonatomic)BOOL isLeft;
@property(nonatomic)int type;  //1 网页解析
@property(strong,nonatomic)NSURL * mUrl;
@property(nonatomic,strong)NSString *NameTitle;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,assign)NSUInteger i;//是否园林资讯
@end
