//
//  BuyListView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "BuyListView.h"

@implementation BuyListView
- (instancetype)initWithFrame:(CGRect)frame  type:(CollecgtionType)type
{self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
       
        
      
        
        SMLabel *titleLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(17, 10, WindowWith, 24) textColor:RGBA(85, 201, 196, 1) textFont:sysFont(20)];
        _titlelbl=titleLbl;
        [self addSubview:titleLbl];
        
     
        SMLabel *numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(titleLbl.right+2, titleLbl.top+6,100, 15) textColor:RGBA(108, 123, 138, 1) textFont:sysFont(14)];
        _numlbl=numberLbl;
        [self addSubview:numberLbl];
        
        if (type==ENT_gongying) {
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 1, WindowWith-30, 41) textColor:RGB(230, 122, 119) textFont:sysFont(17)];
            lbl.text=@"￥320";
            _pricelbl=lbl;
            _pricelbl.right = WindowWith - 30;
            lbl.textAlignment=NSTextAlignmentRight;
            [self addSubview:lbl];
        }
 
        SDPhotosGroupView *imagesView=[[SDPhotosGroupView alloc]initWithFrame:CGRectMake(15, numberLbl.bottom+12, WindowWith-30, 345) withTableViewCell:YES];
        _imagesView=imagesView;
        [self addSubview:imagesView];
     
        
        SMLabel *ganjinLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, imagesView.bottom +12, WindowWith-15*2, 15) textColor:cGrayLightColor textFont:sysFont(15)];
        
        _ganjingLbl=ganjinLbl;
        [self addSubview:ganjinLbl];
        
       
        
        UIImage *lineImg=Image(@"Line2.png");
        UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ganjinLbl.left, ganjinLbl.bottom+10, WindowWith-2*ganjinLbl.left, lineImg.size.height)];
        _lineView=lineImageView;
        lineImageView.image=lineImg;
        [self addSubview:lineImageView];
        
        if (type==ENT_qiugou) {
            UIImage *buyImg=Image(@"buy_2.png");
            UIImageView *buyImageView=[[UIImageView alloc]initWithImage:buyImg];
            buyImageView.frame=CGRectMake(ganjinLbl.left,ganjinLbl.bottom+5 , buyImg.size.width, buyImg.size.height);
            _paymentImageView=buyImageView;
            [self addSubview:buyImageView];
            
            
            UIImage *degreeImg=Image(@"level_3.png");
            UIImageView *degreeImageView=[[UIImageView alloc]initWithImage:degreeImg];
            degreeImageView.frame=CGRectMake(buyImageView.right+10, buyImageView.top, degreeImg.size.width, degreeImg.size.height);
            _urgencyImageView=degreeImageView;
            [self addSubview:degreeImageView];
            
            lineImageView.top = buyImageView.bottom + 10;
        }
   
        SMLabel *yaoqiuLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(ganjinLbl.left, lineImageView.bottom+15, 47, 15) textColor:RGB(108, 123, 138) textFont:sysFont(8)];
        _yqkeylbl=yaoqiuLabel;
        if (type==ENT_qiugou) {
            yaoqiuLabel.text=@"需求描述";
        }else if (type==ENT_gongying){
            yaoqiuLabel.text=@"产品特点";
        }
     
        yaoqiuLabel.textAlignment=NSTextAlignmentCenter;
        [yaoqiuLabel setLayerMasksCornerRadius:3 BorderWidth:0.5 borderColor:RGB(189, 202, 219)];
        [self addSubview:yaoqiuLabel];
        
       
