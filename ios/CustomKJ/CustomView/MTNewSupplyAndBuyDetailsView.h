//
//  MTNewSupplyAndBuyDetailsView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"

@interface MTNewSupplyAndBuyDetailsView : CustomView
{
	UIAsyncImageView *_headImageView;
	UIAsyncImageView *_VipImageView;
//	UIAsyncImageView *_gongqiuTypeImgView;
	SMLabel *_nickName;
	SMLabel *_identLbl;
	SMLabel *_bqLbl;
//	CommentAndLikeView *_commentAndLikeView;
//	UIButton *_btn;
	SMLabel *_tilteLbl;
	SMLabel *_pricelbl;
	SMLabel *_ganjingLbl;
	UIView *_lineView1;
	UIView *_lineView2;
//	UIView *_lineView3;
	SMLabel *_tedianLbl;
	SMLabel *_adressLbl;
	SMLabel *_logisticsLbl;
	UIImageView *_tedianImageView;
	UIImageView *_adressImageView;
	UIImageView *_logisticsImageView;
	SMLabel *_timeLbl;
	MTSupplyAndBuyDetailsImageView *_imagesView;
}
-(CGFloat)setDataWithmodel:(MTSupplyAndBuyListModel *)model;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;

@end

