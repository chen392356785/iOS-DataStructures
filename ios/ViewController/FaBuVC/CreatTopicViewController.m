//
//  CreatTopicViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/25.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CreatTopicViewController.h"
//#import "ZLPhotoActionSheet.h"
#import "JLSimplePickViewComponent.h"
@interface CreatTopicViewController()<UICollectionViewDelegate,
UICollectionViewDataSource,UITextViewDelegate,JLActionSheetDelegate>
{
    ZLPhotoActionSheet *actionSheet;
    UICollectionView *_collectionView;
    NSMutableArray *imgsArray;
    BOOL isFirstAddPhoto;
    UIView *_downView;
    PlaceholderTextView *_placeholderTextView;
    
    SMLabel * themeLabel;
    
    NSMutableArray * themeArr;
    NSMutableArray * theme_IdArr;
    UIView *_lineView;
}
@end
@implementation CreatTopicViewController
@synthesize theme_Id;
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"发布话题"];
    
    __weak CreatTopicViewController * weakSelf=self;
    themeArr=[[NSMutableArray alloc]init];
    theme_IdArr=[[NSMutableArray alloc]init];
    
    _BaseScrollView.backgroundColor=[UIColor whiteColor];
    //上传苗木图片
    imgsArray=[[NSMutableArray alloc]init];
    CGFloat f=(WindowWith-80)/3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(f, f);
    layout.sectionInset = UIEdgeInsetsMake(0, 5,0,5);
    //layout.sectionInset.right = layout.sectionInset.right + w;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    UIImage *addImg=Image(@"fb_uploadimg.png");
    [imgsArray addObject:addImg];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 30, WindowWith-40, f+12) collectionViewLayout:layout];
    _collectionView.userInteractionEnabled=YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled=NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CreateBSCollectionViewCell class] forCellWithReuseIdentifier: @"CreateBSCollectionViewCell"];
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 9;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    [_BaseScrollView addSubview:_collectionView];
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0,  _collectionView.bottom+10, WindowWith, 540)];
    _downView=downView;
    
    SMLabel *photoLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0, 250, 20) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(14)];
    
    photoLbl.text=@"话题图片（最多9张)";
    [downView addSubview:photoLbl];
    
    UIView *photoView=[[UIView alloc]initWithFrame:CGRectMake(0, photoLbl.bottom+20, WindowWith, 5)];
    photoView.backgroundColor=cLineColor;
    [downView addSubview:photoView];
    [_BaseScrollView addSubview:downView];
    
    //主题
    UIView * themeView=[[UIView alloc]initWithFrame:CGRectMake(0, photoView.bottom, WindowWith, 40)];
    themeView.backgroundColor=[UIColor whiteColor];
    [downView addSubview:themeView];
    
    SMLabel * themeL=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 10, 60, 20) textColor:RGB(189, 202, 219) textFont:sysFont(15)];
    themeL.text=@"主题";
    themeL.textAlignment=NSTextAlignmentCenter;
    [themeView addSubview:themeL];
    
    UIView * line=[[UIView alloc]initWithFrame:CGRectMake(60, 10, 1, 20)];
    line.backgroundColor=RGB(189, 202, 219);
    [themeView addSubview:line];
    
    themeLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(80, 10, WindowWith-120, 20) textColor:RGB(189, 202, 219) textFont:sysFont(15)];
    
    [themeView addSubview:themeLabel];
    
    UIImageView * next=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-24,10, 14, 20)];
    next.image=[UIImage imageNamed:@"GQ_Left"];
    [themeView addSubview:next];
    if (theme_Id.length>0) {
        themeLabel.text=self.themeName;
        next.hidden=YES;
    }else{
        themeLabel.text=@"";
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTheme:)];
        [themeView addGestureRecognizer:tap];
    }
    
    //手势
    UIView *photoView1=[[UIView alloc]initWithFrame:CGRectMake(0, themeView.bottom, WindowWith, 5)];
    photoView1.backgroundColor=cLineColor;
    [downView addSubview:photoView1];
    
    _placeholderTextView =[[PlaceholderTextView alloc]initWithFrame:CGRectMake(10, photoView1.bottom, WindowWith-20, 150)];
    _placeholderTextView.placeholder=@"话题内容（2000字)";
    _placeholderTextView.delegate=self;
    _placeholderTextView.returnKeyType=UIReturnKeyDone;
    _placeholderTextView.placeholderColor=cLineColor;
    _placeholderTextView.placeholderFont=sysFont(15);
    [downView addSubview:_placeholderTextView];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, _placeholderTextView.bottom, WindowWith, WindowHeight - _placeholderTextView.bottom)];
    lineView2.backgroundColor=cLineColor;
    _lineView = lineView2;
    [downView addSubview:lineView2];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0,0.12*WindowWith, WindowWith-80, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTintColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.enabled=NO;
    btn.tag=20;
    [btn setTitle:@"发  布" forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(18.8);
    [lineView2 addSubview:btn];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=21;
    
    [network getThemeList:0 num:20 success:^(NSDictionary * obj) {
        
        NSArray * arr=obj[@"content"];
        [weakSelf upDateData:arr];
        
        if (self->theme_Id.length==0) {
//            ThemeListModel *mod=[arr objectAtIndex:0];
            //            themeLabel.text=mod.theme_header;
        }
    } failure:^(NSDictionary * obj2) {
        
    }];
}

