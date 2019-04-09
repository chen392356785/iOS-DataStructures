

#import <Foundation/Foundation.h>


@interface GJEncode : NSObject {

}

+ (NSString*)MD5Encode:(NSString*)str;
+ (NSString*)URLEncode:(NSString*)str;
+ (NSString*)URLDecoded:(NSString*)str;
+ (NSString*)HandleSpecialCharactor:(NSString*)str;
+ (NSString*)URLEncodeAndHandleSpecialCharactor:(NSString*)str;
@end
