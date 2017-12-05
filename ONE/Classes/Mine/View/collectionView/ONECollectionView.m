//
//  ONECollectionView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/22.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONECollectionView.h"
#import "ONEMainCellModel.h"

@implementation ONECollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = [NSArray array];
        self.contentDic = [NSDictionary dictionary];
        self.collectionInstance = [ONECollectionInstance shareCollection];
        
        self.backgroundColor = [UIColor whiteColor];
        self.tableView = [[UITableView alloc] initWithFrame:frame];
        [self addSubview:_tableView];
        
    }
    return self;
}

- (void)judgeStyle {
//    NSLog(@"labelStr:%@", _labelStr);
    if ([_labelStr isEqual:@"阅读"]) {
        _labelStr = @"文章";
        _titleArray = _collectionInstance.articleDic.allKeys;
        _contentDic = _collectionInstance.articleDic;
    } else if ([_labelStr isEqual:@"问答"]) {
        _titleArray = _collectionInstance.anwersDic.allKeys;
        _contentDic = _collectionInstance.anwersDic;
    } else if ([_labelStr isEqual:@"连载"]) {
        _titleArray = _collectionInstance.serialDic.allKeys;
        _contentDic = _collectionInstance.serialDic;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"cell.title.text:%@", _titleArray[indexPath.row]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.imageView setImage:[UIImage imageNamed:_labelStr]];
    cell.textLabel.text = _titleArray[indexPath.row];
    ONEMainCellModel *model = [_contentDic objectForKey:_titleArray[indexPath.section]];
    
    cell.detailTextLabel.text = model.article;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegat respondsToSelector:@selector(pushContentView:)]) {
        [_delegat pushContentView:[_contentDic objectForKey:_titleArray[indexPath.row]]];
    }
}

// cell 的删除操作
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if ([_labelStr isEqual:@"文章"]) {
            [_collectionInstance.articleDic removeObjectForKey:_titleArray[indexPath.row]];
            _titleArray = _collectionInstance.articleDic.allKeys;
            _contentDic = _collectionInstance.articleDic;
        } else if ([_labelStr isEqual:@"问答"]) {
            [_collectionInstance.anwersDic removeObjectForKey:_titleArray[indexPath.row]];
            _titleArray = _collectionInstance.anwersDic.allKeys;
            _contentDic = _collectionInstance.anwersDic;
        } else if ([_labelStr isEqual:@"连载"]) {
            [_collectionInstance.serialDic removeObjectForKey:_titleArray[indexPath.row]];
            _titleArray = _collectionInstance.serialDic.allKeys;
            _contentDic = _collectionInstance.serialDic;
        }
        [_tableView reloadData];
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    return @[deleteRowAction];
}


@end
