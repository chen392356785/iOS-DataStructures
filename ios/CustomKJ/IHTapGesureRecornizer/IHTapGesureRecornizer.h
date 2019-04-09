//
//  IHTapGesureRecornizer.h
//  MinshengBank_Richness
//
//  Created by infohold mac1 on 11-12-7.
//  Copyright 2011 infohold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IHTapGesureRecornizer : UITapGestureRecognizer
{
	NSObject *objectValue;
	int objectTag;
	NSObject *RecognizerOwner;
}

@property(nonatomic,strong) NSObject *RecognizerOwner;
@property(nonatomic,strong) NSObject *objectValue;
@property(nonatomic) int objectTag;

@end
