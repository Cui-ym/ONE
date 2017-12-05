//
//  ONEFirstTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/10/11.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEFirstTableViewCell.h"
#import "ONEFirstCellModel.h"
#import "UILabel+LabelHeight.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

#define MAIN_CELL @"mainCell"

@implementation ONEFirstTableViewCell

-(void)setModel:(ONEFirstCellModel *)model
{
    _model = model;
    _urlString = _model.urlString;
//    _time.text = _model.time;
    _label.text = _model.label;
    _authorLab.text = _model.author;
    _articleLab.text = _model.article;
//    _time.text = model.time;
    _title.text = model.title;
    [_likeBtn setTitle:_model.likeNumber forState:UIControlStateNormal];
    [_forwardBtn setTitle:_model.forwardNumber forState:UIControlStateNormal];
    
}

+ (CGFloat)cellModel:(ONEFirstCellModel *)model size:(CGSize)contextSize{
    CGSize size = CGSizeMake(contextSize.width * 0.9, 0);
    CGFloat labelHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:model.label font:[UIFont systemFontOfSize:12.0]];
    CGFloat titleHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:model.title font:[UIFont systemFontOfSize:15.0]];
    CGFloat articleHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:model.article font:[UIFont systemFontOfSize:14.0]];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: model.picture];
    CGFloat imageHight = image.size.height * contextSize.width / image.size.width;
    // 64 时间高度
    // 95 各个控件间距和 + 底部按钮
    // 64 固定图片高度
    if (image == nil) {
        imageHight = 100;
    }
//    NSLog(@"计算：%lf %lf %lf %lf %@", labelHeigth, titleHeigth, articleHeigth, imageHight, image);
    return labelHeigth + titleHeigth + articleHeigth + imageHight + 110; //+ 64;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
//
//        self.time = [[UILabel alloc] init];
//        [self.contentView addSubview:_time];
//
        self.authorLab = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLab];
        
        self.articleLab = [[UILabel alloc] init];
        [self.contentView addSubview:_articleLab];
        
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        
        self.noteBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_noteBtn];
        
        self.collectionBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_collectionBtn];
        
        self.likeBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_likeBtn];
        
        self.forwardBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_forwardBtn];
        
        self.picture = [[UIButton alloc] init];
        [self.contentView addSubview:_picture];
    }
    
    return self;
}

- (void)layoutSubviews {
    // 设置颜色
    _picture.backgroundColor = [UIColor yellowColor];
    
    // 时间
//    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView);
//        make.width.equalTo(self.mas_width).multipliedBy(0.9);
//        make.top.equalTo(self.mas_top);
//        make.height.mas_equalTo(64);
//    }];
//    _time.font = [UIFont systemFontOfSize:18 weight:UIFontWeightThin];
//    _time.textAlignment = NSTextAlignmentCenter;
//
    // 图片
    [_picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
    // 头标签
    _label.textColor = [UIColor colorWithRed:0.44f green:0.44f blue:0.45f alpha:1.00f];
    _label.textAlignment = NSTextAlignmentCenter;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.picture.mas_bottom).offset(15);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(200);
    }];
    _label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    
    // 文章
    [_articleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.8);
        make.top.equalTo(_label.mas_bottom).offset(20);
    }];
    _articleLab.textColor = [UIColor colorWithRed:0.46f green:0.46f blue:0.46f alpha:1.00f];
    _articleLab.numberOfLines = 0;
    _articleLab.font = [UIFont systemFontOfSize:15];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 自适应高度
        CGFloat articleHeight = [UILabel_LabelHeight getHeightByWidth:_articleLab.frame.size.width title:_articleLab.text font:_articleLab.font];
        [_articleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(articleHeight);
        }];
    });

    // 主题
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.9);
        make.top.equalTo(_articleLab.mas_bottom).offset(20);
    }];
    _title.textColor = [UIColor colorWithRed:0.44f green:0.44f blue:0.45f alpha:1.00f];
    _title.numberOfLines = 0;
    _title.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    _title.textAlignment = NSTextAlignmentCenter;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 自适应高度
        CGFloat authorHeight = [UILabel_LabelHeight getHeightByWidth:_title.frame.size.width title:_title.text font:_title.font];
        [_title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(authorHeight);
        }];
    });
    
    // 小记
    [_noteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(50);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(25);
    }];
    [_noteBtn setTitle:@"小记" forState:UIControlStateNormal];
    _noteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_noteBtn setTitleColor:[UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f] forState:UIControlStateNormal];
    _noteBtn.imageView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
    // 设置图片，文字位置
    _noteBtn.imageEdgeInsets = UIEdgeInsetsMake(1, 0, 1, 30);
    _noteBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 20, 2, 0);
    
    // 收藏按钮
    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        [UIColor colorWithRed:0.98f green:0.83f blue:0.42f alpha:1.00f];
    }];
//        _collectionBtn.backgroundColor = [UIColor blackColor];
    [_collectionBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    [_collectionBtn addTarget:self action:@selector(collectionBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_collectionBtn setImage:[UIImage imageNamed:@"收藏填充"] forState:UIControlStateSelected];
}

// 收藏按钮点击事件
- (void)collectionBtnSelect:(UIButton *)button {
    //    NSLog(@"点击了收藏按钮  %ld", button.tag);
    if ([_delegate respondsToSelector:@selector(clickCollectionButton: model: title:)]) {
        [self.delegate clickCollectionButton:button model:_model title:_title.text];
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
