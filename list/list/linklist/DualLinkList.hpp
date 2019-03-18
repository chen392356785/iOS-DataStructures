//
//  DualLinkList.hpp
//  list
//
//  Created by dzb on 2019/3/6.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef DualLinkList_hpp
#define DualLinkList_hpp

#include <stdio.h>
#include "LinkList.hpp"


template <class T>
class DualLinkList : public LinkList<T> {
	Node<T> *_head; ///头指针
public:
    DualLinkList();
    ~DualLinkList();
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
DualLinkList<T>::DualLinkList() {
	_head = new Node<T>(NULL);
	_head->_pre = _head->_next = _head;
}

template <class T>
DualLinkList<T>::~DualLinkList() {
	destroyList();
}

///链表插入一个元素
template <typename T>
void DualLinkList<T>::insertList(T e) {
	Node<T> *cur = new Node<T>(e);
	cur->_next = _head->_next;
	cur->_pre = _head->_pre;
	
	_head->_next = cur;
	cur->_next->_pre = cur;
	cur->_pre = _head;
}

///遍历链表内容
template <typename T>
void DualLinkList<T>::travereList(void) {
	Node<T> *cur = _head->_next;
	while (cur != _head) {
		std::cout<<cur->_data<<std::endl;
		cur = cur->_next;
	}
}

/// 链表长度
template <typename T>
int DualLinkList<T>::lenList(void) {
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
Node<T> * DualLinkList<T>::serchList(T find) {
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
template <class T>
void DualLinkList<T>::deleteList(Node<T> *pFind) {
	
    
}

/// 排序
template <typename T>
void DualLinkList<T>::popSortList(void) {
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
void DualLinkList<T>::reverseList(void) {
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
void DualLinkList<T>::destroyList(void) {
	Node<T> *t;
	while (_head) {
		t = _head->_next;
		delete _head;
		_head = t;
	}
}


#endif /* DualLinkList_hpp */
