//
//  THJSONAdapter.h
//  Owner
//
//  Created by Neely on 2018/3/26.
//

#import <Foundation/Foundation.h>

@interface THJSONAdapter : NSObject

/*
 return NSMutableArray
 */
+ (NSMutableArray *)listWithClass:(Class)aClass jsonArray:(NSArray *)jsonArray;

/*
 return id
 */
+ (id)modelOfClass:(Class)aClass jsonDictionary:(NSDictionary *)dictinary;

@end
