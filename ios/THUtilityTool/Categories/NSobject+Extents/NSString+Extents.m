//
//  NSString+Extents.m
//  CiCi
//
//  Created by jacobChiang on 13-10-9.
//  Copyright (c) 2013年 Paitao. All rights reserved.
//

#import "NSString+Extents.h"
//#import <CommonCrypto/CommonDigest.h>

#define ellipsis @"..."

@implementation NSString (Extents)

- (NSString *)convertStringToMD5String
{
    return [self convertStringToMD5String:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)convertStringToMD5String:(int)length
{
    if (!self) return nil;
    
    const char *newStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(newStr,(int)strlen(newStr), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:length];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

//- (NSString *)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font
//{
//    NSMutableString *truncatedString = [self mutableCopy];
//    if ([self sizeWithFont:font].width > width) {
////        width -= [ellipsis sizeWithFont:font].width;
//		NSDictionary *attributes = @{NSFontAttributeName:font};
//		width -= [ellipsis boundingRectWithSize:CGSizeMake(200.0f,100.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.width;
//
//        NSRange range = {truncatedString.length - 1, 1};
//
//        while ([truncatedString sizeWithFont:font].width > width) {
//            [truncatedString deleteCharactersInRange:range];
//
//            range.location--;
//        }
//
//        [truncatedString replaceCharactersInRange:range withString:ellipsis];
//    }
//
//    return truncatedString;
//}

//- (NSString *)stringByTruncatingToWidth:(CGFloat)width
//                               withFont:(UIFont *)font
//                             withSuffix:(NSString *)suffix
//{
//    return [NSString stringWithFormat:@"%@%@", [self stringByTruncatingToWidth:
//                                                         (width - [suffix sizeWithFont:font].width -
//                                                          4)withFont:font],
//                                      suffix];
//}

- (NSString *)urlencode
{
    NSMutableString *output = [@"" mutableCopy];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    NSUInteger sourceLen = strlen((const char *)source);
    for (NSInteger i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' ') {
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') || (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSString *)URLDecode
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)check_line
{
    NSString *string = (NSString *)self;
    if ([string rangeOfString:@"_"].location) {
        return [string stringByReplacingOccurrencesOfString:@"_" withString:@""];
    }

    return string;
}

static NSString *ccphoneRegex = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";

static NSString *emailregex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

static NSString *phoneregex = @"1[0-9]{10}$";

//车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
// NSString *carRegex = @"^[\\u4e00-\\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\\u4e00-\\u9fff]$";//其中\\u4e00-\\u9fa5表示unicode编码中汉字已编码部分，\\u9fa5-\\u9fff是保留部分，将来可能会添加
static NSString *licenceregex =  @"(^[\\u4e00-\\u9fff]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\\u4e00-\\u9fff]$)";

static NSString *coderegex = @"(^[0-9]{4,6}$)";

static NSString *pwdregex = @"(^[A-Za-z0-9]{6,20}$)";

static NSString *accountregex = @"^[\u4e00-\u9fa5a-zA-Z0-9]{2,16}";

static NSString *nickNameregex = @"^[\u4e00-\u9fa5a-zA-Z0-9]{4,16}";

static NSString *bankNameregex = @"[\u4e00-\u9fa5a-zA-Z0-9]{2,}";

static NSString *isChinese = @"[\u4e00-\u9fa5]";

static NSString *isNumber = @"^[0-9]*$";
//匹配首尾空白字符的正则表达式
static NSString *spacing = @"[\\s]*";
//@"^s*|s*$";

static NSString *num = @"(^[0-9]{0,50}$)";

// 首位 不为 0 的数字
static NSString *Unum = @"(^\\+?[1-9][0-9]*$)";

static NSString *com = @"[0-9A-Za-z]{6,8}";

static NSString *bankCoderegex = @"(^[0-9]{6}$)";

- (BOOL)evaluateCCPasswd
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdregex];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateCCPhoneNum
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneregex];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateEmail
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailregex];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateChinaPhoneNum
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneregex];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateChinaLicence
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", licenceregex];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateValidate
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", coderegex];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluatePassword
{
    return [self length] >= 6 && [self length] <= 20;
}

- (BOOL)evaluateAccount
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", accountregex];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaNumber
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateNickName
{

    NSPredicate *full = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nickNameregex];
    return [full evaluateWithObject:self];
}

