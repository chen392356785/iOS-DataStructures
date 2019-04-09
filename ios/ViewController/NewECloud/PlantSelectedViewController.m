//
//  PlantSelectedViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 29/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PlantSelectedViewController.h"

@interface PlantSelectedViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *commTableView;
    
    SMLabel *_lbl;
    
    NSArray *plantNameArr;//筛选的数组
    
    IHTextField *_textFiled;
}
@end

@implementation PlantSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"品种筛选"];
    plantNameArr = self.nameArr;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, WindowWith-20, 35)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 4.0;
    [_BaseScrollView addSubview:view];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTextfiled:)];
    singleTap.numberOfTapsRequired = 1;
    view.userInteractionEnabled = YES;
    [view  addGestureRecognizer:singleTap];
    
    UIImage *img = Image(@"weatherCity_search.png");
    CGSize size = [IHUtility GetSizeByText:@"请输入品种名" sizeOfFont:14 width:WindowWith];
    IHTextField *textFiled = [[IHTextField alloc] initWithFrame:CGRectMake(0, 0, size.width + img.size.width, 35)];
    textFiled.centerX = view.width/2.0;
    textFiled.font = sysFont(14);
    textFiled.delegate = self;
    textFiled.clearButtonMode= UITextFieldViewModeWhileEditing;
    _textFiled= textFiled;
    textFiled.placeholder = @"请输入品种名";
    [textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [view addSubview:textFiled];
    
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    searchImg.image = img;
    textFiled.leftView =  searchImg;
    
    commTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 35, WindowWith,WindowHeight- 35) style:UITableViewStylePlain];
    commTableView.dataSource=self;
    commTableView.delegate=self;
    commTableView.backgroundColor = RGB(247 , 248, 250);
    [self setExtraCellLineHidden:commTableView];
    [self.view addSubview:commTableView];
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, 0, commTableView.width - 20, 40) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text = @"没有找到该品种";
    _lbl = lbl;
    
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return plantNameArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"TableViewCell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        cell.backgroundColor = RGB(247 , 248, 250);
    }
    NSDictionary *dic = plantNameArr[indexPath.row];
    cell.textLabel.text = dic[@"nursery_type_name"];
    cell.textLabel.font = sysFont(16);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlantCell:)];
    singleTap.numberOfTapsRequired = 1;
    cell.userInteractionEnabled = YES;
    [cell  addGestureRecognizer:singleTap];
    cell.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tapPlantCell:(UITapGestureRecognizer *)tap
{
    UITableViewCell *cell = (UITableViewCell *)tap.view;
    NSDictionary *dic = plantNameArr[cell.tag];
    NSString *plant_type = [NSString stringWithFormat:@"%@",dic[@"nursery_type_id"]];
    
    NSString * str=dic[@"units"];
    NSArray *arr;
    if (str.length>0) {
        arr = [network getJsonForString:str];
    }
    
    [self.delegate disPlaySelectedSuccess:dic[@"nursery_type_name"] plant_type:plant_type unitArr:arr];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)tapTextfiled:(UITapGestureRecognizer *)tap
{
    [_textFiled becomeFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.3 animations:^{
		self->_textFiled.left = 10;
		self->_textFiled.width = WindowWith - 40;
    }];
    
    if (textField.text.length > 0) {
        
        [self searchCompanyName:textField.text];
    }else{
        plantNameArr = self.nameArr;
        [_lbl removeFromSuperview];
        [commTableView reloadData];
    }
}
- (void) textFieldDidChange:(UITextField *)textField {
    
    if (textField.text.length > 0) {
        
        [self searchCompanyName:textField.text];
    }else{
        plantNameArr = self.nameArr;
        [_lbl removeFromSuperview];
        [commTableView reloadData];
    }
}

- (void)searchCompanyName:(NSString *)text
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in self.nameArr) {
        if ([dic[@"nursery_type_name"] containsString:text]) {
            [array addObject:dic];
        }
    }
    
    plantNameArr = array;
    if (plantNameArr.count<=0) {
        
        [commTableView addSubview:_lbl];
    }else{
        [_lbl removeFromSuperview];
    }
    [commTableView reloadData];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UIImage *img = Image(@"weatherCity_search.png");
    CGSize size = [IHUtility GetSizeByText:@"请输入品种名" sizeOfFont:14 width:WindowWith];
    _textFiled.width = size.width + img.size.width;
    [UIView animateWithDuration:.3 animations:^{
		self->_textFiled.centerX = (WindowWith-20)/2.0;
        
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_textFiled resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
