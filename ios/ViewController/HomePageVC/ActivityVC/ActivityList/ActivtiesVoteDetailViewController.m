//
//  ActivtiesVoteDetailViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 22/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivtiesVoteDetailViewController.h"
#import "YLWebViewController.h"

@interface ImagetableViewCell : UITableViewCell {
    UIImageView *_imageView;
}
- (void) setimageUrl:(NSString *)urlStr;
@end

@implementation ImagetableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return self;
}
- (void)layoutSubviews {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.mas_equalTo(self);
    }];
}
- (void)setimageUrl:(NSString *)urlStr {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:DefaultImage_logo];
}
@end


@interface ActivtiesVoteDetailViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextView * _contentLabel;
    UITableView *_tableView;
}

@end

static NSString *imageTableviewCellId = @"ImagetableViewCellID";
@implementation ActivtiesVoteDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [rightbutton setImage:[UIImage imageNamed:@"shareGreen.png"] forState:UIControlStateNormal];
    rightbutton.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"活动详情"];
    if (self.model.imgList2.count > 0) {
        [self createTableView];
        return;
    }
    UITextView * contentLbl = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight-KtopHeitht)];
    contentLbl.font = [UIFont systemFontOfSize:14];
    contentLbl.scrollEnabled=YES;
    contentLbl.delegate=self;
    _contentLabel = contentLbl;
    contentLbl.dataDetectorTypes = UIDataDetectorTypeLink;
    if(_IOS7){
        contentLbl.selectable = YES;//用法：决定UITextView 中文本是否可以相应用户的触摸，主要指：1、文本中URL是否可以被点击；2、UIMenuItem是否可以响应
    }
    //   contentLbl.delegate=self;
    contentLbl.backgroundColor=[UIColor clearColor];
    [contentLbl setEditable:NO];
    contentLbl.textColor=cBlackColor;
    [self setcontentText:self.content];
    
    [self.view addSubview:contentLbl];

}
- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight-KtopHeitht) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.imgList2.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.model.imgList2.count-1) {
        return  iPhoneWidth/[self.model.picwidth floatValue]*[self.model.pichigth floatValue];
    }
    return  iPhoneWidth/[self.model.picwidth floatValue]*220;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImagetableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageTableviewCellId];;
    if (!cell) {
        cell = [[ImagetableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:imageTableviewCellId];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    imageListModel *model = self.model.imgList2[indexPath.row];
    [cell setimageUrl:model.key];
    return cell;
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSString *urlstr = [URL absoluteString];
    
    // 响应以下前缀或域名的网址链接
    if ( [urlstr hasPrefix:@"http://"] || [urlstr hasPrefix:@"https://"] || [urlstr hasPrefix:@"www."]|| [urlstr hasPrefix:@".com"]|| [urlstr hasPrefix:@".cn"]) {
        
        //        self.selectUrlBlock(urlstr);
        [self webViewUrl:[NSURL URLWithString:urlstr]];
        
        return NO;
    };
    return YES; // let the system open this URL
}

-(void)setcontentText:(NSString *)text
{
    
   
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
//    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    
    
    NSString *HurlStr = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>%@",iPhoneWidth-10,text];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[HurlStr dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:nil];
    [attrString addAttribute:NSFontAttributeName value:sysFont(font(14)) range:NSMakeRange(0,attrString.length)];
    
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:6];//调整行间距
//    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
    
    _contentLabel.attributedText = attrString;
    _contentLabel.textColor =  cBlackColor;
    
}
-(void)webViewUrl:(NSURL *)url{
    YLWebViewController *controller=[[YLWebViewController alloc]init];
    controller.type=1;
    controller.mUrl=url;
    [self pushViewController:controller];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)home:(id)sender
{
    NSString *urlStr = [NSString stringWithFormat:@"%@vote/detail.html?vote_id=%d",shareURL,[self.model.activities_id intValue]];
    
    [self ShareUrl:self withTittle:@"火爆行业的投票活动！拿出你的选票想我开炮！" content:self.model.activities_titile withUrl:urlStr imgUrl:self.model.activities_pic];
}

@end
