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
	
public:
	
	///内部私有类
	class Node {
	public:
		E &e;
		Node *next;
		Node(E &e);
		Node(E &e,Node &next);
		Node();
		void toString();
	};
	
};

//MARK:: Node内部类实现

template <typename E>
LinkedList<E>::Node::Node() : Node(nullptr,nullptr) {
	
}

template <typename E>
LinkedList<E>::Node::Node(E &e) : Node(e,nullptr) {
	
}

template <typename E>
LinkedList<E>::Node::Node(E &e,Node &next) : Node(nullptr,nullptr) {
	this->e = e;
	this->next = next;
}



#endif /* LinkedList_hpp */
