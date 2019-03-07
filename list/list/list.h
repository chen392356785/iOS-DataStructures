#ifndef LIST_H
#define LIST_H

#include <stdlib.h>

struct Node {
    int data;
    Node *next;
};

//创建空链表
Node * createList();
///插入元素
void insertList(Node *head,int data);
///便利链表
void travereList(Node *head);
///链表长度
int lenList(Node *head);
///搜索链表元素
Node * serchList(Node *head,int find);
///删除链表元素
void deleteList(Node *head,Node *pFind);
/// 排序
void popSortList(Node *head);
///逆置链表
void reverseList(Node *head);
///销毁链表
void destroyList(Node *head);

#endif // LIST_H
