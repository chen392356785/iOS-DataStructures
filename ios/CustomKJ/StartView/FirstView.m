//
//  FirstView.m
//  QiDongYe
//
//  Created by Zmh on 27/4/16.
//  Copyright © 2016年 Zmh. All rights reserved.
//

#import "FirstView.h"
//#import "UIViewAdditions.h"
//#import "MainViewController.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@implementation FirstView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame images:(NSArray *)images index:(int)index top:(CGFloat)imageTop zoomSize:(CGFloat)zoomSize
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        CGFloat y = imageTop * zoomSize;
        if (index == 2) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",images[2]]]];
        }

        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",images[0]]];
        UIImageView *topImageV = [[UIImageView alloc] init];
        topImageV.frame = CGRectMake((Width -image.size.width * zoomSize)/2.0 , y, image.size.width *zoomSize , image.size.height*zoomSize);
        topImageV.image = image;
        topImageV.tag = index + 10;
        imgHeight = topImageV.height;
        imgWidth = topImageV.width;
        imgTop = topImageV.top;
        self.topImageView = topImageV;
        [self addSubview:topImageV];
        
        if (index<2) {
            UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@",images[1]]];
            UIImageView *secondImageV = [[UIImageView alloc] init];
            secondImageV.frame = CGRectMake((Width -image1.size.width*zoomSize)/2.0 , 50.0 *zoomSize + topImageV.bottom , image1.size.width*zoomSize, image1.size.height*zoomSize);
            secondImageV.image = image1;
            [self addSubview:secondImageV];
          }else {
            UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@",images[1]]];
            UIButton *buuton = [[UIButton alloc] initWithFrame:CGRectMake((Width -image1.size.width*zoomSize)/2.0 , 50.0 *zoomSize + topImageV.bottom , image1.size.width*zoomSize, image1.size.height*zoomSize)];
            [buuton setBackgroundImage:image1 forState:UIControlStateNormal];
            [self addSubview:buuton];
              self.startAppBtu = buuton;
            

        }
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:@"changeValue" object:nil];
    }
    return self;
}


- (void)changeValue:(NSNotification *)notfication
{
    float value = [notfication.object[@"value"] floatValue];
    UIImageView *imageView  = (UIImageView *)[self viewWithTag:10];
    UIImageView *imageView2  = (UIImageView *)[self viewWithTag:11];
    imageView2.frame = CGRectMake((Width -imgWidth*0.7)/2.0 ,imgTop + imgHeight*0.15 ,imgWidth*0.7,imgHeight*0.7);
    UIImageView *imageView3  = (UIImageView *)[self viewWithTag:12];

    if (value <= Width /2.0 ) {
        float small = (1-value/(Width/2.0)*0.3);
        float width = imgWidth*small;
        float height = imgHeight*small;
        imageView.frame = CGRectMake((Width -width)/2.0 , imgTop+(imgHeight-width)/2,width , height);
    }else if ( Width /2.0 <= value && value <= Width) {
        
        float small = (1-(2 - value / (Width/2.0))*0.3);
        float width = imgWidth*small;
        float height = imgHeight*small;
        imageView2.frame = CGRectMake((Width -width)/2.0 ,imgTop + (imgHeight - height)/2.0,width , height);
        
    }else if (value >= Width){
        
        float small = (1-(value - Width) / (Width/2.0)*0.3);
        float width = imgWidth*small;
        float height = imgHeight*small;
        imageView2.frame = CGRectMake((Width -width)/2.0 , imgTop + (imgHeight - height)/2.0,width , height);
        
        float small3 = (1-(2 - (value-Width) /(Width/2.0))*0.3);
        float width3 = imgWidth*small3;
        float height3 = imgHeight*small3;
        imageView3.frame = CGRectMake((Width -width3)/2.0 , imgTop + (imgHeight - height3)/2.0,width3 , height3);
    }

    NSLog(@"%f ,%f ,%f",imageView2.width,imageView2.height,imageView2.top);
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                   name:@"changeValue" object:nil];
}
@end
