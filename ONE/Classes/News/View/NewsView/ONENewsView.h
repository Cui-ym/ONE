//
//  ONENewsView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONENewsModel.h"
#import "ONENewsTableView.h"
#import "ONENewsTableView.h"

@protocol ONENewsViewDelegate <NSObject>
// 点击按钮滚动scrollView
- (void)clickButton:(UIButton *)sender;

// 滚动scrollView 变换按钮点击事件
- (void)scrollEndPosition:(CGPoint)point;

// 网络请求数据 刷新数据
- (void)getTableViewData:(NSInteger)num table:(ONENewsTableView *)table which:(int)add;

// push进详细界面
- (void)pushContentViewControllerWithString:(NSString *)html;
@end

@interface ONENewsView : UIView <UIScrollViewDelegate, ONENewsTableViewDelegate>

// 定义model
@property (nonatomic, strong) ONENewsDataModel *model;

// 五个新闻选项
@property (nonatomic, strong) UIScrollView *headScrollView;
@property (nonatomic, strong) UIButton *homeBtn;
@property (nonatomic, strong) UIButton *internationalBtn;
@property (nonatomic, strong) UIButton *itBtn;
@property (nonatomic, strong) UIButton *latestBtn;
@property (nonatomic, strong) UIButton *socialBtn;
@property (nonatomic, strong) ONENewsTableView *tableView;

// 定义 scrollView
@property (nonatomic, strong) UIScrollView *scrollView;

// 设置代理
@property (nonatomic, weak) id<ONENewsViewDelegate> delegate;

- (void)setNewsTableView:(NSInteger)num flag:(BOOL)flag model:(NSArray<ONENewsItemModel>*) model;


@end
