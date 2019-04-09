//
//  CustomView+AskBarSubViews.h
//  MiaoTuProject
//
//  Created by Zmh on 31/10/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"

@interface CustomView (AskBarSubViews)

@end

//版主介绍
@interface ModeratorIntroducedView : CustomView
{
    UIAsyncImageView *_heardImg;
    SMLabel *_nameLbl;
    SMLabel *_positionLbl;
    UILabel *_textLbl;//版主介绍详情
    UIButton *_btn;//下放按钮
    UIImageView *_upImage;
    NSString *_textContent;//版主介绍内容
}
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
- (void)setDataWith:(AskBarDetailModel *)model;
@end


@interface AskBarContentView : CustomView
{
    UIAsyncImageView *_askHeardImg;
    SMLabel *_askNameLbl;
    SMLabel *_problemLbl;
    UIAsyncImageView *_replyHeardImg;
    SMLabel *_replyNameLbl;
    SMLabel *_NameLbl;
    SMLabel *_replyTimeLbl;
    SMLabel *_replyContentLbl;
    UIButton *_agreeBtn;
    UIButton *_shareBtn;
    
}
@property (nonatomic,strong)UIButton *commentBtn;
@property (nonatomic,strong)UIButton *deleteBtn;

@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
- (void)setData:(ReplyProblemListModel *)Model;
@end

@interface AskQuestionNumView : CustomView
{

}
@property (nonatomic,strong)UIButton *btn1;
@property (nonatomic,strong)UIButton *btn2;
@property (nonatomic,strong)SMLabel *askNumLbl;
@property (nonatomic,strong)SMLabel *replyNumLbl;;
- (void)setData:(AskBarDetailModel *)model;
@end










