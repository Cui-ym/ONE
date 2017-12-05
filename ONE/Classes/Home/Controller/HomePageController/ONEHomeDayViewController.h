//
//  ONEHomeDayViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/10/18.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEHomeView.h"
#import "ONEHomeModel.h"
#import "ONECollectionInstance.h"

@interface ONEHomeDayViewController : UIViewController  <ONEHomeViewDelegate ,UITableViewDelegate>

@property (nonatomic, strong) ONECollectionInstance *instance;
@property (nonatomic, copy)   NSString *urlString;
@property (nonatomic, strong) ONEHomeView *homeView;
@property (nonatomic, strong) ONEHomeModel *homeModel;

@end
