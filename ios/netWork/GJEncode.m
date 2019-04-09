

#import "GJEncode.h"
#import <CommonCrypto/CommonDigest.h>

@implementation GJEncode
+ (NSString*)MD5Encode:(NSString*)str
{
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), result );
	
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15] ];
}





+ (NSString*)URLEncode:(NSString*)str
{
	return [(NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[[str mutableCopy] autorelease], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/~"),kCFStringEncodingUTF8) autorelease];
}

+ (NSString*)URLDecoded:(NSString*)str
{
    NSString *result = (NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)str,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8);
    [result autorelease];
    return result;
}

+ (NSString*)HandleSpecialCharactor:(NSString*)str
{
    NSMutableString* str2 = [[NSMutableString alloc] initWithString:str];  
    
    [str2 replaceOccurrencesOfString:@"\\" withString:@"\\\\" options:NSLiteralSearch range:NSMakeRange(0, [str2 length])];
    
    [str2 replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSLiteralSearch range:NSMakeRange(0, [str2 length])];
    [str2 replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSLiteralSearch range:NSMakeRange(0, [str2 length])];
    [str2 replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSLiteralSearch range:NSMakeRange(0, [str2 length])];    
    
    return [str2 autorelease];
    
}

+ (NSString*)URLEncodeAndHandleSpecialCharactor:(NSString*)str
{
    NSString* str2 = [self HandleSpecialCharactor:str];
    return [self URLEncode:str2];
}


@end
