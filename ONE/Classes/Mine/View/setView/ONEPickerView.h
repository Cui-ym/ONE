//
//  ONEPickerView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/9.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ONEPickerViewDelegate <NSObject>

- (void)pickViewSureBtnClick:(NSString *)selectRow;

@end

@interface ONEPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, assign) int flag;
@property (nonatomic, assign) int firstRow;
@property (nonatomic, strong) UIView *back;
@property (nonatomic, strong) UIView *buttonView;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, weak) id<ONEPickerViewDelegate> delegate;

- (void)setWhitchPicker:(int)flag;

@end
