//
//  Stack.hpp
//  02-Array-Stack
//
//  Created by dzb on 2019/3/3.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef Stack_hpp
#define Stack_hpp

#include <stdio.h>

template <class E>
class Stack {
	
public:
	virturl int getSize();
	virturl bool isEmpty();
	virturl void push(E e);
	virturl E pop();
	virturl E peek();
};

#endif /* Stack_hpp */
