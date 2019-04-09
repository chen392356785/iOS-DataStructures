//
//  NewSlideHeadingViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/6/23.
//  Copyright © 2016年 xubin. All rights reserved.
//

#define SCR_W     self.view.frame.size.width
#define SCR_H     self.view.frame.size.height
#define LAST_LABEL_FOUT 13
#define NOW_LABEL_FOUT 13
#define TAG_ONEHUNDRED 100

#define TABBAR

typedef enum {
    
    AXC_ZERO  =0,
    AXC_ADD,
    AXC_ATWO,
    AXC_ATHR,
    AXC_FOUR,
    TENOFADD  =10
    
}AXC_ENUM;

#define SIX_TEN  (TENOFADD + TENOFADD ) * AXC_ATHR
#define EIGHT_TEN  (TENOFADD + TENOFADD ) * AXC_FOUR


#import "NewSlideHeadingViewController.h"
#import "NewsTableListViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "NewsDetailViewController.h"
#import "NewsImageDetailViewController.h"
@interface NewSlideHeadingViewController ()<UIScrollViewDelegate,UITableViewDelegate,NewsDataSourceDelegate>
{
    UIScrollView *_titleScrollView;
    
    UIScrollView *_contentScrollView;
    
    NSInteger _lastSelectedTag;
    
    NSInteger _lastSelectedViewTag;
    NSInteger _pageNum;
    SearchView *_searchV;
    UIView *_lineView;
    NSMutableArray *controllerArray;
    NSString *_NewsName;
    
    UIView *_searchView;//搜索结果遮罩
    NSMutableArray *dataArray;
    NSMutableArray *btnArray;//热门搜索或者附近的人
    NSArray *array;//附近的人
    
    NSInteger btnIndex;//选择按钮的索引
    MTBaseTableView *commTableView;
    SearchType _searchType;
}

@end

@implementation NewSlideHeadingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightButtonImage:Image(@"Search Icon.png") forState:UIControlStateNormal];
    _searchView.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    controllerArray=[[NSMutableArray alloc]init];
    [self addPortData];
    [self setTitle:@"园林资讯"];
    
    // self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.view.backgroundColor = RGB(249, 249, 249);
    
    [self addTitleScrollView];
    
    [self addContentScreollView];
    [self addSearchListView];
}

- (void)home:(id)sender
{
    _searchType=ENT_CloseSearch;
    __weak NewSlideHeadingViewController *weakSelf=self;
    SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 44)];
    searchV.backgroundColor = self.navigationController.navigationBar.backgroundColor;
    _searchV = searchV;
    //__weak SearchView *searchSelf = searchV;
    searchV.button.hidden=NO;
    _searchView.hidden = NO;
    searchV.textfiled.placeholder=@"请输入想找的资讯";
    [searchV.textfiled becomeFirstResponder];
    searchV.selectBtnBlock = ^(NSInteger index){
        if (index == SelectBackVC) {
            [weakSelf selectBack];
        }else if (index == SelectBtnBlock){
            [weakSelf selectBtn];
        }else if (index == openBlock){
            //开始编辑搜索框内容
            self->_searchView.hidden = NO;
        }
    };
    
    [self.navigationController.navigationBar addSubview:searchV];
    rightbutton.hidden = YES;
    NSArray *Arr=[IHUtility getUserdefalutsList:kSearchNewsHistory];
    [commTableView setupData:Arr index:45];
}

//点击取消
-(void)selectBack {
    _searchType=ENT_CloseSearch;
    __weak NewSlideHeadingViewController *weakSelf=self;
    __weak SearchView *searchSelf = _searchV;
    if (_NewsName.length > 0) {
        _NewsName = @"";
        searchSelf.textfiled.text=@"";
        //刷新列表
        [weakSelf beginRefesh:ENT_RefreshHeader];
    }
    //隐藏搜索遮罩
    _searchView.hidden = YES;
    [dataArray removeAllObjects];
    [searchSelf.textfiled resignFirstResponder];
    
    [_searchV removeFromSuperview];
    
    rightbutton.hidden = NO;
    //[self back:nil];
}
//点击搜索
-(void)selectBtn {
    _searchType=ENT_Search;
    __weak NewSlideHeadingViewController *weakSelf=self;
    __weak SearchView *searchSelf = _searchV;
    
    _NewsName = searchSelf.textfiled.text;
    // _searchView.hidden = YES;
    //刷新列表
    //[weakSelf beginRefesh:ENT_RefreshHeader];
    [self setCommtableView];
    
    [weakSelf SaveSearchHistory:_NewsName];
}

