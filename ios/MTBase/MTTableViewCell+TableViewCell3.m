//
//  MTTableViewCell+TableViewCell3.m
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/12/5.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell+TableViewCell3.h"

@implementation MTTableViewCell (TableViewCell3)

@end

@implementation HotInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kWidth(160))];
        scroll.showsHorizontalScrollIndicator=NO;
        _scroll=scroll;
        for (int i=0; i<10; i++) {
            
            int x = 12;
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(x+(kWidth(160)+7)*i, kWidth(11), kWidth(160), kWidth(146))];
            v.tag=100+i;
            
            v.hidden=YES;
            UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 0,kWidth(160),kWidth(103))];
            [imgView setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:[UIColor clearColor]];
            /*  UIViewContentModeScaleToFill  */
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.tag=110+i;
            [v addSubview:imgView];
            
//            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imgView.bottom+6.5, v.width, 15) textColor:RGB(44, 44, 46) textFont:sysFont(15)];
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imgView.bottom + kWidth(3), imgView.width, v.height - imgView.bottom) textColor:kColor(@"#333333") textFont:sysFont(13)];
            lbl.tag=120+i;
            lbl.numberOfLines = 2;
            lbl.textAlignment = NSTextAlignmentLeft;
            lbl.text=@"关于树苗的故事";
            [v addSubview:lbl];
            
            
            lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, lbl.bottom, v.width, 16.5) textColor:RGB(135, 134, 140) textFont:sysFont(12)];
            lbl.tag=130+i;
            lbl.text=@"我们来做一个关于树木的测试...";
//            [v addSubview:lbl];
            
            [scroll addSubview:v];
            
        }
        [self.contentView addSubview:scroll];
        
    }
    return self;
}

-(void)setItemArray:(NSMutableArray *)ItemArray{
    
    [ItemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *v=[self viewWithTag:100+idx];
        v.hidden=NO;
        
        UIAsyncImageView *imgView=[v viewWithTag:110+idx];
        
        
        NSArray *arr=[network getJsonForString:obj[@"info_url"]];
      
        NSString *ImgUrlStr;
        if ([arr.firstObject[@"t_url"] hasPrefix:@"http"]) {
            ImgUrlStr = arr.firstObject[@"t_url"];
        }else {
            ImgUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,arr.firstObject[@"t_url"]];
        }
        [imgView setImageAsyncWithURL:ImgUrlStr placeholderImage:DefaultImage_logo];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        
        SMLabel *lbl= [v viewWithTag:120+idx];
        lbl.text=obj[@"info_title"];
        
        
        lbl=[v viewWithTag:130+idx];
        lbl.text=obj[@"infomation_desc"];
        
        IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.objectValue=obj;
        [v addGestureRecognizer:tap];
        
    }];
    
    _scroll.contentSize=CGSizeMake( kWidth(160) *ItemArray.count +7*(ItemArray.count+1), _scroll.height);
    for (NSInteger i=100+ItemArray.count; i<110; i++) {
        UIView *btn=(UIView *)[self viewWithTag:i];
        btn.hidden=YES;
    }
}

-(void)tapClick:(IHTapGesureRecornizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MYActionHomePageZiXunTableViewAction indexPath:self.indexPath attribute:tap.objectValue];
    }
}

@end

@implementation ZhanLueQiYeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kWidth(160))];
        scroll.showsHorizontalScrollIndicator=NO;
        _scroll=scroll;
        
        for (int i=0; i<10; i++) {
            
            int x = 12;
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(x+(kWidth(160)+7)*i, kWidth(11), kWidth(160), kWidth(146))];
            v.tag=100+i;
            
            v.hidden=YES;
           UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 0,kWidth(160),kWidth(103))];
            [imgView setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:[UIColor clearColor]];
            /*  UIViewContentModeScaleToFill  */
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.tag=110+i;
            [v addSubview:imgView];
            
            //            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imgView.bottom+6.5, v.width, 15) textColor:RGB(44, 44, 46) textFont:sysFont(15)];
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imgView.bottom + kWidth(3), imgView.width, v.height - imgView.bottom) textColor:kColor(@"#333333") textFont:sysFont(13)];
            lbl.tag=150+i;
            lbl.numberOfLines = 0;
            lbl.textAlignment = NSTextAlignmentLeft;
            lbl.text=@"关于树苗的故事";
            [v addSubview:lbl];
            
            
            lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, lbl.bottom+5.5, v.width, 16.5) textColor:RGB(135, 134, 140) textFont:sysFont(12)];
            lbl.tag=180+i;
            lbl.text=@"我们来做一个关于树木的测试...";
            //            [v addSubview:lbl];
            
            [scroll addSubview:v];
            
        }
        [self.contentView addSubview:scroll];
        
    }
    return self;
}

