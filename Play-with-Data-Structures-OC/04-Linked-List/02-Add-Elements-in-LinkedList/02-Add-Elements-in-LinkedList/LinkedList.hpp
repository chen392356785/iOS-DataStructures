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
		void toString();
	};
	
	Node *head;
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
	// 返回链表是否为空
	bool isEmpty();
};

//MARK:: Node内部类实现

template <typename E>
LinkedList<E>::Node::Node() : Node(NULL,nullptr) { }

template <typename E>
LinkedList<E>::Node::Node(E e) : Node(e,nullptr) { }

template <typename E>
LinkedList<E>::Node::Node(E e,Node *next) : _e(e) , _next(next) {}

//MARK: LinkedList类实现

///构造函数
template <typename E>
LinkedList<E>::LinkedList() {
	this->head = NULL;
	this->_size = 0;
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
	head = new Node(e,head);
	_size++;
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
	if(index == 0) {
		addFirst(e);
	} else {
		Node prev = head;
		for(int i = 0 ; i < index - 1 ; i ++) {
			prev = prev.next;
			prev.next = new Node(e, prev.next);
			_size ++;
		}
	}
	
}

///析构函数
template <typename E>
LinkedList<E>::~LinkedList() {
	
}

#endif /* LinkedList_hpp */
