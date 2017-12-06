//
//  ONENewsView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONENewsView.h"
#import <Masonry.h>

@implementation ONENewsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, 40)];
        [self addSubview:_headView];
        
        self.itBtn = [[UIButton alloc] init];
        [_headView addSubview:_itBtn];
        
        self.homeBtn = [[UIButton alloc] init];
        [_headView addSubview:_homeBtn];
        
        self.latestBtn = [[UIButton alloc] init];
        [_headView addSubview:_latestBtn];
        
        self.socialBtn = [[UIButton alloc] init];
        [_headView addSubview:_socialBtn];
        
        self.internationalBtn = [[UIButton alloc] init];
        [_headView addSubview:_internationalBtn];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 104)];
        [self addSubview:_scrollView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.02];
    
    // 加载五个按钮的基本信息
    [_homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView.mas_left);
        make.top.equalTo(_headView.mas_top).offset(10);
        make.height.mas_equalTo(20.0);
        make.width.equalTo(_headView.mas_width).multipliedBy(0.2);
    }];
    [_homeBtn setTitle:@"国内" forState:UIControlStateNormal];
    [_homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_homeBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [_internationalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_homeBtn.mas_right);
        make.top.equalTo(_headView.mas_top).offset(10);
        make.height.mas_equalTo(20);
        make.width.equalTo(_headView.mas_width).multipliedBy(0.2);
    }];
    [_internationalBtn setTitle:@"国际" forState:UIControlStateNormal];
    [_internationalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_internationalBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [_latestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_internationalBtn.mas_right);
        make.top.equalTo(_headView.mas_top).offset(10);
        make.height.mas_equalTo(20);
        make.width.equalTo(_headView.mas_width).multipliedBy(0.2);
    }];
    [_latestBtn setTitle:@"实时" forState:UIControlStateNormal];
    [_latestBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_latestBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [_itBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_latestBtn.mas_right);
        make.top.equalTo(_headView.mas_top).offset(10);
        make.height.mas_equalTo(20);
        make.width.equalTo(_headView.mas_width).multipliedBy(0.2);
    }];
    [_itBtn setTitle:@"IT" forState:UIControlStateNormal];
    [_itBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_itBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [_socialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_itBtn.mas_right);
        make.top.equalTo(_headView.mas_top).offset(10);
        make.height.mas_equalTo(20);
        make.width.equalTo(_headView.mas_width).multipliedBy(0.2);
    }];
    [_socialBtn setTitle:@"社会" forState:UIControlStateNormal];
    [_socialBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_socialBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    // 设置scrollView
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 5, self.frame.size.height - 104);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

@end
