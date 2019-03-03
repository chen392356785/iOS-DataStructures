//
//  ArrayList.cpp
//  02-Create-Our-Own-Array
//
//  Created by dzb on 2019/2/27.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include "ArrayList.hpp"
#include "Student.hpp"
#include <iostream>
using namespace std;

template <class T>
/**
 默认数组容量是10
 */
ArrayList<T>::ArrayList() : ArrayList(10) {
	cout << "ArrayList()构造函数" << endl;
}

template <class T>
ArrayList<T> ::ArrayList(int capacity) {
	_capacity = capacity;
	_size = 0;
	_data = new T[capacity]();
	cout << "ArrayList(int capacity)构造函数" << endl;
}

template <class T>
int ArrayList<T>::getCapacity() {
	return _capacity;
}

template <class T>
int ArrayList<T>::getSize() {
	return _size;
}

template <class T>
bool ArrayList<T>::isEmpty() {
	return _size == 0;
}

template <class T>
ArrayList<T>::~ArrayList() {
	cout << "~ArrayList()析构函数" << endl;
	delete [] _data;
}

#pragma mark - 添加元素
template <class T>
// 向所有元素后添加一个新元素
void ArrayList<T>::addLast(T element) {
	insert(element,_size);
}
template <class T>
// 在所有元素前添加一个新元素
void ArrayList<T>::addFirst(T element) {
	insert(element,0);
}

template <class T>
void ArrayList<T>::insert(T element,int index) {
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

template <class T>
/// 修改index索引位置的元素为e
void ArrayList<T>::setObject(T element, int index) {
	if(index < 0 || index >= _size) {
		cout << "Set failed. Index is illegal." << endl;
		return;
	}
	_data[index] = element;
}
#pragma mark - 查找

template <class T>
// 查找数组中是否有元素e
bool ArrayList<T>::contains(T e) {
	for(int i = 0 ; i < _size ; i ++){
		if(_data[i] == e)
			return true;
	}
	return false;
}

template <class T>
// 查找数组中元素e所在的索引，如果不存在元素e，则返回-1
int ArrayList<T>::find(T e) {
	for(int i = 0 ; i < _size ; i ++){
		if(_data[i] == e)
			return i;
	}
	return -1;
}

template <class T>
/// 获取index索引位置的元素
T ArrayList<T>::objectAtIndex(int index) {
	if (index < 0 || index >= _size) {
		cout << "Get failed. Index is illegal." << endl;
		return 0;
	}
	return _data[index];
}

#pragma mark - 删除
template <class T>
// 从数组中删除index位置的元素, 返回删除的元素
T ArrayList<T>::remove(int index) {
	if(index < 0 || index >= _size) {
		cout << "Remove failed. Index is illegal." << endl;
		return 0;
	}
	T ret = _data[index];
	for(int i = index + 1 ; i < _size ; i ++)
		_data[i - 1] = _data[i];
	_size --;
	return ret;
}
template <class T>
// 从数组中删除第一个元素, 返回删除的元素
T ArrayList<T>::removeFirst() {
	return remove(0);
}
template <class T>
// 从数组中删除最后一个元素, 返回删除的元素
T ArrayList<T>::removeLast() {
	return remove(_size-1);
}

template <class T>
// 从数组中删除元素e
void ArrayList<T>::removeElement(T e) {
	int index = find(e);
	if(index != -1)
		remove(index);
}

template <class T>
void ArrayList<T>::display() {
	std::cout << "[";
	for (int i = 0; i < _size; ++i) {
		T t = _data[i];
		std::cout << t;
		if (i != _size - 1) {
			std::cout << ", ";
		}
	}
	std::cout << "]" << endl;
}

template class ArrayList<int>;
template class ArrayList<float>;
template class ArrayList<double>;
template class ArrayList<char *>;
template class ArrayList<long>;
template class ArrayList<Student*>;
