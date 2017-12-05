//
//  ONESetView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONESetTableViewCell.h"
#import "ONEMineModel.h"
#import "ONEPickerView.h"

@protocol ONESetViewDelegate<NSObject>

@optional
- (void)didSelectCell:(ONESetTableViewCell *)cell;

@end

@interface ONESetView : UIView <UITableViewDelegate, UITableViewDataSource, ONEPickerViewDelegate, UITextViewDelegate>

@property (nonatomic, assign) int flag;
@property (nonatomic, strong) ONEMineModel *mineModel;

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ONEPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, weak) id<ONESetViewDelegate> delegate;
@property (nonatomic, strong) ONESetTableViewCell *setCell;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

- (void)addPickerView;

@end
