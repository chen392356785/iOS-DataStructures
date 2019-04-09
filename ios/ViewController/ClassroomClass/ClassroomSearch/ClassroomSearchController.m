//
//  ClassroomSearchController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/15.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ClassroomSearchController.h"
#import "MTHomeSearchView.h"
#import "ClassSourceListController.h"


@interface ClassroomSearchController () <TFFlowerSearchViewDelegate>{
    MTHomeSearchView *searchView;
    NSMutableArray *btnArray; //热门搜索
}

@end

@implementation ClassroomSearchController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [searchView.searchTextField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    btnArray =[[NSMutableArray alloc]init];
    
    [self setNavgaitonBar];
    [self initViews];
}

#pragma - mark 设置导航栏
- (void) setNavgaitonBar {    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = kWidth(1);
    leftbutton.frame = CGRectMake(0, 0, 0, 44);
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    leftbutton.hidden = YES;
    
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
    //修改标题和标题颜色
    leftBut.frame=CGRectMake(0, 0, 0, 44);
    
    
    UIView *leftCustomView = [[UIView alloc] initWithFrame:leftBut.frame];
    [leftCustomView addSubview: leftBut];
    UIBarButtonItem * leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView: leftCustomView];
    self.navigationItem.leftBarButtonItems = @[leftButtonItem];
    
    searchView = [[MTHomeSearchView alloc] initWithFrame:CGRectMake(kWidth(20), 0,iPhoneWidth - kWidth(50) ,34)];
    searchView.layer.borderWidth = 0.0;
    searchView.layer.cornerRadius = 6;
    searchView.clipsToBounds = YES;
    searchView.delegate = self;
    searchView.backgroundColor = kColor(@"#f1f4f7");
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索你感兴趣的课程或导师" attributes:
                                      @{NSForegroundColorAttributeName:kColor(@"#999999"),
                                        NSFontAttributeName:searchView.searchTextField.font
                                        }];
    searchView.searchTextField.attributedPlaceholder = attrString;
    self.navigationItem.titleView = searchView;
    searchView.searchTextField.textColor = [UIColor blackColor];
    searchView.searchTextField.text = self.Model.keyWord;
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //修改标题和标题颜色
    cancleBtn.frame=CGRectMake(0, 0, 34, 44);
    UIBarButtonItem *rightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpacer.width = kWidth(16);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = sysFont(15);
    [cancleBtn setTitleColor:kColor(@"#2b2b2b") forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithCustomView:cancleBtn];
    self.navigationItem.rightBarButtonItems = @[cancleItem,rightSpacer];
}

- (void) cancleAction {
     [searchView.searchTextField resignFirstResponder];
     [self.navigationController popViewControllerAnimated:YES];
}
- (void)initViews {
     __weak ClassroomSearchController *weakSelf=self;
    //热门搜索
    for (keywordListModel *model in self.Model.keywordList) {
        [btnArray addObject:model.keywordName];
    }
    ButtonTypesetView *HotSearchView = [[ButtonTypesetView alloc] initWithFrame:CGRectMake(10, kWidth(34), WindowWith - 20, 300) dataArr:btnArray title:@"热门搜索"];
    HotSearchView.selectBlock = ^(NSInteger index){
        [weakSelf creatSearch:index];
        
    };
    [self.view addSubview:HotSearchView];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, HotSearchView.bottom, WindowWith-24, 1)];
    lineView.backgroundColor = cLineColor;
    [self.view addSubview:lineView];
}
#pragma - mark Tag
-(void)creatSearch:(NSInteger)index{
    NSString *SearTagStr = btnArray[index];
    searchView.searchTextField.text = SearTagStr;
    [self searchDataText:SearTagStr];
}
#pragma - mark TFFlowerSearchViewDelegate 搜索
- (void)flowerSearchViewWithText:(NSString *)searchText textField:(UITextField *)textField{
    [self searchDataText:textField.text];
}
- (void) searchDataText:(NSString *) searText{
    [searchView.searchTextField resignFirstResponder];
    NSDictionary *dict = @{
                           @"title"     : searText,
                           @"type"      : @"2",
                           };
    [self addWaitingView];
    [network httpRequestWithParameter:dict method:selectClassSearchlUrl success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSDictionary *dict = obj[@"content"];
        NSArray *arr = dict[@"studyClassList"];
        if (arr.count == 0) {
            [self showHomeHint:@"没有找到你要的内容哦~"];
            return ;
        }
        
        NSMutableArray *dataArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arr) {
            studyBannerListModel *model = [[studyBannerListModel alloc] initWithDictionary:dict error:nil];
            [dataArr addObject:model];
        }
       
        ClassSourceListController *listVc = [[ClassSourceListController alloc] init];
        listVc.titleStr = searText;
        listVc.IsSearchVcJump = YES;
        listVc.SearchArr = dataArr;
        [self pushViewController:listVc];
    } failure:^(NSDictionary *obj2) {
        [self removeWaitingView];
    }];
}
@end
