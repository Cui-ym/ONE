//
//  ONESerialViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONESerialModel.h"
#import "ONESerialView.h"

@interface ONESerialViewController : UIViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *commentUrl;
@property (nonatomic, strong) ONESerialModel *model;
@property (nonatomic, strong) ONESerialView *serialView;

@end