-(void)setItemArray:(NSMutableArray *)ItemArray{
    
    [ItemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *v=[self viewWithTag:100+idx];
        v.hidden=NO;
        
        UIAsyncImageView *imgView=[v viewWithTag:110+idx];
        
//        NSString *ImgUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,obj[@"logo"]];
//        [imgView setImageAsyncWithURL:ImgUrlStr placeholderImage:DefaultImage_logo];
        NSArray *arr=[network getJsonForString:obj[@"company_image"]];
        if (arr > 0) {
            NSDictionary *imgDic  = arr[0];
            [imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,imgDic[@"t_url"]] placeholderImage:DefaultImage_logo];
        }else {
            imgView.image = DefaultImage_logo;
        }
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        
        
        SMLabel *lbl= [v viewWithTag:150+idx];
        lbl.text=obj[@"company_name"];
    
        
        lbl=[v viewWithTag:180+idx];
        lbl.text=obj[@"company_desc"];
        
        IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.objectValue=obj;
        [v addGestureRecognizer:tap];
        
    }];
    
    _scroll.contentSize=CGSizeMake( kWidth(160) *ItemArray.count +7*(ItemArray.count+1), _scroll.height);
    for (NSInteger i=100+ItemArray.count; i<110; i++) {
        UIView *btn=(UIView *)[self viewWithTag:i];
        btn.hidden=YES;
    }
}

-(void)tapClick:(IHTapGesureRecornizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MYActionHomePageZhanlueQiyeTableViewAction indexPath:self.indexPath attribute:tap.objectValue];
    }
}

@end

//新品种
@implementation HotXinPinZhongTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, kWidth(10), WindowWith, kWidth(273))];
            scroll.showsHorizontalScrollIndicator=NO;
            _scroll=scroll;
            for (int i=0; i<12; i++) {
                UIControl *v=[[UIControl alloc]initWithFrame:CGRectMake(12+i*(kWidth(170)+kWidth(7)), kWidth(5), kWidth(170), kWidth(263))];
                v.tag=100+i;
                v.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
                UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(kWidth(4), 0,  kWidth(162), kWidth(205))];
                imgView.tag=310+i;
                [imgView setLayerMasksCornerRadius:3 BorderWidth:0 borderColor:[UIColor clearColor]];
                [v addSubview:imgView];
                
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, imgView.bottom, width(imgView), height(v) - imgView.bottom)];
                bgView.backgroundColor = [UIColor whiteColor];
                bgView.tag = 330+i;
                bgView.alpha = 0.7;
                
                SMLabel *nameLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(kWidth(4), kWidth(10), width(bgView) - kWidth(8), kWidth(15)) textColor:kColor(@"#282828") textFont:RegularFont(12)];
                nameLabel.tag = 350+i;
                nameLabel.text=@"品种：香樟";
                [bgView addSubview:nameLabel];
                
                SMLabel *PicLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(nameLabel.left, nameLabel.bottom + kWidth(8), nameLabel.width, kWidth(15)) textColor:kColor(@"#070707") textFont:boldFont(12)];
                PicLabel.text=@"￥ 12";
                PicLabel.tag = 300+i;
                PicLabel.textAlignment = NSTextAlignmentLeft;
                [bgView addSubview:PicLabel];
                
                
                
                SMLabel *GuigeLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(minX(nameLabel), maxY(nameLabel), width(PicLabel) , kWidth(18)) textColor:RGB(44, 44, 46) textFont:sysFont(13)];
                GuigeLabel.text=@"规格：50cm";
                GuigeLabel.tag = 400+i;
//                [bgView addSubview:GuigeLabel];
                
                SMLabel *phoneLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(minX(nameLabel), maxY(GuigeLabel), width(PicLabel), kWidth(18)) textColor:RGB(44, 44, 46) textFont:sysFont(13)];
                phoneLabel.text=@"联系方式：16668765555df";
                phoneLabel.tag = 450+i;
//                [bgView addSubview:phoneLabel];
                
                [v addSubview:bgView];
                [_scroll addSubview:v];
                 v.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
                v.layer.cornerRadius = 7;
                v.layer.shadowOffset = CGSizeMake(0, 0);
                v.layer.shadowOpacity = 1;
                v.layer.shadowRadius = 3;
                
            }
        [self.contentView addSubview:scroll];
    }
    return self;
}


-(void)setItemArray:(NSMutableArray *)ItemArray{
    
    [ItemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIControl *v=[self->_scroll viewWithTag:100+idx];
        v.hidden=NO;
        UIAsyncImageView *imgView=[v viewWithTag:310+idx];
        
        NSString *ImgUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,obj[@"src_pic"]];
        [imgView setImageAsyncWithURL:ImgUrlStr placeholderImage:DefaultImage_logo];
        
        UIView *bgView = [v viewWithTag:330+idx];
        
        SMLabel *lbl0=[bgView viewWithTag:300+idx];
        
        NSString *str = [NSString stringWithFormat:@"价格：￥%@",obj[@"loadingPrice"]];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#F20B0B") range:NSMakeRange(3, str.length - 3)];
        lbl0.attributedText = attributedStr;
        
//        lbl0.text = [NSString stringWithFormat:@"￥ %@",obj[@"loadingPrice"]];
        SMLabel *lbl1=[bgView viewWithTag:350+idx];
        lbl1.text = [NSString stringWithFormat:@"品种：%@",obj[@"plantTitle"]];
//        SMLabel *lbl2=[bgView viewWithTag:400+idx];
//        lbl2.text = [NSString stringWithFormat:@"规格：%@",obj[@"remark"]];
//        SMLabel *lbl3=[bgView viewWithTag:450+idx];
//        lbl3.text = [NSString stringWithFormat:@"联系方式：%@",obj[@"mobile"]];
        IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.objectValue=obj;
        [v addGestureRecognizer:tap];
        
    }];
    _scroll.contentSize=CGSizeMake( (kWidth(170)+kWidth(7)) *ItemArray.count +12, _scroll.height);
    for (NSInteger i=100+ItemArray.count; i<112; i++) {
        UIControl *btn=(UIControl *)[_scroll viewWithTag:i];
        btn.hidden=YES;
    }
}
-(void)tapClick:(IHTapGesureRecornizer *)tap{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTActionHomePageXinPinZhongTableViewCellAction indexPath:self.indexPath attribute:tap.objectValue];
    }
}
@end

