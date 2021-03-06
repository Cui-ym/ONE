//
//  ONENewsTableView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONENewsModel.h"

@protocol ONENewsTableViewDelegate<NSObject>

- (void)didSelectedCell:(NSString *)content;

@end

@interface ONENewsTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<ONENewsTableViewDelegate> newsDelegate;
@property (nonatomic, copy) NSArray<ONENewsItemModel> *newsArray;
@property (nonatomic, strong) NSMutableArray *heightArray;

- (void)calculateHeight;

@end
