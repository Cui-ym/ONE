//
//  ONECollectionTableViewCell.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYButton.h"

@protocol ONECollectionTableViewCellDelegate<NSObject>

@optional
- (void)pushController:(NSString *)string;

@end

@interface ONECollectionTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ONECollectionTableViewCellDelegate>delegate;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) MYButton *pictureBtn;
@property (nonatomic, strong) MYButton *articleBtn;
@property (nonatomic, strong) MYButton *anwersBtn;
@property (nonatomic, strong) MYButton *serialBtn;

@end
