//
//  ONESetViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONESetView.h"
#import "ONESetTableViewCell.h"
#import "ONEMineModel.h"

@protocol ONESetViewControllerDelegate<NSObject>

@optional
- (void)pushMineModel:(ONEMineModel *)model;

@end

@interface ONESetViewController : UIViewController

@property (nonatomic, weak) id<ONESetViewControllerDelegate> delegate;

@property (nonatomic, strong) UIImage *headImage;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) ONEMineModel *mineModel;

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) ONESetView *setView;
@property (nonatomic, strong) ONESetTableViewCell *setCell;
@property (nonatomic, copy) NSString *picture;

- (void)setSetView;

@end
