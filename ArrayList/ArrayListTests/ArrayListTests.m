//
//  ArrayListTests.m
//  ArrayListTests
//
//  Created by dzb on 2018/7/19.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArrayStack.h"
#import "ArrayQueue.h"

@interface ArrayListTests : XCTestCase

@end

@implementation ArrayListTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
	
	
//	[self testStack];
//	BOOL valid = [self isValid:@"{ [ ( ) ] }"];
	
	[self testQueue];
}

- (void) testStack {
	ArrayStack <NSNumber *> *stack = [ArrayStack stackWithCapacity:10];
	for (int i = 0; i<10; i++) {
		[stack push:@(i)];
	}
	NSLog(@"%ld",(long)stack.size);
	NSLog(@"%ld",(long)stack.isEmpty);
	NSLog(@"%@",stack);
	
	id obj = [stack pop];
	NSLog(@"%@",obj);
	
	NSLog(@"%@",stack);
	
	[stack removeAllObjects];
	
	NSLog(@"%@",stack);
	
}

/**
 编译器匹配 {} [] ()

 @param string 字符串
 @return 匹配字符串是否正常关闭
 */
- (BOOL) isValid:(NSString *)string {
	
	ArrayStack <NSString *> *stack = [ArrayStack stackWithCapacity:10];
	const char * strArray = string.UTF8String;
	size_t len = strlen(strArray);
	for (int i = 0; i<len; i++) {
		char c = strArray[i];
		if (c == '{' || c == '[' || c == '(') {
			[stack push:c];
		}
		printf("%c\n",c);
	}
	return YES;
}

- (void) testQueue {
	
	ArrayQueue <NSNumber *> *queue = [ArrayQueue arrayQueue];
	for (int i = 0; i<10; i++) {
		[queue enqueue:@(i)];
		NSLog(@"queue = %@",queue);
		if (i % 3 == 2) {
			[queue dequeue];
			NSLog(@"queue = %@",queue);
		}
	}


}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
