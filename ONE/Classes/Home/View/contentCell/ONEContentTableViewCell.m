//
//  ONEContentTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/28.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEContentTableViewCell.h"


@implementation ONEContentTableViewCell

+ (CGFloat)cellHeightTitle:(NSString *)title size:(CGSize)contextSize {
    CGSize size = CGSizeMake(contextSize.width * 0.9, 0);
    CGFloat titleHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:title font:[UIFont systemFontOfSize:20.0]];
    
    return titleHeigth + 130;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        
        self.author = [[UILabel alloc] init];
        [self.contentView addSubview:_author];
        
        self.contentWeb = [[WKWebView alloc] init];
        _contentWeb.userInteractionEnabled = NO;
        _contentWeb.navigationDelegate = self;
        [self.contentView addSubview:_contentWeb];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(44);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.9);
    }];
    _title.numberOfLines = 0;
    _title.textAlignment = NSTextAlignmentLeft;
    _title.textColor = [UIColor blackColor];
    _title.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    
    [self.author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(44);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.9);
    }];
    _author.textAlignment = NSTextAlignmentLeft;
    _author.textColor = [UIColor blackColor];
    _author.font = [UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight];
    
    [self.contentWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_author.mas_bottom).offset(22);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.9);
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    __weak ONEContentTableViewCell *weakSelf = self;
    [_contentWeb evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@", any];
//        _scrollView.contentSize = CGSizeMake(weakSelf.frame.size.width, heightStr.floatValue + 100 + weakSelf.title.frame.size.height + weakSelf.author.frame.size.height);
        [weakSelf.contentWeb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(heightStr.floatValue);
        }];
    }];
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
