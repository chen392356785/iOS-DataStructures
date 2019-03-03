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
		cout << "ArrayList()构造函数" << endl;
	}
	
	ArrayList::ArrayList(int capacity) : _capacity(capacity) {
		_size = 0;
		_data = new int[capacity]();
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
	
	
	// 向所有元素后添加一个新元素
	void ArrayList::addLast(int element) {
		add(element,_size);
	}
	// 在所有元素前添加一个新元素
	void ArrayList::addFirst(int element) {
		add(element,0);
	}
	
	void ArrayList::add(int element,int index) {
		if (_size == _capacity) {
			cout << "Add failed. Array is full." << endl;
			return;
		}
		
		if(index < 0 || index > _size) {
			cout << "Add failed. Require index >= 0 and index <= size." << endl;
			return;
		}
		
		///交换索引位置 移动数组索引位置 主要是针对往数组中间位置插入元素时候 需要移动元素位置
		for(int i = ( _size - 1);(i >= index && i >= 0); i--) {
			_data[i + 1] = _data[i];
		}
		
		_data[index] = element;
		_size ++;
	}
	
	void ArrayList::display() {
		for (int i = 0; i<_size; i++) {
			int el = _data[i];
			cout << el << endl;
		}
	}
	
	/// 获取index索引位置的元素
	int ArrayList::objectAtIndex(int index) {
		if (index < 0 || index >= _size) {
			cout << "Get failed. Index is illegal." << endl;
			return 0;
		}
		return _data[index];
	}
	/// 修改index索引位置的元素为e
	void ArrayList::setObject(int element, int index) {
		if(index < 0 || index >= _size) {
			cout << "Set failed. Index is illegal." << endl;
			return;
		}
		_data[index] = element;
	}
	
}

