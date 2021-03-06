//
//  LoopQueue.hpp
//  06-Loop-Queue
//
//  Created by dzb on 2019/3/4.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef LoopQueue_hpp
#define LoopQueue_hpp

#include <stdio.h>
#include "Queue.hpp"
#include <iostream>
#include "ArrayList.hpp"

using namespace std;

template <typename E>
class LoopQueue : public Queue<E> {
private:
	E *_data;
	int _front; ///队首
	int _tail; ///队尾
	int _size; ///队列元素个数
	int _capacity; ///队列容量
	// 有兴趣的同学，在完成这一章后，可以思考一下：
	// LoopQueue中不声明size，如何完成所有的逻辑？
	// 这个问题可能会比大家想象的要难一点点：）
public:
	///构造方法
	explicit  LoopQueue();
	explicit  LoopQueue(int capacity);
	///析构函数
	~LoopQueue();
	int getSize();
	bool isEmpty();
	void enqueue(E e);
	int getCapacity();
	E dequeue();
	E getFront();
	void toString();
};


///构造方法
template <typename E>
LoopQueue<E>::LoopQueue() :LoopQueue(10) { }

template <typename E>
LoopQueue<E>::LoopQueue(int capacity) {
	_capacity = capacity;
	_data = new E[_capacity+1]();
	_front = _tail = _size = 0;
}
///析构函数
template <typename E>
LoopQueue<E>::~LoopQueue() {
	if (_data != nullptr) {
		delete _data;
		_data = nullptr;
	}
}

template <typename E>
int LoopQueue<E>::getSize() {
	return _size;
}

template <typename E>
bool LoopQueue<E>::isEmpty() {
	return (bool)(_front == _tail);
}

template <typename E>
int LoopQueue<E>::getCapacity() {
	return _capacity;
}

// 下一小节再做具体实现
template <typename E>
void LoopQueue<E>::enqueue(E e) {
	
}
// 下一小节再做具体实现
template <typename E>
E LoopQueue<E>::dequeue() {
	return 0;
}
// 下一小节再做具体实现
template <typename E>
E LoopQueue<E>::getFront() {
	return 1;
}

template <typename E>
void LoopQueue<E>::toString() {
	
}

#endif /* LoopQueue_hpp */

