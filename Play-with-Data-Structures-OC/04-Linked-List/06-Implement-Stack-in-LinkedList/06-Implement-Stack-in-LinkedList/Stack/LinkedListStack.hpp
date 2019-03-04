//
//  LinkedListStack.hpp
//  06-Implement-Stack-in-LinkedList
//
//  Created by dzb on 2019/3/4.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef LinkedListStack_hpp
#define LinkedListStack_hpp

#include <stdio.h>
#include "LinkedList.hpp"

template <typename E>
class LinkedListStack  {
private:
	LinkedList<E> *_list;
public:
	LinkedListStack();
	~LinkedListStack();
	int getSize();
	int getCapacity();
	bool isEmpty();
	void push(E e);
	E pop();
	E peek();
	///输出栈中所有元素
	void toString();
};


#pragma mark 构造 析构函数
template <typename E>
LinkedListStack<E>::LinkedListStack(){
	_list = new LinkedList<E>();
}

template <typename E>
LinkedListStack<E>::~LinkedListStack() {
	if (_list != nullptr) {
		delete _list;
		_list = nullptr;
	}
	cout << "~LinkedListStack<E>::~~LinkedListStack()" << endl;
}

template <typename E>
int LinkedListStack<E>::getSize() {
	return _list->getSize();
}
template <typename E>
bool LinkedListStack<E>::isEmpty() {
	return _list->isEmpty();
}

template <typename E>
void LinkedListStack<E>::push(E e) {
	E p1(e);
	_list->addLast(p1);
}

template <typename E>
E  LinkedListStack<E>::pop() {
	return (_list->removeLast());
}

template <typename E>
E LinkedListStack<E>::peek() {
	return _list->getLast();
}

template <typename E>
void LinkedListStack<E>::toString() {
	cout << "Stack: [";
	for (int i = 0; i <_list->getSize(); ++i) {
		E e = _list->get(i);
		if (i != 0) {
			cout << ", ";
		}
		std::cout << e;
	}
	cout << "] top" << endl;
}



#endif /* LinkedListStack_hpp */
