//
//  ONEHomeView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/10/1.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEMainCellModel.h"
#import "ONEFirstCellModel.h"
#import "ONEFirstTableViewCell.h"
#import "ONEMainTableViewCell.h"

@protocol ONEHomeViewDelegate <NSObject>

@required
//- (void)tableViewDidScroll:(UITableView *)tableView;
- (void)pushArticleViewController:(NSString *)string label:(NSString *)label author:(NSString *)author;

@optional
- (void)collectType:(NSString *)type model:(ONEMainCellModel *)model;
- (void)cancleCollectType:(NSString *)type title:(NSString *)title;

- (void)collectPictureModel:(ONEFirstCellModel *)model title:(NSString *)title;
- (void)cancleCollectPictureTitle:(NSString *)title;

@end

@interface ONEHomeView : UIView <UITableViewDataSource, UITableViewDelegate, ONEMainTableViewCellDelegate, ONEFirstTableViewCellDelegate>

@property (nonatomic, weak) id<ONEHomeViewDelegate> delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) ONEFirstTableViewCell *firstCell;
@property (nonatomic, strong) ONEMainTableViewCell *MainCell;
@property (nonatomic, strong) ONEFirstCellModel *firstModel;

@property (nonatomic, strong) ONEMainCellModel *firstMainModel;
@property (nonatomic, strong) ONEMainCellModel *secondMainModel;
@property (nonatomic, strong) ONEMainCellModel *thridMainModel;
@property (nonatomic, strong) ONEMainCellModel *fourthMainModel;
@property (nonatomic, strong) ONEMainCellModel *fifthMainModel;
@property (nonatomic, strong) ONEMainCellModel *sixMainModel;
@property (nonatomic) NSInteger number;

// cell 中按钮的状态
@property (nonatomic, strong) NSMutableArray *btnStatusArr;

- (void)calculateHeight;

@end
