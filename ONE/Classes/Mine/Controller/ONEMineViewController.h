//
//  ONEMineViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEMineView.h"
#import "ONEMineModel.h"
#import "ONECollectionViewController.h"
#import "ONESetViewController.h"
#import <Masonry.h>

@interface ONEMineViewController : UIViewController

@property (nonatomic, strong) ONEMineView *mineView;
@property (nonatomic, strong) ONEMineModel *mineModel;
@property (nonatomic, strong) ONESetViewController *setViewController;
@property (nonatomic, strong) ONECollectionViewController *pictureController;
@property (nonatomic, strong) ONECollectionViewController *articleController;
@property (nonatomic, strong) ONECollectionViewController *anwersController;
@property (nonatomic, strong) ONECollectionViewController *serialController;

@end
