//
//  UIView+Shadow.m
//  Shadow Maker Example
//
//  Created by Philip Yu on 5/14/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "UIView+Shadow.h"

#define kShadowViewTag 2132
#define kValidDirections [NSArray arrayWithObjects: @"top", @"bottom", @"left", @"right",nil]

@implementation UIView (Shadow)
//
//- (void) makeInsetShadow
//{
//    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
//    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:0.5];
//    [self createShadowViewWithRadius:3 Color:color Directions:shadowDirections];
//}

//- (void) makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha
//{
//    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
//    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:alpha];
//    [self createShadowViewWithRadius:radius Color:color Directions:shadowDirections];
//}

//- (void) makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
//{
//   [self createShadowViewWithRadius:radius Color:color Directions:directions];
//}

- (void) createShadowViewWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
{
    NSMutableDictionary *directionDict = [[NSMutableDictionary alloc] init];
    
    for (NSString * direction in directions)[directionDict setObject:@"1" forKey:direction];
    
    for (NSString * direction in directionDict)
    {
        if ([kValidDirections containsObject:direction])
        {
            CAGradientLayer * shadow = [CAGradientLayer layer];
            
            if ([direction isEqualToString:@"top"])
            {
                [shadow setStartPoint:CGPointMake(0.5, 0.0)];
                [shadow setEndPoint:CGPointMake(0.5, 1.0)];
                shadow.frame = CGRectMake(0, 0, self.bounds.size.width, radius);
            }
            else if ([direction isEqualToString:@"bottom"])
            {
                [shadow setStartPoint:CGPointMake(0.5, 1.0)];
                [shadow setEndPoint:CGPointMake(0.5, 0.0)];
                shadow.frame = CGRectMake(0, self.bounds.size.height - radius, self.bounds.size.width, radius);
            }
            else if ([direction isEqualToString:@"left"])
            {
                shadow.frame = CGRectMake(0, 0, radius, self.bounds.size.height);
                [shadow setStartPoint:CGPointMake(0.0, 0.5)];
                [shadow setEndPoint:CGPointMake(1.0, 0.5)];
            }
            else if ([direction isEqualToString:@"right"])
            {
                shadow.frame = CGRectMake(self.bounds.size.width - radius, 0, radius, self.bounds.size.height);
                [shadow setStartPoint:CGPointMake(1.0, 0.5)];
                [shadow setEndPoint:CGPointMake(0.0, 0.5)];
            }
            
            shadow.colors = [NSArray arrayWithObjects:(id)[color CGColor], (id)[[UIColor clearColor] CGColor], nil];
            
            [self.layer insertSublayer:shadow atIndex:0];
        }
    }
}

- (void) makeLayerRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
{
    for (NSString * direction in directions)
    {
        if ([direction isEqualToString:@"top"])
        {
            CALayer * topBorder  = [CALayer layer];
            topBorder.borderWidth= radius;
            topBorder.borderColor= color.CGColor;
            topBorder.frame      = CGRectMake(0.0, 0.0, self.width, radius);
            [self.layer addSublayer:topBorder];
        }
        else if ([direction isEqualToString:@"bottom"])
        {
            CALayer * bottomBorder  = [CALayer layer];
            bottomBorder.borderWidth= radius;
            bottomBorder.borderColor= color.CGColor;
            bottomBorder.frame      = CGRectMake(0.0, self.height-1 , self.width, radius);
            [self.layer addSublayer:bottomBorder];
        }
        else if ([direction isEqualToString:@"left"])
        {
            CALayer * leftBorder  = [CALayer layer];
            leftBorder.borderWidth= radius;
            leftBorder.borderColor= color.CGColor;
            leftBorder.frame      = CGRectMake(0.0, 0.0 , radius, self.height);
            [self.layer addSublayer:leftBorder];
        }
        else if ([direction isEqualToString:@"right"])
        {
            CALayer * rightBorder  = [CALayer layer];
            rightBorder.borderWidth= radius;
            rightBorder.borderColor= color.CGColor;
            rightBorder.frame      = CGRectMake(0.0, self.width , radius , self.height);
            [self.layer addSublayer:rightBorder];
        }
    }
}
@end
