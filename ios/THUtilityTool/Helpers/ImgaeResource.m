//
//  ImgaeResource.m
//  Owner
//
//  Created by Neely on 2018/3/26.
//

#import "ImgaeResource.h"

@implementation ImgaeResource

+ (NSString *)hashToUrl:(NSString *)hash
{
    
    NSString *_url = hash;
    
    if (_url.length < 3)
        return _url;
    
    {
        _url = [_url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([_url hasPrefix:@"http:"] || [_url hasPrefix:@"https:"] || [_url hasPrefix:@"file:"] ||
            [_url hasPrefix:@"res:"])
        {
            _url = [_url stringByReplacingOccurrencesOfString:@"|" withString:@"%7c"];
            
            if ([_url hasPrefix:@"http:"])
                _url = [_url stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
            
            return _url;
        }
    }
    
    return _url;
}
@end
