//
//  Student.hpp
//  06-Generic-Data-Structures
//
//  Created by dzb on 2019/2/28.
//  Copyright © 2019 大兵布莱恩特. All rights reserved.
//

#ifndef Student_hpp
#define Student_hpp

#include <stdio.h>
class Student {
private:
	char *_name;
	int _score;
public:
	Student(char *name,int score);
	void toString();
	~Student();
};


#endif /* Student_hpp */
