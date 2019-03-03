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
//		cout << arr.getSize() << endl;
//		cout << arr.getCapacity() << endl;
//		cout << arr.isEmpty() << endl;

		arr.addFirst(10);
		arr.addFirst(20);
		arr.display();
		arr.addFirst(30);
		arr.display();

	}
	return 0;
}