-(void)submitClick:(UIButton *)sender{
    
    if (themeLabel.text.length <=0) {
        [self addSucessView:@"请选择主题" type:2];
        return;
    }
    
    if (_placeholderTextView.text.length>2000) {
        [self addSucessView:@"输入的字数超过限制" type:2];
        return;
    }
    
    __weak CreatTopicViewController *weakSelf=self;
    UIImage *addimg=Image(@"fb_uploadimg.png");
    NSData *data = UIImagePNGRepresentation(addimg);
    for (int i=0; i<imgsArray.count; i++) {
        UIImage *imgA=[imgsArray objectAtIndex:i];
        NSData *data1 = UIImagePNGRepresentation(imgA);
        if ([data isEqual:data1]) {
            [imgsArray removeObject:imgA];
        }
    }
    
    [self addWaitingView];
    if (imgsArray.count>0) {
        [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
            [network getAddTopic:obj
                   topic_content:self->_placeholderTextView.text
                         address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]
                        theme_Id:self->theme_Id
                         success:^(NSDictionary *obj) {
                             [self removeWaitingView];
                             
                             NSDictionary *dic2=obj[@"content"];
                             NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"3",@"type", nil];
                             
                             [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabBarSelectedIndex object:[NSNumber numberWithInt:0]];
                             [weakSelf back];
                         }];
        }];
    }else{
        [network getAddTopic:@""
               topic_content:_placeholderTextView.text
                     address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]
                    theme_Id:theme_Id
                     success:^(NSDictionary *obj) {
                         [self removeWaitingView];
                         
                         NSDictionary *dic2=obj[@"content"];
                         NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"3",@"type", nil];
                         
                         [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                         [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabBarSelectedIndex object:[NSNumber numberWithInt:0]];
                         [weakSelf back];
                     }];
    }
}

#pragma mark textView代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [_placeholderTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)textViewDidChange:(UITextView *)textView
{
    //实现等待输入效果
    if (textView.text.length == 0)
    {
        UIButton *btn=(UIButton*)[_BaseScrollView viewWithTag:20];
        btn.enabled=NO;
    }
    else
    {
        UIButton *btn=(UIButton*)[_BaseScrollView viewWithTag:20];
        btn.enabled=YES;
    }
}

- (void)btnSelectPhoto_Click:(id)sender
{
    [_placeholderTextView resignFirstResponder];
    [actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
        for (int i=0; i<selectPhotos.count; i++) {
            UIImage *img2 = [selectPhotos objectAtIndex:i];
            if (!self->isFirstAddPhoto) {
                [self->imgsArray removeAllObjects];
                [self->imgsArray addObject:img2];
                self->isFirstAddPhoto=YES;
            }else{
                [self->imgsArray insertObject:img2 atIndex:0];
            }
        }
        if (self->imgsArray.count>=9) {
            NSMutableArray *arr2=[[NSMutableArray alloc]init];
            for (int i=0; i<9; i++) {
                UIImage *img=[self->imgsArray objectAtIndex:i];
                [arr2 addObject:img];
            }
            [self->imgsArray removeAllObjects];
            [self->imgsArray addObjectsFromArray:arr2];
            //            UIImage *addimg=Image(@"fb_uploadimg.png");
            //            [imgsArray addObject:addimg];
        }
        UIImage *addimg=Image(@"fb_uploadimg.png");
        NSData *data = UIImagePNGRepresentation(addimg);
        if (self->imgsArray.count<9) {
            UIImage *img1=[self->imgsArray lastObject];
            NSData *data1 = UIImagePNGRepresentation(img1);
            if (![data1 isEqual:data]) {
                [self->imgsArray addObject:addimg];
            }
        }
        [self->_collectionView reloadData];
        [self setBaseScrollHeigh:self->imgsArray];
    }];
}

