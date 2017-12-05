//
//  ONECollectionView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/22.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONECollectionInstance.h"
#import "ONECollectionInstance.h"
#import "ONEMainCellModel.h"

@protocol ONECollectionViewDelegate <NSObject>

@required
- (void)pushContentView:(ONEMainCellModel *)model;

@end

@interface ONECollectionView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<ONECollectionViewDelegate>delegat;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ONECollectionInstance *collectionInstance;
@property (nonatomic, copy) NSString *labelStr;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSDictionary *contentDic;

- (void)judgeStyle;

@end
