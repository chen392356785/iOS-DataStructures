//
//  ArrayList.hpp
//  02-Create-Our-Own-Array
//
//  Created by dzb on 2019/2/27.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef ArrayList_hpp
#define ArrayList_hpp

#include <stdio.h>

template <class T>
class ArrayList {
	
private:
	T *_data; /// int型指针数组
	int _size; ///数组元素个数
	int _capacity; ///数组容量
public:
	///构造方法
	ArrayList();
	ArrayList(int capacity);
	///析构函数
	~ArrayList();
	// 获取数组的容量
	int getCapacity();
	///获取数组中的元素个数
	int getSize();
	// 返回数组是否为空
	bool isEmpty();
	// 向所有元素后添加一个新元素
	void addLast(T element);
	// 在所有元素前添加一个新元素
	void addFirst(T element);
	/// 在数组任意位置插入一个元素
	void insert(T element,int index);
	/// 获取index索引位置的元素
	T objectAtIndex(int index);
	/// 修改index索引位置的元素为e
	void setObject(T element,int index);
	// 查找数组中是否有元素e
	bool contains(T e);
	// 查找数组中元素e所在的索引，如果不存在元素e，则返回-1
	int find(T e);
	// 从数组中删除index位置的元素, 返回删除的元素
	T remove(int index);
	// 从数组中删除第一个元素, 返回删除的元素
	T removeFirst();
	// 从数组中删除最后一个元素, 返回删除的元素
	T removeLast();
	// 从数组中删除元素e
	void removeElement(T e);
	///打印内部元素
	void printf();
};
	


#endif /* ArrayList_hpp */
