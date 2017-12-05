//
//  ONEMineView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEMineModel.h"
#import "ONEPersonalTableViewCell.h"
#import "ONECollectionTableViewCell.h"

@interface ONEMineView : UIView <UITableViewDelegate, UITableViewDataSource, ONEPersonalTableViewCellDelegate, ONECollectionTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) ONEMineModel *mineModel;

@end
