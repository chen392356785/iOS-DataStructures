//
//  dlist.cpp
//  list
//
//  Created by dzb on 2019/3/6.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include "dlist.hpp"
#include <stdlib.h>
#include <iostream>

/**
 创建双向循环列表
 */
DNode *createDoubleList() {
	DNode *head = (DNode *)malloc(sizeof(DNode));
	head->pre = head->next = head;
	return head;
}

void insertList(DNode *head,int data) {
	
	DNode *cur = (DNode *)malloc(sizeof(DNode));
	cur->data = data;
	cur->next = head->next;
	cur->pre = head->pre;
	
	head->next = cur;
	cur->next->pre = cur;
	cur->pre = head;

}

void traverseList(DNode *head) {
	
	DNode *t = head->pre;
	while (t != head) {
		std::cout<<t->data<<std::endl;
		t = t->pre;
	}
	
}
