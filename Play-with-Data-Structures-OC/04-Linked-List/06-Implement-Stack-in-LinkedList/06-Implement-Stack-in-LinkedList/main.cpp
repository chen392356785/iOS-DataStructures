//
//  main.cpp
//  01-Linked-List-Basics
//
//  Created by dzb on 2019/3/4.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include <iostream>
#include "LinkedList.hpp"
#include "LinkedListStack.hpp"
#include <iostream>
#include <stdlib.h>
#include <time.h>
#include "ArrayStack.hpp"

// 测试使用stack运行opCount个push和pop操作所需要的时间，单位：秒

double testArrayStack(ArrayStack<int> &q, int opCount){
	
	clock_t startTime = clock();
	size_t randnum = random();
	for(int i = 0 ; i < opCount ; i ++) {
		q.push(i);
		randnum++;
	}
	for(int i = 0 ; i < opCount ; i ++) {
		q.pop();
	}
	
	clock_t endTime = clock();
	
	return double(endTime - startTime) / CLOCKS_PER_SEC;
}

double testLinkListStack(LinkedListStack <int> &q, int opCount){
	
	clock_t startTime = clock();
	size_t randnum = random();

	for(int i = 0 ; i < opCount ; i ++) {
		q.push(i);
		randnum++;
	}
	for(int i = 0 ; i < opCount ; i ++) {
		q.pop();
	}
	
	clock_t endTime = clock();
	
	return double(endTime - startTime) / CLOCKS_PER_SEC;
}

int main(int argc, const char * argv[]) {

	{
		int opCount = 1000;
		ArrayStack< int> arrayStack;
		double time1 = testArrayStack(arrayStack,opCount);
		std::cout<<"ArrayStack, time: " << time1 << " s" << endl;
		
		LinkedListStack< int> linkStack;
		double time2 = testLinkListStack(linkStack,opCount);
		std::cout<<"LinkedListStack, time: " << time2 << " s" << endl;
		
		 // 其实这个时间比较很复杂，因为LinkedListStack中包含更多的new操作
	}
	
	getchar();
	
	return 0;
}
