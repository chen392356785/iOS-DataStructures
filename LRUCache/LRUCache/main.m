//
//  main.m
//  LRUCache
//
//  Created by dzb on 2019/3/18.
//  Copyright © 2019年 大兵布莱恩特. All rights reserved.
//

#import "Person.h"
#include "LRUCache.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        LRUCache *cache = [LRUCache shareCache];
        cache.countLimit = 2;
        {
            Person *p1 = [[Person alloc] initWithName:@"dzb"];
            Person *p2 = [[Person alloc] initWithName:@"aaa"];
            //Person *p3 = [[Person alloc] initWithName:@"ccc"];
            
            [cache setObject:p1 forKey:@"dzb"];
            [cache setObject:p2 forKey:@"aaa"];
            
        }
        
//        [cache removeAllObjects];
        [cache setObject:[[Person alloc] initWithName:@"dzb"] forKey:@"ccc"];
        NSLog(@"%lu",(unsigned long)cache.totalCount);
        [cache removeAllObjects];
        NSLog(@"%lu",(unsigned long)cache.totalCount);

    }
    
    while (1) {
        
        usleep(1000.0f);
    }
    
    
    return 0;
}
