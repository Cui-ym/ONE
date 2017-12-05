//
//  ONEAnswerTableViewCell.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/2.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEAnswerTableViewCell.h"
#import "UILabel+LabelHeight.h"

#import <Masonry.h>

@implementation ONEAnswerTableViewCell
+ (CGFloat)cellHeightTitle:(NSString *)title question:(NSString *)question size:(CGSize)contextSize {
    CGSize size = CGSizeMake(contextSize.width * 0.9, 0);
    CGFloat titleHeigth = [UILabel_LabelHeight getHeightByWidth:size.width title:title font:[UIFont systemFontOfSize:20.0]];
    CGFloat questionHeight = [UILabel_LabelHeight getHeightByWidth:size.width title:question font:[UIFont systemFontOfSize:20.0]];
    
    return titleHeigth + questionHeight + 155;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        
        self.author = [[UILabel alloc] init];
        [self.contentView addSubview:_author];
        
        self.questioner = [[UILabel alloc] init];
        [self.contentView addSubview:_questioner];
        
        self.question = [[UILabel alloc] init];
        [self.contentView addSubview:_question];
        
        self.answer = [[WKWebView alloc] init];
        _answer.userInteractionEnabled = NO;
        _answer.navigationDelegate = self;
        [self.contentView addSubview:_answer];
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
    
    [self.questioner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(44);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.9);
    }];
    _questioner.textAlignment = NSTextAlignmentLeft;
    _questioner.textColor = [UIColor blackColor];
    _questioner.font = [UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight];
    
    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_questioner.mas_bottom).offset(15);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.9);
    }];
    _question.textAlignment = NSTextAlignmentLeft;
    _question.textColor = [UIColor blackColor];
    _question.numberOfLines = 0;
    _question.font = [UIFont systemFontOfSize:15 weight:UIFontWeightUltraLight];
    
    [self.author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_question.mas_bottom).offset(44);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.9);
    }];
    _author.textAlignment = NSTextAlignmentLeft;
    _author.textColor = [UIColor blackColor];
    _author.font = [UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight];
    
    [self.answer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_author.mas_bottom).offset(15);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.9);
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    __weak ONEAnswerTableViewCell *weakSelf = self;
    [_answer evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@", any];
        //        _scrollView.contentSize = CGSizeMake(weakSelf.frame.size.width, heightStr.floatValue + 100 + weakSelf.title.frame.size.height + weakSelf.author.frame.size.height);
        [weakSelf.answer mas_updateConstraints:^(MASConstraintMaker *make) {
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
