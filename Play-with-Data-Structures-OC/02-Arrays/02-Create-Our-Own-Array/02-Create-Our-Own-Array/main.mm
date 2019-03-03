//
//  main.m
//  02-Create-Our-Own-Array
//
//  Created by dzb on 2019/2/15.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#import "Array.h"
#include <iostream>
#include "ArrayList.hpp"

using namespace std;

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		using M::ArrayList;
		ArrayList arr = ArrayList();
		cout << arr.getSize() << endl;
		cout << arr.getCapacity() << endl;
		cout << arr.isEmpty() << endl;

		M::ArrayList arr2 = M::ArrayList(100);
		cout << arr2.getSize() << endl;
		cout << arr2.getCapacity() << endl;
		cout << arr2.isEmpty() << endl;
//
//		Array *arr1 = [[Array alloc] init];
//		Array *arr2 = [[Array alloc] initWithCapacity:10];
//
//		NSLog(@"arr1.getSize is %zd",arr1.getSize);
//		NSLog(@"arr1.getCapacity is %zd",arr1.getCapacity);
//		NSLog(@"arr1.isEmpty is %d",arr1.isEmpty);
//
//		NSLog(@"arr2.getSize is %zd",arr2.getSize);
//		NSLog(@"arr2.getCapacity is %zd",arr2.getCapacity);
//		NSLog(@"arr2.isEmpty is %d",arr2.isEmpty);

	}
	return 0;
}
