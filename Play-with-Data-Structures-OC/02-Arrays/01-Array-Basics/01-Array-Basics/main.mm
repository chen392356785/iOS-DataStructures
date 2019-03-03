//
//  main.m
//  01-Array-Basics
//
//  Created by dzb on 2019/2/15.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	
	int arr[10] = {0};
	for (int i = 0; i<sizeof(arr)/sizeof(int); i++) {
		arr[i] = i;
	}
	
	int scores[] = {100,99,66};
	for (int i = 0; i<sizeof(scores)/sizeof(int); i++) {
		printf("scores[i] = %d\n",scores[i]);
	}
	
	///C++中的for in 方法
	for (int score : scores) {
		printf("score is %d",score);
	}
	
	scores[0] = 96;
	
	for (int i = 0; i<sizeof(scores)/sizeof(int); i++) {
		printf("scores[i] = %d\n",scores[i]);
	}
	
	
	return 0;
}
