#include "list.h"
#include <iostream>

//创建空链表
Node * createList() {
    Node *head = (Node *) malloc(sizeof (Node));
    head->next = nullptr;
	return head;
}

///插入元素
void insertList(Node *head,int data) {
	Node *cur = (Node *)malloc(sizeof(Node));
	cur->data = data;
	cur->next = head->next;
	head->next = cur;
}

///便利链表
void travereList(Node *head) {
	head = head->next;
	while (head) {
		std::cout<<head->data<<std::endl;
		head = head->next;
	}
}

///链表长度
int lenList(Node *head) {
	int count = 0;
	head = head->next;
	while (head) {
		count++;
		head = head->next;
	}
	return count;
}

///搜索链表元素
Node * serchList(Node *head,int find) {
	head = head->next;
	while (head) {
		if (head->data == find) {
			break;
		}
		head = head->next;
	}
	return head;
}
///删除链表元素
void deleteList(Node *head,Node *pFind) {
	
	if (pFind->next == NULL) {
		while (head->next != pFind) {
			head = head->next;
		}
		head->next = pFind->next;
		free(pFind);
	} else {
		pFind->data = pFind->next->data;
		Node *t = pFind->next;
		pFind->next = t->next;
		free(t);
	}

}

/// 排序
void popSortList(Node *head) {
	///交换数据
	Node *p,*q;
	int len = lenList(head);
	for (int i = 0; i<len-1; i++) {
		p = head->next;
		q = p->next;
		for (int j = 0; j<len-1-i; j++) {
			if (p->data > q->data) {
				p->data ^= q->data;
				q->data ^= p->data;
				p->data ^= q->data;
			}
			p = p->next;
			q = q->next;
		}
	}
	
}
///逆置链表
void reverseList(Node *head) {
	Node *h = head->next;
	head->next = NULL;
	Node *t;
	while (h) {
		t = h->next;
		h->next = head->next;
		head->next = h;
		h = t;
	}
}

///销毁链表
void destroyList(Node *head) {
	Node *t;
	while (head) {
		t = head->next;
		free(head);
		head = t;
	}
}
