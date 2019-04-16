//
//  ReleaseNewVarietyHeadView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/31.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ReleaseNewVarietyHeadView.h"

@interface ReleaseNewVarietyHeadView () <UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *_collectionView;
//    UILabel *photoLabel;
//    CGRect _frame;
    NSMutableArray *imaArray;
}
@end

@implementation ReleaseNewVarietyHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        _frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubView];
    }
    return self;
}

- (void) creatSubView {
    
    imaArray = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 24,0,24);
     CGFloat f=(WindowWith-80)/3;
    layout.itemSize = CGSizeMake(f, f);
    //layout.sectionInset.right = layout.sectionInset.right + w;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, self.bottom - kWidth(44)) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[CreateBSCollectionViewCell class] forCellWithReuseIdentifier: @"CreateBSCollectionViewCell"];
    
    _photoLabel = [[UILabel alloc] init];
    _photoLabel.text = @"上传新品种示例图片（最多一张）";
	
    [self addSubview:_photoLabel];
    [_photoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_collectionView.mas_bottom).mas_offset(kWidth(5));
        make.left.mas_equalTo(self).mas_offset(24);
        make.right.mas_equalTo(self).mas_offset(-24);
        make.height.mas_offset(kWidth(30));
    }];
    _photoLabel.font = sysFont(font(14));
    _photoLabel.textColor = [UIColor redColor];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (imaArray.count >= 1) {
        return imaArray.count;
    }
    return imaArray.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CreateBSCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreateBSCollectionViewCell" forIndexPath:indexPath];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.m_imgView.userInteractionEnabled = YES;
    [cell.m_imgView  addGestureRecognizer:singleTap];
    cell.deleteBtn.tag = [indexPath row];
    if ([indexPath row] != (imaArray.count)){
        [cell.deleteBtn setHidden:NO];
    }
    else {
        if (imaArray.count == 1) {
            UIImage *addimg=Image(@"fb_uploadimg.png");
            NSData *data = UIImagePNGRepresentation(addimg);
            UIImage *img1;
            if ([[imaArray lastObject] isKindOfClass:[UIImage class]]) {
                img1=[imaArray lastObject];
            }else {
                NSString *url = [imaArray lastObject];
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
    if (indexPath.row == imaArray.count) {
        UIImage *addimg=Image(@"fb_uploadimg.png");
        [cell.m_imgView setImage:addimg];
        cell.m_imgView.tag = [indexPath row];
        cell.deleteBtn.tag=indexPath.row;
        return cell;
    }
    if ([[imaArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        NSString *imgUrl=[imaArray objectAtIndex:indexPath.row];
        [cell.m_imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",imgUrl] placeholderImage:DefaultImage_logo];
        cell.m_imgView.tag = [indexPath row];
        cell.deleteBtn.tag=indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteIMGClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        UIImage *img=[imaArray objectAtIndex:indexPath.row];
        [cell.m_imgView setImage:img];
        cell.m_imgView.tag = [indexPath row];
        cell.deleteBtn.tag=indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteIMGClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    if (index == (imaArray.count))
    {
        [self.delegage showActionSheetPicSelectBlock:^(NSMutableArray *ImagArr) {
			self->imaArray = ImagArr;
            [self updateCollectionHeight:self->imaArray];
            [self->_collectionView reloadData];
        }];
    }else{
        
    }
}
-(void)deleteIMGClick:(UIButton*)sender{
    [imaArray removeObjectAtIndex:sender.tag];
     [self updateCollectionHeight:imaArray];
    [_collectionView reloadData];
}
- (void) updateCollectionHeight:(NSMutableArray *) array{
    CGFloat f=(WindowWith-80)/3;
    
    CGRect rect=_collectionView.frame;
    if ((array.count+1) <4) {
        rect.size.height=f+20;
    }else if (array.count <7){
        rect.size.height=f*2+30;
    }else{
        rect.size.height=f*3+40;
    }
    _collectionView.frame=rect;
    self.frame = CGRectMake(0, 0, iPhoneWidth, _collectionView.bottom + 44);
    NSMutableArray *tempArr  = [[NSMutableArray alloc] initWithArray:array];
    [self.delegage remoePicSelectUpDataUIFrame:self.frame andImageArr:tempArr];
}

@end
