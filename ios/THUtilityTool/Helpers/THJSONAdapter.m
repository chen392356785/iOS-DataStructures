//
//  THJSONAdapter.m
//  Owner
//
//  Created by Neely on 2018/3/26.
//

#import "THJSONAdapter.h"
//#import "MJExtension.h"

@implementation THJSONAdapter

+ (NSMutableArray *)listWithClass:(Class)aClass jsonArray:(NSArray *)jsonArray{
    
    if ([jsonArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *list = @[].mutableCopy;
        for (NSDictionary *dictinoary in jsonArray) {
            NSObject *obj = [[aClass alloc] init];
            [obj mj_setKeyValues:dictinoary];
            [list addObject:obj];
        }
        return list;
    }
    return @[].mutableCopy;
}

+ (id)modelOfClass:(Class)aClass jsonDictionary:(NSDictionary *)dictinary{
    
    if ([dictinary isKindOfClass:[NSDictionary class]]) {
        NSObject *obj = [[aClass alloc] init];
        [obj mj_setKeyValues:dictinary];
        return obj;
    }
    return nil;
    
}

@end
