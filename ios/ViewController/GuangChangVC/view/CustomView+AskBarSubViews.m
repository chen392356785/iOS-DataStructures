//
//  CustomView+AskBarSubViews.m
//  MiaoTuProject
//
//  Created by Zmh on 31/10/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+AskBarSubViews.h"

@implementation CustomView (AskBarSubViews)

@end

@implementation ModeratorIntroducedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIAsyncImageView *heardImg = [UIAsyncImageView new];
        heardImg.image = defalutHeadImage;
        heardImg.userInteractionEnabled = YES;
        _heardImg = heardImg;
        [self addSubview:heardImg];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapHeardImg:)];
        tap1.numberOfTapsRequired = 1;
        tap1.numberOfTouchesRequired = 1;
        [heardImg addGestureRecognizer:tap1];
        
        SMLabel *nameLbl = [SMLabel new];
        nameLbl.font = sysFont(14);
        nameLbl.text = @"苏菲玛索";
        nameLbl.textColor = cBlackColor;
        _nameLbl = nameLbl;
        [self addSubview:nameLbl];
        
        //职位
        SMLabel *positionLbl = [SMLabel new];
        positionLbl.font = sysFont(12);
        positionLbl.text = @"";
        positionLbl.textColor = cGrayLightColor;
        _positionLbl = positionLbl;
        [self addSubview:positionLbl];
        
        UILabel *textView = [UILabel new];
        textView.text = @"";
        textView.textColor = cGrayLightColor;
        textView.font = sysFont(13);
        textView.numberOfLines= 0;
        _textLbl = textView;
        [self addSubview:textView];
        
        
        UIImage *image = Image(@"iconfont-fanhui.png");
        UIButton *btn = [UIButton new];
//        [btn setImage:image forState:UIControlStateNormal];
        _btn = btn;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImageView *imageV =[UIImageView new];
        imageV.image = image;
        imageV.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _upImage = imageV;
        [btn addSubview:imageV];
        //头像
        heardImg.sd_cornerRadiusFromWidthRatio = @(0.5);
        heardImg.sd_layout
        .topSpaceToView(self,14)
        .leftSpaceToView(self,19.5)
        .widthIs(52).heightIs(52);
        
        //名字
        nameLbl.sd_layout
        .topSpaceToView(self,19)
        .leftSpaceToView(heardImg,16)
        .heightIs(16);
        [nameLbl setSingleLineAutoResizeWithMaxWidth:100];
        //职位
        positionLbl.sd_layout
        .leftSpaceToView(nameLbl,8)
        .topEqualToView(nameLbl)
        .heightIs(16);
        [positionLbl setSingleLineAutoResizeWithMaxWidth:150];
        
        CGFloat width = WindowWith - 98;
        //内容
        textView.sd_layout
        .leftEqualToView(nameLbl)
        .topSpaceToView(nameLbl,8)
        .widthIs(width).autoHeightRatio(0);
        [textView setMaxNumberOfLinesToShow:2];
        
        btn.sd_layout
        .topSpaceToView(textView,10)
        .leftSpaceToView(self,0)
        .widthIs(WindowWith)
        .heightIs(25);
        
        imageV.sd_layout.centerXIs(WindowWith/2.0).centerYIs(20).widthIs(image.size.height).heightIs(image.size.width);

        [self setupAutoHeightWithBottomView:btn bottomMargin:10];
    }
    return self;
}
- (void)TapHeardImg:(UITapGestureRecognizer *)tap
{
    self.selectBtnBlock(SelectheadImageBlock);
}
- (void)btnAction:(UIButton *)button
{
    button.selected = !button.selected;
    _textLbl.text = _textContent;
    if (button.selected) {
        _upImage.transform = CGAffineTransformMakeRotation(M_PI_2);
        _textLbl.sd_layout.autoHeightRatio(0);
        [_textLbl setMaxNumberOfLinesToShow:0];
    }else {
        _upImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _textLbl.sd_layout.autoHeightRatio(0);
        [_textLbl setMaxNumberOfLinesToShow:2];
    }
    
    _btn.sd_layout.topSpaceToView(_textLbl,10);

    self.selectBtnBlock(openBlock);
}

