//
//  main.m
//  03-Add-Element-in-Array
//
//  Created by dzb on 2019/2/15.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <iostream>
#include "ArrayList.hpp"

using namespace std;

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		using M::ArrayList;
		ArrayList arr = ArrayList();
		
		arr.addFirst(10);
		arr.addFirst(20);
		arr.addFirst(30);
		arr.display();
		
		int a = arr.objectAtIndex(2);
		cout << a << endl;
		
		arr.setObject(100, 2);
		a = arr.objectAtIndex(2);
		cout << a << endl;

	}
	return 0;
}
