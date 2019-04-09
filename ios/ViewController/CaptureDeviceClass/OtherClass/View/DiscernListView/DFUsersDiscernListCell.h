//
//  DFUsersDiscernListCell.h
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"
@class DFDiscernListModel;

@protocol DFDiscernListCellDelegate <NSObject>

- (void)addComment:(UIButton *)sender;

@end

@interface DFUsersDiscernListCell : SHPAbstractCollectionViewCell

@property (nonatomic, weak) id <DFDiscernListCellDelegate> delegate;

@property (nonatomic, strong) DFDiscernListModel *listModel;

@end
