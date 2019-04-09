//
//  DFCommentViewController.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFConstant.h"
#import "DFIconConstant.h"
#import "DFCommentViewController.h"
#import "DFUserCommentView.h"
#import "DFUserCommentCell.h"
#import "DFCommentTopCell.h"
#import "DFCommentModel.h"
#import "DFIdentifierConstant.h"
#import "DFDiscernListModel.h"

@interface DFCommentViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) DFUserCommentView *commentView;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, assign) NSInteger nowPage;

@end

@implementation DFCommentViewController

- (NSMutableArray *)listArray {
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configureView];
    
    [self getCommentListData];
}

- (DFUserCommentView *)commentView {
    return (DFUserCommentView *)self.view;
}

#pragma mark - 配置页面
- (void)configureView {
    DFUserCommentView *commentView = [[DFUserCommentView alloc]init];
    self.view = commentView;
    
    DFNavigationView *navigationView = commentView.navigationView;
    [navigationView.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    commentView.tableView.delegate = self;
    commentView.tableView.dataSource = self;
    [commentView.tableView registerClass:[DFUserCommentCell class] forCellReuseIdentifier:CommentListIdentifier];
    [commentView.tableView registerClass:[DFCommentTopCell class] forCellReuseIdentifier:CommentHeaderIdentifier];
    [commentView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CommentTitleIdentifier];
    commentView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    commentView.tableView.mj_header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(getCommentListData)];
    commentView.tableView.mj_footer = [MJRefreshAutoBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreCommentListData)];
//    commentView.tableView.mj_footer.automaticallyHidden = YES;
	
    [commentView.tableView.mj_header beginRefreshing];
    
    [commentView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    commentView.textField.delegate = self;
    [commentView.sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 获取评论列表数据
- (void)getCommentListData {
    [self.commentView.tableView.mj_footer endRefreshing];
    
    self.nowPage = 1;
    [HttpRequest getCommentListInfoWith:self.listModel.ID nowPage:self.nowPage success:^(NSDictionary *result) {
        [self.commentView.tableView.mj_header endRefreshing];
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            NSArray *array = result[DFData];
            if (TTValidateArray(array) && array.count != 0) {
                [self.listArray removeAllObjects];
                self.nowPage ++;
                for (NSDictionary *commDic in array) {
                    DFCommentModel *commentModel = [DFCommentModel mj_objectWithKeyValues:commDic];
                    [self.listArray addObject:commentModel];
                }
            }
            if (self.listArray.count < 10) {
                [self.commentView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.commentView.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.commentView.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 获取更多评论列表数据
- (void)getMoreCommentListData {
    [self.commentView.tableView.mj_header endRefreshing];
    [HttpRequest getCommentListInfoWith:self.listModel.ID nowPage:self.nowPage success:^(NSDictionary *result) {
        [self.commentView.tableView.mj_footer endRefreshing];
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            NSArray *array = result[DFData];
            if (TTValidateArray(array)) {
                if (array.count > 0) {
                    self.nowPage ++;
                    for (NSDictionary *commDic in array) {
                        DFCommentModel *commentModel = [DFCommentModel mj_objectWithKeyValues:commDic];
                        [self.listArray addObject:commentModel];
                    }
                }else {
                    [self.commentView.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [self.commentView.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.commentView.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.listArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DFCommentTopCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentHeaderIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.flowerImageView setImageWithURL:[NSURL URLWithString:self.listModel.ImagePath] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [cell.userHeader sd_setImageWithURL:[NSURL URLWithString:self.listModel.HeadImage] placeholderImage:kImage(UserHeaderIcon)];
        cell.userName.text = self.listModel.NickName;
        cell.userName.textAlignment = NSTextAlignmentCenter;
        return cell;
    }else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTitleIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = DFCommentString();
        cell.textLabel.font = kRegularFont(14);
        cell.textLabel.textColor = THTitleColor3;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5 * TTUIScale(), iPhoneWidth, 0.5 * TTUIScale())];
        lineView.backgroundColor = THLineColor;
        [cell.contentView addSubview:lineView];
        return cell;
    }else {
        DFUserCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentListIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        DFCommentModel *commentModel = self.listArray[indexPath.row];
        cell.commentModel = commentModel;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 380 * TTUIScale();
    }else if (indexPath.section == 1) {
        return 50 * TTUIScale();
    }else {
        DFCommentModel *commentModel = self.listArray[indexPath.row];
        return 60 * TTUIScale() + [self heightWithString:commentModel.Content];;
    }
}

#pragma mark - 提交评论
- (void)sendMessage {
    
    NSString *commentText = self.commentView.textField.text;
    if (!commentText || [commentText isEqualToString:@""]) {
        [DFTool showTips:DFSpaceLetterString()];
        return ;
    }
    
    
//    [DFTool addWaitingView:self.view];
    [HttpRequest postAddCommentInfoWith:self.listModel.ID content:commentText success:^(NSDictionary *result) {
//        [DFTool removeWaitingView:self.view];
        
        if (!TTValidateDictionary(result)) {
            return ;
        }
        
        if ([result[DFErrCode]integerValue] == 200) {
            [self.commentView.textField resignFirstResponder];
            [self getCommentListData];
            
            self.commentView.textField.text = @"";
        }
        
        [DFTool showTips:result[DFErrMsg]];
        
    } failure:^(NSError *error) {
//        [DFTool removeWaitingView:self.view];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.commentView.textField) {
        [self.commentView.textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.commentView.textField) {
        if (textField.text.length > 200) {
            textField.text = [textField.text substringToIndex:200];
        }
    }
}

#pragma mark - 计算评论内容高度
- (CGFloat)heightWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:PingFangRegularFont() size:14 * TTUIScale()];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat height = [string boundingRectWithSize:CGSizeMake(iPhoneWidth - 80 * TTUIScale(), 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return height + 2;
}

#pragma mark - 返回
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
