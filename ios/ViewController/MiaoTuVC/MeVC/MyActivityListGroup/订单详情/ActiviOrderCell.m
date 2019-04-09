//
//  ActiviOrderCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/10.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ActiviOrderCell.h"

@implementation ActiviOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

@end




@interface ActivityInfoCell () {
    UILabel *nameLabel;
    UILabel *line;
}
    
@end

@implementation ActivityInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        
        line = [[UILabel alloc] init];
        [self addSubview:line];
        
        [self layoutSubViewUI];
    }
    return self;
}
- (void) layoutSubViewUI {
    nameLabel.textColor = kColor(@"#333333");
    nameLabel.font = sysFont(font(16));
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kWidth(5));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(30));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-1);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_offset(1);
    }];
    line.backgroundColor = cLineColor;
    
}
- (void) setActivitiesListModel:(NSString *)str {
    nameLabel.textColor = kColor(@"#333333");
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(0, 1)];
    nameLabel.attributedText = attributedStr;
}
@end







@interface OrderDetailCell () {
    UILabel *_titlelabel;
    UIImageView *_imageView;
    UILabel *picLabel;
    UILabel *totalLabel;
    UILabel *OrderPicLabel;
}

@end

@implementation OrderDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        _titlelabel = [[UILabel alloc] init];
        [self addSubview:_titlelabel];
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        picLabel = [[UILabel alloc] init];
        [self addSubview:picLabel];
        totalLabel = [[UILabel alloc] init];
        [self addSubview:totalLabel];
        OrderPicLabel = [[UILabel alloc]init];
        [self addSubview:OrderPicLabel];
        [self LaysubViewsUI];
    }
    return self;
}
- (void) LaysubViewsUI {
    UILabel *xqlable = [[UILabel alloc] init];
    xqlable.text = @"详情";
    xqlable.font = sysFont(font(16));
    [self.contentView addSubview:xqlable];
    [xqlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(kWidth(200));
        make.height.mas_offset(kWidth(30));
    }];
//*/
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = cLineColor;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(xqlable.mas_bottom);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_offset(1);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).mas_offset(kWidth(7));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.height.mas_offset(kWidth(80));
        make.width.mas_offset(kWidth(80));
    }];
    
    _titlelabel.font = sysFont(font(16));
    _titlelabel.textColor = kColor(@"#333333");
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->_imageView.mas_top).mas_offset(kWidth(6));
		make.left.mas_equalTo(self->_imageView.mas_right).mas_offset(kWidth(13));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(16));
    }];
    
    picLabel.font = sysFont(font(16));
    picLabel.textColor = kColor(@"#ff0000");
    [picLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->_titlelabel.mas_bottom).mas_offset(kWidth(37));
		make.left.mas_equalTo(self->_titlelabel.mas_left);
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.height.mas_offset(kWidth(16));
    }];
    
    UILabel *Line2 = [[UILabel alloc] init];
    [self addSubview:Line2];
    Line2.backgroundColor = cLineColor;
    [Line2 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->_imageView.mas_bottom).mas_offset(kWidth(6));
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_offset(kWidth(1));
    }];
   
    UILabel *showtatoLabel = [[UILabel alloc] init];;
    [self addSubview:showtatoLabel];
    showtatoLabel.text = @"商品总价";
    showtatoLabel.font = sysFont(font(14));
    [showtatoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Line2.mas_bottom).mas_offset(kWidth(11));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(kWidth(120));
        make.height.mas_offset(kWidth(30));
    }];
    
    totalLabel.font = sysFont(font(14));
    totalLabel.textAlignment = NSTextAlignmentRight;
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(showtatoLabel.mas_top);
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.width.mas_offset(kWidth(120));
        make.height.mas_offset(kWidth(30));
    }];
    
//    UILabel *showOrderPLabel = [[UILabel alloc] init];;
//    [self addSubview:showOrderPLabel];
//    showOrderPLabel.text = @"订单总价";
//    showOrderPLabel.font = sysFont(font(14));
//    [showOrderPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(showtatoLabel.mas_bottom);
//        make.left.mas_equalTo(self).mas_offset(kWidth(12));
//        make.width.mas_offset(kWidth(120));
//        make.height.mas_offset(kWidth(30));
//    }];
    
