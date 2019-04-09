//
//  AddressDropView.m
//  MiaotoLogistic
//
//  Created by Zmh on 7/1/17.
//  Copyright © 2017年 Zmh. All rights reserved.
//

#import "AddressDropView.h"

@implementation AddressDropView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(44, 44, 46, .4);
        
        proviceStr = @"";
        cityStr = @"";
        AreaStr = @"";
        
        page = 0;
         [self _addTapGestureRecognizerToSelf];
        [self getPickerData];
        [self createView];
        
    }
    return self;
    
}

-(void)_addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}
-(void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
#pragma mark - get data
- (void)getPickerData
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dataArea2" ofType:@"plist"];
    NSDictionary *root=[[NSDictionary alloc] initWithContentsOfFile:path];
    _dataDic = root;
    dataArr = [root allKeys];

    

}
 - (void)createView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 45)];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(28, 9, (WindowWith - 28 - 20)/3.0, 36);
    _btn.backgroundColor = [UIColor whiteColor];
    _btn.titleLabel.font = sysFont(14);
    [_btn setTitle:@"全部" forState:UIControlStateNormal];
    [_btn setTitleColor:cBlackColor forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(allBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_btn];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(_btn.right +4, 9, (WindowWith - 28 - 20)/3.0, 36);
    _backBtn.backgroundColor = [UIColor whiteColor];
    _backBtn.titleLabel.font = sysFont(14);
    _backBtn.hidden = YES;
    [_backBtn setTitle:@"返回上一级" forState:UIControlStateNormal];
    [_backBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_backBtn];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, self.height - 60) style:UITableViewStylePlain];
    tableView.backgroundColor = cBgColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.tableHeaderView = view;
    _tableView = tableView;
    [self addSubview:tableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (page == 0) {
        return dataArr.count;
    }else{
        return 1;
    }
    

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"tableCelleID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    [cell removeAllSubviews];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.tag = indexPath.row;
    SMLabel *lbl = [[SMLabel alloc ] initWithFrameWith:CGRectMake(8, 0, 12, cell.height) textColor:cGrayLightColor textFont:sysFont(12)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines= 0;
    [cell addSubview:lbl];
    
    NSArray *array;
    if (page ==0) {
        //获取分区划分省份
        NSDictionary *Dic = _dataDic[dataArr[indexPath.row]];
        array = [Dic allKeys];
        lbl.text = dataArr[indexPath.row];
    }else{
        if (page == 1) {
            lbl.text = proviceStr;
        }else{
            lbl.text = cityStr;
        }
        
        array = itemArr;
    }
    
    lbl.height = ((array.count - 1)/3+1)*40 ;
    
    for (int i = 0; i<array.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(28 + i%3 * ((WindowWith - 28 - 20)/3.0 + 4), 4 + i/3*(36 + 4), (WindowWith - 28 - 20)/3.0, 36);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.titleLabel.font = sysFont(14);
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectedAddress:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array;
    if (page ==0) {
        NSDictionary *Dic = _dataDic[dataArr[indexPath.row]];
        array = [Dic allKeys];
    }else {
        array = itemArr;
    }
    CGFloat height = ((array.count - 1)/3+1)*40 ;
    
    return height;
}


- (void)selectedAddress:(UIButton *)button
{
    _backBtn.hidden = NO;
    
    if (page == 0) {
        //获取点击省份所有的市数组
        UITableViewCell *cell = (UITableViewCell *)button.superview;
        NSDictionary *Dic = _dataDic[dataArr[cell.tag]];
        NSArray *array = [Dic objectForKey:button.titleLabel.text];
        NSMutableArray *mutArr  = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            [mutArr addObject:dic[@"name"]];
        }
        
        itemArr = mutArr;
        cityArr = array;
        
        page++;
        proviceStr = button.titleLabel.text;
        
        [_tableView reloadData];
    }else if(page == 1){
        
        for (NSDictionary *dic in cityArr) {
            if ([dic[@"name"] isEqualToString:button.titleLabel.text]) {
                itemArr = dic[@"sub"];
            }
        }
        
        page++;
        cityStr = button.titleLabel.text;
        
        [_tableView reloadData];
    }else{
        AreaStr = button.titleLabel.text;
        self.selectBtnBlock(proviceStr,cityStr,AreaStr,@"");
        [self hiddenBottomView];
        self.selectBlock(SelectBtnBlock);
    }
    
    
}

- (void)allBtn:(UIButton *)button
{
    self.selectBtnBlock(proviceStr,cityStr,AreaStr,@"");
    [self hiddenBottomView];
     self.selectBlock(SelectBtnBlock);
}

- (void)backBtn:(UIButton *)button
{
    page--;
    
    if (page == 0) {
        
        _backBtn.hidden = YES;
        [_tableView reloadData];
        cityStr = @"";
        
    }else if(page == 1){
        NSMutableArray *mutArr  = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in cityArr) {
            [mutArr addObject:dic[@"name"]];
        }
        
        itemArr = mutArr;
        [_tableView reloadData];
        
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
