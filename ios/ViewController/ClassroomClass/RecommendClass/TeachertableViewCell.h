//
//  TeachertableViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/16.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassroomModel.h"

@interface TeachertableViewCell : UITableViewCell {
    UIView *_bgView;
    UIImageView *_headImage;
    UILabel *_nameLabel;
    UILabel *_contLabel;
}
//- (void) setSubDatatearchListModel:(TearchListModel *)model;
@property (nonatomic, strong) TearchListModel *model;
@end


@interface TeacherClasstListViewCell : UITableViewCell {
     UIAsyncImageView *_topImageView;
     SMLabel *_titileLabel;
     SMLabel *_infoLabel;
     SMLabel *_priceLabel;
     UILabel *_signUpLabel;
     UILabel *_lineLabel;
    

}
- (void) setTearchClassListModel:(studyBannerListModel *)model;
@end
