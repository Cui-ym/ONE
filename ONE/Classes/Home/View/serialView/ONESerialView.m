//
//  ONESerialView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONESerialView.h"
#import "UILabel+LabelHeight.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

#define contentCell @"serialContentCell"
#define commentCell @"serialCommentCell"

@implementation ONESerialView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64)];
        [_commentTableView registerClass:[ONEContentTableViewCell class] forCellReuseIdentifier:contentCell];
        [_commentTableView registerClass:[ONECommentTableViewCell class] forCellReuseIdentifier:commentCell];
        [self addSubview:_commentTableView];
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.9, 0)];
        _webView.userInteractionEnabled = NO;
        _webView.navigationDelegate = self;
        self.commentArray = [NSArray array];
        self.cellHeightArray = [NSMutableArray array];
        
        
    }
    return self;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    __weak ONESerialView *weakSelf = self;
    [_webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@", any];
        weakSelf.webHeight = heightStr.floatValue;
        [weakSelf calculateHeight];
        
    }];
}

- (void)calculateHeight {
    CGFloat height = [ONEContentTableViewCell cellHeightTitle:_title size:CGSizeMake(self.frame.size.width, 0)];
    height = height + _webHeight;
    NSNumber *cellHeight = [NSNumber numberWithFloat:height];
    [_cellHeightArray addObject:cellHeight];
    [_commentTableView reloadData];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    // 评论高度的自适应
    for (int i = 0; i < _commentArray.count; i++) {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [_cellHeightArray[0] floatValue];
    }
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _commentArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        _serialCell = [tableView dequeueReusableCellWithIdentifier:contentCell forIndexPath:indexPath];
        _serialCell.title.text = _title;
        _serialCell.author.text = _author;
        [_serialCell.contentWeb loadHTMLString:_webString baseURL:nil];
        return _serialCell;
    } else {
        _commentCell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
        _commentCell.nicknameLabel.text = [[_commentArray[indexPath.row] objectForKey:@"user"] objectForKey:@"user_name"];
        _commentCell.timeLabel.text = [_commentArray[indexPath.row] objectForKey:@"input_date"];
        _commentCell.commentLabel.text = [_commentArray[indexPath.row] objectForKey:@"content"];
        NSURL *url = [NSURL URLWithString:[[_commentArray[indexPath.row] objectForKey:@"user"] objectForKey:@"web_url"]] ;
        [_commentCell.profilePicture sd_setImageWithURL:url];
        return _commentCell;
    }
}


@end
