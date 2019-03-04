//
//  LinkedList.hpp
//  01-Linked-List-Basics
//
//  Created by dzb on 2019/3/4.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef LinkedList_hpp
#define LinkedList_hpp

#include <stdio.h>
#include <iostream>
using namespace std;

template <typename E>
class LinkedList {
private:

	///内部私有类
	class Node {
	public:
		E _e;
		Node *_next;
		Node();
		Node(E e);
		Node(E e,Node *next);
	};
	
	Node *_dummyHead;
	int _size;
	
public:
	///构造函数
	LinkedList();
	///析构函数
	~LinkedList();
	// 获取链表中的元素个数
	int getSize();
	// 在链表头添加新的元素e
	void addFirst(E e);
	// 在链表的index(0-based)位置添加新的元素e
	// 在链表中不是一个常用的操作，练习用：）
	void add(int index, E e);
	// 在链表末尾添加新的元素e
	void addLast(E e);
	// 获得链表的第一个元素
	E getFirst();
	// 获得链表的最后一个元素
	E getLast();
	// 获得链表的第index(0-based)个位置的元素
	// 在链表中不是一个常用的操作，练习用：）
	E get(int index);
	// 修改链表的第index(0-based)个位置的元素为e
	// 在链表中不是一个常用的操作，练习用：）
	void set(int index, E e);
	// 查找链表中是否有元素e
	bool contains(E e);
	// 返回链表是否为空
	bool isEmpty();
	void toString();
};

//MARK:: Node内部类实现

template <typename E>
LinkedList<E>::Node::Node() : Node(NULL,nullptr) { }

template <typename E>
LinkedList<E>::Node::Node(E e) : Node(e,nullptr) { }

template <typename E>
LinkedList<E>::Node::Node(E e,Node *next) : _e(e) , _next(next) { }

//MARK: LinkedList类实现

///构造函数
template <typename E>
LinkedList<E>::LinkedList() {
	_dummyHead = new Node();
	_size = 0;
}
// 获取链表中的元素个数
template <typename E>
int LinkedList<E>::getSize() {
	return _size;
}
// 返回链表是否为空
template <typename E>
bool LinkedList<E>::isEmpty() {
	return _size == 0;
}

// 在链表头添加新的元素e
template <typename E>
void LinkedList<E>::addFirst(E e) {
	add(0, e);
}

// 在链表末尾添加新的元素e
template <typename E>
void LinkedList<E>::addLast(E e) {
	add(_size,e);
}

// 在链表的index(0-based)位置添加新的元素e
// 在链表中不是一个常用的操作，练习用：）
template <typename E>
void LinkedList<E>::add(int index, E e) {
	
	if(index < 0 || index > _size)
		throw "Add failed. Illegal index.";
	Node *prev = _dummyHead;
	for (int i = 0; i<index; i++) {
		prev = prev->_next;
	}
	prev->_next = new Node(e,prev->_next);
	_size++;

}

template <typename E>
// 获得链表的第一个元素
E LinkedList<E>::getFirst() {
	return get(0);
}
template <typename E>
// 获得链表的最后一个元素
E LinkedList<E>::getLast() {
	return get(_size-1);
}

template <typename E>
// 获得链表的第index(0-based)个位置的元素
// 在链表中不是一个常用的操作，练习用：）
E LinkedList<E>::get(int index) {
	if(index < 0 || index >= _size)
		throw "Get failed. Illegal index.";
	Node *cur = _dummyHead->_next;
	for (int i = 0; i<index; i++) {
		cur = cur->_next;
	}
	return cur->_e;
}

template <typename E>
// 修改链表的第index(0-based)个位置的元素为e
// 在链表中不是一个常用的操作，练习用：）
void LinkedList<E>::set(int index, E e) {
	if(index < 0 || index >= _size)
		throw "Get failed. Illegal index.";
	Node *cur = _dummyHead->_next;
	for (int i = 0; i<index; i++) {
		cur = cur->_next;
	}
	cur->_e = e;
}

template <typename E>
// 查找链表中是否有元素e
bool LinkedList<E>::contains(E e) {
	Node *cur = _dummyHead->_next;
	while (cur != nullptr) {
		if (cur->_e == e) { return true; }
		cur = cur->_next;
	}
	return false;
}

///析构函数
template <typename E>
LinkedList<E>::~LinkedList() {

}

template <typename E>
void LinkedList<E>::toString() {
	for (Node *cur = _dummyHead->_next; cur != nullptr; cur = cur->_next) {
		cout<< cur->_e<< " -> ";
	}
	cout<<" NULL " << endl;
}


#endif /* LinkedList_hpp */