@implementation HotVarietiesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat w = WindowWith/4;
        
        for (int i=0; i<4; i++) {
            ECloudMiaoMuYunCollectionView *view=[[ECloudMiaoMuYunCollectionView alloc]initWithFrame:CGRectMake(i*w, kWidth(20), w, w+10)];
            view.titleLab.text=@"高大乔木";
            view.tag=200+i;
            view.hidden=YES;
            [self.contentView addSubview:view];
        }
    }
    return self;
}

-(void)tapClick:(IHTapGesureRecornizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTActionHomePagePinZhongTableViewCellAciont indexPath:self.indexPath attribute:tap.objectValue];
    }
}


-(void)setItemArray:(NSMutableArray *)ItemArray{
    
    [ItemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ECloudMiaoMuYunCollectionView *v=[self viewWithTag:200+idx];
        v.hidden=NO;
        
        [v.imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,obj[@"nursery_image"]] placeholderImage:Image(@"cs_xz.png")];
        v.titleLab.text =[obj objectForKey:@"nursery_type_name"];
        
        IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.objectValue=obj;
        [v addGestureRecognizer:tap];
    }];
    
    
    for (NSInteger i=200+ItemArray.count; i<204; i++) {
        ECloudMiaoMuYunCollectionView *btn=(ECloudMiaoMuYunCollectionView *)[self viewWithTag:i];
        btn.hidden=YES;
    }
}


@end

@implementation HotCompanyTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        for (int i=0; i < 2; i++) {
            
            UIControl *v=[[UIControl alloc]initWithFrame:CGRectMake(12+i*(kWidth(170)+kWidth(7)), 20, kWidth(170), kWidth(262))];
            v.tag=300+i;
            v.backgroundColor = [UIColor whiteColor];
            UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(kWidth(4), 2, kWidth(162), kWidth(205))];
            imgView.tag=310+i;
            [imgView setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:[UIColor clearColor]];
            [v addSubview:imgView];
            
            UIImage *vipImg=Image(@"hp_viptb.png");
            UIImageView *vipView=[[UIImageView alloc]initWithFrame:CGRectMake(imgView.right-2-vipImg.size.width, imgView.bottom-vipImg.size.height+4, vipImg.size.width, vipImg.size.height)];
            vipView.image=vipImg;
//            [v addSubview:vipView];
            
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imgView.left, imgView.bottom, imgView.width, height(v) - imgView.bottom - kWidth(12)) textColor:kColor(@"#282828") textFont:sysFont(12)];
            lbl.textAlignment = NSTextAlignmentLeft;
            lbl.text=@"杭州绿化园林公司";
            lbl.numberOfLines = 2;
            lbl.tag=320+i;
            [v addSubview:lbl];
            
            v.layer.cornerRadius = 7;
            v.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
            v.layer.shadowOffset = CGSizeMake(0, 0);
            v.layer.shadowOpacity = 1;
            v.layer.shadowRadius = 3;
            
            [self.contentView addSubview:v];
            
           
            
        }
    }
    return self;
}


-(void)setItemArray:(NSMutableArray *)ItemArray{
    
    [ItemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIControl *v=[self viewWithTag:300+idx];
        v.hidden=NO;
        UIAsyncImageView *imgView=[v viewWithTag:310+idx];
//        NSArray *arr=[network getJsonForString:obj[@"company_image"]];
        [imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",obj[@"company_index_image"]] placeholderImage:DefaultImage_logo];
//        if (arr > 0) {
//            NSDictionary *imgDic  = arr[0];
//            [imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,imgDic[@"t_url"]] placeholderImage:DefaultImage_logo];
//        }else {
//            imgView.image = DefaultImage_logo;
//        }
        SMLabel *lbl=[v viewWithTag:320+idx];
        lbl.text = obj[@"company_name"];
        
        IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.objectValue=obj;
        [v addGestureRecognizer:tap];
        
    }];
    
    
    for (NSInteger i=300+ItemArray.count; i<302; i++) {
        UIControl *btn=(UIControl *)[self viewWithTag:i];
        btn.hidden=YES;
    }
}
-(void)tapClick:(IHTapGesureRecornizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTActionHomePageQiYeTableViewCellAction indexPath:self.indexPath attribute:tap.objectValue];
    }
}




@end

