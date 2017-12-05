//
//  ONEPickerView.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/9.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEPickerView.h"
#define ONEScreenHeight self.frame.size.height
#define ONEScreenWidth self.frame.size.width

@implementation ONEPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        _cityArray = [NSArray arrayWithContentsOfFile:filePath];
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"YYYY-MM-dd";
        _firstRow = 0;
        _province = @"北京省";
        _city = @"北京市";
    }
    return self;
}

- (void)setWhitchPicker:(int)flag{
    _flag = flag;
    NSLog(@"%d", _flag);
    [self creatCaverView];
    [self creatAnimation];
}

- (void)creatAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        _back.alpha = 0.3;
        if (_flag == 1) {
            _datePicker.frame = CGRectMake(0, ONEScreenHeight - ONEScreenWidth / 2., ONEScreenWidth, ONEScreenWidth / 2.);
        } else {
            _pickerView.frame = CGRectMake(0, ONEScreenHeight - ONEScreenWidth / 2., ONEScreenWidth, ONEScreenWidth / 2.);
        }
        _buttonView.frame = CGRectMake(0, ONEScreenHeight - ONEScreenWidth / 2. - 30, ONEScreenHeight, 30);
    }];
}

- (void)creatCaverView {
    // 发送通知隐藏tabbar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tabBarHidden" object:nil];
    
    self.back = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _back.backgroundColor = [UIColor blackColor];
    _back.alpha = 0;
    [self addSubview:_back];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPicker)];
    tap.numberOfTapsRequired = 1;
    [_back addGestureRecognizer:tap];
    [self creatButtonView];
    if (_flag == 1) {
        [self creatDateView];
    } else {
        [self creatPickView];
    }
    
}

- (void)creatDateView {
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, ONEScreenHeight + 30, ONEScreenWidth, ONEScreenWidth / 2.0)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    _date = _datePicker.date;
//    NSLog(@"%@",[_dateFormatter stringFromDate:_date]);
    
    // 添加监听
    [_datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_datePicker];
}

- (void)creatPickView
{
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ONEScreenHeight + 30, ONEScreenWidth, ONEScreenWidth / 2.0)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickerView];
}

- (void)dateChanged {
    _date = _datePicker.date;
//    NSLog(@"%@",[_dateFormatter stringFromDate:_date]);
}


- (void)creatButtonView {
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, ONEScreenHeight, ONEScreenWidth, 30)];
    _buttonView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_buttonView];
    UIView *headLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ONEScreenWidth, 1)];
    headLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:headLine];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, 10, 80, 20);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    leftButton.titleLabel.font = [UIFont systemFontOfSize:18.];
    [_buttonView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(cancelPicker) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(ONEScreenWidth - 30 - 60, 10, 80, 20);
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:20/255.0 green:124/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_buttonView addSubview:rightButton];
    [rightButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

- (void)confirm {
    if (!_string) {
        if (_flag == 1) {
            _string = [_dateFormatter stringFromDate:_date];
        } else if (_flag == 0){
            _string = [self.dictionary objectForKey:@"0"][0];
//            NSLog(@"--%@--", _string);
        } else if (_flag == 2) {
            _string = [NSString stringWithFormat:@"%@ %@", _province, _city];
        }
    }
    if([_delegate respondsToSelector:@selector(pickViewSureBtnClick:)])
        [_delegate pickViewSureBtnClick:_string];
    
    [self cancelPicker];
}

- (void)cancelPicker
{
    [UIView animateWithDuration:0.25 animations:^{
        _back.alpha = 0;
        if (_flag == 1) {
            _datePicker.frame = CGRectMake(0, ONEScreenHeight + 30, ONEScreenWidth, ONEScreenWidth / 2.);
        } else {
            _pickerView.frame = CGRectMake(0, ONEScreenHeight + 30, ONEScreenWidth, ONEScreenWidth / 2.);
        }
        _buttonView.frame = CGRectMake(0, ONEScreenHeight, ONEScreenWidth, 30);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tabBarNotHidden" object:nil];
    
}

#pragma mark - UIPickerViewDelegate
// 告诉系统每一行显示什么内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_flag == 0) {
        NSArray *array =[self.dictionary objectForKey:[NSString stringWithFormat:@"%ld", component]];
        return array[row];
    } else {
        if (component == 0) {
            return [_cityArray[row] objectForKey:@"state"];
//            _firstRow = (int)row;
        } else {
            return [_cityArray[_firstRow] objectForKey:@"cities"][row];
        }
    }
}

// 每列几行数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_flag == 0) {
        NSArray *array = [self.dictionary objectForKey:[NSString stringWithFormat:@"%ld", component]];
        return array.count;
    } else {
        if (component == 0) {
            return self.cityArray.count;
        } else {
            return [self.cityArray[_firstRow][@"cities"] count];
        }
    }
}

// 几个表盘
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _number;
}

// 选中后回调方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_flag == 0) {
        _string = [[self.dictionary objectForKey:@"0"] objectAtIndex:row];
    } else {
        if (component == 0) {
            _province = [NSString stringWithFormat:@"%@省", _cityArray[row][@"state"]];
            _city = [NSString stringWithFormat:@"%@市", _cityArray[row][@"cities"][0]];
            _firstRow = (int)row;
            [self.pickerView reloadComponent:1];
        } else if (component == 1) {
            _city = [NSString stringWithFormat:@"%@市", _cityArray[_firstRow][@"cities"][row]];
        }
        _string = [NSString stringWithFormat:@"%@ %@", _province, _city];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:20]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


@end
