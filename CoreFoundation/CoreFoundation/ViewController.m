//
//  ViewController.m
//  CoreFoundation
//
//  Created by dzb on 2019/4/3.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#import "ViewController.h"
#import "MTArray.h"
#import "MTMutableArray.h"
#import <CoreFoundation/CoreFoundation.h>

@interface ViewController ()
{
	CFArrayRef _array;
}
@end

@implementation ViewController

void callBack(const void *value, void *context) {
	NSLog(@"%@",value);
}

- (void)viewDidLoad {
	[super viewDidLoad];
	CFStringRef s = CFStringCreateWithCString(kCFAllocatorDefault, "dzb",kCFStringEncodingUTF8);
	NSLog(@"%@",s);
	CFRelease(s);
}

- (void) testArray {
	
	const void **arr = malloc(sizeof(void*)*5);
	arr[0] = (__bridge void*)@"dzb";
	arr[1] = (__bridge void*)@"1";
	arr[2] = (__bridge void*)@"2";
	arr[3] = (__bridge void*)@"3";
	arr[4] = (__bridge void*)@"2";
	arr[5] = (__bridge void*)@"5";
	MTArray *array1 = [MTArray arrayWithObjects:@1,@2,@3,@4,@5, nil];
	MTMutableArray *dataArray = [MTMutableArray array];
	[dataArray addObject:@10];
	[dataArray addObject:@12];
	[dataArray addObject:@13];
	[dataArray addObject:@14];
	[dataArray addObject:@15];
	
	for (id obj in dataArray) {
		NSLog(@"%@",obj);
	}
	
	[dataArray removeLastObject];
	
	for (id obj in dataArray) {
		NSLog(@"%@",obj);
	}
}


@end
