//
//  main.cpp
//  05-Contain-Find-and-Remove
//
//  Created by dzb on 2019/2/28.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include <iostream>
#include "ArrayList.hpp"

using namespace std;

int main() {
	
	using M::ArrayList;
	ArrayList arr = ArrayList(20);
	for (int i = 0; i<10; i++) {
		arr.addLast(i);
	}
	arr.display();
	arr.insert(100,1);
	arr.display();
	
	arr.addFirst(-1);
	
	arr.display();
	
	arr.remove(2); ///相当于移除100
	
	arr.display();
	
	arr.removeElement(4);
	arr.display();
	arr.removeFirst();
	arr.display();
	
	return 0;
}
