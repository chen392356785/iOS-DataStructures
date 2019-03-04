//
//  main.cpp
//  05-Array-Queue
//
//  Created by dzb on 2019/3/4.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include <iostream>
#include "LoopQueue.hpp"

int main(int argc, const char * argv[]) {
	
// 下一小节再做具体实现
	LoopQueue<int> queue(10);
	for(int i = 0 ; i < 10 ; i ++){
		queue.enqueue(i);
		queue.toString();
		if(i % 3 == 2){
			queue.dequeue();
			queue.toString();
		}
	}
	
	return 0;
}
