//
//  SDPhotosGroupView.m
//  TaSayProject
//
//  Created by Mac on 15/6/10.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "SDPhotosGroupView.h"
#define SDPhotoGroupImageMargin 10
@implementation SDPhotosGroupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除图片缓存，便于测试
    // [[SDWebImageManager sharedManager].imageCache clearDisk];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame withTableViewCell:(BOOL)isTableViewCell{
    self = [super initWithFrame:frame];
    if (self) {
        
        float imgWidth=(frame.size.width-10)/3 ;
       
        for (int i=0; i<9; i++) {
       //     UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
 
            int j=i%3;
            int y=0;
            if (i>=0&&i<3) {      //1-3
                y=0;
            }else if (i>2&&i<6){  //4-6
                y=imgWidth+5;
            }else{                //7-9
                y=(imgWidth+5)*2;
            }
            UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(j*(imgWidth+5), y, imgWidth, imgWidth)];
            imgView.tag = i+100;
            
          //  [imgView setLayerMasksCornerRadius:1 BorderWidth:0.2 borderColor:cHeadbkColor];
            imgView.userInteractionEnabled=YES;
          //  btn.frame = CGRectMake(j*(imgWidth+10)+15, y, imgWidth, imgWidth);
          //  imgView.hidden=YES;
            [self addSubview:imgView];
        }
    }
    return self;
}

-(void)setImagesCellArray:(NSArray *)imagesCellArray{
    _photoItemArray=imagesCellArray;
    [imagesCellArray enumerateObjectsUsingBlock:^(MTPhotosModel *obj, NSUInteger idx, BOOL *stop) {
        UIAsyncImageView *btn=(UIAsyncImageView *)[self viewWithTag:idx+100];
         CGFloat width=WindowWith-30;
        CGFloat imgWidth=(width-1)/2;
        CGFloat imgWidth3= (width-2)/3;
        
        if (imagesCellArray.count==1) {
            
            
            CGRect rect=btn.frame;
            
            float i;
            float heigh;
            if (obj.imgHeigh>obj.imgWidth*1.8) {
                i=width/1.8/obj.imgWidth;
                heigh=width/1.8/obj.imgHeigh;
            }else{
                if (obj.imgWidth>width) {
                    i=width/obj.imgWidth*0.5;
                    heigh=width/obj.imgHeigh;
                }else{
                    i=0.5;
                }
            }
  
            btn.frame=CGRectMake(rect.origin.x, rect.origin.y, i*obj.imgWidth, i*obj.imgHeigh);
 
        }else if (imagesCellArray.count==2){
            if (idx==0) {
                btn.frame=CGRectMake(0, 0, imgWidth, imgWidth);
            }else if (idx==1){
                btn.frame=CGRectMake(imgWidth+1, 0, imgWidth, imgWidth);
            }
        }else if (imagesCellArray.count==3){
            if (idx==0) {
                btn.frame=CGRectMake(0, 0, width, width);
            }else if (idx==1){
                btn.frame=CGRectMake(0, width+1, imgWidth, imgWidth);
            }else if (idx==2){
                btn.frame=CGRectMake(imgWidth+1, width+1, imgWidth, imgWidth);
            }
         }else if (imagesCellArray.count==4){
            if (idx==0) {
                 btn.frame=CGRectMake(0, 0, imgWidth, imgWidth);
            }else if (idx==1){
                btn.frame=CGRectMake(imgWidth+1, 0, imgWidth, imgWidth);
            }else if (idx==2){
                btn.frame=CGRectMake(0, imgWidth+1, imgWidth, imgWidth);
            }else if (idx==3){
                btn.frame=CGRectMake(imgWidth+1, imgWidth+1, imgWidth, imgWidth);
            }
 
        }else if (imagesCellArray.count==5){
            if (idx==0) {
                btn.frame=CGRectMake(0, 0, imgWidth, imgWidth);
            }else if (idx==1){
                btn.frame=CGRectMake(imgWidth+1, 0, imgWidth, imgWidth);
            }else if (idx==2){
                btn.frame=CGRectMake(0, imgWidth+1, imgWidth3, imgWidth3);
            }else if (idx==3){
                btn.frame=CGRectMake(imgWidth3+1, imgWidth+1, imgWidth3, imgWidth3);
            }else if (idx==4){
                btn.frame=CGRectMake(imgWidth3*2+2, imgWidth+1, imgWidth3, imgWidth3);
            }
        }else if (imagesCellArray.count==6){
            
            if (idx<3) {
                 btn.frame=CGRectMake(imgWidth3*idx+idx, 0, imgWidth3, imgWidth3);
            }else{
                btn.frame=CGRectMake(imgWidth3*(idx-3)+idx-3, imgWidth3+1, imgWidth3, imgWidth3);
            }
            
        }else if (imagesCellArray.count==7){
            if (idx==0) {
                   btn.frame=CGRectMake(0, 0, width, width);
            }else{
                NSUInteger x=idx-1;
                
                if (x<3) {
                    btn.frame=CGRectMake(imgWidth3*x+x, width+1, imgWidth3, imgWidth3);
                }else{
                    btn.frame=CGRectMake(imgWidth3*(x-3)+x-3,width+1+imgWidth3+1, imgWidth3, imgWidth3);
                }
            }
        }else if (imagesCellArray.count==8){
            if (idx==0) {
                btn.frame=CGRectMake(0, 0, imgWidth, imgWidth);
            }else if (idx==1){
                btn.frame=CGRectMake(imgWidth+1, 0, imgWidth, imgWidth);
            }else{
                NSUInteger x=idx-2;
                if (x<3) {
                    btn.frame=CGRectMake(imgWidth3*x+x, imgWidth+1, imgWidth3, imgWidth3);
                }else{
                    btn.frame=CGRectMake(imgWidth3*(x-3)+x-3,imgWidth+1+imgWidth3+1, imgWidth3, imgWidth3);
                }
            }
        }else if (imagesCellArray.count==9){
            int j=idx%3;
            int y=0;
            if (idx>=0&&idx<3) {      //1-3
                y=0;
            }else if (idx>2&&idx<6){  //4-6
                y=imgWidth3+1;
            }else{                //7-9
                y=(imgWidth3+1)*2;
            }
            btn.frame=CGRectMake(j*(imgWidth3+1), y, imgWidth3, imgWidth3);
        }
        
        
        [btn setImageAsyncWithURL:obj.thumbUrl placeholderImage:DefaultImage_logo];
     
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [tap setNumberOfTapsRequired:1];
        [btn addGestureRecognizer:tap];
      
        btn.hidden=NO;
    }];
    int count=(int)imagesCellArray.count;
    for (int i=100+count; i<109; i++) {
        UIButton *btn=(UIButton *)[self viewWithTag:i];
        btn.hidden=YES;
    }
}

