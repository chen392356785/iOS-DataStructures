//
//  ArrayList.cpp
//  02-Create-Our-Own-Array
//
//  Created by dzb on 2019/2/27.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include "ArrayList.hpp"
#include <iostream>
using namespace std;

namespace M {
	
	/**
	 默认数组容量是10
	 */
	ArrayList::ArrayList() : ArrayList(10) {
		cout << _capacity << endl;
		cout << "ArrayList()构造函数" << endl;
	}
	
	ArrayList::ArrayList(int capacity) : _capacity(capacity) {
		_size = 0;
		_data = new int[capacity];
		cout << "ArrayList(int capacity)构造函数" << endl;
	}
	
	int ArrayList::getCapacity() {
		return _capacity;
	}
	
	int ArrayList::getSize() {
		return _size;
	}
	
	bool ArrayList::isEmpty() {
		return _size == 0;
	}
	
	ArrayList::~ArrayList() {
		cout << "~ArrayList()析构函数" << endl;
		delete [] _data;
	}
	
}

