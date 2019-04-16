//
//  ChoosePositionViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ChoosePositionViewController.h"
#import "PositionChooseViewController.h"
@interface ChoosePositionViewController ()<UITableViewDelegate,UITextViewDelegate>
{
    //IHTextField *_textView;
    PlaceholderTextView *_textView;
    MTBaseTableView *commTableView;
//    int page;
    
    NSMutableArray *dataArray;
    SearchType _type;
    NSMutableArray *_arr;
    NSArray *_Arr;
    NSDictionary *_dic;
}
@end

@implementation ChoosePositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"选择职位"];
    dataArray=[[NSMutableArray alloc]init];
    _arr=[[NSMutableArray alloc]init];
    
    [network selectPublicDicInfo:5 success:^(NSDictionary *obj) {
        
        self->_Arr = obj[@"content"];
        for (NSDictionary *dic in obj[@"content"]) {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            for (NSDictionary *Dic in dic[@"childDic"]) {
                
                NSMutableArray *Arr=[[NSMutableArray alloc]init];
                
                for (NSDictionary *dic3 in Dic[@"childDic"]) {
                    
                    [Arr addObject:dic3[@"job_name"]];
                    
                }
                NSDictionary *dic4=@{Dic[@"job_name"]:Arr};
                
                [arr addObject:dic4];
            }
            
            NSDictionary *dic2=@{dic[@"job_name"]:arr};
            [self->dataArray addObject:dic2];
            [self->_arr addObject:dic2];
        }
        
        [self creatTableView];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
-(void)creatTableView{
    
    _type=ENT_CloseSearch;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 60)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UIImage *img = Image(@"Search Icon.png");
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(5, 43/2-img.size.height/2, img.size.width, img.size.height)];
    imageView.image = img;
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0.032*WindowWith, 6, 38, 43)];
    leftView.backgroundColor=RGB(247, 248, 250);
    // imageView.center=leftView.center;
    [leftView addSubview:imageView];
    leftView.layer.cornerRadius=5;
    [view addSubview:leftView];
    
    _textView=[[PlaceholderTextView alloc]initWithFrame:CGRectMake(leftView.right-5, 6, WindowWith-0.032*WindowWith-leftView.right+5, 43)];
    _textView.backgroundColor=RGB(247, 248, 250);
    
    
    //  _textView.leftView=leftView;
    // _textView.leftViewMode=UITextFieldViewModeAlways;
    
    _textView.layer.cornerRadius=5;
    // _textView.clearButtonMode=UITextFieldViewModeAlways;
    _textView.placeholder=@"总经理";
    _textView.placeholderLbl.font=sysFont(14);
    _textView.placeholderLbl.top=43/2-14;
    _textView.font=sysFont(14);
    _textView.textColor=cGrayLightColor;
    _textView.delegate=self;
    [view addSubview:_textView];
    
    //    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.frame=CGRectMake(_textField.right+10, _textField.top, 45, _textField.height);
    //    btn.backgroundColor=cGreenColor;
    //    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    btn.layer.cornerRadius=5;
    //    btn.titleLabel.font=sysFont(14);
    //    [btn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    //    [view addSubview:btn];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, view.bottom, WindowWith, WindowHeight-60) tableviewStyle:UITableViewStylePlain];
    
    commTableView.table.backgroundColor=RGB(247, 248, 250);
    
    commTableView.table.delegate=self;
    commTableView.attribute=self;
    [commTableView setupData:dataArray index:43];
    
    self.view.backgroundColor=cBgColor;
    [self.view addSubview:commTableView];
}

