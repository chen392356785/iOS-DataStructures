//
//  main.cpp
//  01-Linked-List-Basics
//
//  Created by dzb on 2019/3/4.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include <iostream>
#include "LinkedList.hpp"

int main(int argc, const char * argv[]) {
	
	{
		LinkedList<int> link;
		for (int i = 0; i<5; i++) {
			link.addFirst(i);
			link.toString();
		}
		link.add(2, 666);
		link.toString();
	}
	
	getchar();
	
	return 0;
}
