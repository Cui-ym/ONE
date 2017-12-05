//
//  ONEHomeView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/10/1.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEHomeView.h"
#import "ONEMainCellModel.h"
#import "ONEFirstCellModel.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <UIImageView+WebCache.h>

#define FIRST_CELL @"firstCell"
#define MAIN_CELL @"mainCell"

@implementation ONEHomeView
{
    NSArray *array;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 计算结束后添加 tableView
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 49 - 64) style:UITableViewStyleGrouped];
        [self.tableView registerClass:[ONEMainTableViewCell class] forCellReuseIdentifier:MAIN_CELL];
        [self.tableView registerClass:[ONEFirstTableViewCell class] forCellReuseIdentifier:FIRST_CELL];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [self addSubview:_tableView];
        
        self.button = [[UIButton alloc] init];
    }
    return self;
}

// 计算高度
- (void)calculateHeight {
    NSURL *url = [NSURL URLWithString:_firstModel.picture];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:url completed:nil];
    
    CGFloat one = [ONEFirstTableViewCell cellModel:_firstModel size:CGSizeMake(self.frame.size.width, 0)];
    CGFloat two = [ONEMainTableViewCell cellHeight:_firstMainModel size:CGSizeMake(self.frame.size.width, 0)];
    CGFloat three = [ONEMainTableViewCell cellHeight:_secondMainModel size:CGSizeMake(self.frame.size.width, 0)];
    CGFloat four = [ONEMainTableViewCell cellHeight:_thridMainModel size:CGSizeMake(self.frame.size.width, 0)];
    CGFloat five = [ONEMainTableViewCell cellHeight:_fourthMainModel size:CGSizeMake(self.frame.size.width, 0)];
    CGFloat six = [ONEMainTableViewCell cellHeight:_fifthMainModel size:CGSizeMake(self.frame.size.width, 0)];
    CGFloat seven = [ONEMainTableViewCell cellHeight:_sixMainModel size:CGSizeMake(self.frame.size.width, 0)];
//    NSLog(@"%lf %lf %lf %lf %lf", one, two, three, four, five);
    
    NSNumber *oneCell = [NSNumber numberWithFloat:one];
    NSNumber *twoCell = [NSNumber numberWithFloat:two];
    NSNumber *threeCell = [NSNumber numberWithFloat:three];
    NSNumber *fourCell = [NSNumber numberWithFloat:four];
    NSNumber *fiveCell = [NSNumber numberWithFloat:five];
    NSNumber *sixCell = [NSNumber numberWithFloat:six];
    NSNumber *sevenCell = [NSNumber numberWithFloat:seven];
    
//    [_button sd_setBackgroundImageWithURL:url forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        CGFloat imageHeight = image.size.height * self.frame.size.width / image.size.width;
//    }];
    
    array = [NSArray arrayWithObjects:oneCell, twoCell, threeCell, fourCell, fiveCell, sixCell, sevenCell, nil];
    _btnStatusArr = [NSMutableArray array];
    
    // 初始化按钮的状态数组
    for (int i = 0; i < _number - 1; i++) {
        [self.btnStatusArr addObject:@"0"];
    }
    
    _tableView.dataSource = self;
    
    [_tableView setDelegate:self];
//    NSLog(@"%@", _tableView.delegate);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _number;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// 计算高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld", (long)indexPath.section);
//    NSLog(@"number%ld", _number);
//    NSLog(@"%lf", [array[indexPath.section] floatValue]);
    return [array[indexPath.section] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

// 设置 cell 的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) {
//        NSLog(@"%@ section:%ld", _btnStatusArr[indexPath.section - 1], indexPath.section);
        _MainCell = [tableView dequeueReusableCellWithIdentifier:MAIN_CELL forIndexPath:indexPath];
        _MainCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _MainCell.delegate = self;
        _MainCell.collectionBtn.selected = [_btnStatusArr[indexPath.section - 1] boolValue];
    }
    if (indexPath.section == 0) {
        _firstCell = [tableView dequeueReusableCellWithIdentifier:FIRST_CELL forIndexPath:indexPath];
        _firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_firstCell setModel:_firstModel];
        _firstCell.delegate = self;