//    OrderPicLabel.font = sysFont(font(14));
//    OrderPicLabel.textAlignment = NSTextAlignmentRight;
//    [OrderPicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(showOrderPLabel.mas_top);
//        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
//        make.width.mas_offset(kWidth(150));
//        make.height.mas_offset(kWidth(30));
//    }];
//*/
}
- (void)setActivitiesListModel:(ActivitiesListModel *)model {
   [_imageView sd_setImageWithURL:[NSURL URLWithString:model.activities_pic] placeholderImage: Image(@"xiaotu.png")];
    _titlelabel.text = model.activities_titile;
    picLabel.text =  [NSString stringWithFormat:@"￥ %.2f",[model.payment_amount floatValue]/100.0];
    totalLabel.text =  [NSString stringWithFormat:@"￥ %.2f",[model.payment_amount floatValue]/100.0];
    OrderPicLabel.text =  [NSString stringWithFormat:@"￥ %.2f",[model.payment_amount floatValue]/100.0];
}
@end




@interface OrderInfCell () {
    UILabel *OrderNOLabel;
    UILabel *creatTimeLabel;
    UILabel *playTimelabel;
}
@end

@implementation OrderInfCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        OrderNOLabel = [[UILabel alloc] init];
        [self addSubview:OrderNOLabel];
        
        creatTimeLabel = [[UILabel alloc] init];
        [self addSubview:creatTimeLabel];
        
        playTimelabel = [[UILabel alloc] init];
        [self addSubview:playTimelabel];
        [self layoutSubViewUI];
    }
    return self;
}
- (void) layoutSubViewUI {
    OrderNOLabel.textColor = kColor(@"#666666");
    OrderNOLabel.font = sysFont(font(15));
    [OrderNOLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kWidth(10));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(iPhoneWidth - kWidth(70));
        make.height.mas_offset (kWidth(15));
    }];
    
    creatTimeLabel.textColor = kColor(@"#666666");
    creatTimeLabel.font = sysFont(font(15));
    [creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->OrderNOLabel.mas_bottom).mas_offset(kWidth(10));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
		make.width.mas_equalTo(self->OrderNOLabel);
        make.height.mas_offset (kWidth(16));
    }];
    
    UIButton *copyBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:copyBut];
    copyBut.layer.cornerRadius = 10;
    [copyBut setTitleColor:kColor(@"#999999") forState:UIControlStateNormal];
    copyBut.layer.borderWidth = 1.f;
    copyBut.layer.borderColor = kColor(@"#999999").CGColor;
    [copyBut setTitle:@"复制" forState:UIControlStateNormal];
    [copyBut addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    [copyBut mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->OrderNOLabel.mas_top).mas_offset(kWidth(2));
        make.right.mas_equalTo(self).mas_offset(kWidth(-12));
        make.width.mas_offset(kWidth(53));
        make.height.mas_offset (kWidth(24));
    }];
    
    playTimelabel.textColor = kColor(@"#666666");
    playTimelabel.font = sysFont(font(15));
    [playTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self->creatTimeLabel.mas_bottom).mas_offset(kWidth(10));
        make.left.mas_equalTo(self).mas_offset(kWidth(12));
        make.width.mas_offset(iPhoneWidth - 67);
        make.height.mas_offset (kWidth(16));
    }];
}
- (void)setActivitiesListModel:(ActivitiesListModel *)model {
    playTimelabel.hidden = YES;
    OrderNOLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.order_no];
    creatTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",model.uploadtime];
    if ([model.order_status integerValue] == 1) {
        playTimelabel.hidden = NO;
       playTimelabel.text = [NSString stringWithFormat:@"支付时间：%@",model.update_time];
    }else {
        playTimelabel.hidden = YES;
    }
}
- (void) copyAction {
    self.copyBlock();
}
@end
