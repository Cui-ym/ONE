//
//  ONESetView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONESetView.h"

#define ONEScreenHeight self.frame.size.height
#define ONEScreenWidth self.frame.size.width

@implementation ONESetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        [self.tableView registerClass:[ONESetTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:_tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (void)addPickerView {
    self.pickerView = [[ONEPickerView alloc] initWithFrame:self.frame];
    [_pickerView setWhitchPicker:_flag];
    _pickerView.dictionary = _dictionary;
    _pickerView.delegate = self;
    _pickerView.number = _number;
    [self addSubview:_pickerView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    } else if (indexPath.section == 1) {
        return 40;
    } else {
        if (indexPath.row == 0) {
            return 40;
        } else {
            return 150;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 2;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ONESetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.image = YES;
                cell.headLabel.text = @"头像";
                cell.picture.image = [_mineModel.headDic objectForKey:@"UIImagePickerControllerEditedImage"];
                break;
                
            case 1:
                cell.image = YES;
                cell.headLabel.text = @"个人主页背景";
                cell.picture.image = [_mineModel.backgroundDic objectForKey:@"UIImagePickerControllerEditedImage"];
                break;
                
            case 2:
                cell.image = NO;
                cell.headLabel.text = @"昵称";
                cell.label.text = _mineModel.nameStr;
                break;
                
            case 3:
                cell.image = NO;
                cell.headLabel.text = @"性别";
                cell.label.text = _mineModel.genderStr;
                break;
               
            default:
                break;
        }
        return cell;
    } else if (indexPath.section == 1) {
        cell.image = NO;
        switch (indexPath.row) {
            case 0:
                cell.headLabel.text = @"生日";
                cell.label.text = _mineModel.birthdayStr;
                break;
                
            default:
                cell.headLabel.text = @"地区";
                cell.label.text = _mineModel.cityStr;
                break;
        }
        return cell;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == 0) {
            cell.headLabel.text = @"介绍";
        } else {
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, cell.contentView.frame.size.width - 40, 80)];
            textView.delegate = self;
            [cell.contentView addSubview:textView];
            if (_mineModel.profilesStr == nil) {
                textView.text = @"";
            } else {
                textView.text = [NSString stringWithFormat:@"%@", _mineModel.profilesStr];
            }
            textView.font = [UIFont systemFontOfSize:15];
        }
        return cell;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

// 设置个人简介
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.mineModel.profilesStr = textView.text;
//    NSLog(@"textViewDidEndEditing");
}

// 设置 pickerView 回传的字符串
- (void)pickViewSureBtnClick:(NSString *)selectRow {
//    NSLog(@"%@", selectRow);
    self.setCell.label.text = selectRow;
    if ([self.setCell.headLabel.text  isEqual: @"性别"]) {
        self.mineModel.genderStr = selectRow;
    } else if ([self.setCell.headLabel.text  isEqual: @"生日"]) {
        self.mineModel.birthdayStr = selectRow;
    } else if ([self.setCell.headLabel.text  isEqual: @"地区"]) {
        self.mineModel.cityStr = selectRow;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.setCell =[_tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section <= 1) {
        ONESetTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        if ([self.delegate respondsToSelector:@selector(didSelectCell:)]) {
            [self.delegate didSelectCell:cell];
        }
    }
}

@end