-(void)setCommtableView{
    
    [network selectInformationBytitle:_NewsName success:^(NSDictionary *obj) {
        
        NSArray *arr=obj[@"content"];
        if (self->dataArray.count>0) {
            [self->dataArray removeAllObjects];
        }
        [self->dataArray addObjectsFromArray:arr];
        
        [self->commTableView setupData:self->dataArray index:54];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)SaveSearchHistory:(NSString *)searchText
{
    
    NSArray *Arr=[IHUtility getUserdefalutsList:kSearchNewsHistory];
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:Arr];
    for (NSString *str in Arr) {
        if ([str isEqualToString:searchText]) {
            [arr removeObject:str];
        }
    }
    [arr addObject:searchText];
    [IHUtility saveUserDefaluts:arr key:kSearchNewsHistory];
    
    commTableView.hidden=NO;
    // [commTableView setupData:arr index:45];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchV removeFromSuperview];
}

- (void)addPortData{
    _ShowPagesClassNameArray=[[NSMutableArray alloc]init];
    _arrayTittles=[[NSMutableArray alloc]init];
    _programIdArray=[[NSMutableArray alloc]init];
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutInit];
    
    for (NSDictionary *obj in dic[@"infomationProgramLsit"]) {
        [_arrayTittles addObject:obj[@"program_name"]];
        [_programIdArray addObject:obj[@"program_id"]];
    }
    for (NSInteger i=0; i<_arrayTittles.count; i++) {
        [_ShowPagesClassNameArray addObject:@"NewsTableListViewController"];
    }
    _pageNum = _ShowPagesClassNameArray.count;
}

- (void)addSearchListView{
//    __weak NewSlideHeadingViewController *weakSelf=self;
    dataArray =[[NSMutableArray alloc]init];
    _searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];
    _searchView.backgroundColor=[UIColor whiteColor];
    _searchView.hidden=YES;
    [self.view addSubview:_searchView];
    
    //[dataArray addObjectsFromArray:Arr];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 10, WindowWith, WindowHeight - 10) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    //[commTableView setupData:dataArray index:45];
    
    [_searchView addSubview:commTableView];
}

- (void)addTitleScrollView{
    
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(AXC_ZERO,0, SCR_W, 40)];
    _titleScrollView.backgroundColor = RGB(249, 249, 249);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置滚动视图的滑动范围
    //设置标题的宽度
    CGFloat labelW = EIGHT_TEN;
    _titleScrollView.contentSize = CGSizeMake(labelW * _arrayTittles.count, AXC_ZERO);
    
    //添加label
    for (int i = AXC_ZERO ; i < _arrayTittles.count; i++) {
        
        if (_arrayTittles.count<=4) {
            
            CGFloat labelY = AXC_ZERO;
            CGFloat labelH = 40;
            CGFloat labelX = i * WindowWith/_arrayTittles.count;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, WindowWith/_arrayTittles.count, labelH)];
            
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = RGB(249, 249, 249);
            label.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
            label.text = _arrayTittles[i];
            label.textColor=cGrayLightColor;
            
            //给label添加手势
            label.userInteractionEnabled = YES;
            label.tag = TAG_ONEHUNDRED + i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapLabel:)];
            [label addGestureRecognizer:tap];
            
            //设置默认选项
            if (i == AXC_ZERO) {
                label.textColor = cGreenColor;
                
                label.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
                _lastSelectedTag = label.tag;
                //_lastSelectedViewTag=_lineView.tag;
            }
            
            [_titleScrollView addSubview:label];
        }else{
            
            CGFloat labelY = AXC_ZERO;
            CGFloat labelH = 40;
            CGFloat labelX = i * labelW;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW+5, labelH)];
            
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = RGB(249, 249, 249);
            label.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
            label.text = _arrayTittles[i];
            label.textColor=cGrayLightColor;
            
            //给label添加手势
            label.userInteractionEnabled = YES;
            label.tag = TAG_ONEHUNDRED + i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapLabel:)];
            [label addGestureRecognizer:tap];
            
            //设置默认选项
            if (i == AXC_ZERO) {
                label.textColor = cGreenColor;
                
                label.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
                _lastSelectedTag = label.tag;
                //_lastSelectedViewTag=_lineView.tag;
            }
            [_titleScrollView addSubview:label];
        }
    }
    _lineView=[[UIView alloc]initWithFrame:CGRectMake(0,  39, EIGHT_TEN, 1)];
    if (_arrayTittles.count<=4){
        _lineView.width=WindowWith/_arrayTittles.count;
    }
    
    _lineView.backgroundColor=cGreenColor;
    [_titleScrollView addSubview:_lineView];
    
    [self.view addSubview:_titleScrollView];
}

