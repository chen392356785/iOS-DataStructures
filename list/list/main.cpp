//
//  main.cpp
//  list
//
//  Created by dzb on 2019/3/6.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include <time.h>
#include <stdlib.h>
#include <iostream>
#include "DualLinkList.hpp"
//#include "SingleLinkList.hpp"

//bool HasCircle(Node *head) {
//	Node *pFastNode = head;
//	Node *pSlowNode = head;
//	while (pFastNode != NULL && pFastNode->next != NULL) {
//		pFastNode = pFastNode->next->next;
//		pSlowNode = pSlowNode->next;
//		if (pSlowNode == pFastNode) {
//			return true;
//		}
//	}
//	return false;
//}

//
////	DNode *head = createDoubleList();
////	for (int i = 0; i<10; i++) {
////		insertList(head,i);
////	}
////	traverseList(head);
//
////	std::cout<<HasCircle(head)<<std::endl;
//
//
//	Node *head2 = createList();
//	for (int i = 0; i<10; i++) {
//		insertList(head2,i);
//	}
//
//	std::cout<<HasCircle(head2)<<std::endl;
//
//
////
//////	Node *n1 = serchList(head,1001);
//////	Node *n2 = serchList(head,2222);
//////	deleteList(head, n1);
//////	deleteList(head, n2);
//////	travereList(head);
////
//////	popSortList(head);
////
////
////	reverseList(head);
////	travereList(head);
////
////	destroyList(head);
//

int main(int argc, const char * argv[]) {

	DualLinkList<int> linklist;
	linklist.insertList(100);
	linklist.insertList(33);
	linklist.insertList(655);
    linklist.travereList();
//	std::cout<<linklist.lenList()<<std::endl;
//	
//	Node<int> *n = linklist.serchList(33);
//	if (n != nullptr) {
//		std::cout<<"n->_data is " << n->_data << std::endl;
////		linklist.deleteList(n);
//	}
//	
//	linklist.popSortList();
//	linklist.travereList();
//	linklist.reverseList();
//	linklist.travereList();

	getchar();
	
	return 0;
}