//        SMLabel *yaoqiuLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(yaoqiuLabel.right+10, yaoqiuLabel.top, WindowWith-77-15, 21) textColor:RGB(108, 123, 137) textFont:sysFont(14)];
//        _yqvaluelbl=yaoqiuLbl;
//        yaoqiuLbl.numberOfLines=0;
//        yaoqiuLbl.text=@"求购北美橡树幼苗，苗龄2年以上，具体规格见参数，要求移活率在95以上的。";
//        [self addSubview:yaoqiuLbl];
        
        UITextView * contentLbl = [[UITextView alloc]init];
        contentLbl.font = [UIFont systemFontOfSize:14];
        _yqvaluelbl=contentLbl;
        contentLbl.scrollEnabled=NO;
        contentLbl.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
        if(_IOS7){
            contentLbl.selectable = YES;//用法：决定UITextView 中文本是否可以相应用户的触摸，主要指：1、文本中URL是否可以被点击；2、UIMenuItem是否可以响应
        }
     //   contentLbl.delegate=self;
        contentLbl.backgroundColor=[UIColor clearColor];
        [contentLbl setEditable:NO];
        contentLbl.textColor=RGB(108, 123, 137);
        contentLbl.frame = CGRectMake(yaoqiuLabel.right+10, yaoqiuLabel.top, WindowWith-77-15+10, 21);
        [self addSubview :contentLbl];
        
     
      
        SMLabel *quyuLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, _yqvaluelbl.bottom+15, 47, 15) textColor:RGB(108, 123, 138) textFont:sysFont(8)];
        _quyukeylbl=quyuLabel;
        if (type==ENT_gongying) {
            quyuLabel.text=@"苗源所在地";
        }else if (type==ENT_qiugou)
            quyuLabel.text=@"采苗区域";
        quyuLabel.textAlignment=NSTextAlignmentCenter;
        [quyuLabel setLayerMasksCornerRadius:3 BorderWidth:0.5 borderColor:RGB(189, 202, 219)];
        [self addSubview:quyuLabel];
        
        
    
        SMLabel *quyuLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(quyuLabel.right+10, quyuLabel.top, WindowWith-77-15, 16) textColor:RGB(108, 123, 138) textFont:sysFont(14)];
        quyuLbl.numberOfLines=0;
        _quyuvaluelbl=quyuLbl;
        quyuLbl.text=@"湖南、湖北及两广一带";
        [self addSubview:quyuLbl];
        
        CGFloat quHeigh=quyuLabel.bottom;
        if (type==ENT_qiugou) {
            SMLabel *yongmiaoLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, quyuLbl.bottom+15, 47, 15) textColor:RGB(108, 123, 138) textFont:sysFont(8)];
            _ymkeylbl=yongmiaoLabel;
            yongmiaoLabel.text=@"用苗地点";
            yongmiaoLabel.textAlignment=NSTextAlignmentCenter;
            [yongmiaoLabel setLayerMasksCornerRadius:3 BorderWidth:0.5 borderColor:RGB(189, 202, 219)];
            [self addSubview:yongmiaoLabel];
            
            CGSize yongmiaoSize=[IHUtility GetSizeByText:@"湖南长沙" sizeOfFont:14 width:WindowWith-yongmiaoLabel.right+10-titleLbl.left];
            SMLabel *yongmiaoLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(yongmiaoLabel.right+10, yongmiaoLabel.top, yongmiaoSize.width, yongmiaoSize.height) textColor:RGB(108, 123, 138) textFont:sysFont(14)];
            _ymvaluelbl=yongmiaoLbl;
            yongmiaoLbl.numberOfLines=0;
         //   yongmiaoLbl.text=@"湖南长沙";
            [self addSubview:yongmiaoLbl];
            
            quHeigh=yongmiaoLabel.bottom;
        }
        
    }
    
    return self;
}
//-(void)headTap:(UITapGestureRecognizer *)tap{
//
//    self.selectBlock(SelectheadImageBlock);
//
//}

