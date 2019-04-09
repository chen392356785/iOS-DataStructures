//
//  TopicListView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotosGroupView.h"
@interface TopicListView : UIView
{
    SDPhotosGroupView *_imagesView;
    SMLabel *_contentlbl;
    SMLabel *_timelbl;
    SMLabel *_addresslbl;
    UIImageView *_addressImge;
    UIImageView *_timeImageView;
}
 
-(void)setData:(MTTopicListModel *)model;
 
@end