#pragma mark - 点击标题
- (void)TapLabel:(UITapGestureRecognizer *)sender{
    
    NSInteger index = sender.view.tag - TAG_ONEHUNDRED;
    CGFloat offSetX = SCR_W * index;
    
    NewsTableListViewController *vc=[controllerArray objectAtIndex:index];
    if (vc.dataArray.count==0) {
        [vc beginRefresh];
    }
    
    [_contentScrollView setContentOffset:CGPointMake(offSetX, AXC_ZERO) animated:NO];
    
    NSInteger tagOfLabel = index + TAG_ONEHUNDRED;
    if (tagOfLabel == _lastSelectedTag) {
        return;
    }
    //获取当前点击的Label
    UILabel *nowLabel = (UILabel *)[self.view viewWithTag:tagOfLabel];
    
    _lineView.origin=CGPointMake(nowLabel.left, 39);
    //更改状态
    nowLabel.textColor = cGreenColor;
    
    nowLabel.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
    
    //获取上一个点击按钮
    UILabel *lastLabel = (UILabel *)[self.view viewWithTag:_lastSelectedTag];
    
    lastLabel.textColor = cBlackColor;
    
    lastLabel.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
    _lastSelectedTag = tagOfLabel;
    
    //点击后自动居中
    if (index >= AXC_ATWO && index <_pageNum - AXC_ATWO) {
        
        NSInteger OrX = nowLabel.tag - TAG_ONEHUNDRED;
        [_titleScrollView setContentOffset:CGPointMake(OrX * lastLabel.frame.size.width - (SCR_W/AXC_ATWO-lastLabel.frame.size.width/AXC_ATWO), AXC_ZERO) animated:YES];
    } else if (index==0) {
        [_titleScrollView setContentOffset:CGPointMake(AXC_ZERO, AXC_ZERO) animated:YES];
    }else if (index==_pageNum-1){
        NSInteger OrX = nowLabel.tag - TAG_ONEHUNDRED;
        [_titleScrollView setContentOffset:CGPointMake(OrX * lastLabel.frame.size.width - (SCR_W-lastLabel.frame.size.width)-25, AXC_ZERO) animated:YES];
    }
}

- (void)addContentScreollView{
    
    CGFloat contentCcrollViewY = CGRectGetMaxY(_titleScrollView.frame);
    CGFloat contentCcrollViewW = SCR_W;
    CGFloat contentCcrollViewH = SCR_H - contentCcrollViewY;
    CGFloat contentCcrollViewX = AXC_ZERO;
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(contentCcrollViewX, contentCcrollViewY, contentCcrollViewW, contentCcrollViewH)];
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.contentSize = CGSizeMake(SCR_W * _arrayTittles.count, AXC_ZERO);
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    //添加视图
    for (int i = AXC_ZERO ; i < _ShowPagesClassNameArray.count; i++) {
        Class class = NSClassFromString(_ShowPagesClassNameArray[i]);
        
        NewsTableListViewController *View = [[class alloc]init];
        View.type = @"1";
        View.program_id=[_programIdArray[i] intValue];
        [controllerArray addObject:View];

        UIView *view = View.view;
        CGFloat viewx = SCR_W * i;
        CGRect frame = view.frame;
        frame.origin.x = viewx;
        view.frame = frame;
        [_contentScrollView addSubview:view];
        [self addChildViewController:View];
        
        if (i==0) {
            [View beginRefresh];
        }
    }

    
}

