//
//  ONECommentTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/27.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONECommentTableViewCell.h"
#import "UILabel+LabelHeight.h"
#import <Masonry.h>

@implementation ONECommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.profilePicture = [[UIImageView alloc] init];
        [self.contentView addSubview:_profilePicture];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        
        self.commentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_commentLabel];
    }
    return self;
}

+ (CGFloat)cellComment:(NSString *)comment size:(CGSize)contextSize {
    CGFloat commentHeigth = [UILabel_LabelHeight getHeightByWidth:contextSize.width - 80 title:comment font:[UIFont systemFontOfSize:15.0]];
//    NSLog(@"%f", commentHeigth);
    return commentHeigth + 80;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.profilePicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.height.width.mas_equalTo(30);
        make.width.width.mas_equalTo(30);
    }];
//    self.profilePicture.backgroundColor = [UIColor redColor];
    _profilePicture.layer.borderWidth = 1;
    _profilePicture.layer.borderColor = [[UIColor whiteColor] CGColor];
    _profilePicture.layer.masksToBounds = YES;
    _profilePicture.layer.cornerRadius = 15;
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(_profilePicture.mas_top);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.35);
        make.height.mas_equalTo(20);
    }];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
//    self.timeLabel.backgroundColor = [UIColor redColor];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_profilePicture.mas_right).offset(15);
        make.top.equalTo(_profilePicture.mas_top);
        make.right.equalTo(_timeLabel.mas_left).offset(-20);
    }];
    self.nicknameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    self.nicknameLabel.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.00f];
//    _nicknameLabel.textColor = [UIColor]
//    self.nicknameLabel.backgroundColor = [UIColor blackColor];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_profilePicture.mas_bottom).offset(15);
        make.left.equalTo(_profilePicture.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];
    _commentLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
    _commentLabel.numberOfLines = 0;
//    self.commentLabel.backgroundColor = [UIColor yellowColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
