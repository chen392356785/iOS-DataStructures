//
//  ActvRegInfoView.m
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActvRegInfoView.h"

@implementation ActvRegInfoView

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
        self.backgroundColor = [UIColor whiteColor];
        
        UIImage *img = Image(@"iconfont-wo.png");
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, img.size.width, img.size.height)];
        imageview.image = img;
        [self addSubview:imageview];
        
        SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageview.right + 5, imageview.top, 56, 20) textColor:cBlackColor textFont:sysFont(14)];
        label.text = @"联系信息";
        [self addSubview:label];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, label.bottom + 5, self.width - 30, 0.5)];
        lineView.backgroundColor = RGB(239, 239, 239);
        [self addSubview:lineView];
        
        label = [[SMLabel alloc] initWithFrameWith:CGRectMake(15,lineView.bottom + 13.5,55, 22) textColor:cBlackColor textFont:sysFont(16)];
        label.text = @"报名人:";
        [self addSubview:label];
        
        SMLabel *nameLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(label.right + 5, label.top,150, 22) textColor:cBlackColor textFont:sysFont(16)];
        _nameLabel = nameLbl;
        [self addSubview:nameLbl];
        
        SMLabel *phoneLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, label.top,103, 22) textColor:cBlackColor textFont:sysFont(16)];
        phoneLbl.right = self.width - 10;
        _phoneLbl = phoneLbl;
        [self addSubview:phoneLbl];
        
        SMLabel *companyLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(label.left, label.bottom + 11,180, 22) textColor:cBlackColor textFont:sysFont(16)];
        _companyLbl = companyLbl;
        [self addSubview:companyLbl];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(companyLbl.right + 8, companyLbl.top, 0.5, 22)];
        lineView2.backgroundColor = RGB(109, 124, 139);
        _lineView = lineView2;
        [self addSubview:lineView2];
        
        
        SMLabel *jobLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(lineView2.right + 8, companyLbl.top,100, 22) textColor:cBlackColor textFont:sysFont(16)];
        _jobLbl = jobLbl;
        [self addSubview:jobLbl];
        

        
    }
    return self;
}

- (void)setdata:(NSString *)people phone:(NSString *)phone company:(NSString *)company jobStr:(NSString *)jobStr
{
    if ([people isEqualToString:@""]||people == nil) {
        _nameLabel.text = USERMODEL.nickName;
    }else {
        _nameLabel.text = people;
    }
    
    if ([phone isEqualToString:@""]||phone == nil) {
        _phoneLbl.text = USERMODEL.userName;
    }else {
        _phoneLbl.text = phone;
    }
    
    _companyLbl.text = company;
    [_companyLbl sizeToFit];
    _companyLbl.height = 22;
    
    _lineView.left = _companyLbl.right + 8;
    _jobLbl.left = _lineView.right + 8;
    _jobLbl.width = self.width - _lineView.right - 18;
    _jobLbl.text = jobStr;
    
    
    
}

@end
