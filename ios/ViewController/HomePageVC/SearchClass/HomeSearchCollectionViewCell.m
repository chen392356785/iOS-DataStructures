//
//  HomeSearchCollectionViewCell.m
//  MiaoTuProject
//
//  Created by tinghua on 2018/9/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "CustomView+CustomCategory2.h"
#import "HomeSearchCollectionViewCell.h"

@implementation HomeSearchCollectionViewCell

@end
#pragma mark -

#pragma mark - 园林云搜索
//122+15+14+11+32+55
@implementation YuanLinSearchViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        EPImageView *epImageView=[[EPImageView alloc]initWithFrame:CGRectMake(6, kWidth(5), WindowWith - 12, kWidth(122))];
        _epImageView=epImageView;
        epImageView.cornerRedius = 4;
        [self.contentView addSubview:epImageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(epImageView.left+5, epImageView.bottom+kWidth(10), WindowWith-24, kWidth(14)) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"玉兰";
        _titleLbl=lbl;
        _titleLbl.textColor = kColor(@"#2b8a38");
        [self.contentView addSubview:lbl];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, maxY(_titleLbl) + kWidth(10), iPhoneWidth - 24, 1)];
        lineLabel.backgroundColor = cLineColor;
        [self.contentView addSubview:lineLabel];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(minX(lineLabel), maxY(lineLabel), width(lineLabel)/2, kWidth(28)) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"联系人：姜小文";
        _personLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(maxX(_personLbl), minY(_personLbl), width(_personLbl), height(_personLbl)) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"电话：13888888888";
        _telphoneLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(minX(_personLbl), maxY(_personLbl), width(lineLabel), kWidth(55)) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"地址：湖南省长沙市岳麓区玉兰路988号";
        _adressLbl=lbl;
        [self.contentView addSubview:lbl];
    }
    
    
    return self;
}
- (void) setHomeSearchCellModel:(HomSearchModel *)Model{
    NSArray *arr=[network getJsonForString:Model.imageUrl];
    [_epImageView setDataWith:arr];
    _titleLbl.text=Model.title;
    
    _personLbl.text=[NSString stringWithFormat:@"联系人：%@",Model.nickname];
    _telphoneLbl.text=[NSString stringWithFormat:@"电话：%@",Model.mobile];
    _adressLbl.text=[NSString stringWithFormat:@"地址：%@",Model.address];

}


@end
#pragma mark -


#pragma mark - 企业云搜索
@implementation QiYeSearchViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        NSInteger tag = 0;
        for (int i=0; i<2; i++) {
             UIControl *v=[[UIControl alloc]initWithFrame:CGRectMake(kWidth(24) + ((iPhoneWidth- kWidth(24))/2)*i, 0, (iPhoneWidth- kWidth(24))/2, kWidth(175))];
             v.tag=300+tag;
             UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, kWidth(10),  width(v)-kWidth(24), kWidth(108))];
             imgView.tag=310+i;
             [imgView setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:[UIColor clearColor]];
             [v addSubview:imgView];

            
             SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imgView.left, imgView.bottom + kWidth(8), imgView.width, kWidth(35)) textColor:RGB(44, 44, 49) textFont:sysFont(12.5)];
             lbl.textAlignment = NSTextAlignmentCenter;
             lbl.text=@"杭州绿化园林公司";
             lbl.numberOfLines = 2;
             lbl.tag=320+tag;
             [v addSubview:lbl];
             [self.contentView addSubview:v];
             tag ++;
        }
    }
    return self;
}
//- (void) setHomeSearchCellModel:(HomSearchModel *)Model{
//    
//}
-(void)setItemArray:(NSMutableArray *)ItemArray{
    [ItemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIControl *v=[self viewWithTag:300+idx];
        v.hidden=NO;
        UIAsyncImageView *imgView=[v viewWithTag:310+idx];
        NSArray *arr=[network getJsonForString:obj[@"img"]];
        if (arr > 0) {
            NSDictionary *imgDic  = arr[0];
            [imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,imgDic[@"t_url"]] placeholderImage:DefaultImage_logo];
        }else {
            imgView.image = DefaultImage_logo;
        }
        SMLabel *lbl=[v viewWithTag:320+idx];
        lbl.numberOfLines = 2;
        lbl.text = obj[@"title"];
        
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
        [self.delegate BCtableViewCell:self action:MYActionHomePageZhanlueQiyeTableViewAction indexPath:self.indexPath attribute:tap.objectValue];
    }
}
@end
#pragma mark -


#pragma mark - 人脉云搜索
@implementation RenMaiSearchViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        iconView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(4), kWidth(49), kWidth(49))];
        [self.contentView addSubview:iconView];
        iconView.layer.cornerRadius = width(iconView)/2;
        nameLabel = [[SMLabel alloc] initWithFrameWith:CGRectMake(maxX(iconView)+kWidth(15), minY(iconView) + kWidth(5), kWidth(200), kWidth(16)) textColor:kColor(@"#282828") textFont:sysFont(font(16))];
        nameLabel.text = @"张~~";
        [self.contentView addSubview:nameLabel];
        
        conLabel = [[SMLabel alloc] initWithFrameWith:CGRectMake(minX(nameLabel), maxY(nameLabel)+ kWidth(8), iPhoneWidth - minX(nameLabel) - kWidth(30), height(iconView) - maxY(nameLabel) - kWidth(8)) textColor:kColor(@"#7d7d7d") textFont:sysFont(font(14))];
        conLabel.text = @"上海九鼎园林景观有限公司";
        [self.contentView addSubview:conLabel];
    
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(conLabel), kWidth(56), iPhoneWidth - minX(conLabel), 1)];
        lineLabel.backgroundColor = cLineColor;
        [self.contentView addSubview:lineLabel];
        
    }
    return self;
}
- (void) setHomeSearchCellModel:(HomSearchModel *)Model{
    NSString *ImgUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,Model.hImage];
    [iconView setImageAsyncWithURL:ImgUrlStr placeholderImage:DefaultImage_logo];
    nameLabel.text = Model.nickname;
    conLabel.text = Model.title;
}
@end
