//
//  ONEMineView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEMineView.h"
#import <Masonry.h>

#define firstCell @"firstCell"
#define collectCell @"collectCell"

@implementation ONEMineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tableView = [[UITableView alloc] initWithFrame:frame];
        [self addSubview:_tableView];
        [_tableView registerClass:[ONEPersonalTableViewCell class] forCellReuseIdentifier:firstCell];
        [_tableView registerClass:[ONECollectionTableViewCell class] forCellReuseIdentifier:collectCell];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 10;
    }
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 300.0;
    } else if (indexPath.section == 1){
        return 100.0;
    }
    return 30.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ONEPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell forIndexPath:indexPath];
        cell.mineModel = self.mineModel;
//        NSLog(@"==%@==", cell.mineModel.profilesStr);
//        NSLog(@"==%@==", cell.mineModel.nameStr);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 1) {
        ONECollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collectCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)pushController {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushController" object:nil];
}

- (void)pushController:(NSString *)string {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:string, @"collection", nil];
    NSNotification *notification = [[NSNotification alloc] initWithName:@"pushCollectionController" object:nil userInfo:dictionary];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
