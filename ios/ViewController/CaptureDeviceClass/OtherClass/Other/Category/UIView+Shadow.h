//
//  UIView+Shadow.h
//  Shadow Maker Example
//
//  Created by Philip Yu on 5/14/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Shadow)
//- (void) makeInsetShadow;
//- (void) makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha;
////画内阴影
//- (void) makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions;
//画边框
- (void) makeLayerRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions;
@end
