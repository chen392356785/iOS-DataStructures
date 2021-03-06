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

namespace M {
	
	class ArrayList {
	private:
		int *_data; /// int型指针数组
		int _size; ///数组元素个数
		int _capacity; ///数组容量
	public:
		///构造方法
		ArrayList();
		ArrayList(int capacity);
		///析构函数
		~ArrayList();
	public:
		// 获取数组的容量
		int getCapacity();
		///获取数组中的元素个数
		int getSize();
		// 返回数组是否为空
		bool isEmpty();
		// 向所有元素后添加一个新元素
		void addLast(int element);
		// 在所有元素前添加一个新元素
		void addFirst(int element);
		///打印内部元素
		void display();
	private:
		void add(int element,int index);
	};
	
}


#endif /* ArrayList_hpp */
