//
//  ONEFirstTableViewCell.h
//  ONE
//
//  Created by 崔一鸣 on 2017/10/11.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEFirstCellModel.h"

@protocol ONEFirstTableViewCellDelegate<NSObject>

@optional
- (void)clickCollectionButton:(UIButton *)button model:(ONEFirstCellModel *)model title:(NSString *)title;

@end


@interface ONEFirstTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *urlString;
//@property (nonatomic, strong) UILabel *time;            // 时间
@property (nonatomic, strong) UILabel *label;           // 标签
@property (nonatomic, strong) UILabel *title;           // 主题
@property (nonatomic, strong) UILabel *authorLab;       // 作者
@property (nonatomic, strong) UILabel *articleLab;      // 内容
@property (nonatomic, strong) UIButton *picture;        // 照片
@property (nonatomic, strong) UIButton *noteBtn;        // 小记
@property (nonatomic, strong) UIButton *collectionBtn;  // 收藏按钮
@property (nonatomic, strong) UIButton *likeBtn;        // 喜欢按钮
@property (nonatomic, strong) UIButton *forwardBtn;     // 转发按钮

@property (nonatomic, strong) ONEFirstCellModel *model;
@property (nonatomic, weak) id<ONEFirstTableViewCellDelegate> delegate;

+(CGFloat)cellModel:(ONEFirstCellModel *)model size:(CGSize)contextSize;
- (void)setModel:(ONEFirstCellModel *)model;

@end
