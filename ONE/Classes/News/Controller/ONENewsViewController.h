//
//  ONENewsViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONENewsView.h"

@interface ONENewsViewController : UIViewController

@property (nonatomic, strong) ONENewsView *newsView;
@property (nonatomic, copy) NSArray *array;

@end
