//
//  CustomScrollCell.m
//  JXScrollCell
//
//  Created by jiaxin on 15/12/14.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "CustomScrollCell.h"
 

@interface CustomScrollCell ()
@property (nonatomic, weak) UIView *containerView;
@end

@implementation CustomScrollCell
@synthesize model;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [[self class] getHeight])];
    containerView.clipsToBounds = YES;
    [self.contentView addSubview:containerView];
    self.containerView = containerView;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:containerView.bounds];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.image = DefaultImage_logo;
    [containerView addSubview:self.headerImageView];
    self.contentView.clipsToBounds = YES;
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [[self class] getHeight])];
    bgView.alpha=0.5;
    bgView.backgroundColor=[UIColor blackColor];
    [self.contentView addSubview:bgView];
 
    self.nameLabel = [[SMLabel alloc] initWithFrame:CGRectMake(20, [[self class] getHeight]/2 - 15, [UIScreen mainScreen].bounds.size.width - 40, 22)];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.font = sysFont(18);
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = @"最美的不是风景，而是陪你看风景的人(*^__^*)";
    [self.contentView addSubview:self.nameLabel];
    
    self.detailLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, self.nameLabel.bottom+5, WindowWith, 15) textColor:[UIColor whiteColor] textFont:sysFont(11)];
    self.detailLabel.numberOfLines=1;
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.detailLabel];
}

-(void)setData{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.content_url] placeholderImage:DefaultImage_logo];
   
    self.nameLabel.text=model.theme_header;
    self.detailLabel.text=model.theme_content;
    
}

+ (CGFloat)getHeight
{
    return WindowWith/8*3 ;
}
@end
