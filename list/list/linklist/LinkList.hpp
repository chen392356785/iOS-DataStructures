//
//  LinkList.hpp
//  list
//
//  Created by dzb on 2019/3/6.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef LinkList_hpp
#define LinkList_hpp

#include <stdio.h>

template <typename T>
struct Node {
public:
	T _data;
	Node *_next;
	Node *_pre;
	///单向链表构造函数
	Node(T data,Node *next) : Node(data,next,NULL) { }
	///双向链表构造函数
	Node(T a,Node *next,Node *pre) : _data(a), _next(next),_pre(pre) { }
	Node(T data) : Node(data,NULL) { }
	~Node() {
		std::cout<< "~SNode()" <<std::endl;
	}
};

///链表虚基类 提供了链表操作的接口
template <class T>
class LinkList {
	
public:
	///链表插入一个元素
	virtual void insertList(T e);
	///遍历链表内容
	virtual void travereList(void);
	/// 链表长度
	virtual int lenList(void);
	///删除链表元素
	virtual void deleteList(Node<T> pFind);
	///搜索链表内容
	virtual Node<T> * serchList(T find);
	/// 排序
	virtual void popSortList(void);
	///逆置链表
	virtual void reverseList(void);
	///销毁链表
	virtual void destroyList(void);

};

///链表插入一个元素
template <typename T>
void LinkList<T>::insertList(T e) {
	
}

///遍历链表内容
template <typename T>
void LinkList<T>::travereList(void) {
	
}

/// 链表长度
template <typename T>
int LinkList<T>::lenList(void) {
	return 0;
}

///删除链表元素
template <typename T>
void LinkList<T>::deleteList(Node<T> pFind) {
	
}

/// 排序
template <typename T>
void LinkList<T>::popSortList(void) {
	
}

///逆置链表
template <typename T>
void LinkList<T>::reverseList(void) {
	
}

///销毁链表
template <typename T>
void LinkList<T>::destroyList(void) {
	
}

///搜索链表内容
template <typename T>
Node<T> * LinkList<T>::serchList(T find) {
	return nullptr;
}

#endif /* LinkList_hpp */
