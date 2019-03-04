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
		~Node();
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
	void add(int index,E e);
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
	/// 输出打印
	void toString();
	
	// 从链表中删除index(0-based)位置的元素, 返回删除的元素
	// 在链表中不是一个常用的操作，练习用：）
	E remove(int index);
	// 从链表中删除第一个元素, 返回删除的元素
	E removeFirst();
	// 从链表中删除最后一个元素, 返回删除的元素
	E removeLast();
	// 从链表中删除元素e
	void removeElement(E e);
};

//MARK:: Node内部类实现

template <typename E>
LinkedList<E>::Node::Node() : Node(nullptr,nullptr) { }

template <typename E>
LinkedList<E>::Node::Node(E e) : Node(e,nullptr) { }

template <typename E>
LinkedList<E>::Node::Node(E e,Node *next) :_e(e),_next(next) { }
template <typename E>
LinkedList<E>::Node::~Node() {
	std::cout<<"LinkedList<E>::Node::~Node()"<<endl;
}

//MARK: LinkedList类实现

///构造函数
template <typename E>
LinkedList<E>::LinkedList() {
	_dummyHead = new Node(0,nullptr);
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
	cout << "~LinkedList() " << endl;
	while (_size != 0) {
		removeFirst();
	}
}

template <typename E>
void LinkedList<E>::toString() {
	for (Node *cur = _dummyHead->_next; cur != nullptr; cur = cur->_next) {
		E e = cur->_e;
		cout<<e<< " -> ";
	}
	cout<<" NULL " << endl;
}


// 从链表中删除index(0-based)位置的元素, 返回删除的元素
// 在链表中不是一个常用的操作，练习用：）
template <typename E>
E  LinkedList<E>::remove(int index) {
	if(index < 0 || index >= _size)
		throw "Remove failed. Index is illegal.";
	Node *prev = _dummyHead;
	for (int i = 0; i<index; i++) {
		prev = prev->_next;
	}
	Node *retNode = prev->_next;
	prev->_next = retNode->_next;
	retNode->_next = nullptr;
	_size--;
	E e = retNode->_e;
	delete retNode;
	return e;
}
// 从链表中删除第一个元素, 返回删除的元素
template <typename E>
E LinkedList<E>::removeFirst() {
	return remove(0);
}
// 从链表中删除最后一个元素, 返回删除的元素
template <typename E>
E LinkedList<E>::removeLast() {
	return remove(_size - 1);
}
// 从链表中删除元素e
template <typename E>
void LinkedList<E>::removeElement(E e) {
	Node *prev = _dummyHead;
	while(prev->_next != nullptr){
		if(prev->_next->_e == e)
			break;
		prev = prev->_next;
	}
	
	if(prev->_next != nullptr){
		Node *delNode = prev->_next;
		prev->_next = delNode->_next;
		delete delNode;
		delNode->_next = nullptr;
		_size --;
	}
}


#endif /* LinkedList_hpp */