- (BOOL)evaluateBankName{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bankNameregex];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateSpacing
{
    BOOL isSpace = NO;
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", spacing];

    for (NSInteger i = 0; i < self.length; i++) {
        NSString *subStr = [self substringWithRange:NSMakeRange(i, 1)];

        BOOL isSpace = [prd evaluateWithObject:subStr];

        if (isSpace) {
            return isSpace;
        }
    }

    return isSpace;
}

- (BOOL)evaluateNumber
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isNumber];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateNum
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Unum];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateCommand
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", com];
    return [prd evaluateWithObject:self];
}

- (BOOL)evaluateBankCodeValidate
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bankCoderegex];
    return [prd evaluateWithObject:self];
}

- (CGFloat)lineBreakSizeOfStringwithFont:(UIFont *)font
                                maxwidth:(CGFloat)width
                           lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self lineBreakSizeOfStringwithFont:font maxwidth:width lineBreakMode:lineBreakMode lineSpace:0];
}

- (CGFloat)lineBreakSizeOfStringwithFont:(UIFont *)font
                                maxwidth:(CGFloat)width
                           lineBreakMode:(NSLineBreakMode)lineBreakMode
                               lineSpace:(CGFloat)space
{
    return ceil([self stringSizeWithFont:font maxwidth:width lineBreakMode:lineBreakMode lineSpace:space].height);
}

- (CGSize)stringSizeWithFont:(UIFont *)font
                    maxwidth:(CGFloat)width
               lineBreakMode:(NSLineBreakMode)lineBreakMode
                   lineSpace:(CGFloat)space
{
    CGRect rect;
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED < 70000)
    CGSize size = [self sizeWithFont:font
                   constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                       lineBreakMode:lineBreakMode];
    rect = CGRectMake(0, 0, size.width, size.height);
#else
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    if (space > 0)
        paragraphStyle.lineSpacing = space;
    
    rect = [self
            boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
            attributes:@{
                         NSFontAttributeName : font,
                         NSParagraphStyleAttributeName : paragraphStyle.copy
                         } context:nil];
#endif
    return rect.size;
}

- (CGFloat)lineBreakSizeOfStringwithFont:(UIFont *)font maxwidth:(CGFloat)width
{
    return [self lineBreakSizeOfStringwithFont:font
                                      maxwidth:width
                                 lineBreakMode:NSLineBreakByWordWrapping];
}

//----------split
+ (NSMutableArray *)splitString:(NSString *)originalString
                       maxWidth:(CGFloat)maxWidth
                           font:(UIFont *)font
{
    if (!originalString || !maxWidth || !font || originalString.length < 1) {
        return nil;
    }

    BOOL split = NO;

    NSMutableArray *array = [@[] mutableCopy];

    NSInteger index = 0;
    NSString *frontString = nil;

    for (; index < originalString.length; index++) {
        NSString *subString = [originalString substringToIndex:index];

        if ([NSString width:subString inFont:font] > maxWidth) {
            NSString *excessString = [originalString substringFromIndex:index - 1 ? index - 1 : 0];
            [array addObjectsFromArray:
                       [NSString splitString:excessString maxWidth:maxWidth font:font]];
            split = YES;
            break;
        }
        frontString = subString;
    }
    if (split && frontString) {
        [array insertObject:frontString atIndex:0];
    } else {
        [array insertObject:originalString atIndex:0];
    }

    return array;
}

+ (NSString *)frontStringInString:(NSString *)originalString
                         maxWidth:(CGFloat)maxWidth
                             font:(UIFont *)font
{
    if (!originalString || !maxWidth || !font || originalString.length < 1) {
        return nil;
    }

    BOOL split = NO;

    NSInteger index = 0;
    NSString *frontString = nil;
    for (; index < originalString.length; index++) {
        NSString *subString = [originalString substringToIndex:index];

        if ([NSString width:subString inFont:font] > maxWidth) {
            split = YES;
            break;
        }
        frontString = subString;
    }

    if (split) {
        return frontString;
    } else {
        return originalString;
    }
}

+ (NSString *)excessStringInString:(NSString *)originalString
                          maxWidth:(CGFloat)maxWidth
                              font:(UIFont *)font
{
    if (!originalString || !maxWidth || !font || originalString.length < 1) {
        return nil;
    }

    NSInteger index = 0;
    NSString *excessString = nil;
    for (; index < originalString.length; index++) {
        NSString *subString = [originalString substringToIndex:index];

        if ([NSString width:subString inFont:font] > maxWidth) {
            excessString = [originalString substringFromIndex:index - 1 ? index - 1 : 0];
            break;
        }
    }
    return excessString;
}

