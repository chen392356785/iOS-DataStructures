//
//  SMLabel.h
//  SMAirlineTickets
//
//  Created by yaoyongping on 12-5-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface SMLabel : UILabel{
     id delegate;
@private
    VerticalAlignment _verticalAlignment;
}
@property (nonatomic) VerticalAlignment verticalAlignment;  //居上、中、下

-(id)initWithFrameWith:(CGRect)frame textColor :(UIColor*)color textFont:(UIFont *)font;


@end
 
