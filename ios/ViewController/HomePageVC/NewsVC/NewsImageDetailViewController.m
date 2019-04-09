//
//  NewsImageDetailViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 24/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NewsImageDetailViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "NewsCommentListViewController.h"
#import "InputKeyBoardView.h"
#import "ImageDetailTableView.h"
#import "CustomView+CustomCategory2.h"

@interface NewsImageDetailViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *dataArr;
    NSMutableArray *descriptionArr;
    SMLabel *_pageLbl;
    UITextView *_detailLbl;
    UITextField *_pltxt;
    InputKeyBoardView *_keyBoardView;
    UIButton *_collectBtn;
    NewsImgCommentView *_commentV;
    ImageDetailTableView *_tableView;
}
@end

@implementation NewsImageDetailViewController

-(void)useMethodToFindBlackLineAndHind:(BOOL)isHidden
{
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    blackLineImageView.hidden = isHidden;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self useMethodToFindBlackLineAndHind:YES];
    
    //    UIImage *img = Image(@"Group 32.png");
    //    [leftbutton setBackgroundImage:img forState:UIControlStateNormal];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArr = [NSMutableArray array];
    descriptionArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor blackColor];
    _BaseScrollView.backgroundColor = [UIColor blackColor];
    
    if (self.infoModel.hasCollection == 1) {
        [self setApleaNavgationItem:YES];
    }else {
        [self setApleaNavgationItem:NO];
    }
    [self greatImageScroll];
    
}
- (void)greatImageScroll
{
    __weak NewsImageDetailViewController *weakSelf = self;
    _BaseScrollView.top = -64;
    
    for (NewsImageModel *imgMod in self.infoModel.imgModels) {
        [dataArr addObject:imgMod.img_path];
        [descriptionArr addObject:imgMod.descriptionStr];
    }
    //创建表视图
    CGRect frame = CGRectMake(-10, -64, WindowWith + 20, kScreenHeight - 40);
    _tableView = [[ImageDetailTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    //传数据
    _tableView.dataList = dataArr;
    [self.view addSubview:_tableView];
    
    NewsImgCommentView *commentV = [[NewsImgCommentView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 50)];
    commentV.bottom = WindowHeight;
    commentV.backgroundColor = RGBA(0, 0, 0, 0.4);
    [commentV setDataNum:(int)self.infoModel.commentTotal];
    [commentV.commList addTarget:self action:@selector(commentList:) forControlEvents:UIControlEventTouchUpInside];
    _commentV = commentV;
    [self.view addSubview:commentV];
    
    UITapGestureRecognizer *commTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentNews:)];
    commTap.numberOfTapsRequired= 1;
    commTap.numberOfTouchesRequired= 1;
    [commentV addGestureRecognizer:commTap];
    
    UIView *newDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 190)];
    newDetailView.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self.view addSubview:newDetailView];
    
    SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, 15, 20, 18) textColor:RGBA(255, 255, 255, 1) textFont:sysFont(14)];
    label.right = WindowWith - 8;
    label.text = [NSString stringWithFormat:@"/%d",(int)dataArr.count];
    [newDetailView addSubview:label];
    
    SMLabel *pageLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, 15, 20, 18) textColor:RGBA(255, 255, 255, 1) textFont:sysFont(17)];
    pageLbl.right = label.left;
    pageLbl.text = @"1";
    pageLbl.textAlignment = NSTextAlignmentRight;
    _pageLbl = pageLbl;
    [newDetailView addSubview:pageLbl];
    
    SMLabel *titleLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, 15, label.left - 15, 18) textColor:RGBA(255, 255, 255, 1) textFont:sysFont(19)];
    titleLbl.text = self.infoModel.info_title;
    [newDetailView addSubview:titleLbl];
    
    SMLabel *sourceLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(titleLbl.left, titleLbl.bottom + 8, titleLbl.width, 15) textColor:RGBA(255, 255, 255, 1) textFont:sysFont(15)];
    sourceLbl.text = [NSString stringWithFormat:@"来源：%@",self.infoModel.info_from];
    [newDetailView addSubview:sourceLbl];
    
    
    UITextView *detailLbl = [[UITextView alloc] initWithFrame:CGRectMake(12, sourceLbl.bottom + 17, WindowWith-24, 100)];
    detailLbl.backgroundColor = [UIColor clearColor];
    [detailLbl setEditable:NO];
    detailLbl.text = descriptionArr[0];
    detailLbl.textColor = RGBA(255, 255, 255, 1);
    detailLbl.font = sysFont(15);
    _detailLbl = detailLbl;
    [newDetailView addSubview:detailLbl];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, detailLbl.bottom + 20, WindowWith, 0.5)];
    lineView.backgroundColor = RGBA(44, 44, 46, 1);
    [newDetailView addSubview:lineView];
    
    newDetailView.height = lineView.bottom;
    newDetailView.bottom = commentV.top;
    
    _tableView.selectBlock = ^(NSInteger index){
        [weakSelf scrollImage:index];
    };
    
    UITextField *txt=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0)];
    _pltxt=txt;
    [self.view addSubview:txt];
    _keyBoardView=[[InputKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)  submit:^(NSString *str) {
        [weakSelf createComment:str];
    } back:^{
        [weakSelf resignKeyBoard];
    }];
    txt.inputAccessoryView =_keyBoardView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollImage:(NSInteger)index
{
    _pageLbl.text = [NSString stringWithFormat:@"%zd",index];
    _detailLbl.text = descriptionArr[index-1];
}