+ (CGSize)size:(NSString *)text inFont:(UIFont *)font
{
    if (!text || !font) {
        return CGSizeZero;
    }

    CGSize size = CGSizeZero;

    if ([text respondsToSelector:@selector(sizeWithAttributes:)]) {
        size = [text sizeWithAttributes:@{NSFontAttributeName : font}];
    } else {
		size = [text boundingRectWithSize:CGSizeMake(300, 200.0f) options:0 attributes:@{NSFontAttributeName :font} context:NULL].size;
//        size = [text sizeWithFont:font];
    }

    return size;
}

+ (CGFloat)width:(NSString *)text inFont:(UIFont *)font
{
    if (!text || !font) {
        return 0.0;
    }
    return [NSString size:text inFont:font].width;
}

+ (CGFloat)height:(NSString *)text inFont:(UIFont *)font
{
    if (!text || !font) {
        return 0.0;
    }
    return [NSString size:text inFont:font].height;
}

+ (CGSize)singalSizeInFont:(UIFont *)font
{
    return [NSString size:@"是" inFont:font];
}

+ (CGFloat)singalWidthInFont:(UIFont *)font
{
    return [NSString size:@"是" inFont:font].width;
}

+ (CGFloat)singalHeightInFont:(UIFont *)font
{
    return [NSString size:@"是" inFont:font].height;
}

+ (NSString *)contentFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日HH时mm分ss秒"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)stringByDateString:(NSString *)dateString
{
    NSMutableString *result = [@"" mutableCopy];
    NSUInteger lastIndex = -1;
    lastIndex = [self _switchString:dateString lastIndex:lastIndex result:result keyword:@"年"];
    lastIndex = [self _switchString:dateString lastIndex:lastIndex result:result keyword:@"月"];
    lastIndex = [self _switchString:dateString lastIndex:lastIndex result:result keyword:@"日"];
    lastIndex = [self _switchString:dateString lastIndex:lastIndex result:result keyword:@"时"];
    lastIndex = [self _switchString:dateString lastIndex:lastIndex result:result keyword:@"分"];
    [self _switchString:dateString lastIndex:lastIndex result:result keyword:@"秒"];
    return result.length > 0 ? result : nil;
}

+ (NSUInteger)_switchString:(NSString *)stringToSwitch
                  lastIndex:(NSUInteger)lastIndex
                     result:(NSMutableString *)result
                    keyword:(NSString *)keyword
{
    NSRange timeRange = [stringToSwitch rangeOfString:keyword];
    if (timeRange.length > 0) {
        NSRange digitRange = NSMakeRange(lastIndex + 1, timeRange.location - lastIndex - 1);
        NSString *findString = [stringToSwitch substringWithRange:digitRange];
        NSString *switchString = [NSString chineseStringFromDigitString:findString];
        [result appendString:switchString];
        [result appendString:keyword];
        lastIndex = timeRange.location;
    }
    return lastIndex;
}

+ (NSString *)chineseStringFromDigitString:(NSString *)nsString
{
    NSUInteger length = [nsString length];
    NSMutableString *result = [@"" mutableCopy];
    char *cstring = (char *)[nsString UTF8String];
    for (NSInteger index = 0; index < length; index++) {
        char c = cstring[index];
        if ((index == 0) && (c == '0')) {
            continue;
        } else if ((index == 0) && ((c > '9') || (c < '0'))) {
            continue;
        }
        if ((length == 2) && (index == 1) && (cstring[0] != '0') && (cstring[0] != '1')) {
            [result appendString:@"十"];
        }
        if ((cstring[0] != '0') && (index == (length - 1)) && (c == '0')) {
            continue;
        }
        switch (c) {
        case '0':
            [result appendString:@"零"];
            break;

        case '1':
            if ((length == 2) && (index == 0)) {
                [result appendString:@"十"];
            } else {
                [result appendString:@"一"];
            }
            break;

        case '2':
            [result appendString:@"二"];
            break;

        case '3':
            [result appendString:@"三"];
            break;

        case '4':
            [result appendString:@"四"];
            break;

        case '5':
            [result appendString:@"五"];
            break;

        case '6':
            [result appendString:@"六"];
            break;

        case '7':
            [result appendString:@"七"];
            break;

        case '8':
            [result appendString:@"八"];
            break;

        case '9':
            [result appendString:@"九"];
            break;

        default:
            break;
        }
    }
    return result.length > 0 ? result : nil;
}

