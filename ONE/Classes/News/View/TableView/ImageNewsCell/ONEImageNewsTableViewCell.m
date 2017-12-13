//
//  ONEImageNewsTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEImageNewsTableViewCell.h"
#import "UILabel+LabelHeight.h"

#import <UIImageView+WebCache.h>
#import <Masonry.h>

@implementation ONEImageNewsTableViewCell

+ (CGFloat)cellModel:(ONENewsItemModel *)model size:(CGSize)contextSize {
    CGSize size = CGSizeMake(contextSize.width * 0.9, 0);
    CGFloat titleHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:model.title font:[UIFont systemFontOfSize:18.0]];
    CGFloat datailHeight = [UILabel_LabelHeight getHeightByWidth:size.width title:model.desc font:[UIFont systemFontOfSize:16.0]];
    if ([model.havePic  isEqual: @"0"]) {
        return titleHeigth + datailHeight + 40;
    } else {
        return titleHeigth + datailHeight + 245;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.newsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_newsImageView];
        
        self.titleLab = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLab];
        
        self.timeLab = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLab];
        
        self.datailLab = [[UILabel alloc] init];
        [self.contentView addSubview:_datailLab];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.height.mas_equalTo(30);
    }];
    _titleLab.numberOfLines = 0;
    _titleLab.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
//    _titleLab.backgroundColor = [UIColor redColor];
    
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_left);
        make.right.equalTo(self.titleLab.mas_right);
        make.height.mas_equalTo(200);
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
    }];
//    _newsImageView.backgroundColor = [UIColor yellowColor];
    
    [self.datailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.newsImageView.mas_bottom).offset(5);
        make.left.equalTo(self.titleLab.mas_left);
        make.right.equalTo(self.titleLab.mas_right);
    }];
    _datailLab.numberOfLines = 0;
    _datailLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightThin];
//    _datailLab.backgroundColor = [UIColor yellowColor];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.equalTo(self.titleLab.mas_left);
        make.right.equalTo(self.titleLab.mas_right);
        make.height.mas_equalTo(15);
    }];
    _timeLab.font = [UIFont systemFontOfSize:15];
    _timeLab.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
//    _timeLab.backgroundColor = [UIColor blueColor];
    
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