-(void)search{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        
        _type=ENT_CloseSearch;
        [dataArray removeAllObjects];
        [dataArray addObjectsFromArray:_arr];
        
        [commTableView setupData:dataArray index:43];
        
    }else{
        
        _type=ENT_Search;
        
        [network selectJobInfoByJobName:textView.text success:^(NSDictionary *obj) {
            [self->dataArray removeAllObjects];
            NSArray *arr=obj[@"content"];
            [self->dataArray addObjectsFromArray:arr];
            
            [self->commTableView setupData:self->dataArray index:44];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    
    if (action==MTDeleteActionTableViewCell) {
        
        NSString *index=(NSString *)attribute;
        NSDictionary *dic=dataArray[indexPath.section];
        PositionChooseViewController *vc=[[PositionChooseViewController alloc]init];
        vc.text=dic.allKeys[0];
        vc.dic=dic;
        vc.arr=_Arr;
        vc.index=[index integerValue];
        vc.Poptype = self.Poptype;
        [self pushViewController:vc];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_type==ENT_Search) {
        return 72.5;
    }else{
        NSDictionary *dic=dataArray[indexPath.section];
        
        NSString *text=dic.allKeys[0];
        NSArray *arr=dic[text];
        
        NSMutableArray *Arr=[[NSMutableArray alloc]init];
        for (NSInteger i=0; i<arr.count; i++) {
            NSDictionary *Dic=arr[i];
            [Arr addObject:Dic.allKeys[0]];
            
        }
        
        ChoosePositionView *view=[[ChoosePositionView alloc]init];
        CGFloat height=[view setDataWithArr:Arr];
        
        return height;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _dic=dataArray[indexPath.section];
    
    if (_type==ENT_Search) {
        
        SearchJobNameModel *model=dataArray[indexPath.row];
        NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@%@",@"<meta charset=\"UTF-8\" >",model.jobName] dataUsingEncoding:NSUTF8StringEncoding]
                                                                                        options:options documentAttributes:nil error:nil];
        self.selectBlock(model.jobId,[attrString string]);
        [self back:nil];
    }else{
        
        //        NSDictionary *dic=dataArray[indexPath.section];
        //        PositionChooseViewController *vc=[[PositionChooseViewController alloc]init];
        //        vc.text=dic.allKeys[0];
        //        vc.dic=dic;
        //        vc.arr=_Arr;
        //        vc.Poptype = self.Poptype;
        //        [self pushViewController:vc];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(void)pushToPosiTionVC:(UITapGestureRecognizer *)Tap{
    _dic=dataArray[Tap.view.tag];
    PositionChooseViewController *vc=[[PositionChooseViewController alloc]init];
    vc.text=_dic.allKeys[0];
    vc.dic=_dic;
    vc.arr=_Arr;
    vc.Poptype = self.Poptype;
    [self pushViewController:vc];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 40)];
    view.backgroundColor=cBgColor;
    view.tag=section;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToPosiTionVC:)];
    [view addGestureRecognizer:tap];
    
    NSDictionary *dic=dataArray[section];
    NSString *text=dic.allKeys[0];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 7, 7)];
    imageView.image=Image(@"Job_dian.png");
    [view addSubview:imageView];
    imageView.centerY=view.centerY;
    CGSize size=[IHUtility GetSizeByText:text sizeOfFont:14 width:150];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+8, 0, size.width, 14) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text=text;
    lbl.centerY=imageView.centerY;
    [view addSubview:lbl];
    
    UIImage *img=Image(@"iconfont-fanhui.png");
    
    UIImageView *toImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-15-img.size.width, 0, img.size.width, img.size.height)];
    toImageView.image=img;
    toImageView.centerY=view.centerY;
    [view addSubview:toImageView];
    
    //1.view当前的当前状态
    CGAffineTransform tranform = toImageView.transform;
    //2.创建一个平移,并且得到计算好的结果
    //tx, ty, 平移量
    CGAffineTransform translate = CGAffineTransformTranslate(tranform/*当前的状态*/, 0, 0);
    
    CGAffineTransform scale = CGAffineTransformScale(translate, 1, 1); //包含平移
    //2.创建一个旋转
    //旋转角度为弧度,顺时针为正数,逆时针为负数
    CGAffineTransform rotate = CGAffineTransformRotate(scale, -180 * M_PI / 180/*单位为弧度*/);//包含缩放
    
    toImageView.transform=rotate;
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