#pragma mark- 收藏活动
- (void)collection
{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    __weak NewsImageDetailViewController *weakSelf = self;
    [network collectNews:[NSString stringWithFormat:@"%d",self.infoModel.info_id] success:^(NSDictionary *obj) {
        [weakSelf addSucessView:@"你成功喜欢" type:1];
        self.infoModel.hasCollection = 1;
        //        _collectBtn.selected = YES;
        self->searchBtn.selected = YES;
        [self.delegate disPalyNewsCollect:self.infoModel indexPath:self.indexPath];
        
    }];
}

#pragma mark-分享
- (void)share
{
    //  [self ShareUrl:self withTittle:[NSString stringWithFormat:@"[图集]%@",self.infoModel.info_title] content:self.infoModel.infomation_desc withUrl:self.infoModel.infomation_url];
    
    [self shareView:ENT_Photos object:self.infoModel vc:self];
}

- (void)commentNews:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:_commentV];
    if (CGRectContainsPoint(_commentV.commentLbl.frame, point)) {
        [self becomeKeyBoard];
    }
}
-(void)becomeKeyBoard{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    //    self.isReply=NO;
    [_pltxt becomeFirstResponder];
    [_keyBoardView.txtView becomeFirstResponder];
}
-(void)resignKeyBoard{
    [_keyBoardView.txtView resignFirstResponder];
    [_pltxt resignFirstResponder];
}

-(void)createComment:(NSString *)content{
    
    [self resignKeyBoard];
    
    int commentType=0;
    int replyComment_id=0;
    int replyUserID=0;
    NSString *replyUserName;
    [self addWaitingView];
    
    [network getAddNewsComment:self.infoModel.info_id user_id:[USERMODEL.userID intValue] reply_user_id:replyUserID reply_nickname:replyUserName info_comment:content comment_type:commentType reply_info_comment_id:replyComment_id success:^(NSDictionary *obj) {
        self->_keyBoardView.txtView.text = @"";
        int number = [self->_commentV.commList.titleLabel.text intValue] + 1;
        [self->_commentV.commList setTitle:stringFormatInt(number) forState:UIControlStateNormal];
        [self removeWaitingView];
        
        [self addSucessView:@"评论成功" type:1];
    }];
}

- (void)commentList:(UIButton *)btn
{
    NewsCommentListViewController *commentVC = [[NewsCommentListViewController alloc] init];
    commentVC.infoModel = self.infoModel;
    [self pushViewController:commentVC];
}

@end
