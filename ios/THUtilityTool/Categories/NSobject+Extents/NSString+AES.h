//
//  NSString+AES.h
//  MiaoTuProjectTests
//
//  Created by Neely on 2018/4/28.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

    /**< 加密方法 */
- (NSString*)aci_encryptWithAES;
    
    /**< 解密方法 */
- (NSString*)aci_decryptWithAES;
    

@end
