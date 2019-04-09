//
//  CompanyImageViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CompanyImageViewController.h"
//#import "ZLPhotoActionSheet.h"
#import "JLSimplePickViewComponent.h"
@interface CompanyImageViewController ()<UICollectionViewDelegate,
UICollectionViewDataSource,UITextViewDelegate,JLActionSheetDelegate>
{
	ZLPhotoActionSheet *actionSheet;
	UICollectionView *_collectionView;
	NSMutableArray *imgsArray;
	BOOL isFirstAddPhoto;
	BOOL isSelectedPhoto;
	SMLabel *_lbl;
}
@end

@implementation CompanyImageViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setTitle:@"企业形象"];
	
	
	CGFloat f=(WindowWith-80)/3;
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.itemSize = CGSizeMake(f, f);
	layout.sectionInset = UIEdgeInsetsMake(0, 5,0, 5);
	//layout.sectionInset.right = layout.sectionInset.right + w;
	layout.minimumInteritemSpacing = 0;
	layout.minimumLineSpacing = 10;
	
	_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 30, WindowWith-40, f+12) collectionViewLayout:layout];
	
	_collectionView.userInteractionEnabled=YES;
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	_collectionView.scrollEnabled=NO;
	_collectionView.backgroundColor = [UIColor whiteColor];
	[_collectionView registerClass:[CreateBSCollectionViewCell class] forCellWithReuseIdentifier: @"CreateBSCollectionViewCell"];
	actionSheet = [[ZLPhotoActionSheet alloc] init];
	//设置照片最大选择数
	actionSheet.maxSelectCount = 5;
	//设置照片最大预览数
	actionSheet.maxPreviewCount = 20;
	[_BaseScrollView addSubview:_collectionView];
	
	imgsArray=[[NSMutableArray alloc]init];
	UIImage *addImg=Image(@"fb_uploadimg.png");
	
	[imgsArray addObject:addImg];
	
	
	
	[_collectionView reloadData];
	
	
	_lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(20, _collectionView.bottom + 10, WindowWith-40, 17) textColor:cGrayLightColor textFont:sysFont(14)];
	_lbl.text =  @"最多只能上传5张图片";
	// [_BaseScrollView addSubview:_lbl];
	
	UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame=CGRectMake(0,0, WindowWith-50, 40);
	btn.bottom = WindowHeight - 60;
	btn.backgroundColor=cGreenColor;
	[btn setTintColor:[UIColor whiteColor]];
	[btn setTitle:@"保  存" forState:UIControlStateNormal];
	
	[btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
	btn.titleLabel.font=sysFont(18.8);
	[_BaseScrollView addSubview:btn];
	btn.centerX=self.view.centerX;
	btn.layer.cornerRadius=20;
}


- (void)btnSelectPhoto_Click:(id)sender
{
	[_BaseScrollView endEditing:YES];
	
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
		if (self->imgsArray.count>=5) {
			NSMutableArray *arr2=[[NSMutableArray alloc]init];
			for (int i=0; i<5; i++) {
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
		if (self->imgsArray.count<5) {
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
	
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
	singleTap.numberOfTapsRequired = 1;
	cell.m_imgView.userInteractionEnabled = YES;
	[cell.m_imgView  addGestureRecognizer:singleTap];
	cell.deleteBtn.tag = [indexPath row];
	if ([indexPath row] != (imgsArray.count - 1)){
		[cell.deleteBtn setHidden:NO];
		
	}
	else {
		if (imgsArray.count == 5) {
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
	
	
	//    if (self.model!=nil) {
	//        NSString *imgUrl=[imgsArray objectAtIndex:indexPath.row];
	//        [cell.imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",imgUrl] placeholderImage:DefaultImage_logo];
	//        cell.deleteBtn.hidden=YES;
	//
	//
	//    }else{
	UIImage *img=[imgsArray objectAtIndex:indexPath.row];
	[cell.m_imgView setImage:img];
	cell.m_imgView.tag = [indexPath row];
	cell.deleteBtn.tag=indexPath.row;
	[cell.deleteBtn addTarget:self action:@selector(deleteIMGClick:) forControlEvents:UIControlEventTouchUpInside];
	
	//  }
	
	
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
	if (imgsArray.count<5) {
		UIImage *img1=[imgsArray lastObject];
		NSData *data1 = UIImagePNGRepresentation(img1);
		if (![data1 isEqual:data]) {
			[imgsArray addObject:addimg];
		}
	}
	[_collectionView reloadData];
	[self setBaseScrollHeigh:imgsArray];
	if (imgsArray.count==0) {
		isSelectedPhoto=NO;
	}
	
}


-(void)setBaseScrollHeigh:(NSArray *)arr2{
	
	
	CGFloat f=(WindowWith-80)/3;
	
	CGRect rect=_collectionView.frame;
	if (arr2.count<4) {
		rect.size.height=f+20;
	}else if (arr2.count<7){
		rect.size.height=f*2+30;
	}else{
		rect.size.height=f*3+40;
	}
	_collectionView.frame=rect;
	
	_lbl.top = _collectionView.bottom + 10;
	
	//    CGRect rect2=_downView.frame;
	//
	//    rect2.origin.y=_collectionView.bottom;
	//    _downView.frame=rect2;
	//    _BaseScrollView.contentSize=CGSizeMake(WindowWith, _addBtn.bottom+_collectionView.bottom+100);
}

- (void)submitClick:(UIButton *)button
{
	
	if (imgsArray.count==0) {
		[self addSucessView:@"请上传图片" type:2];
		return;
	}
	
	
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
	
	__weak CompanyImageViewController *weakSelf=self;
	[AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
		
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self removeWaitingView];
			
			NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo]];
			
			NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithDictionary:Dic[@"companyinfo"]];
			
			
			
			[dic1 setObject:obj forKey:@"company_image"];
			
			[Dic setObject:dic1 forKey:@"companyinfo"];
			
			[IHUtility saveDicUserDefaluts:Dic key:kUserDefalutLoginInfo];
			
			
			weakSelf.selectImageBlock(obj);
			[self back:nil];
			
		});
		
	}];
	
	
	
}


@end

