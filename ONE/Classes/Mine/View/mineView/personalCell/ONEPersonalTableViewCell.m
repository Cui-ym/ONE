//
//  ONEPersonalTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEPersonalTableViewCell.h"
#import <Masonry.h>

@implementation ONEPersonalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundPicture = [[UIImageView alloc] init];
        [self.contentView addSubview:_backgroundPicture];
        
        self.headPicture = [[UIImageView alloc] init];
        [self.contentView addSubview:_headPicture];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        
        self.profilesLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_profilesLabel];
        
        self.editButton = [[UIButton alloc] init];
        [self.editButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_editButton];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backgroundPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.equalTo(self.contentView);
    }];
    _backgroundPicture.backgroundColor = [UIColor grayColor];
    _backgroundPicture.image = [_mineModel.backgroundDic objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self.headPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(70);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.25);
        make.width.equalTo(self.contentView.mas_height).multipliedBy(0.25);
    }];
    _headPicture.layer.borderWidth = 1;
    _headPicture.image = [_mineModel.headDic objectForKey:@"UIImagePickerControllerEditedImage"];
    _headPicture.layer.borderColor = [[UIColor whiteColor] CGColor];
    _headPicture.layer.masksToBounds = YES;
    _headPicture.layer.cornerRadius = self.contentView.frame.size.height * 0.25 * 0.5;
    _headPicture.backgroundColor = [UIColor yellowColor];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_headPicture.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.contentView.mas_width);
    }];
    _nameLabel.text = _mineModel.nameStr;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor whiteColor];
    
    [self.profilesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.equalTo(self.contentView.mas_width);
    }];
    if (_mineModel.profilesStr == nil) {
        _profilesLabel.text = @"介绍：空";
    } else {
        _profilesLabel.text = [NSString stringWithFormat:@"介绍：%@", _mineModel.profilesStr];
    }
    _profilesLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    _profilesLabel.textAlignment = NSTextAlignmentCenter;
    _profilesLabel.textColor = [UIColor whiteColor];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);;
        make.top.equalTo(_profilesLabel.mas_bottom).offset(20);
        make.width.equalTo(_headPicture.mas_width).multipliedBy(1.2);
        make.height.mas_equalTo(24);
    }];
    _editButton.backgroundColor = [UIColor colorWithRed:0.55f green:0.56f blue:0.54f alpha:1.00f];
    [_editButton setTintColor:[UIColor whiteColor]];
    [_editButton setTitle:@"编   辑" forState:UIControlStateNormal];
    _editButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _editButton.layer.masksToBounds = YES;
    _editButton.layer.cornerRadius = 12;
    
}

- (void)clickButton {
    if ([_delegate respondsToSelector:@selector(pushController)]) {
        [self.delegate pushController];
    }
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
