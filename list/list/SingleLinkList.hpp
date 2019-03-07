//
//  SingleLinkList.hpp
//  list
//
//  Created by dzb on 2019/3/6.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef SingleLinkList_hpp
#define SingleLinkList_hpp

#include <stdio.h>
#include "LinkList.hpp"
using namespace std;

template <class T>
class SingleLinkList : public LinkList<T> {
	
public:
	
	Node<T> *_head = nullptr;
	SingleLinkList();
	~SingleLinkList();
	///链表插入一个元素
	void insertList(T e);
	///遍历链表内容
	void travereList(void);
	/// 链表长度
	int lenList(void);
	///搜索链表元素
	Node<T> * serchList(T find);
	///删除链表元素
	void deleteList(Node<T> *pFind);
	/// 排序
	void popSortList(void);
	///逆置链表
	void reverseList(void);
	///销毁链表
	void destroyList(void);
	
};

template <class T>
SingleLinkList<T>::SingleLinkList() {
	this->_head = new Node<T>(NULL);
}

template <class T>
SingleLinkList<T>::~SingleLinkList() {
	destroyList();
}


///链表插入一个元素
template <typename T>
void SingleLinkList<T>::insertList(T e) {
	Node<T> *cur = new Node<T>(e);
	cur->_next = _head->_next;
	_head->_next = cur;
}

///遍历链表内容
template <typename T>
void SingleLinkList<T>::travereList(void) {
	Node<T> *cur = _head->_next;
	while (cur != nullptr) {
		std::cout<<cur->_data<<std::endl;
		cur = cur->_next;
	}
}

/// 链表长度
template <typename T>
int SingleLinkList<T>::lenList(void) {
	int count = 0;
	Node<T> *cur = _head->_next;
	while (cur != nullptr) {
		count++;
		cur = cur->_next;
	}
	return count;
}

///搜索链表元素
template <typename T>
Node<T> * SingleLinkList<T>::serchList(T find) {
	Node<T> *cur = _head->_next;
	while (cur != nullptr) {
		if (cur->_data == find) {
			return cur;
		}
		cur = cur->_next;
	}
	return nullptr;
}

///删除链表元素
template <typename T>
void SingleLinkList<T>::deleteList(Node<T> *pFind) {
	
	if (pFind->_next == NULL) {
		Node<T> *cur = _head->_next;
		while (cur->_next != pFind) {
			cur = cur->_next;
		}
		cur->_next = pFind->_next;
		delete pFind;
	} else {
		pFind->_data = pFind->_next->_data;
		Node<T> *t = pFind->_next;
		pFind->_next = t->_next;
		delete t;
	}
}

/// 排序
template <typename T>
void SingleLinkList<T>::popSortList(void) {
	///交换数据
	Node<T> *p,*q;
	int len = lenList();
	for (int i = 0; i<len-1; i++) {
		p = _head->_next;
		q = p->_next;
		for (int j = 0; j<len-1-i; j++) {
			if (p->_data > q->_data) {
				p->_data ^= q->_data;
				q->_data ^= p->_data;
				p->_data ^= q->_data;
			}
			p = p->_next;
			q = q->_next;
		}
	}
	
}

///逆置链表
template <typename T>
void SingleLinkList<T>::reverseList(void) {
	Node<T> *h = _head->_next;
	_head->_next = NULL;
	Node<T> *t;
	while (h) {
		t = h->_next;
		h->_next = _head->_next;
		_head->_next = h;
		h = t;
	}
}

///销毁链表
template <typename T>
void SingleLinkList<T>::destroyList(void) {
	Node<T> *t;
	while (_head) {
		t = _head->_next;
		delete _head;
		_head = t;
	}
}

#endif /* SingleLinkList_hpp */
