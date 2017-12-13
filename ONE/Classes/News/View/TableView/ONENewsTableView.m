//
//  ONENewsTableView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONENewsTableView.h"
#import "ONEImageNewsTableViewCell.h"
#import "ONEWordsNewsTableViewCell.h"

#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <Masonry.h>

#define imageCell @"imageCell"
#define wordsCell @"wordsCell"

@implementation ONENewsTableView
{
    int cellArray[10000];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.newsArray = [NSArray<ONENewsItemModel> array];
        self.heightArray  = [NSMutableArray array];
        
        [self registerClass:[ONEImageNewsTableViewCell class] forCellReuseIdentifier:imageCell];
        [self registerClass:[ONEWordsNewsTableViewCell class] forCellReuseIdentifier:wordsCell];
        
    }
    return self;
}

- (void)calculateHeight {
    _heightArray = [NSMutableArray array];
    for (int i = 0; i < _newsArray.count; i++) {
        CGFloat height = [ONEImageNewsTableViewCell cellModel:_newsArray[i] size:CGSizeMake(self.frame.size.width, 0)];
        NSNumber *cellHeight = [NSNumber numberWithFloat:height];
        [_heightArray addObject:cellHeight];
    }
//    NSLog(@"%@", _newsArray);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_heightArray[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ONENewsItemModel *model = _newsArray[indexPath.row];
    if (![model.havePic  isEqual: @"0"]) {
        ONEImageNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[model.imageurls[0] objectForKey:@"url"]];
        [cell.newsImageView sd_setImageWithURL:url];
        cell.titleLab.text = model.title;
        cell.timeLab.text = model.pubDate;
        cell.datailLab.text = model.desc;
        return cell;
    } else {
        ONEWordsNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wordsCell forIndexPath:indexPath];
        cell.titleLab.text = model.title;
        cell.timeLab.text = model.pubDate;
        cell.datailLab.text = model.desc;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ONENewsItemModel *model = self.newsArray[indexPath.row];
    if ([self.newsDelegate respondsToSelector:@selector(didSelectedCell:)]) {
        [_newsDelegate didSelectedCell:model.link];
    }
}

@end
