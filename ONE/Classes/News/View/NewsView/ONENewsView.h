//
//  ONENewsView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ONENewsView : UIView

// 五个新闻选项
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *homeBtn;
@property (nonatomic, strong) UIButton *internationalBtn;
@property (nonatomic, strong) UIButton *itBtn;
@property (nonatomic, strong) UIButton *latestBtn;
@property (nonatomic, strong) UIButton *socialBtn;

// 定义 scrollView
@property (nonatomic, strong) UIScrollView *scrollView;


@end
