//
//  TTFunctions.m
//  TTUtility
//
//  Created by shine_tata on 16/9/18.
//  Copyright © 2016年 shine_tata. All rights reserved.
//

#import "TTFunctions.h"

#pragma mark - 基本数据类型

NSString * TTValidateString(id object) {
    if (!object) {
        return nil;
    }
    if (![object isKindOfClass:[NSString class]]) {
        return nil;
    }
    return object;
}

NSInteger TTValidateInteger(id object) {
    if (!object) {
        return 0;
    }
    if (![object respondsToSelector:@selector(integerValue)]) {
        return 0;
    }
    return [(NSString *)object integerValue];
}

NSDictionary * TTValidateDictionary(id object) {
    if (!object) {
        return nil;
    }
    if (![object isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return object;
}

NSArray * TTValidateArray(id object) {
    if (!object) {
        return nil;
    }
    if (![object isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return object;
}

CGFloat TTValidateFloat(id object) {
    if (!object) {
        return 0;
    }
    if (![object respondsToSelector:@selector(floatValue)]) {
        return 0;
    }
    return [(NSString *)object floatValue];
}

BOOL TTValidateBOOL(id object) {
    if (!object) {
        return NO;
    }
    if (![object respondsToSelector:@selector(boolValue)]) {
        return NO;
    }
    return [(NSString *)object boolValue];
}

#pragma mark - 多线程处理

void TTDispatchMainSync(TTDispatchBlock block) {
    if (!block) {
        return;
    }
    if ([NSThread isMainThread]) {
        block();
    }else{
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void TTDispatchMainAsync(TTDispatchBlock block) {
    if (!block) {
        return;
    }
    if ([NSThread isMainThread]) {
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void TTDispatchSync(TTDispatchBlock block) {
    if (!block) {
        return;
    }
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

void TTDispatchAsync(TTDispatchBlock block) {
    if (!block) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

void TTDispatchDelay(CGFloat seconds, TTDispatchBlock block) {
    if (!block) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

#pragma mark - 屏幕适配

CGFloat TTUIScale() {
    static CGFloat scale = 0.0;
    if (fabs(scale) < 1e-6) {
        // based on iPhone 6
        CGSize designSize = CGSizeMake(375, 667);
        CGSize currentSize = [UIScreen mainScreen].bounds.size;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // iPad使用缩放模式，调整系数
            if (currentSize.width / 320.0 > 3) {
                // ipad pro
                currentSize = CGSizeMake(375, 667);
            } else {
                currentSize = CGSizeMake(320, 480);
            }
        }
        
        scale = (currentSize.width / designSize.width + currentSize.height / designSize.height) / 2;
    }
    return scale;
}

CGFloat TTUIRatio() {
    static CGFloat ratio = 0.0;
    if (fabs(ratio) < 1e-6) {
        // based on iPhone 5
        CGSize baseSize = CGSizeMake(320, 568);
        CGSize currentSize = [UIScreen mainScreen].bounds.size;
        
        CGFloat baseRatio = baseSize.height / baseSize.width;
        CGFloat currentRatio = currentSize.height / currentSize.width;
        ratio = baseRatio - currentRatio;
    }
    return ratio;
}

#pragma mark - 可读时间

NSString * TTDateRecentlyString() {
    return @"刚刚";
}

NSString * TTDateSecondBeforeString(NSInteger second) {
    return [NSString stringWithFormat:@"%ld秒前", (long)second];
}

NSString * TTDateMinuteBeforeString(NSInteger minute) {
    return [NSString stringWithFormat:@"%ld分钟前", (long)minute];
}

NSString * TTDateHalfHourBeforeString() {
    return @"半小时前";
}

NSString * TTDateTodayString() {
    return @"今天";
}

NSString * TTDateYestodayString() {
    return @"昨天";
}

NSString * TTDateDayBeforeYestodayString() {
    return @"前天";
}

#pragma mark - APP版本号

NSString * TTAppVersion() {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

NSString * TTAppDetailedVersion() {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *resultString = [NSString stringWithFormat:@"%@(%@)", appVersion, appBuild];
    return resultString;
}


#pragma mark - 判断分享类型
//*/HYFX
NSString * TTSelectShareType(NSInteger index) {
//    NSDictionary *info = @{@(TTShareTypeWechat) : UMShareToWechatSession,
//                           @(TTShareTypeWechatTimeline) : UMShareToWechatTimeline,
//                           @(TTShareTypeQQ) : UMShareToQQ,
//                           @(TTShareTypeQzone) : UMShareToQzone,
//                           @(TTShareTypeSina) : UMShareToSina };
//    NSString *shareType = info[@(index)];
    NSString *shareType = @"";
    return shareType;
}
//*/
#pragma mark - Color Convertion

UIColor * TTColorWithString(NSString *string) {
    NSString *colorString = string;
    if (string.length == 0) {
        return nil;
    }
    
    // check convenience color, such as whiteColor, blackColor, etc
    NSString *selectorString = [NSString stringWithFormat:@"%@Color", string];
    SEL selector = NSSelectorFromString(selectorString);
    if ([[UIColor class] respondsToSelector:selector]) {
        // 以做是否响应selector的判断，忽略警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [[UIColor class] performSelector:selector];
#pragma clang diagnostic pop
    }
    
    if (string.length == 6) {
        // no alpha
        colorString = [string stringByAppendingString:@"ff"];
    }
    
    if (colorString.length != 8) {
        // 无法解析的字串
        return nil;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    unsigned int hexNumber = 0;
    BOOL success = [scanner scanHexInt:&hexNumber];
    
    UIColor *color = nil;
    if (success) {
        int alpha = hexNumber & 0x000000ff;
        int blue = (hexNumber >> 8) & 0x000000ff;
        int green = (hexNumber >> 16) & 0x000000ff;
        int red = (hexNumber >> 24) & 0x000000ff;
        
        color = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha / 255.0];
    } else {
        NSLog(@"Invalid color parameter");
    }
    
    return color;
}

NSString * TTStringWithColor(UIColor *color) {
    CGFloat red, green, blue, alpha;
    
    UIColor *theColor = color;
    
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
    // 在mac下，如whiteColor等生成的color对象是在NSCalibratedWhiteColorSpace颜色空间，
    // 读取rgb值会出错，需要转换到NSDeviceRGBColorSpace颜色空间
    theColor = [theColor colorUsingColorSpaceName:NSDeviceRGBColorSpace];
#endif
    
    [theColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    red *= 255.0;
    green *= 255.0;
    blue *= 255.0;
    alpha *= 255.0;
    
    int value = alpha;
    // +0.5以四舍五入
    value += (int)(blue + 0.5) << 8;
    value += (int)(green + 0.5) << 16;
    value += (int)(red + 0.5) << 24;
    
    return [NSString stringWithFormat:@"%08X", value];
}