@implementation HotContactsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat w= (WindowWith - 75)/5;
        
        for (int i=0; i<5; i++) {
            
            UIControl *v=[[UIControl alloc]initWithFrame:CGRectMake(12+i*(w+12), 8,w, w+30)];
            v.tag=400+i;
         
            UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 0,w, w)];
            imgView.tag=410+i;
            [imgView setLayerMasksCornerRadius:w/2 BorderWidth:0 borderColor:[UIColor clearColor]];
            [v addSubview:imgView];
            
            UIImage *vipImg=Image(@"hp_viptb.png");
            UIImageView *vipView=[[UIImageView alloc]initWithFrame:CGRectMake(imgView.right-2-vipImg.size.width, imgView.bottom-vipImg.size.height-1, vipImg.size.width, vipImg.size.height)];
            vipView.image=vipImg;
            
            [v addSubview:vipView];
            
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imgView.left, imgView.bottom+13, imgView.width, 14) textColor:RGB(44, 44, 46) textFont:sysFont(14)];
            lbl.textAlignment=NSTextAlignmentCenter;
            lbl.tag=420+i;
            [v addSubview:lbl];
            [self.contentView addSubview:v];
        }
        
    }
    return self;
}

-(void)setItemArray:(NSMutableArray *)ItemArray{
    
    [ItemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIControl *v=[self viewWithTag:400+idx];
        v.hidden=NO;
        UIAsyncImageView *imgView=[v viewWithTag:410+idx];
   
        SMLabel *lbl=[v viewWithTag:420+idx];
       
//        [imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@@!body",ConfigManager.ImageUrl,obj[@"heed_image_url"]] placeholderImage:defalutHeadImage];
        [imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,obj[@"heed_image_url"]] placeholderImage:defalutHeadImage];
        lbl.text=[obj objectForKey:@"nickname"];
        
        IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.objectValue=obj;
        [v addGestureRecognizer:tap];
    }];
    
    
    for (NSInteger i=400+ItemArray.count; i<405; i++) {
        UIControl *btn=(UIControl *)[self viewWithTag:i];
        btn.hidden=YES;
    }
}

-(void)tapClick:(IHTapGesureRecornizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTActionHomePageRenMaiTableViewCellAction indexPath:self.indexPath attribute:tap.objectValue];
    }
}


@end

@implementation ScoreHistoryCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.width = WindowWith;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 200)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(12, 12, self.width - 100, 20) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text = @"";
        _orderNumLbl= lbl;
        [backView addSubview:lbl];
        
        CGSize size = [IHUtility GetSizeByText:@"支付成功" sizeOfFont:14 width:200];
        SMLabel *stateLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 12, size.width, 20) textColor:cGreenColor textFont:sysFont(14)];
        stateLbl.right = self.width - 12;
        stateLbl.text = @"支付成功";
//        _stateLbl = stateLbl;
        stateLbl.textAlignment= NSTextAlignmentCenter;
        [backView addSubview:stateLbl];
        
        UIView *linview = [[UIView alloc] initWithFrame:CGRectMake(12, lbl.bottom + 12, self.width-24, 1)];
        linview.backgroundColor = cLineColor;
        [backView addSubview:linview];
        
        UIAsyncImageView *imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(12, linview.bottom + 12, 95, 64)];
        imageView.image = Image(@"score_HIstoryType.png");
        _imageView= imageView;
        [backView addSubview:imageView];
        
        SMLabel *timeLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, imageView.width- 22, 18) textColor:[UIColor whiteColor] textFont:[UIFont boldSystemFontOfSize:19]];
        timeLbl.text = @"";
        _timeLbl = timeLbl;
        timeLbl.textAlignment = NSTextAlignmentCenter;
        timeLbl.bottom = imageView.height/2.0;
        [imageView addSubview:timeLbl];
        
        SMLabel *typeLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, imageView.width- 22, 18) textColor:[UIColor whiteColor] textFont:sysFont(17)];
        typeLbl.text = @"";
        typeLbl.textAlignment = NSTextAlignmentCenter;
        typeLbl.top = imageView.height/2.0;
        _typeLbl = typeLbl;
        [imageView addSubview:typeLbl];
        
        
        SMLabel *nameLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageView.right + 10, imageView.top + 8, self.width - imageView.right - 22, 20) textColor:cBlackColor textFont:sysFont(14)];
        nameLbl.text = @"";
        _nameLbl = nameLbl;
        [backView addSubview:nameLbl];
        
        SMLabel *priceLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageView.right + 10, 0, 100, 13) textColor:cBlackColor textFont:sysFont(13)];
        priceLbl.bottom = imageView.bottom - 8;
        priceLbl.text = @"";
        _priceLbl = priceLbl;
        [backView addSubview:priceLbl];
        
        SMLabel *numLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, 20, 13) textColor:cBlackColor textFont:sysFont(13)];
        numLbl.bottom = priceLbl.bottom;
        numLbl.right = self.width - 12;
        numLbl.text = @"";
        _numLbl = numLbl;
        [backView addSubview:numLbl];
        
        UIView *linview2 = [[UIView alloc] initWithFrame:CGRectMake(12, imageView.bottom + 12, self.width-24, 1)];
        linview2.backgroundColor = cLineColor;
        [backView addSubview:linview2];
        
        SMLabel *contentLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(12, linview2.bottom + 10, self.width - 24, 20) textColor:cBlackColor textFont:sysFont(14)];
        contentLbl.text = @"";
        _contentLbl = contentLbl;
        [backView addSubview:contentLbl];
        backView.height = contentLbl.bottom + 12;
        
    }
    
    return self;
}