-(void)setData:(MTSupplyAndBuyListModel*)model type:(CollecgtionType)type{
    CGRect rect=_titlelbl.frame;
    CGSize size=[IHUtility GetSizeByText:model.varieties sizeOfFont:20 width:WindowWith];
    CGFloat w=WindowWith-90-18-60;
    CGFloat w1;
    if (size.width>w) {
        w1=w;
    }else{
        w1=size.width;
    }
    rect.size.width=w1;
    _titlelbl.frame=rect;
    _titlelbl.text=model.varieties;
    
    rect=_numlbl.frame;
    rect.origin.x=_titlelbl.right+2;
    _numlbl.frame=rect;
    _numlbl.text=[NSString stringWithFormat:@"(%@株)",model.number];
    _imagesView.imagesCellArray=model.imgArray;
    
    rect=_imagesView.frame;
    rect.origin.y=_numlbl.bottom+12;
    int imgHeigh;
    if (model.imgArray.count>0) {
        rect.size.height=[IHUtility getNewImagesViewHeigh:model.imgArray imageWidth:WindowWith-30];
        imgHeigh=0;
    }else{
        rect.size.height=0;
        imgHeigh=-7;
    }
    _imagesView.frame=rect;
    
    
    if (type==ENT_gongying  ||type==ENT_qiugou) {   //供应
        
        NSMutableArray *bqArray=[self getLabelViewList:model.rod_diameter
                                         crown_width_s:model.crown_width_s
                                         crown_width_e:model.crown_width_e
                                              height_s:model.height_s
                                              height_e:model.height_e
                                          branch_point:model.branch_point
                                            number:[model.number integerValue] ];
        NSMutableString *str=[[NSMutableString alloc]init];
        for (NSString *obj in bqArray) {
            [str appendString:[NSString stringWithFormat:@"%@ ",obj]];
        }
        _ganjingLbl.text=str;
        
        
        
        rect= _ganjingLbl.frame;
        rect.origin.y=_imagesView.bottom+15;
       
        rect.size.height=15;
        _ganjingLbl.frame=rect;
        
       // [_lableView setData:bqArray];
        
        
        UIImage *buyImg=Image(@"buy_2.png");
        UIImage *degreeImg=Image(@"level_3.png");
        
      
        
        if (type==ENT_qiugou) {
            int payType=[model.payment_methods_dictionary_id intValue];
            int urgencyType=[model.urgency_level_id intValue];
       
            if (payType==0) {
                _paymentImageView.hidden=YES;
                
            }else{
                if (payType==1) {
                    buyImg=Image(@"buy_1.png");
                }else if (payType==2){
                    buyImg=Image(@"buy_2.png");
                }else if (payType==3){
                    buyImg=Image(@"buy_3.png");
                }
                _paymentImageView.image=buyImg;
                _paymentImageView.hidden=NO;
                rect.size.width=buyImg.size.width;
                rect.size.height=buyImg.size.height;
                rect=_paymentImageView.frame;
                rect.origin.y=_ganjingLbl.bottom+5;
                _paymentImageView.frame=rect;
                
            
              
            }
            if (urgencyType==0) {
                _urgencyImageView.hidden=YES;
            }else
            {
                if (urgencyType==1) {
                    degreeImg=Image(@"xunjia.png");
                }else if (urgencyType==2){
                    degreeImg=Image(@"lijicaigou.png");
                }else if (urgencyType==3){
                    degreeImg=Image(@"jihuacaigou.png");
                }
                _urgencyImageView.image=degreeImg;
                _urgencyImageView.hidden=NO;
                if (_paymentImageView.hidden) {
                    rect=_urgencyImageView.frame;
                    rect.origin.y=_ganjingLbl.bottom+5;
                    rect.origin.x=_paymentImageView.left;
                   rect.size.width=degreeImg.size.width;
                    rect.size.height=degreeImg.size.height;
                    _urgencyImageView.frame=rect;
                }else
                {
                    rect=_urgencyImageView.frame;
                    rect.origin.y=_ganjingLbl.bottom+5;
                    rect.origin.x=_paymentImageView.right+10;
                    rect.size.width=degreeImg.size.width;
                    rect.size.height=degreeImg.size.height;
                    _urgencyImageView.frame=rect;
                    
                }
                
            }
            
        }
        
        
        rect=_lineView.frame;
        
        if (type == ENT_qiugou) {
            if (_paymentImageView.hidden == YES && _urgencyImageView.hidden == YES) {
                rect.origin.y=_ganjingLbl.bottom+10;
            }else {
                if (_paymentImageView.hidden == YES) {
                     rect.origin.y=_urgencyImageView.bottom+10;
                }else{
                rect.origin.y=_paymentImageView.bottom+10;
                }
            }
        }else if (type==ENT_gongying){

            rect.origin.y=_ganjingLbl.bottom+10;
        }
        
        _lineView.frame=rect;
        
        if (type==ENT_qiugou) {
            _yqkeylbl.text=@"需求描述";
        }else if (type==ENT_gongying){
            _yqkeylbl.text=@"产品特点";
        }
        
        if (type==ENT_gongying) {
            _quyukeylbl.text=@"苗源所在地";
        }else if (type==ENT_qiugou)
            _quyukeylbl.text=@"采苗区域";
        
        
        CGFloat h1=0;
        if (model.selling_point.length>0) {
            rect=_yqkeylbl.frame;
            rect.origin.y=_lineView.bottom+15;
            _yqkeylbl.frame=rect;
            _yqkeylbl.hidden=NO;
            rect=_yqvaluelbl.frame;
            CGSize size1=[IHUtility GetSizeByText:model.selling_point sizeOfFont:14 width:WindowWith-77-15];
            rect.origin.y=_yqkeylbl.top-9;
            rect.size.height=size1.height+18;
            _yqvaluelbl.frame=rect;
            _yqvaluelbl.text=model.selling_point;
            _yqvaluelbl.hidden=NO;
            h1=_yqvaluelbl.bottom;
        }else{
            h1=_lineView.bottom;
            _yqkeylbl.hidden=YES;
            _yqvaluelbl.hidden=YES;
        }
        int h2;
        NSString *myStr;
        if (type==ENT_gongying) {
            myStr=model.seedling_source_address;
            
            _pricelbl.text=[NSString stringWithFormat:@"￥%.2f",[model.unit_price doubleValue]];
            CGSize sizePrice=[IHUtility GetSizeByText:_pricelbl.text sizeOfFont:17 width:WindowWith-77-15];
            _pricelbl.width = sizePrice.width;
            _pricelbl.right = WindowWith - 30;
            if (_titlelbl.width + _numlbl.width + 19 > WindowWith - _pricelbl.width - 30) {
                _titlelbl.width = _pricelbl.left - _numlbl.width - 19;
                _numlbl.left = _titlelbl.right + 2;
            }
            
        }else if (type==ENT_qiugou){
            myStr=model.mining_area;
        }
        if (myStr.length>0) {
            rect=_quyukeylbl.frame;
            rect.origin.y=h1+12;
            _quyukeylbl.frame=rect;
            _quyukeylbl.hidden=NO;
            _quyuvaluelbl.hidden=NO;
            rect=_quyuvaluelbl.frame;
            rect.origin.y=_quyukeylbl.top;
            _quyuvaluelbl.frame=rect;
            _quyuvaluelbl.text=myStr;
            h2=_quyuvaluelbl.bottom;
        }else{
            _quyukeylbl.hidden=YES;
            _quyuvaluelbl.hidden=YES;
            h2=h1;
        }
        
        int h3=0;
        if (type==ENT_qiugou) {
            
            if (model.use_mining_area.length>0) {
                rect=_ymkeylbl.frame;
                rect.origin.y=h2+12;
                _ymkeylbl.frame=rect;
                _ymkeylbl.hidden=NO;
                _ymvaluelbl.hidden=NO;
                rect=_ymvaluelbl.frame;
                rect.origin.y=_ymkeylbl.top;
                _ymvaluelbl.frame=rect;
                _ymvaluelbl.text=model.use_mining_area;
                h3=_ymvaluelbl.bottom;
            }else{
                _ymkeylbl.hidden=YES;
                _ymvaluelbl.hidden=YES;
                h3=h2;
            }
            
        }
        

        
    }
   
    
    
}

