//
//  ONEPersonalTableViewCell.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEMineModel.h"

@protocol ONEPersonalTableViewCellDelegate<NSObject>

@optional
- (void)pushController;

@end

@interface ONEPersonalTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ONEPersonalTableViewCellDelegate>delegate;

@property (nonatomic, strong) ONEMineModel *mineModel;
@property (nonatomic, strong) UIImageView *headPicture;
@property (nonatomic, strong) UIImageView *backgroundPicture;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *profilesLabel;
@property (nonatomic, strong) UIButton *editButton;

@end