/*
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 NSInteger index = scrollView.contentOffset.x / SCR_W;
 
 }
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取用户滑动到第几页
    NSInteger index = scrollView.contentOffset.x / SCR_W;
    
    NewsTableListViewController *vc=[controllerArray objectAtIndex:index];
    
    if (vc.dataArray.count==0) {
        [vc beginRefresh];
    }
    
    //判断用户有没有滑动
    NSInteger labelOfTag = index + TAG_ONEHUNDRED;
    //用户没有切换界面
    if (labelOfTag == _lastSelectedTag) {
        return;
    }
    
    //获取当前要选中的label
    UILabel *nowLabel = (UILabel *)[self.view viewWithTag:labelOfTag];
    
    nowLabel.textColor = cGreenColor;
    
    nowLabel.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT] ;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=self->_lineView.frame;
        rect.origin.x=nowLabel.left;
        self->_lineView.frame=rect;
    }];
    
    
    //把上一个选中的Label回复原来状态
    UILabel *LastLabel = (UILabel *)[self.view viewWithTag:_lastSelectedTag] ;
    
    LastLabel.textColor = cBlackColor;
    
    
    LastLabel.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
    
    _lastSelectedTag = labelOfTag;
    
    if (_arrayTittles.count>4){
        if (index >= AXC_ATWO && index <_pageNum - AXC_ATWO) {
            
            NSInteger OrX = nowLabel.tag - TAG_ONEHUNDRED;
            [_titleScrollView setContentOffset:CGPointMake(OrX * LastLabel.frame.size.width - (SCR_W/AXC_ATWO-LastLabel.frame.size.width/AXC_ATWO), AXC_ZERO) animated:YES];
        }  else if (index==0) {
            [_titleScrollView setContentOffset:CGPointMake(AXC_ZERO, AXC_ZERO) animated:YES];
        }else if (index==_pageNum-1){
            NSInteger OrX = nowLabel.tag - TAG_ONEHUNDRED;
            [_titleScrollView setContentOffset:CGPointMake(OrX * LastLabel.frame.size.width - (SCR_W-LastLabel.frame.size.width)-25, AXC_ZERO) animated:YES];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //获取用户滑动到第几页
    NSInteger index = scrollView.contentOffset.x / SCR_W;
    
    //判断用户有没有滑动
    NSInteger labelOfTag = index + TAG_ONEHUNDRED;
    //用户没有切换界面
    if (labelOfTag == _lastSelectedTag) {
        return;
    }
    
    //获取当前要选中的label
    UILabel *nowLabel = (UILabel *)[self.view viewWithTag:labelOfTag];
    
    nowLabel.textColor = cGreenColor;
    
    nowLabel.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=self->_lineView.frame;
        rect.origin.x=nowLabel.left;
        self->_lineView.frame=rect;
    }];
    
    //把上一个选中的Label回复原来状态
    UILabel *LastLabel = (UILabel *)[self.view viewWithTag:_lastSelectedTag] ;
    
    LastLabel.textColor = cBlackColor;
    
    LastLabel.font = [UIFont systemFontOfSize:LAST_LABEL_FOUT];
    
    _lastSelectedTag = labelOfTag;
    
    if (_arrayTittles.count>4){
        //让Title跟随内容滑动 前三个不滑
        if (index >= AXC_ATWO && index <_pageNum - AXC_ATWO) {
            CGFloat offSetX = (index - AXC_ATWO) *LastLabel.frame.size.width;
            
            [_titleScrollView setContentOffset:CGPointMake(offSetX + TENOFADD, AXC_ZERO) animated:YES];
            
            if (index==0) {
                _titleScrollView.frame=CGRectMake(AXC_ZERO,0, SCR_W, 40);
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchType==ENT_CloseSearch) {
        return 40;
    }else if (_searchType==ENT_Search){
        NewsSearchModel * model=dataArray[indexPath.row];
        CGSize size=[IHUtility GetSizeByText:model.info_title sizeOfFont:14 width:WindowWith-24];
        
        return 40-14+size.height;
    }
    return 0;
}

//段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchType==ENT_CloseSearch) {
        return 30;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (_searchType==ENT_CloseSearch) {
        return 30;
    }
    return 0;
}

#pragma mark - 外观代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (_searchType==ENT_CloseSearch) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 52)];
        view.backgroundColor=[UIColor whiteColor];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15 , 5, 80, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"搜索历史";
        [view addSubview:lbl];
        
        return view;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_searchType==ENT_CloseSearch) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 52)];
        view.backgroundColor=[UIColor whiteColor];
        view.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clean)];
        [view addGestureRecognizer:tap];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15 , 10, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"清除历史记录";
        lbl.centerX=self.view.centerX;
        [view addSubview:lbl];
        return view;
    }
    return nil;
}

-(void)clean{
    commTableView.hidden=YES;
    [IHUtility saveUserDefaluts:@[] key:kSearchNewsHistory];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_searchType==ENT_CloseSearch) {
        _searchType=ENT_Search;
        NSArray *Arr=[IHUtility getUserdefalutsList:kSearchNewsHistory];
        _NewsName = Arr[indexPath.row];
        [_searchV.textfiled resignFirstResponder];
        _searchV.textfiled.text = _NewsName;
        //_searchView.hidden = YES;
        
        //刷新列表
        //[self beginRefesh:ENT_RefreshHeader];
        [self setCommtableView];
        
    }else{
        
        NewsSearchModel * model=dataArray[indexPath.row];
        
        if ([model.img_type intValue]== 3) {
            [self addWaitingView];
            [network getImageNewsDetail:model.info_id success:^(NSDictionary *obj) {
                [self removeWaitingView];
                
                NewsListModel *mod = obj[@"content"];
                NewsImageDetailViewController *vc = [[NewsImageDetailViewController alloc] init];
                vc.infoModel = mod;
                vc.indexPath = indexPath;
                vc.delegate = self;
                [self pushViewController:vc];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
        }else {
            
            [self addWaitingView];
            [network getImageNewsDetail:model.info_id success:^(NSDictionary *obj) {
                [self removeWaitingView];
                
                NewsListModel *mod = obj[@"content"];
                
                NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
                vc.infoModel = mod;
                //  vc.model = mod;
                vc.indexPath = indexPath;
                vc.delegate = self;
                [self pushViewController:vc];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
        }
    }
}

-(void)scrollPage:(CGFloat)x{
    
}

@end