//        _firstCell.time.text = _firstModel.time;
        _firstCell.label.text = _firstModel.label;
        _firstCell.title.text = _firstModel.title;
        _firstCell.articleLab.text = _firstModel.article;
        NSURL *url = [NSURL URLWithString:_firstModel.picture];
        [_firstCell.picture sd_setBackgroundImageWithURL:url forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            CGFloat imageHeight = image.size.height * self.frame.size.width / image.size.width;
            [_firstCell.picture mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(imageHeight);
            }];
        }];
        return _firstCell;
    } else if (indexPath.section == 1) {
        [_MainCell setContent:_firstMainModel];
        return _MainCell;
    } else if (indexPath.section == 2) {
        [_MainCell setContent:_secondMainModel];
        return _MainCell;
    } else if (indexPath.section == 3) {
        [_MainCell setContent:_thridMainModel];
        return _MainCell;
    } else if (indexPath.section == 4) {
        [_MainCell setContent:_fourthMainModel];
        return _MainCell;
    } else if (indexPath.section == 5) {
        [_MainCell setContent:_fifthMainModel];
        return _MainCell;
    } else {
        [_MainCell setContent:_sixMainModel];
        return _MainCell;
    }
}

// 点击收藏按钮执行的代理方法
- (void)clickCollectionButton:(UIButton *)button type:(NSString *)type model:(ONEMainCellModel *)model{
    // 通过 item 的值来更改 button 数组中的值
    if ([model.item_id isEqualToString:_firstMainModel.item_id]) {
        _btnStatusArr[0] = [_btnStatusArr[0]  isEqual: @"0"] ? @"1" : @"0";
    } else if ([model.item_id isEqualToString:_secondMainModel.item_id]) {
        _btnStatusArr[1] = [_btnStatusArr[1]  isEqual: @"0"] ? @"1" : @"0";
    } else if ([model.item_id isEqualToString:_thridMainModel.item_id]) {
        _btnStatusArr[2] = [_btnStatusArr[2]  isEqual: @"0"] ? @"1" : @"0";
    } else if ([model.item_id isEqualToString:_fourthMainModel.item_id]) {
        _btnStatusArr[3] = [_btnStatusArr[3]  isEqual: @"0"] ? @"1" : @"0";
    } else if ([model.item_id isEqualToString:_fifthMainModel.item_id]) {
        _btnStatusArr[4] = [_btnStatusArr[4]  isEqual: @"0"] ? @"1" : @"0";
    } else if ([model.item_id isEqualToString:_sixMainModel.item_id]) {
        _btnStatusArr[5] = [_btnStatusArr[5]  isEqual: @"0"] ? @"1" : @"0";
    }
//    NSLog(@"%@ %@", type, item);
    if (button.selected == NO) {
        [button setSelected:YES];
        if ([_delegate respondsToSelector:@selector(collectType: model:)]) {
//            NSLog(@"执行收藏方法");
            [self.delegate collectType:type model:model];
        }
    } else {
        [button setSelected:NO];
        if ([_delegate respondsToSelector:@selector(cancleCollectType: title:)]) {
            [self.delegate cancleCollectType:type title:model.title];
        }
    }
}

- (void)clickCollectionButton:(UIButton *)button model:(ONEFirstCellModel *)model title:(NSString *)title{
    if (button.selected == NO) {
        [button setSelected:YES];
        if ([_delegate respondsToSelector:@selector(collectPictureModel: title:)]) {
            //            NSLog(@"执行收藏方法");
            [self.delegate collectPictureModel:model title:title];
        }
    } else {
        [button setSelected:NO];
        if ([_delegate respondsToSelector:@selector(cancleCollectPictureTitle:)]) {
            [self.delegate cancleCollectPictureTitle:title];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 1) {
        _MainCell = [_tableView cellForRowAtIndexPath:indexPath];
        if ([self.delegate respondsToSelector:@selector(pushArticleViewController: label: author:)]) {
            [self.delegate pushArticleViewController:_MainCell.item_id label:_MainCell.label.text author:_MainCell.authorLab.text];
        }
    }
}

// 当 tableView 变动，调用代理方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if ([self.delegate respondsToSelector:@selector(tableViewDidScroll:)]) {
//        [self.delegate tableViewDidScroll:self.tableView];
//    }
//}

@end
