//
//  ONEMainTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/10/1.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEMainTableViewCell.h"
#import "ONEMainCellModel.h"
#import "UILabel+LabelHeight.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

#define MAIN_CELL @"mainCell"

@implementation ONEMainTableViewCell
{
    CGFloat height;
    BOOL flag;
}

- (void)setContent:(ONEMainCellModel *)model {
    _model = model;
    self.label.text = model.label;
    self.titleLab.text = model.title;
    self.authorLab.text = model.author;
    self.articleLab.text = model.article;
    self.timeLab.text = model.time;
    self.item_id = model.item_id;
    NSURL *url = [NSURL URLWithString:model.picture];
    [self.picture sd_setImageWithURL:url];
}

+ (CGFloat)cellHeight:(ONEMainCellModel *)model size:(CGSize)contextSize{
    CGSize size = CGSizeMake(contextSize.width * 0.9, 0);
    CGFloat labelHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:model.label font:[UIFont systemFontOfSize:12.0]];
    CGFloat titleHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:model.title font:[UIFont systemFontOfSize:20.0]];
    CGFloat authorHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:model.author font:[UIFont systemFontOfSize:15.0]];
    CGFloat articleHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:model.article font:[UIFont systemFontOfSize:14.0]];
    return labelHeigth + titleHeigth + authorHeigth + articleHeigth + contextSize.width * 0.55 + 85 + 20;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        
        self.titleLab = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLab];
        
        self.authorLab = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLab];
        
        self.articleLab = [[UILabel alloc] init];
        [self.contentView addSubview:_articleLab];
        
        self.timeLab = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLab];
        
        self.collectionBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_collectionBtn];
        
        self.likeBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_likeBtn];
        
        self.forwardBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_forwardBtn];
        
        self.picture = [[UIImageView alloc] init];
        [self.contentView addSubview:_picture];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    self.instance = [ONECollectionInstance shareCollection];
    
    // 设置颜色
    _picture.backgroundColor = [UIColor yellowColor];
    
    // 头标签
    _label.textColor = [UIColor colorWithRed:0.71f green:0.71f blue:0.71f alpha:1.00f];
    _label.textAlignment = NSTextAlignmentCenter;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(200);
    }];
    _label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    
    // 主题
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.mas_width).multipliedBy(0.9);
        make.top.equalTo(_label.mas_bottom).offset(15);
    }];
    _titleLab.tintColor = [UIColor blackColor];
    _titleLab.numberOfLines = 0;
    _titleLab.font = [UIFont systemFontOfSize:18 weight:UIFontWeightThin];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 自适应高度
        CGFloat titleHeight = [UILabel_LabelHeight getHeightByWidth:_titleLab.frame.size.width title:_titleLab.text font:_titleLab.font];
        [_titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(titleHeight);
        }];
    });
    
    // 作者
    [_authorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.mas_width).multipliedBy(0.9);
        make.top.equalTo(_titleLab.mas_bottom).offset(15);
    }];
    _authorLab.textColor = [UIColor colorWithRed:0.44f green:0.44f blue:0.45f alpha:1.00f];
    _authorLab.numberOfLines = 0;
    _authorLab.font = [UIFont systemFontOfSize:15];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 自适应高度
        CGFloat authorHeight = [UILabel_LabelHeight getHeightByWidth:_authorLab.frame.size.width title:_authorLab.text font:_authorLab.font];
        [_authorLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(authorHeight);
        }];
    });
    
    // 图片
    [_picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.mas_width).multipliedBy(0.9);
        make.top.equalTo(_authorLab.mas_bottom).offset(10);
        make.height.equalTo(self.mas_width).multipliedBy(0.55);
    }];
    
    // 文章
    [_articleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.mas_width).multipliedBy(0.9);
        make.top.equalTo(_picture.mas_bottom).offset(15);
    }];
    _articleLab.textColor = [UIColor colorWithRed:0.44f green:0.44f blue:0.45f alpha:1.00f];
    _articleLab.numberOfLines = 0;
    _articleLab.font = [UIFont systemFontOfSize:14];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 自适应高度
        CGFloat articleHeight = [UILabel_LabelHeight getHeightByWidth:_articleLab.frame.size.width title:_articleLab.text font:_articleLab.font];
        [_articleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(articleHeight);
        }];
    });
    
    // 时间
    _timeLab.textColor = [UIColor colorWithRed:0.44f green:0.44f blue:0.45f alpha:1.00f];
    _timeLab.font = [UIFont systemFontOfSize:12];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(20);
        make.top.equalTo(_articleLab.mas_bottom).offset(20);
    }];
    
    // 收藏按钮
    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_articleLab.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
//      _collectionBtn.backgroundColor = [UIColor yellowColor];
    [_collectionBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    [_collectionBtn addTarget:self action:@selector(collectionBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_collectionBtn setImage:[UIImage imageNamed:@"收藏填充"] forState:UIControlStateSelected];
    
}

// 收藏按钮点击事件
- (void)collectionBtnSelect:(UIButton *)button {
//    NSLog(@"点击了收藏按钮  %ld", button.tag);
    if ([_delegate respondsToSelector:@selector(clickCollectionButton: type: model: )]) {
        [self.delegate clickCollectionButton:button type:_label.text model:_model];
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
