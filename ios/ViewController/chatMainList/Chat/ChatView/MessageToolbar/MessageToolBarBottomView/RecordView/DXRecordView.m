/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "DXRecordView.h"
#import "EMCDDeviceManager.h"
@interface DXRecordView ()
{
    NSTimer *_timer;
    // 显示动画的ImageView
    UIImageView *_recordAnimationView;
    // 提示文字
    UILabel *_textLabel;
    BOOL isDragOutside;
}

@end

@implementation DXRecordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor grayColor];
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        bgView.alpha = 0.6;
        [self addSubview:bgView];
        
        UIImage *img=[UIImage imageNamed:@"VoiceSearchFeedback001.png"];
        _recordAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 -img.size.width/2, self.bounds.size.height/2 - img.size.height/2-12, img.size
                                                                             .width,  img.size
                                                                             .height)];
        
        
        
        _recordAnimationView.image = img;
        [self addSubview:_recordAnimationView];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,
                                                               self.bounds.size.height - 30,
                                                               self.bounds.size.width - 10,
                                                               25)];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.text = NSLocalizedString(@"message.toolBar.record.upCancel", @"Fingers up slide, cancel sending");
        [self addSubview:_textLabel];
        _textLabel.font = sysFont(11);
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.layer.cornerRadius = 5;
        _textLabel.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
        _textLabel.layer.masksToBounds = YES;
    }
    return self;
}

// 录音按钮按下
-(void)recordButtonTouchDown
{
    isDragOutside=NO;
    // 需要根据声音大小切换recordView动画
    _textLabel.text = NSLocalizedString(@"message.toolBar.record.upCancel", @"Fingers up slide, cancel sending");
    _textLabel.backgroundColor =[UIColor colorWithRed:189/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                              target:self
                                            selector:@selector(setVoiceImage)
                                            userInfo:nil
                                             repeats:YES];
    
}
// 手指在录音按钮内部时离开
-(void)recordButtonTouchUpInside
{
    [_timer invalidate];
}
// 手指在录音按钮外部时离开
-(void)recordButtonTouchUpOutside
{
    [_timer invalidate];
}
// 手指移动到录音按钮内部
-(void)recordButtonDragInside
{
    isDragOutside=NO;
    _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedback001.png"];
    _textLabel.text = NSLocalizedString(@"message.toolBar.record.upCancel", @"Fingers up slide, cancel sending");
    _textLabel.backgroundColor = [UIColor colorWithRed:189/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
}

// 手指移动到录音按钮外部
-(void)recordButtonDragOutside
{
    
    isDragOutside=YES;
    _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedbackCanal.png"];
    
    _textLabel.text = NSLocalizedString(@"message.toolBar.record.loosenCancel", @"loosen the fingers, to cancel sending");
    _textLabel.backgroundColor = [UIColor colorWithRed:189/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
}

-(void)setVoiceImage {
    if (isDragOutside==YES) {
        _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedbackCanal.png"];
        return;
    }
    
    _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedback001"];
    double voiceSound = 0;
    float soundF=0.125;
    
    
    
    voiceSound = [[EMCDDeviceManager sharedInstance] emPeekRecorderVoiceMeter];
    if (0 < voiceSound <= soundF) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback001"]];
    }else if (soundF<voiceSound<=soundF*2) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback002"]];
    }else if (soundF*2<voiceSound<=soundF*3) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback003"]];
    }else if (soundF*3<voiceSound<=soundF*4) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback004"]];
    }else if (soundF*4<voiceSound<=soundF*5) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback005"]];
    }else if (soundF*5<voiceSound<=soundF*6) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback006"]];
    }else if (soundF*6<voiceSound<=soundF*7) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback007"]];
    }else {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback008"]];
    }
}

@end