- (void)setHistory:(ScoreHistoryModel *)model
{
    _orderNumLbl.text = [NSString stringWithFormat:@"订单号：%@",model.orderId];
    
    _timeLbl.text = [NSString stringWithFormat:@"%@小时",model.couponHour];
    
    NSString *typetext;
    if ([model.couponType isEqualToString:@"1"]) {
        typetext = @"个人券";
    }else if ([model.couponType isEqualToString:@"2"]){
        typetext = @"企业券";
    }
    _typeLbl.text = typetext;
    
    _nameLbl.text = model.couponName;
    
    _priceLbl.text = [NSString stringWithFormat:@"%@ 积分",model.amount];
    
    _contentLbl.text = [NSString stringWithFormat:@"已发放，于%@发放",[IHUtility FormatDateByString:model.useTime]];
    
}
@end

@implementation ScoreConvertCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.width = WindowWith;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 55)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(12, 10, WindowWith, 20) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text = @"";
        _lbl = lbl;
        [backView addSubview:lbl];
        
        SMLabel *timeLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(12, lbl.bottom + 2,200 , 16) textColor:cGrayLightColor textFont:sysFont(12)];
        timeLbl.text = @"";
        _timeLbl = timeLbl;
        [backView addSubview:timeLbl];
        
        SMLabel *numLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, 28.5, 14) textColor:cGreenColor textFont:sysFont(14)];
        numLbl.centerY = self.height/2.0;
        numLbl.right = self.width - 12;
        numLbl.text = @"";
        _numLbl = numLbl;
        [backView addSubview:numLbl];
        
        UIView *linview2 = [[UIView alloc] initWithFrame:CGRectMake(12, timeLbl.bottom + 6.5, self.width-24, 1)];
        linview2.backgroundColor = cLineColor;
        [backView addSubview:linview2];
        
        
    }
    
    return self;
}
- (void)setDetail:(ScoreDetailModel *)model
{
    _lbl.text = model.creditName;
    
    _timeLbl.text = model.creditTime;
    
    if ([model.creditNumber intValue]>=0) {
        _numLbl.text = [NSString stringWithFormat:@"+%@",model.creditNumber];
    }else{
        _numLbl.text = model.creditNumber;
    }
    CGSize size = [IHUtility GetSizeByText:_numLbl.text sizeOfFont:14 width:100];
    _numLbl.width = size.width;
    _numLbl.right = self.width - 12;
    
}
@end


@implementation FindCarTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith-24, 9)];
        lineView.backgroundColor=cBgColor;
        [self.contentView addSubview:lineView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 15+9, 54, 18) textColor:cBlackColor textFont:sysFont(18)];
        lbl.text=@"永安镇";
        _chufaLbl=lbl;
        [self.contentView addSubview:lbl];
        
        UIImage *img=Image(@"logistics_to.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+8, 0, img.size.width, img.size.height)];
        imageView.image=img;
        _toImageView=imageView;
        imageView.centerY=lbl.centerY;
        [self.contentView addSubview:imageView];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+8, 15+9, 54, 18) textColor:cBlackColor textFont:sysFont(18)];
        lbl.text=@"新化镇";
        _mudiLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top+4, 50, 14) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"(常德)";
        _cityLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, lbl.bottom+15, 40, 40)];
        headImageView.image=defalutHeadImage;
        [headImageView setLayerMasksCornerRadius:20 BorderWidth:0 borderColor:cGreenColor];
        _headImageView=headImageView;
        [self.contentView addSubview:headImageView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, headImageView.bottom+8, 37, 14) textColor:cBlackColor textFont:sysFont(12)];
        lbl.centerX=headImageView.centerX;
        lbl.text=@"刘乐东";
        _nameLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+20, headImageView.top, WindowWith-24-headImageView.right-20-10, 14) textColor:cGreenColor textFont:sysFont(13)];
        lbl.text=@"湘A5B862/高栏车/13米/4吨";
        _yaoqiuLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, WindowWith-24-lbl.left-13, 35) textColor:RGB(132, 131, 136) textFont:sysFont(12)];
        lbl.text=@"长期跑永安-新化一线，配货价格，专车速度！请货主们看到与我联系。";
        lbl.numberOfLines=0;
        _discLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+20, 100, 13) textColor:RGB(132, 131, 136) textFont:sysFont(12)];
        lbl.text=@"14:25";
        _timeLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        img=Image(@"logistics_telphone.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn=btn;
        btn.frame=CGRectMake(WindowWith-24-12-img.size.width, _discLbl.bottom+10, img.size.width, img.size.height);
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
       
        img=Image(@"logistics_lianxi.png");
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _lianxiBtn=btn;
        btn.frame=CGRectMake(WindowWith-24-12-img.size.width-30-img.size.width, _discLbl.bottom+10, img.size.width, img.size.height);
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(lianxi) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];

        
        
        
        
    }
    
    return self;
}

