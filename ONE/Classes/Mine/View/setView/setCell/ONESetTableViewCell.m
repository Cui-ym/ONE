//
//  ONESetTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/8.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONESetTableViewCell.h"
#import <Masonry.h>

@implementation ONESetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_headLabel];
        
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        
        self.picture = [[UIImageView alloc] init];
        [self.contentView addSubview:_picture];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.4);
    }];
    _headLabel.textAlignment = NSTextAlignmentLeft;
    _headLabel.font = [UIFont systemFontOfSize:15];
//    _headLabel.backgroundColor = [UIColor yellowColor];
    
    if (self.image) {
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(self.contentView.mas_height).multipliedBy(0.6);
            make.right.equalTo(self.contentView.mas_right);
            make.width.equalTo(_picture.mas_height);
        }];
        _picture.backgroundColor = [UIColor yellowColor];
    } else {
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(self.contentView.mas_height).multipliedBy(0.3);
            make.right.equalTo(self.contentView.mas_right);
            make.left.equalTo(self.contentView.mas_centerX);
        }];
        _label.textAlignment = NSTextAlignmentRight;
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = [UIColor colorWithRed:0.41f green:0.41f blue:0.41f alpha:1.00f];
        
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
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
