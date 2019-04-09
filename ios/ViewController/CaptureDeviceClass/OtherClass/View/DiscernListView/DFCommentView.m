//
//  DFCommentView.m
//  DF
//
//  Created by Tata on 2017/12/1.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFCommentView.h"
#import "DFCommentModel.h"

@interface DFCommentView ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation DFCommentView

- (void)addSubviews {
    [self creatViews];
    
    [self addSubview:self.contentLabel];
    
}

- (void)defineLayout {
    
    
    
}

- (void)creatViews {
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.cas_styleClass = @"commentView_contentLabel";
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
}

- (void)setCommentModel:(DFCommentModel *)commentModel {
    if (!commentModel) {
        return;
    }
    _commentModel = commentModel;
    
    NSString *userName = commentModel.NickName;
    NSString *userContent = commentModel.Content;
    
    NSString *contentString = [NSString stringWithFormat:@"%@：%@",userName,userContent];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(self.contentLabel.cas_marginLeft);
        make.right.equalTo(self.mas_right).with.offset(self.contentLabel.cas_marginRight);
        make.height.equalTo(@([self heightWithString:contentString]));
    }];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentString];
    NSInteger nickNameLength = userName.length + 1;
    NSInteger commentSting = userContent.length;
    NSRange range1 = NSMakeRange(0, nickNameLength);
    NSRange range2 = NSMakeRange(nickNameLength, commentSting);
    NSDictionary *rangeDic1 = [NSDictionary dictionaryWithObjectsAndKeys:THBaseColor,NSForegroundColorAttributeName, nil];
    [attributedString addAttributes:rangeDic1 range:range1];
    NSDictionary *rangeDic2 = [NSDictionary dictionaryWithObjectsAndKeys:THTitleColor5,NSForegroundColorAttributeName, nil];
    [attributedString addAttributes:rangeDic2 range:range2];

    [self.contentLabel setAttributedText:attributedString];
}


- (CGFloat)heightWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:11 * TTUIScale()];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat height = [string boundingRectWithSize:CGSizeMake((iPhoneWidth - 20 * TTUIScale() - 5)/2 - 10 * TTUIScale(), 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return height + 3;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
