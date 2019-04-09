//
//  UIImage+Base64.m
//  DF
//
//  Created by Tata on 2017/11/21.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "UIImage+Base64.h"

@implementation UIImage (Base64)

- (NSString *)base64String {
    return [UIImagePNGRepresentation(self) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
