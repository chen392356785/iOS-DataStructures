//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"


static const CGFloat kWidth = 150.0f;
static const CGFloat kHeight = 60.f;

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   250.0
#define kCalloutHeight  70.0

@interface CustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView

@synthesize calloutView=_calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    self.selectBtnBlock(coorinate.latitude,coorinate.longitude,@"1");
    NSLog(@"点击导航coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            /* Construct custom callout. */
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
            [self.calloutView addGestureRecognizer:tap];
            
            
            
            UIImage *img=Image(@"mt_daohang.png");
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kCalloutWidth-img.size.width-25, 20)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = cGreenColor;
            name.text = self.name;//@"Hello Amap!";
            [self.calloutView addSubview:name];
            
           
            CGSize size=[IHUtility GetSizeByText:self.adress sizeOfFont:12 width:kCalloutWidth-img.size.width-35];
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(name.left, name.bottom+5, size.width, size.height) textColor:cGrayLightColor textFont:sysFont(12)];
            lbl.numberOfLines=2;
            lbl.textColor=cBlackColor;
            lbl.text=self.adress;
            if (size.height>35) {
                lbl.height=35;
            }
            [self.calloutView addSubview:lbl];
            
            
           
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(kCalloutWidth-img.size.width-10, 10, img.size.width, img.size.height);
            [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            
            [self.calloutView addSubview:btn];
            
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(kCalloutWidth-btn.width-15, btn.top, 1, btn.height)];
            lineView.backgroundColor=cLineColor;

            [self.calloutView addSubview:lineView];
            
            
            img=Image(@"GQ_Left.png");
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left-img.size.width-5, kCalloutHeight/2-img.size.height, img.size.width, img.size.height)];
            imageview.image=img;
            [self.calloutView addSubview:imageview];
            
        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

-(void)headTap:(UITapGestureRecognizer *)tap{
    
    self.selectBlock(SelectNameBlock);
    
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}








#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
       // self.backgroundColor = [UIColor grayColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHoriMargin, kVertMargin, kPortraitWidth, kPortraitHeight)];
        //[self addSubview:self.portraitImageView];
        
        /* Create name label. */
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitWidth + kHoriMargin,
                                                                   kVertMargin,
                                                                   kWidth - kPortraitWidth - kHoriMargin,
                                                                   kHeight - 2 * kVertMargin)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.textColor        = [UIColor whiteColor];
        self.nameLabel.font             = sysFont(15);
        //[self addSubview:self.nameLabel];
    }
    
    return self;
}

@end
