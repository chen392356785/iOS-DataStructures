//
//  XMSchemeManager.m
//  xmLife
//  Created by Neely on 2018/4/27.
//

#import "XMSchemeManager.h"

@interface XMSchemeManager ()

@property (strong, nonatomic) NSMutableArray *schemeList;
@property (strong, nonatomic) NSMutableDictionary *schemaMap;

@end

@implementation XMSchemeManager

+ (instancetype)sharedInstance
{
    static XMSchemeManager *s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      s_instance = [[[self class] alloc] init];
    });
    return s_instance;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _schemeList = [@[] mutableCopy];
        _schemaMap = [@{} mutableCopy];
    }
    return self;
}

- (void)registerScheme:(XMSchemeBase *)scheme forTag:(id)tag
{
    [self addSchemeToList:scheme];
    if (tag) {
        [_schemaMap setObject:scheme forKey:tag];
    }
}

- (void)addSchemeToList:(XMSchemeBase *)scheme
{
    NSLog(@"%@: %zd", NSStringFromClass([scheme class]), scheme.priority);
    for (NSInteger i = 0; i < _schemeList.count; i++) {
        XMSchemeBase *schemeItem = _schemeList[i];
        if (scheme.priority > schemeItem.priority) {
            [_schemeList insertObject:scheme atIndex:i];
            return;
        }
    }
    [_schemeList addObject:scheme];
}
//- (XMSchemeBase *)schemeForTag:(id)tag
//{
//    NSAssert(tag != nil, @"schemeForTag不能为空");
//    return _schemaMap[tag];
//}

- (void)dealAllSchemeLoaded
{
}

- (BOOL)handleDealScheme:(XMSchemeData *)schemeData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      [self dealAllSchemeLoaded];
    });

    if (schemeData == nil) {
        return NO;
    }
    BOOL handleDealScheme = NO;
    for (XMSchemeBase *dealScheme in _schemeList) {
        if ([dealScheme canDealScheme:schemeData] && [dealScheme handleDealScheme:schemeData]) {
            handleDealScheme = YES;
            if (schemeData.dealBlock) {
                schemeData.dealBlock(schemeData);
            }
        }
    }
    return handleDealScheme;
}

@end