-(void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imgsArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CreateBSCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreateBSCollectionViewCell" forIndexPath:indexPath];
    
    UIImage *img=[imgsArray objectAtIndex:indexPath.row];
    [cell.m_imgView setImage:img];
    
    cell.m_imgView.tag = [indexPath row];
    cell.deleteBtn.tag=indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteIMGClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.m_imgView.userInteractionEnabled = YES;
    [cell.m_imgView  addGestureRecognizer:singleTap];
    cell.deleteBtn.tag = [indexPath row];
    if ([indexPath row] != (imgsArray.count - 1)){
        [cell.deleteBtn setHidden:NO];
    }
    else {
        if (imgsArray.count == 9) {
            UIImage *addimg=Image(@"fb_uploadimg.png");
            NSData *data = UIImagePNGRepresentation(addimg);
            UIImage *img1;
            if ([[imgsArray lastObject] isKindOfClass:[UIImage class]]) {
                img1=[imgsArray lastObject];
            }else {
                NSString *url = [imgsArray lastObject];
                img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            }
            NSData *data1 = UIImagePNGRepresentation(img1);
            if (![data1 isEqual:data]) {
                [cell.deleteBtn setHidden:NO];
            }else{
                [cell.deleteBtn setHidden:YES];
            }
        }else {
            [cell.deleteBtn setHidden:YES];
        }
    }
    return cell;
}

- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    if (index == (imgsArray.count -1))
    {
        [self btnSelectPhoto_Click:nil];
    }else{
        
    }
}

-(void)deleteIMGClick:(UIButton*)sender{
    [imgsArray removeObjectAtIndex:sender.tag];
    
    UIImage *addimg=Image(@"fb_uploadimg.png");
    NSData *data = UIImagePNGRepresentation(addimg);
    if (imgsArray.count<9) {
        UIImage *img1=[imgsArray lastObject];
        NSData *data1 = UIImagePNGRepresentation(img1);
        if (![data1 isEqual:data]) {
            [imgsArray addObject:addimg];
        }
    }
    [_collectionView reloadData];
    [self setBaseScrollHeigh:imgsArray];
}

-(void)setBaseScrollHeigh:(NSArray *)arr2{
    
    CGFloat f=(WindowWith-80)/3;
    
    CGRect rect=_collectionView.frame;
    if (arr2.count<4) {
        rect.size.height=f+20;
    }else if (arr2.count<7){
        rect.size.height=f*2+30;
    }else if (arr2.count<10){
        rect.size.height=f*3+40;
    }else {
        rect.size.height=f*4+40;
    }
    _collectionView.frame=rect;
    
    CGRect rect2=_downView.frame;
    
    rect2.origin.y=_collectionView.bottom;
    _downView.frame=rect2;
    _lineView.top = _placeholderTextView.bottom;
    
    if (_downView.bottom+100>450) {
        [_BaseScrollView setContentSize:CGSizeMake(WindowWith, _downView.bottom)];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
//选择主题
- (void)chooseTheme:(UITapGestureRecognizer *)tap
{
    NSLog(@"选择主题");
    [_placeholderTextView resignFirstResponder];
    JLSimplePickViewComponent * pivkView=[[JLSimplePickViewComponent alloc]initWithParams:@"选择主题" withData:themeArr];
    pivkView.ActionSheetDelegate=self;
    [pivkView show];
}
-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedIndex:(NSInteger)index{
    
    themeLabel.text=themeArr[index];
    theme_Id=theme_IdArr[index];
}
- (void)upDateData:(NSArray *)arr
{
    for (ThemeListModel * model in arr) {
        [themeArr addObject:model.theme_header];
        [theme_IdArr addObject:model.theme_id];
    }
}
@end
