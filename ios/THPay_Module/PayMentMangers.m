//
//  PayMentMangers.m
//  MiaoTuProjectTests
//
//  Created by Neely on 2018/4/27.
//

#import "PayMentMangers.h"
#import "XMPaySchemeService.h"
#import "PayTypeConstants.h"
#import "PayMentModel.h"
//#import "THJSONAdapter.h"
#import "JSONUtility.h"
#import "NSString+AES.h"

@interface PayMentMangers ()
    
@property (nonatomic, copy) PayMentMangersResultBlock resultBlock;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, assign) long long orderId;
    
@end


@implementation PayMentMangers

+ (instancetype)manager {
    static PayMentMangers *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
//活动
- (void)payment:(NSString *)orderNo
     orderPrice:(NSString *)orderPrice
           type:(NSString *)type
        subject:(NSString *)subject
        activitieID:(NSString *)activitie_id
       parentVC:(SMBaseViewController *)parentVC
    resultBlock:(PayMentMangersResultBlock)resultBlock;
{
    self.resultBlock = resultBlock;
    self.orderNo = orderNo;
    /**
    *  @brief 支付宝和微信支付需走渠道号
    */
    
    [self aliPayAndweChatPayment:orderNo orderPrice:orderPrice type:type crowID:nil  subject:subject activitieID:activitie_id parentVC:parentVC];
    
}
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
    resultBlock:(PayMentMangersResultBlock)resultBlock
{
    self.resultBlock = resultBlock;
    self.orderNo = orderNo;
    /**
     *  @brief 支付宝和微信支付需走渠道号
     */
    [self aliPayAndweChatPayment:orderNo orderPrice:orderPrice type:type crowID:crowID subject:subject activitieID:activitie_id parentVC:parentVC];
}
//课堂生成订单接口
- (void)saveClassSourceOrder:(NSDictionary *)dict playType:(NSString *)type parentVC:(SMBaseViewController *)parentVC
                 resultBlock:(PayMentMangersResultBlock)resultBlock {
    self.resultBlock = resultBlock;
    [self aliPayAndweChatPayment:dict andPlayType:type parentVC:parentVC];
}

//加入VIP
- (void)saveJoinVipOrder:(NSDictionary *)dict playType:(NSString *)type parentVC:(SMBaseViewController *)parentVC
             resultBlock:(PayMentMangersResultBlock)resultBlock{
    
    self.resultBlock = resultBlock;
    THWeak(parentVC);
    [parentVC addWaitingView];
	
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
	NSString *DataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *data = [DataStr aci_encryptWithAES];
    NSDictionary *dict1 = @{@"data" : data};
    
    [network orderPayParameter:dict1 method:JoinVipOrderUrl playType:type success:^(NSDictionary *obj) {
        THStrong(parentVC);
        [parentVC removeWaitingView];
        if ([type isEqualToString:@"0"]) {
            if (self.resultBlock) {
                self.resultBlock(YES, obj[@"content"]);
                self.resultBlock = nil;
            }
            return ;
        }
		PayMentModel *model = [PayMentModel new];
		model.code = [[obj objectForKey:@"code"] intValue];
		model.data = [obj objectForKey:@"data"];
		model.type = [[obj objectForKey:@"type"] intValue];
		model.msg = [obj objectForKey:@"msg"];
		[self choosePayType:type json:model];
    } failure:^(NSDictionary *obj2) {
		THStrong(parentVC);
		[parentVC showHint:@"网络错误"];
		[parentVC removeWaitingView];
    }];
    
}
/**
*  @brief 微信和支付宝支付渠道
*
*  @param parentVC <#parentVC description#>
*/
-(void)aliPayAndweChatPayment:(NSString *)orderNo
                   orderPrice:(NSString *)orderPrice
                         type:(NSString *)type
                       crowID:(NSString *)crowID
                      subject:(NSString *)subject
                    activitieID:(NSString *)activitie_id
                     parentVC:(SMBaseViewController *)parentVC{
    
    THWeak(parentVC);
    [parentVC addWaitingView];
    [network orderPay:orderNo orderPrice:orderPrice subject:subject type:type crowID:crowID  activitieID:activitie_id success:^(NSDictionary *obj) {
        THStrong(parentVC);
        [parentVC removeWaitingView];
		PayMentModel *model = [PayMentModel new];
		model.code = [[obj objectForKey:@"code"] intValue];
		model.data = [obj objectForKey:@"data"];
		model.type = [[obj objectForKey:@"type"] intValue];
		model.msg = [obj objectForKey:@"msg"];
		[self choosePayType:type json:model];

    } failure:^(NSDictionary *obj2) {
        THStrong(parentVC);
        [parentVC showHint:@"网络错误"];
        [parentVC removeWaitingView];
    }];
    
}
//课堂生成订单接口
-(void)aliPayAndweChatPayment:(NSDictionary *)dict andPlayType:(NSString *)type
                     parentVC:(SMBaseViewController *)parentVC{
    THWeak(parentVC);
    [parentVC addWaitingView];
    
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
    NSString *DataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *data = [DataStr aci_encryptWithAES];
    NSDictionary *dict1 = @{@"data" : data};
    
    [network orderPayParameter:dict1 method:newsubmitClassSourceUrl playType:type success:^(NSDictionary *obj) {
        THStrong(parentVC);
        [parentVC removeWaitingView];
        if ([type isEqualToString:@"0"]) {
            if (self.resultBlock) {
                self.resultBlock(YES, obj[@"content"]);
                self.resultBlock = nil;
            }
            return ;
        }
		PayMentModel *model = [PayMentModel new];
		model.code = [[obj objectForKey:@"code"] intValue];
		model.data = [obj objectForKey:@"data"];
		model.type = [[obj objectForKey:@"type"] intValue];
		model.msg = [obj objectForKey:@"msg"];
        [self choosePayType:type json:model];
    } failure:^(NSDictionary *obj2) {
        THStrong(parentVC);
        [parentVC showHint:@"网络错误"];
        [parentVC removeWaitingView];
    }];
}
- (void)choosePayType:(NSString *)type json:(PayMentModel *)baseJson
{
    
    if (baseJson.code != CC_IRETURNCODE_OK) {
        [self thirdPaidFailHandler:nil];
        return;
    }

    // 支付宝支付
    if ([type integerValue] == AlIPAY_TYPE) {

        [XMPaySchemeService alipayWithOrderString:[baseJson.data aci_decryptWithAES]
                                      resultBlock:^(BOOL isPaySuccess, NSString *errMsg) {
                                          if (self.resultBlock) {
                                              self.resultBlock(isPaySuccess, errMsg);
                                              self.resultBlock = nil;
                                          }
                                      }];
    } else if ([type integerValue] == WEICHAT_TYPE) { // 微信支付
        if (![WXApi isWXAppInstalled]) {
            [UIAlertView alertViewWithTitle:@"提示"
                                    message:@"未安装微信客户端，重新选择支付方式"
                          cancelButtonTitle:@"确认"];
            return;
        }
        NSString *dataStr = [baseJson.data aci_decryptWithAES];
        NSDictionary *dict = [dataStr jsonObject];
        [XMPaySchemeService weichatPayWithPrepayData:dict
                                         resultBlock:^(BOOL isPaySuccess, NSString *errMsg) {
                                             if (self.resultBlock) {
                                                 self.resultBlock(isPaySuccess, errMsg);
                                                 self.resultBlock = nil;
                                             }
                                         }];
        
    }
}

    
- (void)thirdPaidFailHandler:(NSString *)errMsg
{
    NSString *errTip = errMsg ?: @"支付异常，请重试！";
    [UIAlertView alertViewWithTitle:@"支付失败" message:errTip cancelButtonTitle:@"确认"];
}

    
@end
