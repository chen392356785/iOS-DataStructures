//
//  main.cpp
//  03-A-Stack-Problem-in-Leetcode
//
//  Created by dzb on 2019/3/3.
//  Copyright © 2019年 大兵布莱恩特. All rights reserved.
//

#include <iostream>
#include "Stack/ArrayStack.hpp"

bool isValid(char *s) {
    size_t len = strlen(s);
    ArrayStack<char > stack(10);
    for(int i = 0 ; i < len ; i ++){
        char c = s[i];
        if(c == '(' || c == '[' || c == '{')
            stack.push(c);
        else{
            if(stack.isEmpty())
                return false;
            
            char topChar = stack.pop();
            if(c == ')' && topChar != '(')
                return false;
            if(c == ']' && topChar != '[')
                return false;
            if(c == '}' && topChar != '{')
                return false;
        }
    }
    return stack.isEmpty();
}

int main(int argc, const char * argv[]) {
    std::cout << isValid("()[]{}") << std::endl;
    std::cout << isValid("([)]") << std::endl;
    return 0;
}
