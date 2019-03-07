//
//  dlist.hpp
//  list
//
//  Created by dzb on 2019/3/6.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef dlist_hpp
#define dlist_hpp

#include <stdio.h>


/**
 双向链表结构体
 */
struct DNode {
	int data;
	DNode *pre; ///上一个节点
	DNode *next; ///下一个节点
};

/**
 创建双向循环列表
 */
DNode *createDoubleList();

///插入元素
void insertList(DNode *head,int data);
///遍历
void traverseList(DNode *head);

#endif /* dlist_hpp */
