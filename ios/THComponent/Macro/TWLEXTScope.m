//
//  TWLEXTScope.m
//  SuperCarMan
//
//  Created by chiang on 16/3/2.
//  Copyright © 2016年 Toowell. All rights reserved.
//

#import "TWLEXTScope.h"

void mtl_executeCleanupBlock (__strong mtl_cleanupBlock_t *block) {
    (*block)();
}
