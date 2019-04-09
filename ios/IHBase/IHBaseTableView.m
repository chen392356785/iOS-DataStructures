//
//  IHBaseTableView.m
//  IHBaseProject
//
//  Created by yaoyongping on 13-1-8.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "IHBaseTableView.h"

@implementation IHBaseTableView

-(id)initWithFrame:(CGRect)frame{
	self=[super initWithFrame:frame];
	if (self) {
		UITableView *t=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[t setBackgroundColor:[UIColor clearColor]];
        [self addSubview:t];
		self.table=t;
        t.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame tableviewStyle:(UITableViewStyle)tableviewStyle{
	self=[super initWithFrame:frame];
	if (self) {
		UITableView *t=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:tableviewStyle];
        [t setBackgroundColor:[UIColor clearColor]];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;     //键盘隐藏
		[self addSubview:t];
		self.table=t;
	}
	return self;
}

-(void)setupData:(NSArray *)data index:(int)index{
	
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
	self.styleIndex=index;
	if (self.datasource==nil) {
        
        
	}
    
	self.datasource.attributes=self.attribute;
	self.datasource.allowEdit=self.allowEdit;
	self.datasource.datasource=data;
	self.table.dataSource=self.datasource;
	if (self.datasource!=nil) {
		[self.table reloadData];
	}
    
}

-(void)setFrame:(CGRect)r{
	[super setFrame:r];
	CGRect f=self.table.frame;
	f.size.width=r.size.width;
	f.size.height=r.size.height;
	self.table.frame=f;
	
}
//
//-(float)getCellHeight{
//	return self.tableViewCellHeight;
//}

-(void)dealloc{

}

@end
