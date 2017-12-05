//
//  ONECollectionTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONECollectionTableViewCell.h"
#import <Masonry.h>

@implementation ONECollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        
        self.pictureBtn = [[MYButton alloc] init];
        [self.contentView addSubview:_pictureBtn];
        
        self.articleBtn = [[MYButton alloc] init];
        [self.contentView addSubview:_articleBtn];
        
        self.anwersBtn = [[MYButton alloc] init];
        [self.contentView addSubview:_anwersBtn];
        
        self.serialBtn = [[MYButton alloc] init];
        [self.contentView addSubview:_serialBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    self.label.text = @"我的收藏";
    
    [self.pictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).multipliedBy(0.25).offset(-20);
        make.top.equalTo(_label.mas_bottom).offset(15);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.15);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.15);
    }];
    [_pictureBtn setTitle:@"图 文" forState:UIControlStateNormal];
    [_pictureBtn setImage:[UIImage imageNamed:@"图文"] forState:UIControlStateNormal];
    _pictureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_pictureBtn setTitleColor:[UIColor colorWithRed:0.41f green:0.41f blue:0.41f alpha:1.00f] forState:UIControlStateNormal];
    
    [self.articleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).multipliedBy(0.5).offset(-20);
        make.top.equalTo(_label.mas_bottom).offset(15);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.15);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.15);
    }];
    [_articleBtn setTitle:@"阅 读" forState:UIControlStateNormal];
    _articleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_articleBtn setImage:[UIImage imageNamed:@"文章"] forState:UIControlStateNormal];
    [_articleBtn setTitleColor:[UIColor colorWithRed:0.41f green:0.41f blue:0.41f alpha:1.00f] forState:UIControlStateNormal];
    
    [self.anwersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).multipliedBy(0.75).offset(-20);
        make.top.equalTo(_label.mas_bottom).offset(15);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.15);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.15);
    }];
    [_anwersBtn setTitle:@"问 答" forState:UIControlStateNormal];
    _anwersBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_anwersBtn setImage:[UIImage imageNamed:@"问答"] forState:UIControlStateNormal];
    [_anwersBtn setTitleColor:[UIColor colorWithRed:0.41f green:0.41f blue:0.41f alpha:1.00f] forState:UIControlStateNormal];
    
    [self.serialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(_label.mas_bottom).offset(15);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.15);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.15);
    }];
    [_serialBtn setTitle:@"连 载" forState:UIControlStateNormal];
    _serialBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_serialBtn setImage:[UIImage imageNamed:@"连载"] forState:UIControlStateNormal];
    [_serialBtn setTitleColor:[UIColor colorWithRed:0.41f green:0.41f blue:0.41f alpha:1.00f] forState:UIControlStateNormal];
    
    [_pictureBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_articleBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_anwersBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_serialBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickButton:(UIButton *)button {
//    NSLog(@"%@", button.titleLabel.text);
    if ([_delegate respondsToSelector:@selector(pushController:)]) {
        [self.delegate pushController:button.titleLabel.text];
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