- (void)setDataWith:(AskBarDetailModel *)model
{
    [_heardImg setImageAsyncWithURL:model.heed_image_url placeholderImage:defalutHeadImage];
    
    _nameLbl.text = model.nickname;
    [_nameLbl setSingleLineAutoResizeWithMaxWidth:100];
    
    _positionLbl.text = [NSString stringWithFormat:@"|  %@",model.user_title];
    [_positionLbl setSingleLineAutoResizeWithMaxWidth:100];
    
    _textLbl.text = model.user_desc;
    _textContent = _textLbl.text;
    _textLbl.sd_layout.autoHeightRatio(0);
    [_textLbl setMaxNumberOfLinesToShow:2];
    
}
@end

@implementation AskBarContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //提问人头像
        UIAsyncImageView *askHeardImg = [UIAsyncImageView new];
        askHeardImg.image = defalutHeadImage;
        _askHeardImg = askHeardImg;
        askHeardImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapHeardImg:)];
        tap1.numberOfTapsRequired = 1;
        tap1.numberOfTouchesRequired = 1;
        [askHeardImg addGestureRecognizer:tap1];
        
        //提问人昵称
        SMLabel *askNameLbl = [SMLabel new];
        askNameLbl.text= @"刘乐东";
        askNameLbl.font = sysFont(12);
        askNameLbl.textColor = cGreenColor;
        _askNameLbl = askNameLbl;
        
        //问题
        SMLabel *problemLbl = [SMLabel new];
        problemLbl.text= @"";
        problemLbl.font = sysFont(13);
        problemLbl.textColor = cBlackColor;
        problemLbl.numberOfLines = 0;
        _problemLbl = problemLbl;
        
        UIView *lineV = [UIView new];
        lineV.backgroundColor = cLineColor;
        
        //回复人头像
        UIAsyncImageView *replyHeardImg = [UIAsyncImageView new];
        replyHeardImg.image = defalutHeadImage;
        _replyHeardImg = replyHeardImg;
        replyHeardImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapReplyHeardImg:)];
        tap2.numberOfTapsRequired = 1;
        tap2.numberOfTouchesRequired = 1;
        [replyHeardImg addGestureRecognizer:tap2];
        //回复人昵称
        SMLabel *replyNameLbl = [SMLabel new];
        replyNameLbl.text= @"苏菲玛索";
        replyNameLbl.font = sysFont(12);
        replyNameLbl.textColor = cGrayLightColor;
        _replyNameLbl = replyNameLbl;
        
        SMLabel *Lbl = [SMLabel new];
        Lbl.text= @"回复";
        Lbl.font = sysFont(12);
        Lbl.textColor = cBlackColor;
        
        //提问人昵称
        SMLabel *NameLbl = [SMLabel new];
        NameLbl.text= @"刘乐东";
        NameLbl.font = sysFont(12);
        NameLbl.textColor = cGreenColor;
        _NameLbl = NameLbl;
        
        //回复的时间
        SMLabel *replyTimeLbl = [SMLabel new];
        replyTimeLbl.text= @"08/21";
        replyTimeLbl.font = sysFont(10);
        replyTimeLbl.textColor = cGrayLightColor;
        _replyTimeLbl = replyTimeLbl;
        
        //回复
        SMLabel *replyContentLbl = [SMLabel new];
        replyContentLbl.text= @"";
        replyContentLbl.font = sysFont(13);
        replyContentLbl.numberOfLines= 0;
        replyContentLbl.textColor = cBlackColor;
        _replyContentLbl = replyContentLbl;
        
        UIImage *image = Image(@"lineImage.png");
        UIAsyncImageView *lineImage = [UIAsyncImageView new];
        lineImage.image = Image(@"lineImage.png");
        
        //删除按钮delete1.png
        UIImage *deleteImg = Image(@"delete1");
        UIButton *deleteBtn = [UIButton new];
        [deleteBtn setImage:deleteImg forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.hidden = YES;
        _deleteBtn = deleteBtn;
        
        //点赞按钮
        UIImage *agreeImg = Image(@"agree.png");
        UIImage *agreeSelectedImg = Image(@"agree_select.png");
        UIButton *agreeBtn = [UIButton new];
        [agreeBtn setImage:agreeImg forState:UIControlStateNormal];
        [agreeBtn setImage:agreeSelectedImg forState:UIControlStateSelected];
        agreeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        agreeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        [agreeBtn setTitle:@"32" forState:UIControlStateNormal];
        [agreeBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        agreeBtn.backgroundColor = cLineColor;
        agreeBtn.titleLabel.font = sysFont(12);
        [agreeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _agreeBtn = agreeBtn;
        
        //评论按钮
        UIImage *commentImg = Image(@"comment.png");
        UIImage *commentSelectedImg = Image(@"comment_select.png");
        UIButton *commentBtn = [UIButton new];
        [commentBtn setImage:commentImg forState:UIControlStateNormal];
        [commentBtn setImage:commentSelectedImg forState:UIControlStateSelected];
        commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        [commentBtn setTitle:@"632" forState:UIControlStateNormal];
        [commentBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        commentBtn.backgroundColor = cLineColor;
        commentBtn.titleLabel.font = sysFont(12);
        _commentBtn = commentBtn;
        [commentBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //分享按钮
        UIButton *shareBtn = [UIButton new];
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [shareBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        shareBtn.backgroundColor = cLineColor;
        shareBtn.titleLabel.font = sysFont(12);
        [shareBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn = shareBtn;
        
        //添加所有视图控件
        NSArray *array = @[askHeardImg,askNameLbl,problemLbl,lineV,replyHeardImg,replyNameLbl,Lbl,NameLbl,replyTimeLbl,replyContentLbl,lineImage,agreeBtn,commentBtn,shareBtn];
        [self sd_addSubviews:array];
        
        askHeardImg.sd_cornerRadius = @17.5;
        askHeardImg.sd_layout.topSpaceToView(self,20).leftSpaceToView(self,13).widthIs(35).heightIs(35);
        
        askNameLbl.sd_layout.topSpaceToView(self,23).leftSpaceToView(askHeardImg,10).maxWidthIs(WindowWith-75);
        
        problemLbl.sd_layout.topSpaceToView(askNameLbl,5).leftEqualToView(askNameLbl).widthIs(WindowWith-75).autoHeightRatio(0);
        [problemLbl setMaxNumberOfLinesToShow:0];
        
        lineV.sd_layout.topSpaceToView(problemLbl,12.5).leftSpaceToView(self,0).widthIs(WindowWith).heightIs(1);
        
        replyHeardImg.sd_cornerRadius = @17.5;
        replyHeardImg.sd_layout.topSpaceToView(lineV,15).leftSpaceToView(self,13).widthIs(35).heightIs(35);
        
        replyNameLbl.sd_layout.topSpaceToView(lineV,18).leftSpaceToView(replyHeardImg,10).heightIs(13);
        [replyNameLbl setSingleLineAutoResizeWithMaxWidth:100];
        
        Lbl.sd_layout.leftSpaceToView(replyNameLbl,5).topEqualToView(replyNameLbl).heightIs(15);
        [Lbl setSingleLineAutoResizeWithMaxWidth:100];
        
        NameLbl.sd_layout.leftSpaceToView(Lbl,5).topEqualToView(Lbl).heightIs(13);
        [NameLbl setSingleLineAutoResizeWithMaxWidth:100];
        
        replyTimeLbl.sd_layout.rightSpaceToView(self,15).topEqualToView(NameLbl).heightIs(13);
        [replyTimeLbl setSingleLineAutoResizeWithMaxWidth:50];
        
        replyContentLbl.sd_layout.topSpaceToView(NameLbl,5).leftEqualToView(replyNameLbl).widthIs(WindowWith-75).autoHeightRatio(0);
        [replyContentLbl setMaxNumberOfLinesToShow:0];
        
        lineImage.sd_layout.topSpaceToView(replyContentLbl,15).leftSpaceToView(self,0).widthIs(WindowWith).heightIs(image.size.height);
        
        _deleteBtn.sd_layout.rightSpaceToView(self,10).centerYEqualToView(askNameLbl).widthIs(deleteImg.size.width).heightIs(deleteImg.size.height);
        
        agreeBtn.sd_layout.topSpaceToView(lineImage,6).leftSpaceToView(self,(WindowWith - 70*3)/4.0).widthIs(70).heightIs(25);
        agreeBtn.sd_cornerRadius = @10;
        
        commentBtn.sd_layout.topSpaceToView(lineImage,6).leftSpaceToView(agreeBtn,(WindowWith - 70*3)/4.0).widthIs(70).heightIs(25);
        commentBtn.sd_cornerRadius = @10;
        
        shareBtn.sd_layout.topSpaceToView(lineImage,6).leftSpaceToView(commentBtn,(WindowWith - 70*3)/4.0).widthIs(70).heightIs(25);
        shareBtn.sd_cornerRadius = @10;
        
        [self setupAutoHeightWithBottomView:agreeBtn bottomMargin:6];
        
    }
    return self;
}
- (void)btnAction:(UIButton *)button
{
    
    if (button == _agreeBtn) {
        self.selectBtnBlock(agreeBlock);
    }else if (button == _commentBtn){
        self.selectBtnBlock(commentBlock);
    }else if (button == _shareBtn){
        self.selectBtnBlock(shareBlock);
    }else if (button == _deleteBtn){
        self.selectBtnBlock(closeBlock);
    }
}
- (void)TapHeardImg:(UITapGestureRecognizer *)tap
{
    self.selectBtnBlock(SelectheadImageBlock);
}
- (void)TapReplyHeardImg:(UITapGestureRecognizer *)tap
{
    self.selectBtnBlock(SelectTopViewBlock);
}
- (void)setData:(ReplyProblemListModel *)Model
{
    [_askHeardImg setImageAsyncWithURL:Model.heed_image_url placeholderImage:defalutHeadImage];
    
    _askNameLbl.text = Model.nickname;
    [_askNameLbl setSingleLineAutoResizeWithMaxWidth:200];
    
    _problemLbl.text = Model.title;
    _problemLbl.sd_layout.autoHeightRatio(0);
    [_problemLbl setMaxNumberOfLinesToShow:0];
    
    [_replyHeardImg setImageAsyncWithURL:Model.infoModel.heed_image_url placeholderImage:defalutHeadImage];
    
    _replyNameLbl.text = Model.infoModel.nickname;
    [_replyNameLbl setSingleLineAutoResizeWithMaxWidth:100];
    
    _NameLbl.text = Model.nickname;
    [_NameLbl setSingleLineAutoResizeWithMaxWidth:100];
    
    _replyTimeLbl.text = [IHUtility compareCurrentTimeString:Model.infoModel.answer_time];
    [_replyTimeLbl setSingleLineAutoResizeWithMaxWidth:100];
    
    _replyContentLbl.text = Model.infoModel.answer_content;
    _replyContentLbl.sd_layout.autoHeightRatio(0);
    [_replyContentLbl setMaxNumberOfLinesToShow:0];
    
    [_agreeBtn setTitle:stringFormatInt(Model.infoModel.click_num) forState:UIControlStateNormal];
    if (Model.infoModel.isClick == 1) {
        _agreeBtn.selected = YES;
    }
    [_commentBtn setTitle:stringFormatInt(Model.infoModel.replayNum) forState:UIControlStateNormal];
}
@end

@implementation AskQuestionNumView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *lineV = [UIView new];
        lineV.backgroundColor = cLineColor;
        [self addSubview:lineV];
        lineV.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).widthIs(WindowWith).heightIs(1);
        
        //提问数
        SMLabel *askNumLbl = [SMLabel new];
        askNumLbl.textColor = cGrayLightColor;
        askNumLbl.font = sysFont(14);
        _askNumLbl = askNumLbl;
        [self addSubview:askNumLbl];
        askNumLbl.sd_layout.leftSpaceToView(self,17.5).topSpaceToView(lineV,10).heightIs(20);
        [askNumLbl setSingleLineAutoResizeWithMaxWidth:100];
        
        //回复数
        SMLabel *replyNumLbl = [SMLabel new];
        replyNumLbl.textColor = cGreenColor;
        replyNumLbl.font = sysFont(14);
        _replyNumLbl = replyNumLbl;
        [self addSubview:replyNumLbl];
        replyNumLbl.sd_layout.leftSpaceToView(askNumLbl,9).topEqualToView(askNumLbl).heightIs(20);
        [replyNumLbl setSingleLineAutoResizeWithMaxWidth:100];
        
        //
        UIView *btnView = [UIView new];
        btnView.layer.cornerRadius = 3;
        btnView.layer.borderColor = [UIColor redColor].CGColor;
        btnView.layer.borderWidth = 0.5;
        [self addSubview:btnView];
        btnView.sd_layout.topSpaceToView(lineV,3).rightSpaceToView(self,17.5).widthIs(95).heightIs(35);
        
        UIButton *btn1 = [UIButton new];
        [btn1 setTitleColor:cBlackColor forState:UIControlStateNormal];
        btn1.tag = 101;
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn1.titleLabel.font = sysFont(13);
        [btn1 setBackgroundImage:Image(@"left_btnImage.png") forState:UIControlStateSelected];
        [btn1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn1.selected =YES;
        [btnView addSubview:btn1];
        _btn1 = btn1;
        btn1.sd_layout.leftSpaceToView(btnView,0).topSpaceToView(btnView,0).widthIs(btnView.width/2.0).heightIs(35);
        
        UIButton *btn2 = [UIButton new];
        [btn2 setTitleColor:cBlackColor forState:UIControlStateNormal];
        btn2.tag = 102;
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn2.titleLabel.font = sysFont(13);
        [btn2 setBackgroundImage:Image(@"right_btnImage.png") forState:UIControlStateSelected];
        [btn2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn2];
        _btn2 = btn2;
        btn2.sd_layout.leftSpaceToView(btn1,0).topSpaceToView(btnView,0).widthIs(btnView.width/2.0).heightIs(35);

    }
    return self;
}
-(void)buttonAction:(UIButton *)button
{
    
}
- (void)setData:(AskBarDetailModel *)model
{
    _askNumLbl.text = [NSString stringWithFormat:@"%d人提问",model.questionNum];
    [_askNumLbl setSingleLineAutoResizeWithMaxWidth:100];
    
    _replyNumLbl.text = [NSString stringWithFormat:@"%d回复",model.answerNum];
    [_replyNumLbl setSingleLineAutoResizeWithMaxWidth:100];
    
    if (model.user_id == [USERMODEL.userID intValue]) {
        [_btn1 setTitle:@"已回答" forState:UIControlStateNormal];
    }else {
        [_btn1 setTitle:@"最新" forState:UIControlStateNormal];
    }
    
    if (model.user_id == [USERMODEL.userID intValue]) {
        [_btn2 setTitle:@"未回答" forState:UIControlStateNormal];
    }else {
        [_btn2 setTitle:@"最热" forState:UIControlStateNormal];
    }
}
@end

