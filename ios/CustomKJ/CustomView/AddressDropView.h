//
//  AddressDropView.h
//  MiaotoLogistic
//
//  Created by Zmh on 7/1/17.
//  Copyright © 2017年 Zmh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressDropView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIButton *_btn;
    UIButton *_backBtn;
    
    NSDictionary *_dataDic;
    NSArray *dataArr;
    NSArray *cityArr;
    NSArray *itemArr;
    
    NSString *proviceStr;
    NSString *cityStr;
    NSString *AreaStr;
    
    int page;
}
-(void)hiddenBottomView;
@property(nonatomic,copy)DidSelectJobAdressBlock selectBtnBlock;
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
@end