-(NSMutableArray *)getLabelViewList:(CGFloat)rod_diameter
                      crown_width_s:(CGFloat)crown_width_s
                      crown_width_e:(CGFloat)crown_width_e
                           height_s:(CGFloat)height_s
                           height_e:(CGFloat)height_e
                       branch_point:(CGFloat)branch_point
                             number:(NSInteger)number
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (number>0) {
        NSString *str=[NSString stringWithFormat:@"#数量%ld株",number];
        [arr addObject:str];
    }
    
    if (rod_diameter>0) {
        NSString *str=[NSString stringWithFormat:@"#杆径%.1fcm",rod_diameter];
        [arr addObject:str];
    }
    if (crown_width_s>0 && crown_width_e>0) {
        NSString *str=[NSString stringWithFormat:@"#冠幅%.1f-%.1fcm",crown_width_s,crown_width_e];
        [arr addObject:str];
    }else if (crown_width_s>0 || crown_width_e>0){
        if (crown_width_s>0) {
            NSString *str=[NSString stringWithFormat:@"#冠幅%.1fcm",crown_width_s];
            [arr addObject:str];
        }else{
            NSString *str=[NSString stringWithFormat:@"#冠幅%.1fcm",crown_width_e];
            [arr addObject:str];
        }
        
        
    }
    
    if (height_s>0 && height_e>0) {
        NSString *str=[NSString stringWithFormat:@"#高度%.1f-%.1fcm",height_s,height_e];
        [arr addObject:str];
    }else if (height_s>0 || height_e>0){
        if (height_s>0) {
            NSString *str=[NSString stringWithFormat:@"#高度%.1fcm",height_s];
            [arr addObject:str];
        }else{
            NSString *str=[NSString stringWithFormat:@"#高度%.1fcm",height_e];
            [arr addObject:str];
        }
        
    }
    
    
    if (branch_point>0) {
        NSString *str=[NSString stringWithFormat:@"#分支点%.1fcm",branch_point];
        [arr addObject:str];
    }
    return arr;
}


//-(BOOL)isEmpty:(NSString *) str {
//    
//    if (!str) {
//        return true;
//    } else {
//        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
//        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//        
//        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
//        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
//        
//        if ([trimedString length] == 0) {
//            return true;
//        } else {
//            return false;
//        }
//    }
//}


@end
