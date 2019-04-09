//
//  JSONUtility.h
//  SuperCarMan
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)
/*!
 *  @author Zhang Jianwei, 16-04-25 17:04:55
 *
 *  JSON 字符串转JSONObject
 *
 *  @return
 */
- (id)jsonObject;

/*!
 *  @author Zhang Jianwei, 16-04-25 17:04:27
 *
 *  格式化JSON字符串，控制台输出美观
 *
 *  @return <#return value description#>
 */
- (NSString *)formatedJSONString;


@end

@interface NSDictionary (JSON)

/*!
 *  @author Zhang Jianwei, 16-04-25 17:04:52
 *
 *  JSONobject 转JSON字符串
 *
 *  @return <#return value description#>
 */
- (NSString*)jsonString;

@end

@interface NSArray (JSON)

/*NSArray JSON 字符串*/
- (NSString *)jsonString;

@end
