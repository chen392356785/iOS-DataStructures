//
//  main.cpp
//  01-Linked-List-Basics
//
//  Created by dzb on 2019/3/4.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include <iostream>
#include "LinkedList.hpp"
#include <iostream>

class Person {
public:
	Person() {
		
	}
	~Person() {
		std::cout<<"~Person() " << std::endl;
	}
};

int main(int argc, const char * argv[]) {
	
	{
		///使用智能指针是为了管理对象的引用计数 释放内存
		LinkedList<Person> link;
		for (int i = 0; i<5; i++) {
			shared_ptr<Person> p(new Person());
			link.addFirst(p);
			link.toString();
		}
	}
	
//	link.remove(2);
//	link.toString();
//	link.removeFirst();
//	link.toString();
//	link.removeLast();
//	link.toString();
	getchar();
	
	return 0;
}
