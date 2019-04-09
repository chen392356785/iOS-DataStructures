//
//  THOSMacro.h
//  Owner
////  wannili


#ifndef THOSMacro
#define THOSMacro


#import <Foundation/Foundation.h>
#import "TWLEXTScope.h"


#define GetLocalizedString(key, defalutValue)                                  \
NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle],           \
defalutValue, nil)
#define CCLocalizedString(key)                                                 \
NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], key, nil)

//================================================================================================
// 判断系统版本
#define TW_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define TWOS_IOS5                                                              \
(kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_5_0)
#define TWOS_IOS6                                                              \
(kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_6_0)
#define TWOS_IOS7                                                              \
(kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0)
#define TWOS_IOS8                                                              \
(kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0)



#undef THWeak
#define THWeak(...) @weakify(__VA_ARGS__)
#define THWeakSelf THWeak(self);

#undef THStrong
#define THStrong(...) @strongify(__VA_ARGS__)
#define THStrongSelf THStrong(self);

#define THPerformSelectorLeakWarning(Stuff)                                    \
do {                                                                         \
_Pragma("clang diagnostic push")                                           \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")    \
Stuff;                                                             \
_Pragma("clang diagnostic pop")                                            \
} while (0)


#endif
