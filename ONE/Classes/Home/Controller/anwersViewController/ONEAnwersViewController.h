//
//  ONEAnwersViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEAnwersModel.h"
#import "ONEAnwersView.h"

@interface ONEAnwersViewController : UIViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *questioner;
@property (nonatomic, strong) ONEAnwersModel *model;
@property (nonatomic, strong) ONEAnwersView *anwersView;

@end
