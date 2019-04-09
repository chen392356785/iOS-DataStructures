//
//  TFShowEmptyView.m
//  TH
//
//  Created by 苏浩楠 on 16/5/20.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import "TFShowEmptyView.h"

@interface TFShowEmptyView ()

/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *remindImgView;
/**提示文字*/
@property (weak, nonatomic) IBOutlet UILabel *remindLab;
/*去逛逛按钮**/
@property (weak, nonatomic) IBOutlet UIButton *goToBtn;

@end

@implementation TFShowEmptyView

+ (instancetype)showEmptyView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {}
    return self;
}

#pragma mark --设置数据--
- (void)setEmptyStyle:(TFShowEmptyStyle)emptyStyle {
    _emptyStyle = emptyStyle;
    
    switch (emptyStyle) {
        case TFShowEmptyStyleOrder:
        {
            self.remindImgView.image = kImage(@"icon_noOrder");
            self.remindLab.text = @"您还没有相关订单\n要不要再去逛逛";
            self.goToBtn.hidden = NO;
            [self.goToBtn setTitle:@"起驾" forState:UIControlStateNormal];
        }
            break;
        case TFShowEmptyStyleCollection:
        {
            self.remindImgView.image = kImage(@"icon_noCollection");
            self.remindLab.text = @"收藏夹肚子空空";
            self.goToBtn.hidden = NO;
            [self.goToBtn setTitle:@"起驾" forState:UIControlStateNormal];
        }
            break;
        case TFShowEmptyStyleCoupon:
        {
            self.remindImgView.image = kImage(@"icon_noCoupons");
            self.remindLab.text = @"您还没有优惠券";
            self.goToBtn.hidden = YES;
        }
            break;
        case TFShowEmptyStyleMyFlowerTalk:
        {
            self.remindImgView.image = kImage(@"icon_noFlowerTalk");
            self.remindLab.text = @"您还未发表任何花说";
            self.goToBtn.hidden = NO;
            [self.goToBtn setTitle:@"起驾" forState:UIControlStateNormal];
        }
            break;

        case TFShowEmptyStyleActivityOrder:
        {
            self.remindImgView.image = kImage(@"icon_noOrder");
            self.remindLab.text = @"您还未参与任何活动";
            self.goToBtn.hidden = YES;
        }
            break;
        case TFShowEmptyStyleFlowerCarRecord:
        {
            self.remindImgView.image = kImage(@"icon_noRecords");
            self.remindLab.text = @"您的余额还没有任何明细哦~";
            self.goToBtn.hidden = YES;
        }
            break;
        case TFShowEmptyStyleFocus:
        {
            self.remindImgView.image = kImage(@"icon_concernEmptyMe");
            self.remindLab.text = @"您还没有关注其他花友呢";
            self.goToBtn.hidden = YES;
            [self.goToBtn setTitle:@"起驾" forState:UIControlStateNormal];
        }
            break;
        case TFShowEmptyStyleLife:
        {
            self.remindImgView.image = kImage(@"icon_concernEmptyLife");
            self.remindLab.text = @"当前城市暂无听花LIFE,敬请期待!";
            self.goToBtn.hidden = YES;
        }
            break;
        case TFShowEmptyStyleLifeActivity:
        {
            self.remindImgView.image = kImage(@"icon_concernEmptyLife");
            self.remindLab.text = @"当前城市暂无活动，敬请期待！";
            self.goToBtn.hidden = YES;
        }
            break;
            
        case TFShowEmptyStyleFansRevenue:
        {
            self.remindImgView.image = kImage(@"icon_noRecords");
            self.remindLab.text = @"您的粉丝还没有任何贡献哦";
            self.goToBtn.hidden = YES;
        }
            break;
        case TFShowEmptyStyleFans:
        {
        
            self.remindImgView.image = kImage(@"icon_noRecords");
            self.remindLab.text = @"您还没有粉丝哦";
            self.goToBtn.hidden = YES;

        }
            break;
        case TFShowEmptyStyleWithdrawHistory:
        {
            self.remindImgView.image = kImage(@"icon_withdrawMoney");
            self.remindLab.text = @"您的提现还没有任何明细哦";
            self.goToBtn.hidden = YES;
        }
            break;
        case TFShowEmptyStyleFaileData:
        {
            self.remindImgView.image = kImage(@"icon_noWifi");
            self.remindLab.text = @"网络请求失败\n请检查您的网络重新加载吧";
            self.goToBtn.hidden = NO;
            [self.goToBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        }
            break;
        case TFShowEmptyStyleNetTimeOut:
        {
        
            self.remindImgView.image = kImage(@"icon_noWifi");
            self.remindLab.text = @"您的网络不给力\n请点击重新加载吧";
            self.goToBtn.hidden = NO;
            [self.goToBtn setTitle:@"重新加载" forState:UIControlStateNormal];

        }
            break;
        default:
            break;
    }
}
#pragma mark --按钮点击处理--
- (IBAction)goToButtonClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(showEmptyViewFinished)]) {
        
        [self.delegate showEmptyViewFinished];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.remindLab.font = kLightFont(14);
    self.remindLab.textColor = THBaseColor;
    
    self.goToBtn.hidden = YES;
    self.goToBtn.layer.borderColor = THBaseColor.CGColor;
    self.goToBtn.layer.borderWidth = 1.0;
    self.goToBtn.layer.cornerRadius = 3;
    self.goToBtn.layer.masksToBounds = YES;
    [self.goToBtn setTitleColor:THBaseColor forState:UIControlStateNormal];
    [self.goToBtn setTitleColor:THBaseColor forState:UIControlStateHighlighted];
    [self.goToBtn.titleLabel setFont:kLightFont(14)];

}

@end
