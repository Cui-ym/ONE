//
//  ONENewsView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONENewsView.h"

#import <Masonry.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>

#define mainFrameSize self.frame.size

@implementation ONENewsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64)];
        [self addSubview:_scrollView];
        
        self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, 40)];
        [self addSubview:_headScrollView];
        
        self.itBtn = [[UIButton alloc] init];
        [_headScrollView addSubview:_itBtn];
        
        self.homeBtn = [[UIButton alloc] init];
        [_headScrollView addSubview:_homeBtn];
        
        self.latestBtn = [[UIButton alloc] init];
        [_headScrollView addSubview:_latestBtn];
        
        self.socialBtn = [[UIButton alloc] init];
        [_headScrollView addSubview:_socialBtn];
        
        self.internationalBtn = [[UIButton alloc] init];
        [_headScrollView addSubview:_internationalBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headScrollView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.1];
    
    // 加载五个按钮的基本信息
    [_homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headScrollView.mas_left);
        make.top.equalTo(_headScrollView.mas_top).offset(10);
        make.height.mas_equalTo(20.0);
        make.width.equalTo(_headScrollView.mas_width).multipliedBy(0.2);
    }];
    _homeBtn.tag = 1;
    _homeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_homeBtn setTitle:@"国内" forState:UIControlStateNormal];
    [_homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_homeBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_homeBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_internationalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_homeBtn.mas_right);
        make.top.equalTo(_headScrollView.mas_top).offset(10);
        make.height.mas_equalTo(20);
        make.width.equalTo(_headScrollView.mas_width).multipliedBy(0.2);
    }];
    _internationalBtn.tag = 2;
    _internationalBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_internationalBtn setTitle:@"国际" forState:UIControlStateNormal];
    [_internationalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_internationalBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_internationalBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_latestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_internationalBtn.mas_right);
        make.top.equalTo(_headScrollView.mas_top).offset(10);
        make.height.mas_equalTo(20);
        make.width.equalTo(_headScrollView.mas_width).multipliedBy(0.2);
    }];
    _latestBtn.tag = 3;
    _latestBtn.selected = YES;
    _latestBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [_latestBtn setTitle:@"实时" forState:UIControlStateNormal];
    [_latestBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_latestBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_latestBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_itBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_latestBtn.mas_right);
        make.top.equalTo(_headScrollView.mas_top).offset(10);
        make.height.mas_equalTo(20);
        make.width.equalTo(_headScrollView.mas_width).multipliedBy(0.2);
    }];
    _itBtn.tag = 4;
    _itBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_itBtn setTitle:@"IT" forState:UIControlStateNormal];
    [_itBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_itBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_itBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_socialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_itBtn.mas_right);
        make.top.equalTo(_headScrollView.mas_top).offset(10);
        make.height.mas_equalTo(20);
        make.width.equalTo(_headScrollView.mas_width).multipliedBy(0.2);
    }];
    _socialBtn.tag = 5;
    _socialBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_socialBtn setTitle:@"社会" forState:UIControlStateNormal];
    [_socialBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_socialBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_socialBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置scrollView
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 5, self.frame.size.height - 104);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [_scrollView scrollRectToVisible:CGRectMake(mainFrameSize.width * 2, 0, mainFrameSize.width, mainFrameSize.height) animated:NO];
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self scrollViewDidEndDecelerating:_scrollView];
}

// 给界面添加tableView
- (void)setNewsTableView:(NSInteger)num flag:(BOOL)flag model:(NSArray<ONENewsItemModel>*)model{
    if (flag == 0) {
        self.tableView = [[ONENewsTableView alloc] initWithFrame:CGRectMake(mainFrameSize.width * num, 0, mainFrameSize.width, mainFrameSize.height - 49) style:UITableViewStylePlain];
        _tableView.newsDelegate = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            int num = _tableView.frame.origin.x / mainFrameSize.width;
            if ([self.delegate respondsToSelector:@selector(getTableViewData: table: which:)]) {
                [_delegate getTableViewData:num table:_tableView which:0];
            }
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            int num = _tableView.frame.origin.x / mainFrameSize.width;
            if ([self.delegate respondsToSelector:@selector(getTableViewData: table: which:)]) {
                [_delegate getTableViewData:num table:_tableView which:1
                 ];
            }
            [_tableView.mj_footer endRefreshing];
        }];
        [self.scrollView addSubview:_tableView];
        _tableView.newsArray = model;
        [_tableView calculateHeight];
        [_tableView reloadData];
    }
}

// 按钮点击事件
- (void)clickButton:(UIButton *)button {
    _homeBtn.selected = NO;
    _internationalBtn.selected = NO;
    _itBtn.selected = NO;
    _latestBtn.selected = NO;
    _socialBtn.selected = NO;
    
    button.selected = YES;
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [_delegate clickButton:button];
    }
}

// 监测scrollView是否停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    if ([self.delegate respondsToSelector:@selector(scrollEndPosition:)]) {
        [_delegate scrollEndPosition:point];
    }
}

- (void)didSelectedCell:(NSString *)content {
    if ([self.delegate respondsToSelector:@selector(pushContentViewControllerWithString:)]) {
        [_delegate pushContentViewControllerWithString:content];
    }
}

@end