-(void)setImageSelectZanArray:(NSArray *)imageSelectZanArray{
    _photoItemArray=imageSelectZanArray;
    [imageSelectZanArray enumerateObjectsUsingBlock:^(MTPhotosModel *obj, NSUInteger idx, BOOL *stop) {
        UIAsyncImageView *btn=(UIAsyncImageView *)[self viewWithTag:idx+100];
        [btn setImageAsyncWithURL:obj.thumbUrl placeholderImage:DefaultImage_logo];
        //   btn.image=obj;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick2:)];
        [tap setNumberOfTapsRequired:1];
        [btn addGestureRecognizer:tap];
        btn.hidden=NO;
    }];
    int count=(int)imageSelectZanArray.count;
    for (int i=100+count; i<109; i++) {
        UIAsyncImageView *btn=(UIAsyncImageView *)[self viewWithTag:i];
        btn.hidden=YES;
    }

}

-(void)tapClick2:(UITapGestureRecognizer *)gesture{
    UIAsyncImageView *imgView=(UIAsyncImageView*)gesture.view;
    int index=(int)imgView.tag-100;
    if ([self.delegate respondsToSelector:@selector(PhotosGroupArray:index:)]) {
        [self.delegate PhotosGroupArray:[_photoItemArray mutableCopy] index:index];
    }
}

-(void)tapClick:(UITapGestureRecognizer *)gesture{
    UIAsyncImageView *imgView=(UIAsyncImageView*)gesture.view;
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photoItemArray.count; // 图片总数
    browser.currentImageIndex = (int )imgView.tag-100;
    browser.delegate = self;
    [browser show];
}


#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIAsyncImageView *imgView=(UIAsyncImageView *)[self viewWithTag:index+100];
    return imgView.image; //self.subviews[index].image;
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [[self.photoItemArray[index] imgUrl] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}


@end
