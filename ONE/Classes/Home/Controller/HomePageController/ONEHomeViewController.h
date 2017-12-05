//
//  ONEHomeViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/10/1.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEHomeModel.h"
#import "ONEHomeDayViewController.h"

@interface ONEHomeViewController : UIViewController

@property (nonatomic, strong) ONEHomeModel *homeModel;
@property (nonatomic, strong) ONEHomeDayViewController *firstViewController;
@property (nonatomic, strong) ONEHomeDayViewController *secondViewController;
@property (nonatomic, strong) ONEHomeDayViewController *thridViewController;
@property (nonatomic, strong) ONEHomeDayViewController *fourthViewController;
@property (nonatomic, strong) ONEHomeDayViewController *fifthViewController;
@property (nonatomic, strong) ONEHomeDayViewController *sixthViewController;
@property (nonatomic, strong) ONEHomeDayViewController *seventhViewController;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSString *urlString;

@end
