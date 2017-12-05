//
//  ONECommentTableViewCell.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/27.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ONECommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *profilePicture;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *label;

+(CGFloat)cellComment:(NSString *)comment size:(CGSize)contextSize;

@end