- (NSString *)stringwithoutBlankSpace
{
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *components =
        [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components =
        [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
    str = [components componentsJoinedByString:@""];
    return str;
}


//去掉前后空格
- (NSString *)trimmedBeginAndEndSpaceString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//是否只有中文
- (BOOL)isOnlyChinese
{
    NSString *chineseTest=@"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate*chinesePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseTest];
    return [chinesePredicate evaluateWithObject:self];
}

//是否包含中文
- (BOOL)includeChinese
{
    for(int i = 0; i < [self length];i++)
    {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (NSString *)formatJSON
{
    int indentLevel = 0;
    BOOL inString    = NO;
    char currentChar = '\0';
    char *tab = "    ";
    
    NSUInteger len = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [self UTF8String];
    NSMutableData *buf = [NSMutableData dataWithCapacity:(NSUInteger)(len * 1.1f)];
    
    for (int i = 0; i < len; i++)
    {
        currentChar = utf8[i];
        switch (currentChar) {
            case '{':
            case '[':
                if (!inString) {
                    [buf appendBytes:&currentChar length:1];
                    [buf appendBytes:"\n" length:1];
                    
                    for (int j = 0; j < indentLevel+1; j++) {
                        [buf appendBytes:tab length:strlen(tab)];
                    }
                    
                    indentLevel += 1;
                } else {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case '}':
            case ']':
                if (!inString) {
                    indentLevel -= 1;
                    [buf appendBytes:"\n" length:1];
                    for (int j = 0; j < indentLevel; j++) {
                        [buf appendBytes:tab length:strlen(tab)];
                    }
                    [buf appendBytes:&currentChar length:1];
                } else {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case ',':
                if (!inString) {
                    [buf appendBytes:",\n" length:2];
                    for (int j = 0; j < indentLevel; j++) {
                        [buf appendBytes:tab length:strlen(tab)];
                    }
                } else {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case ':':
                if (!inString) {
                    [buf appendBytes:":" length:1];
                } else {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case ' ':
            case '\n':
            case '\t':
            case '\r':
                if (inString) {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case '"':
                
                if (i > 0 && utf8[i-1] != '\\')
                {
                    inString = !inString;
                }
                
                [buf appendBytes:&currentChar length:1];
                break;
            default:
                [buf appendBytes:&currentChar length:1];
                break;
        }
    }
    
    return [[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)toDictionary
{
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSArray *)toArray
{
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}

+ (BOOL)validateNumber:(NSString *)number belongSpecialCharacters:(NSString *)charactersMacro
{
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:charactersMacro];
    NSRange range = [number rangeOfCharacterFromSet:[tmpSet invertedSet]];
    return (range.length == 0);
}

- (NSString *)check_line_adressArea
{
    NSString *string = (NSString *)self;
    if ([string rangeOfString:@"-"].length) {
        return [[string componentsSeparatedByString:@"-"] firstObject];
    }else if ([string rangeOfString:@"_"].length){
        return [[string componentsSeparatedByString:@"_"] firstObject];
    }
    return string;
}

- (NSString *)check_lineDetaliAddress
{
    NSString *string = (NSString *)self;
    if ([string rangeOfString:@"-"].length) {
        return [[string componentsSeparatedByString:@"-"] lastObject];
    }else if ([string rangeOfString:@"_"].length){
        return [[string componentsSeparatedByString:@"_"] lastObject];
    }
    return string;
}

- (NSInteger)stringByteLength
{
    NSInteger length = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    NSInteger strLength = [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0; i < strLength ;i ++) {
        
        if (*p) {
            p++;
            length++;
        }
        else {
            p++;
        }
        
    }
    return length;
}

@end

@implementation NSString (Format)

+ (NSString *)stringMobileFormat:(NSString *)mobile
{
    if ([mobile evaluateChinaPhoneNum])
    {
        NSMutableString* value = [[NSMutableString alloc] initWithString:mobile];
        [value insertString:@" " atIndex:3];
        [value insertString:@" " atIndex:8];
        return value;
    }
    
    return nil;
}

+ (NSString *)stringChineseFormat:(double)value
{
    if (value / 100000000 >= 1) {
        return [NSString stringWithFormat:@"%.0f亿",value/100000000];
    }else if (value / 10000 >= 1 && value / 100000000 < 1) {
        return [NSString stringWithFormat:@"%.0f万",value/10000];
    }else {
        return [NSString stringWithFormat:@"%.0f",value];
    }
}

@end


BOOL isStringEmptyAfterTrim(NSString *string)
{
    if (string == nil) {
        return YES;
    }
    NSCharacterSet *charsToTrim = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:charsToTrim];
    return trimmedString.length == 0;
}

inline NSString *strOrEmpty(NSString *str)
{
    return str == nil ? @"" : str;
}


