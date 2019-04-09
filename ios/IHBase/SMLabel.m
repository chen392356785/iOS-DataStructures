//
//  SMLabel.m
//  SMAirlineTickets
//
//  Created by yaoyongping on 12-5-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "SMLabel.h"
//#import <CoreText/CoreText.h>

@implementation SMLabel

@synthesize verticalAlignment = verticalAlignment_;

-(id)init
{
	self=[super init];
	if (self!=nil) {
        
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	if (self!=nil) {
		self.backgroundColor=[UIColor clearColor];
        self.verticalAlignment = VerticalAlignmentMiddle;
	}
	return self;
}


-(id)initWithFrameWith:(CGRect)frame textColor :(UIColor*)color textFont:(UIFont *)font
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        self.verticalAlignment = VerticalAlignmentMiddle;
        self.backgroundColor=[UIColor clearColor];
        self.textColor=color;
        self.font=font;
    }
    return self;
}


-(void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}



@end


 
