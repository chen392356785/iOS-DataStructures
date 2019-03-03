//
//  main.m
//  09-Amortized-Time-Complexity
//
//  Created by dzb on 2019/3/3.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <iostream>
#include "ArrayList.hpp"
#include<ctime>

using namespace std;

int main() {
	
	int num = 100;
	clock_t startTime = clock();
	ArrayList<int> array = ArrayList<int>(10);
	for (int i = 0; i<num; i++) {
		array.addLast(i);
	}
	clock_t endTime = clock();//计时结束
	
	double  duration = (double)(endTime - startTime)/CLOCKS_PER_SEC;
	printf( "%f seconds\n", duration );
	system("pause");
	
	//
	//	array.insert(100, 1);
	//	array.display();
	//
	//	array.addFirst(-1);
	//	array.display();
	//
	//	array.remove(2);
	//	array.display();
	//
	//	array.removeElement(4);
	//	array.display();
	//
	//	array.removeFirst();
	//
	//	array.display();
	
	
	
	return 0;
}
