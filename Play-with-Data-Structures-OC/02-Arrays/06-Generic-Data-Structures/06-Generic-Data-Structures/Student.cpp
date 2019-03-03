//
//  Student.cpp
//  06-Generic-Data-Structures
//
//  Created by dzb on 2019/2/28.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#include "Student.hpp"
#include <iostream>
using namespace std;

Student::Student(char *name,int score) : _name(name) ,_score(score)  {
	cout << "Student(char *name,int score)构造函数 " << endl;
}

Student::~Student() {
	cout << "Student::~Student() 析构函数 " << endl;
}

void Student::toString() {
	cout << "name is " << this->_name <<" score is " <<this->_score << endl;
}
