//
//  ONEWordsNewsTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/11.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEWordsNewsTableViewCell.h"
#import <Masonry.h>

@implementation ONEWordsNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
    
    [self.datailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
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