-(void)setDataWithModel:(FindCarModel *)model{
    NSString *str=model.t_province;
    if (![model.t_city isEqualToString:@""]) {
        str=model.t_city;
    }
    if (![model.t_area isEqualToString:@""]) {
        str=model.t_area;
    }
    
    CGSize size=[IHUtility GetSizeByText:str sizeOfFont:18 width:100];
    _chufaLbl.text=str;
    _chufaLbl.size=CGSizeMake(size.width, 20);
   
    _toImageView.left=_chufaLbl.right+8;
    
    
    str=model.f_province;
    if (![model.f_city isEqualToString:@""]) {
        str=model.f_city;
    }
    if (![model.f_area isEqualToString:@""]) {
        str=model.f_area;
    }

    size=[IHUtility GetSizeByText:str sizeOfFont:18 width:150];
    _mudiLbl.text=str;
    _mudiLbl.left=_toImageView.right+8;
    _mudiLbl.width=size.width;
    
    str=model.f_city;
    if (![model.f_city isEqualToString:@""]) {
        if ([model.f_area isEqualToString:@""]) {
            str=model.f_province;
        }
    }else{
        _cityLbl.hidden=YES;
    }
    

       size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"(%@)",str] sizeOfFont:13 width:150];
    _cityLbl.text=[NSString stringWithFormat:@"(%@)",str];
    _cityLbl.width=size.width;
    _cityLbl.left=_mudiLbl.right;
    
    
    
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
     size=[IHUtility GetSizeByText:model.nickname sizeOfFont:12 width:60];
    _nameLbl.text=model.nickname;
    _nameLbl.width=size.width;
    _nameLbl.centerX=_headImageView.centerX;
    
    str=[NSString stringWithFormat:@"%@/%@/%@米/%@辆",model.car_num,model.carType_name,model.car_height,model.loads];
    _yaoqiuLbl.text=str;
    
     size=[IHUtility GetSizeByText:model.remark sizeOfFont:12 width:WindowWith-24-_yaoqiuLbl.left-13];
    
    _discLbl.text=model.remark;
    _discLbl.size=CGSizeMake(size.width, size.height);
    
      NSString *time=[IHUtility compareCurrentTimeString:model.create_time];
    _timeLbl.text=time;
    
    _timeLbl.top=_discLbl.bottom+20;
    
    _lianxiBtn.top=_discLbl.bottom+10;
    
    if([model.remark isEqualToString:@""]){
        _timeLbl.top=_yaoqiuLbl.bottom+20;
        _lianxiBtn.top=_yaoqiuLbl.bottom+10;
    }
    
    
    _phoneBtn.top=_lianxiBtn.top;
    
}

-(void)lianxi{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTLianXiActionTableViewCell indexPath:self.indexPath attribute:nil];
    }

    
    
}

-(void)phone{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTPhoneActionTableViewCell indexPath:self.indexPath attribute:nil];
    }

}


@end



@implementation LogisyicsMyFaBuTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith-24, 9)];
        lineView.backgroundColor=cBgColor;
        [self.contentView addSubview:lineView];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 15+9, 54, 18) textColor:cBlackColor textFont:sysFont(18)];
        lbl.text=@"永安镇";
        _chufaLbl=lbl;
        [self.contentView addSubview:lbl];
        
        UIImage *img=Image(@"logistics_to.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+8, 0, img.size.width, img.size.height)];
        imageView.image=img;
        imageView.centerY=lbl.centerY;
        _toImageView=imageView;
        [self.contentView addSubview:imageView];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+8, 15+9, 54, 18) textColor:cBlackColor textFont:sysFont(18)];
        lbl.text=@"新化镇";
        _mudiLbl=lbl;
        [self.contentView addSubview:lbl];

        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top+4, 50, 14) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"(常德)";
        _cityLbl=lbl;
        [self.contentView addSubview:lbl];
       
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-24-12-35, lbl.top, 35, 13) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"14:25";
        _timeLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, lbl.bottom+15, 40, 40)];
        headImageView.image=defalutHeadImage;
        [headImageView setLayerMasksCornerRadius:20 BorderWidth:0 borderColor:cGreenColor];
        _headImageView=headImageView;
        [self.contentView addSubview:headImageView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, headImageView.bottom+8, 37, 14) textColor:cBlackColor textFont:sysFont(12)];
        lbl.centerX=headImageView.centerX;
        lbl.text=@"刘乐东";
        _nameLbl=lbl;
        [self.contentView addSubview:lbl];

        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+20, headImageView.top, WindowWith-24-headImageView.right-20-10, 14) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text=@"用车时间：2016-12-20";
        _carTimeLbl=lbl;
        [self.contentView addSubview:lbl];

        img=Image(@"logistics_shu.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+8, img.size.width, img.size.height)];;
        imageView.image=img;
        [self.contentView addSubview:imageView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+7, imageView.top, WindowWith-24-imageView.right-7-10, 14) textColor:cGreenColor textFont:sysFont(13)];
        lbl.text=@"樟树/7吨/高价";
        _typeLbl=lbl;
        lbl.centerY=imageView.centerY;
        [self.contentView addSubview:lbl];
        
        
        img=Image(@"logistics_xuqiu.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.left, imageView.bottom+7, img.size.width, img.size.height)];;
        imageView.image=img;
        [self.contentView addSubview:imageView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+7, imageView.top, WindowWith-24-imageView.right-7-10, 14) textColor:cGreenColor textFont:sysFont(13)];
        lbl.text=@"樟树/7吨/高价";
        _yaoqiuLbl=lbl;
        lbl.centerY=imageView.centerY;
        [self.contentView addSubview:lbl];

        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right, lbl.bottom+8, WindowWith-24-headImageView.right-20-10, 14) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"用车时间：2016-12-20";
        lbl.numberOfLines=0;
        _discLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(headImageView.left, lbl.bottom+15, WindowWith-24-headImageView.left*2, 1)];
        lineView.backgroundColor=cBgColor;
        _lineView=lineView;
        [self.contentView addSubview:lineView];
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(lineView.right-75, lineView.bottom+8, 75, 28);
        [btn setLayerMasksCornerRadius:0 BorderWidth:1 borderColor:cBgColor];
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(12);
        _deleteBtn=btn;
        [btn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        
        
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(lineView.right-75-30-75, lineView.bottom+8, 75, 28);
        [btn setLayerMasksCornerRadius:0 BorderWidth:1 borderColor:cBgColor];
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=sysFont(12);
        _editBtn=btn;
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        
        
        
        
        
    }
    
    return self;
}

