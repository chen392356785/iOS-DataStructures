//
//  PayMentMangers.h
//  MiaoTuProjectTests
//
//  Created by Neely on 2018/4/27.
//

#import <Foundation/Foundation.h>
#import "SMBaseViewController.h"

typedef void (^PayMentMangersResultBlock)(BOOL isPaySuccess, NSString *msg);

@interface PayMentMangers : NSObject

+ (instancetype)manager;
/*
 活动支付
 */
- (void)payment:(NSString *)orderNo
        orderPrice:(NSString *)orderPrice
           type:(NSString *)type
        subject:(NSString *)subject
activitieID:(NSString *)activitie_id
       parentVC:(SMBaseViewController *)parentVC
    resultBlock:(PayMentMangersResultBlock)resultBlock;

/*
 众筹支付
 */
- (void)payment:(NSString *)orderNo
     orderPrice:(NSString *)orderPrice
           type:(NSString *)type
        subject:(NSString *)subject
         crowID:(NSString *)crowID
activitieID:(NSString *)activitie_id
       parentVC:(SMBaseViewController *)parentVC
    resultBlock:(PayMentMangersResultBlock)resultBlock;


/**
 课堂生成订单
 @param dict <#dict description#>
 @param type 支付方式  0 - 免费不弹出支付方式选择
 @param parentVC <#parentVC description#>
 @param resultBlock <#resultBlock description#>
 */
- (void)saveClassSourceOrder:(NSDictionary *)dict playType:(NSString *)type parentVC:(SMBaseViewController *)parentVC
                 resultBlock:(PayMentMangersResultBlock)resultBlock;

//加入VIP
- (void)saveJoinVipOrder:(NSDictionary *)dict playType:(NSString *)type parentVC:(SMBaseViewController *)parentVC
                 resultBlock:(PayMentMangersResultBlock)resultBlock;
    
@end
