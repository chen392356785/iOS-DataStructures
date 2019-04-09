//
//  SupplyListView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SupplyListView.h"

@implementation SupplyListView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 2)];
        [self addSubview:lineView];
        lineView.backgroundColor=RGBA(232, 239, 239, 1);
        
        
        CGSize titleSize=[IHUtility GetSizeByText:@"北美橡树" sizeOfFont:20 width:200];
        SMLabel *titleLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.05*WindowWith, 10, titleSize.width, titleSize.height) textColor:RGBA(85, 201, 196, 1) textFont:sysFont(20)];
        titleLbl.text=@"北美橡树";
        [self addSubview:titleLbl];
        
        
        
        
        CGSize numberSize=[IHUtility GetSizeByText:@"(600株)" sizeOfFont:12 width:200];
        SMLabel *numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(titleLbl.right+2, titleLbl.top+8, numberSize.width, numberSize.height) textColor:RGBA(108, 123, 138, 1) textFont:sysFont(12)];
        numberLbl.text=@"(600株)";
        [self addSubview:numberLbl];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.8*WindowWith, numberLbl.top-3, 15, numberLbl.height) textColor:RGBA(253, 120, 135, 1)textFont:sysFont(15)];
        lbl.text=@"￥";
        [self addSubview:lbl];
        
        CGSize priceSize=[IHUtility GetSizeByText:@"320" sizeOfFont:20 width:100];
        SMLabel *priceLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+5, titleLbl.top, priceSize.width, priceSize.height) textColor:RGBA(253, 120, 135, 1) textFont:sysFont(20)];
        priceLbl.text=@"320";
        [self addSubview:priceLbl];
        
        CGSize ganJingSize=[IHUtility GetSizeByText:@"杆径:55cm" sizeOfFont:14 width:200];
        SMLabel *ganJingLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(titleLbl.left, titleLbl.bottom+10, ganJingSize.width, ganJingSize.height) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(14)];
        ganJingLbl.text=@"杆径:55cm";
        [self addSubview:ganJingLbl];
        
        
        CGSize guanFuSize=[IHUtility GetSizeByText:@"冠幅:250-300cm" sizeOfFont:14 width:200];
        SMLabel *guanFuLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith*0.3, ganJingLbl.top, guanFuSize.width, guanFuSize.height) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(14)];
        guanFuLbl.text=@"冠幅:250-300cm";
        [self addSubview:guanFuLbl];
        
        CGSize gaoDuSize=[IHUtility GetSizeByText:@"高度:480~600cm" sizeOfFont:14 width:200];
        SMLabel *gaoDuFuLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith*0.65, ganJingLbl.top, gaoDuSize.width, gaoDuSize.height) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(14)];
        gaoDuFuLbl.text=@"高度:480~600cm";
        [self addSubview:gaoDuFuLbl];
        
        
        
        
        
        
        
        //要求
        UIImage *qiugongImg=Image(@"tedian.png");
        UIImageView *qiugongImageView=[[UIImageView alloc]initWithImage:qiugongImg];
        qiugongImageView.frame=CGRectMake(ganJingLbl.left, ganJingLbl.bottom+15, qiugongImg.size.width, qiugongImg.size.height);
        [self addSubview:qiugongImageView];
        
        CGSize qiugongSize=[IHUtility GetSizeByText:@"求购北美橡树幼苗，苗龄2年以上，具体规格见参数，要求移活率在95以上的。" sizeOfFont:14 width:WindowWith-qiugongImageView.right+10-titleLbl.left];
        SMLabel *qiugouLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(qiugongImageView.right+10, qiugongImageView.top, qiugongSize.width, qiugongSize.height) textColor:RGB(108, 123, 138) textFont:sysFont(14)];
        qiugouLbl.numberOfLines=0;
        qiugouLbl.text=@"求购北美橡树幼苗，苗龄2年以上，具体规格见参数，要求移活率在95以上的。";
        [self addSubview:qiugouLbl];
        
        
        
        //苗源
        UIImage *yongmiaoImg=Image(@"miaoyuan.png");
        UIImageView *yongmiaoImageView=[[UIImageView alloc]initWithImage:yongmiaoImg];
        yongmiaoImageView.frame=CGRectMake(qiugongImageView.left,qiugouLbl.bottom+15, yongmiaoImg.size.width, yongmiaoImg.size.height);
        [self addSubview:yongmiaoImageView];
        
        CGSize yongmiaoSize=[IHUtility GetSizeByText:@"湖南长沙" sizeOfFont:14 width:WindowWith-yongmiaoImageView.right+10-titleLbl.left];
        SMLabel *yongmiaoLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(yongmiaoImageView.right+10, yongmiaoImageView.top, yongmiaoSize.width, yongmiaoSize.height) textColor:RGB(108, 123, 138) textFont:sysFont(14)];
        yongmiaoLbl.numberOfLines=0;
        yongmiaoLbl.text=@"湖南长沙";
        [self addSubview:yongmiaoLbl];
        
        
        
        
        for (NSInteger i=0; i<2; i++) {
            for (NSInteger j=0; j<3; j++) {
                UIImage *img=Image(@"tree.png");
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(yongmiaoImageView.left+j*((WindowWith-yongmiaoImageView.left*2-6)/3+2), yongmiaoLbl.bottom+12+i*((WindowWith-yongmiaoImageView.left*2-6)/3+3), (WindowWith-yongmiaoImageView.left*2-6)/3, (WindowWith-yongmiaoImageView.left*2-6)/3)];
                imageView.image=img;
                [self addSubview:imageView];
            }
            
        }

        
    }
    
    return self;
}

-(void)headTap:(UITapGestureRecognizer *)tap{
    
    self.selectBlock(SelectheadImageBlock);
    
}



@end