-(void)setDataWith:(OwnerFaBuModel *)model{
    
    
    NSString *str=model.placeOfDepartureProvince;
    if (![model.placeOfDepartureCity isEqualToString:@""]) {
        str=model.placeOfDepartureCity;
    }
    if (![model.placeOfDepartureArea isEqualToString:@""]) {
        str=model.placeOfDepartureArea;
    }
    
    CGSize size=[IHUtility GetSizeByText:str sizeOfFont:18 width:100];
    _chufaLbl.text=str;
    _chufaLbl.size=CGSizeMake(size.width, 20);
    
    _toImageView.left=_chufaLbl.right+8;
    
    
    str=model.destinationProvince;
    if (![model.destinationCity isEqualToString:@""]) {
        str=model.destinationCity;
    }
    if (![model.destinationArea isEqualToString:@""]) {
        str=model.destinationArea;
    }
    
    size=[IHUtility GetSizeByText:str sizeOfFont:18 width:150];
    _mudiLbl.text=str;
    _mudiLbl.left=_toImageView.right+8;
    _mudiLbl.width=size.width;
    
    str=model.destinationCity;
    if (![model.destinationCity isEqualToString:@""]) {
        if ([model.destinationArea isEqualToString:@""]) {
            str=model.destinationProvince;
        }
    }else{
        _cityLbl.hidden=YES;
    }
    
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"(%@)",str] sizeOfFont:13 width:150];
    _cityLbl.text=[NSString stringWithFormat:@"(%@)",str];
    _cityLbl.width=size.width;
    _cityLbl.left=_mudiLbl.right;

    
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.userheedImageUrl,smallHeaderImage] placeholderImage:defalutHeadImage];
    size=[IHUtility GetSizeByText:model.userName sizeOfFont:12 width:60];
    _nameLbl.text=model.userName;
    _nameLbl.width=size.width;
    _nameLbl.centerX=_headImageView.centerX;

    _carTimeLbl.text=[NSString stringWithFormat:@"用车时间:  %@",model.carTime];
    
    _typeLbl.text=[NSString stringWithFormat:@"%@/%@吨/%@装车",model.goodsName,model.goodsWeight,model.carloadingMode];
    
    _yaoqiuLbl.text=[NSString stringWithFormat:@"%@/%@",model.carTypeName,model.carHeight];
    
    _lineView.top=_yaoqiuLbl.bottom+15;
    
    if (![model.remark isEqualToString:@""]) {
        size=[IHUtility GetSizeByText:model.remark sizeOfFont:12 width:WindowWith-24-_carTimeLbl.left-12];
        
        _discLbl.text=model.remark;
        _discLbl.size=CGSizeMake(size.width, size.height);
        _lineView.top=_discLbl.bottom+15;
    }else{
        _discLbl.size=CGSizeZero;
    }
    _editBtn.top=_lineView.bottom+8;
    _deleteBtn.top=_editBtn.top;
  
    NSString *time=[IHUtility compareCurrentTimeString:model.createTime];
      size=[IHUtility GetSizeByText:time sizeOfFont:12 width:100];
    _timeLbl.text=time;
    _timeLbl.frame=CGRectMake(WindowWith-24-12-size.width, _cityLbl.top, size.width, 13);
    
    
    
}

-(void)edit{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTEditActionTableViewCell indexPath:self.indexPath attribute:nil];
    }

}
-(void)delete{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTDeleteActionTableViewCell indexPath:self.indexPath attribute:nil];
    }
}


@end


@implementation DriverCheYuanTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.width = WindowWith;
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, 0, WindowWith-24, 1)];
        lineView.backgroundColor=cBgColor;
        [self.contentView addSubview:lineView];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 15, 54, 18) textColor:cBlackColor textFont:sysFont(18)];
        lbl.text=@"永安镇";
        _chufaLbl=lbl;
        [self.contentView addSubview:lbl];
        
        UIImage *img=Image(@"logistics_to.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+8, 0, img.size.width, img.size.height)];
        imageView.image=img;
        _toImageView=imageView;
        imageView.centerY=lbl.centerY;
        [self.contentView addSubview:imageView];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+8, 15, 54, 18) textColor:cBlackColor textFont:sysFont(18)];
        lbl.text=@"新化镇";
        _mudiLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top+4, 50, 14) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"(常德)";
        _cityLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-12-35, lbl.top, 35, 13) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"14:25";
        _timeLbl=lbl;
        [self.contentView addSubview:lbl];
    
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, lbl.bottom+15, WindowWith-24, 14) textColor:cGreenColor textFont:sysFont(13)];
        lbl.text=@"湘A5B862/高栏车/13米/4吨";
        _typeLbl=lbl;
        [self.contentView addSubview:lbl];

        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, lbl.bottom+10, WindowWith-24, 35) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.numberOfLines=0;
        lbl.text=@"长期跑永安-新化一线，配货价格，专车速度！请货主们看到与我联系。";
        _discLbl=lbl;
        [self.contentView addSubview:lbl];

        
        
        
        
        
        
        
    }
    
    return self;
}

-(void)setDataWith:(CheYuanModel *)model{
    NSString *str=model.t_province;
    if (![model.t_city isEqualToString:@""]) {
        str=model.t_city;
    }
    if (![model.t_area isEqualToString:@""]) {
        str=model.t_area;
    }
    
    CGSize size=[IHUtility GetSizeByText:str sizeOfFont:18 width:100];
    _chufaLbl.text=str;
    _chufaLbl.size=CGSizeMake(size.width, 20);
    
    _toImageView.left=_chufaLbl.right+8;
    
    
    str=model.f_province;
    if (![model.f_city isEqualToString:@""]) {
        str=model.f_city;
    }
    if (![model.f_area isEqualToString:@""]) {
        str=model.f_area;
    }
    
    size=[IHUtility GetSizeByText:str sizeOfFont:18 width:150];
    _mudiLbl.text=str;
    _mudiLbl.left=_toImageView.right+8;
    _mudiLbl.width=size.width;
    
    str=model.f_city;
    if (![model.f_city isEqualToString:@""]) {
        if ([model.f_area isEqualToString:@""]) {
            str=model.f_province;
        }
    }else{
        _cityLbl.hidden=YES;
    }
    
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"(%@)",str] sizeOfFont:13 width:150];
    _cityLbl.text=[NSString stringWithFormat:@"(%@)",str];
    _cityLbl.width=size.width;
    _cityLbl.left=_mudiLbl.right;

    _typeLbl.text=[NSString stringWithFormat:@"%@/%@/%@米/%@吨",model.car_num,model.carType_name,model.car_height,model.loads];
    if ([model.carType_name isEqualToString:@"不限"]||[model.carType_name isEqualToString:@""]) {
         _typeLbl.text=[NSString stringWithFormat:@"%@/不限/%@吨",model.car_num,model.loads];
    }
    
    if (![model.remark isEqualToString:@""]) {
        size=[IHUtility GetSizeByText:model.remark sizeOfFont:12 width:WindowWith-24];
        
        _discLbl.text=model.remark;
        _discLbl.size=CGSizeMake(size.width, size.height);
      
    }else{
        _discLbl.size=CGSizeZero;
    }
  
    
    NSString *time=[IHUtility compareCurrentTimeString:model.create_time];
    size=[IHUtility GetSizeByText:time sizeOfFont:12 width:100];
    _timeLbl.text=time;
    _timeLbl.frame=CGRectMake(WindowWith-24-12-size.width, _cityLbl.top, 100, 13);
    _timeLbl.textAlignment=NSTextAlignmentRight;
    
}

@end



@implementation DriverRenZhengTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.width = WindowWith;
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, 0, WindowWith-24, 1)];
        lineView.backgroundColor=cBgColor;
        [self.contentView addSubview:lineView];
        
        UIImage *img=Image(@"dirver_name.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(13, 13, img.size.width, img.size.height)];;
        imageView.image=img;
        _imageView=imageView;
        [self.contentView addSubview:imageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+9, 0, 70, 17) textColor:cBlackColor textFont:sysFont(15)];
        lbl.centerY=imageView.centerY;
        lbl.text=@"车辆类型";
        _name=lbl;
        [self.contentView addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+10, 0, WindowWith-lbl.right-10-12, 15) textColor:cBlackColor textFont:sysFont(13)];
        lbl.centerY=imageView.centerY;
        lbl.text=@"422******815";
        _lbl=lbl;
        lbl.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:lbl];
        
        
        
    }
    
    return self;
}



-(void)setDataWith:(NSDictionary *)dic{
    
    UIImage *img = Image(dic[@"image"]);
    _imageView.image = img;
    _imageView.size = CGSizeMake(img.size.width, img.size.height);
    _name.text = dic[@"text"];
    _lbl.text = dic[@"name"];
    
    
    
}

@end




